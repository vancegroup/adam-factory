local getRoomToWorld = function()
	return RelativeTo.World:getInverseMatrix()
end

local transformMatrixRoomToWorld = function(m)
	return m * getRoomToWorld()
end

local transformMatrixWorldToRoom = function(m)
	return m * RelativeTo.World:getMatrix()
end

local forklift = MatrixTransform{
	position = {0, 0, 0 },
	Transform{
		orientation = AngleAxis(Degrees(-90), Axis{0.0, 1.0, 0.0}),
		Model[[Factory Models/OSG/Shop Carts and Fork Lifts/Forklift.osg]]
	}
}
RelativeTo.World:addChild(forklift)

-- [[ frame action for attaching forklift to room and back ]]
Actions.addFrameAction(
	function()
		local wand = gadget.PositionInterface('VJWand')
		local device = gadget.DigitalInterface("WMButtonMinus")
		-- local device = gadget.DigitalInterface("VJButton2")
		while true do
			repeat
				Actions.waitForRedraw()
			until device.justPressed
			-- get height of the user
			local height = gadget.PositionInterface("VJHead").position:y()
			-- adjust height of user
			RelativeTo.World:postMult(osg.Matrixd.translate(0, -math.abs(1.8288 - height), 0))
			--get forklifts position (currently in the world)
			local world_pose = forklift.Matrix
			--remove the forklift from the world
			RelativeTo.World:removeChild(forklift)
			--calculate room position with respect to world
			local room_pose = transformMatrixWorldToRoom(world_pose)
			--update the position of the forklift to the room position
			forklift.Matrix = room_pose
			--add forklift to room
			RelativeTo.Room:addChild(forklift)
			navigationSwitcher:switchToFrameAction("driving frame action")
			repeat
				Actions.waitForRedraw()
			until device.justPressed
			-- get forklifts position (currently in room)
			local room_pose = forklift.Matrix
			-- remove forklift from room
			RelativeTo.Room:removeChild(forklift)
			-- "transform" the forklifts position with respect to the world
			local world_pose = transformMatrixRoomToWorld(room_pose)
			-- update the position of the forklift to the world position
			forklift.Matrix = world_pose
			-- add forklift to world
			RelativeTo.World:addChild(forklift)
			-- adjust height of user
			RelativeTo.World:preMult(osg.Matrixd.translate(0, math.abs(1.8288 + height), 0))
			navigationSwitcher:switchToFrameAction("walking frame action")
		end
	end
)

function do_nothing()
	while true do
		dt = Actions.waitForRedraw()
	end
end

-- adds remote control move ability to forklift
function forklift_rc_move()
	local joystickY = gadget.AnalogInterface("WMNunchukJoystickY")
	
	local function joystickIsCentered()
		if joystickY.centered > -.05 and joystickY.centered < .05 then
			return true
		else
			return false
		end
	end
	
	while true do
		repeat
			dt = Actions.waitForRedraw()
		until not joystickIsCentered()

		while not joystickIsCentered() do
			local rate = 1
			dt = Actions.waitForRedraw()
			forklift:preMult(osg.Matrixd.translate(0, 0, -rate * joystickY.centered * dt))
			print("moving forklift")
		end
	end
end

-- adds remote control rotation ability to forklift
function forklift_rc_rotate()
	local joystickX = gadget.AnalogInterface("WMNunchukJoystickX")
	
	local function joystickIsCentered()
		if joystickX.centered > -.05 and joystickX.centered < .05 then
			return true
		else
			return false
		end
	end
	
	while true do
		repeat
			dt = Actions.waitForRedraw()
		until not joystickIsCentered()

		while not joystickIsCentered() do
			local rate = 1
			dt = Actions.waitForRedraw()
			forklift:preMult(osg.Matrixd.rotate(-rate * joystickX.centered * dt, 0, 1, 0))
			print("turning forklift")
		end
	end
end

-- frame action switcher for remote controlling translation of forklift
rc_control_switcher_move = frameActionSwitcher{
	switchButton = gadget.DigitalInterface("WMButtonDown"),
	{do_nothing,"forklift rc move frame action off"},
	{forklift_rc_move,"forklift RC move frame action"},
}

-- frame action switcher for remote controlling rotation of forklift
rc_control_switcher_rotate = frameActionSwitcher{
	switchButton = gadget.DigitalInterface("WMButtonDown"),
	{do_nothing,"forklift rc rotate frame action off"},
	{forklift_rc_rotate,"forklift RC rotate frame action"},
}