require("Actions")

local getRoomToWorld = function()
	return RelativeTo.World:getInverseMatrix()
end

local transformPointRoomToWorld = function(v)
	return getRoomToWorld():preMult(v)
end

local transformMatrixRoomToWorld = function(v)
	return getRoomToWorld():preMult(v)
end

local transformPointWorldToRoom = function(v)
	return RelativeTo.World:getMatrix():preMult(v)
end


local forklift = MatrixTransform{
	position = {0, 0, 0 },
	orientation = AngleAxis(Degrees(-90), Axis{0, 1, 0}),
	Model[[Factory Models/OSG/Shop Carts and Fork Lifts/Forklift.osg]]
}
RelativeTo.Room:addChild(forklift)

Actions.addFrameAction(
	function()
		local wand = gadget.PositionInterface('VJWand')
		local device = gadget.DigitalInterface("VJButton2")
		while true do
			repeat
				Actions.waitForRedraw()
			until device.justPressed
			--get forklifts position (currently in room)
			local room_pose = forklift:getMatrix()
			--remove forlift from room
			RelativeTo.Room:removeChild(forklift)
			--"transform" the forklifts position with respect to the world
			local world_pose = transformMatrixRoomToWorld(room_pose)
			--update the position of the forklift to the world position
			forklift:setMatrix(world_pose)
			--add forklift to world
			RelativeTo.World:addChild(forklift)
			repeat
				Actions.waitForRedraw()
			until device.justPressed
			--get forklifts position (currently in the world)
			local world_pose = forklift:getMatrix()
			--remove the forklift from the world
			RelativeTo.World:removeChild(forklift)
			--calculate room position with respect to world
			local room_pose = transformMatrixRoomToWorld(world_pose)
			--	--update the position of the forklift to the room position
			forklift:setMatrix(room_pose)
			--add forklift to room
			RelativeTo.Room:addChild(forklift)
		end
	end
)
