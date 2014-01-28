-- MUST REMOVE STANDARD NAVIGATION BEFORE ADDING CUSTOM NAVIGATION
osgnav.removeStandardNavigation()

-- load model of forklift
local forklift = MatrixTransform{
	position = {0, 0, 0 },
	Transform{
		orientation = AngleAxis(Degrees(-90), Axis{0.0, 1.0, 0.0}),
		Model[[Factory Models/OSG/Shop Carts and Fork Lifts/Forklift.osg]]
	}
}
RelativeTo.World:addChild(forklift)

-- helper  functions
local getRoomToWorld = function()
	return RelativeTo.World:getInverseMatrix()
end

local transformMatrixRoomToWorld = function(m)
	return m * getRoomToWorld()
end

local transformMatrixWorldToRoom = function(m)
	return m * RelativeTo.World:getMatrix()
end

-- set up buttons
local wand = gadget.PositionInterface('VJWand')
local translateButton = gadget.DigitalInterface("VJButton0")
local joystickX = gadget.AnalogInterface("WMNunchukJoystickX")
local joystickY = gadget.AnalogInterface("WMNunchukJoystickY")
local dPadRight = gadget.DigitalInterface("VJButton2")
local dPadLeft = gadget.DigitalInterface("WMButtonLeft")

-- function tests if x-axis of joystick is in center
local function joystickXIsCentered()
	if joystickX.centered > -.05 and joystickX.centered < .05 then
		return true
	else
		return false
	end
end
	
-- function tests if y-axis of joystick is in center
local function joystickYIsCentered()
	if joystickY.centered > -.05 and joystickY.centered < .05 then
		return true
	else
		return false
	end
end

local function base_navigation_with_forklift_rc()
	local translationRate = 1
	local rotationRate = 2
		
	-- loop to control world translation/rotation and forklift translation/rotation
	while true do
		-- world translation
		if translateButton.pressed then
			local dt = Actions.waitForRedraw()
            local translate_value_x = wand.forwardVector:x() * translationRate * dt
            local translate_value_z = wand.forwardVector:z() * translationRate * dt
            print("WALKING")
            translateWorld(-translate_value_x, 0, -translate_value_z)
			Actions.waitForRedraw()
        end
		
		-- world rotation
		if dPadRight.pressed then
			local incrementalRotation = osg.Quat()
			local dt = Actions.waitForRedraw()
			local angle = rotationRate * dt
			incrementalRotation:makeRotate(angle, Vec(0, 1, 0))
			local newHeadPosition = getHeadPositionInWorld()
			rotateWorldAboutPoint(newHeadPosition, incrementalRotation)
			Actions.waitForRedraw()
		end
		
		-- if dPadLeft.pressed then
			-- local incrementalRotation = osg.Quat()
			-- local dt = Actions.waitForRedraw()
			-- local angle = -rotationRate * dt
			-- incrementalRotation:makeRotate(angle, Vec(0, 1, 0))
			-- local newHeadPosition = getHeadPositionInWorld()
			-- rotateWorldAboutPoint(newHeadPosition, incrementalRotation)
		-- end
		
		-- forklift translation
		-- if not joystickXIsCentered() then
			-- local rate = 1
			-- local dt = Actions.waitForRedraw()
			-- forklift:preMult(osg.Matrixd.rotate(-rate * joystickX.centered * dt, 0, 1, 0))
			-- print("turning forklift")
		-- end
		
		--forklift rotation
		-- if not joystickYIsCentered() then
			-- local rate = 1
			-- local dt = Actions.waitForRedraw()
			-- forklift:preMult(osg.Matrixd.translate(0, 0, -rate * joystickY.centered * dt))
			-- print("moving forklift")
		-- end
		
		Actions.waitForRedraw()
		
	end
	
	initialSetup = false
	
end

local function forklift_drive_navigation()
	local translationRate = 1
	local rotationRate = 1
	local incrementalRotation = osg.Quat()
		
	while true do
		-- world translation
		if translateButton.pressed then
			local dt = Actions.waitForRedraw()
            local translate_value_z = wand.forwardVector:z() * translationRate * dt
            print("DRIVING")
            translateWorld(0, 0, -translate_value_z)
        end
		
		-- world rotation
		if not joystickXIsCentered() then
			local dt = Actions.waitForRedraw()
			local angle = joystickX.centered * rotationRate * dt
			incrementalRotation:makeRotate(angle, Vec(0, 1, 0))
			local newHeadPosition = getHeadPositionInWorld()
			rotateWorldAboutPoint(newHeadPosition, incrementalRotation)
		end
		
		Actions.waitForRedraw()
		
	end
end

navigationSwitcher = frameActionSwitcher{
        switchButton = gadget.DigitalInterface("WMButtonPlus"),
        {base_navigation_with_forklift_rc,"base navigation with forklift RC frame action"},
		{forklift_drive_navigation,"forklift driving frame action"},
}

-- [[ frame action for attaching forklift to room and back ]]
Actions.addFrameAction(
	function()
		local device = gadget.DigitalInterface("WMButtonPlus")
		while true do
			repeat
				Actions.waitForRedraw()
			until device.justPressed
			-- get height of the user
			local height = gadget.PositionInterface("VJHead").position:y()
			-- adjust height of user
			RelativeTo.World:postMult(osg.Matrixd.translate(0, -math.abs(1.6 - height), 0))
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
			RelativeTo.World:preMult(osg.Matrixd.translate(0, math.abs(1.6 - height), 0))
		end
	end
)