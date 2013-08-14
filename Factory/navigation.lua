require("Actions")

osgnav.removeStandardNavigation()

local getRoomToWorld = function()
	return RelativeTo.World:getInverseMatrix()
end

local transformPointRoomToWorld = function(v)
	return getRoomToWorld():preMult(v)
end

local transformDirectionRoomToWorld = function(v)
	return getRoomToWorld():preMult(osg.Vec4d(v,0))
end

--[[Update the position of the tracked wii-mote]]
local device = gadget.PositionInterface("VJWand")
updatepositionTrack = function()
	while true do
		track = RelativeTo.World:getInverseMatrix():preMult(device.position)
		Actions.waitForRedraw()
	end
end
Actions.addFrameAction(updatepositionTrack)

--[[Function for walking in scene]]
walking_nav = function(dt)
	local wand = gadget.PositionInterface('VJWand')
	local device = gadget.DigitalInterface("VJButton0")
	local dt = dt
	local rate = 1.5
	while true do
		repeat
			dt = Actions.waitForRedraw()
		until device.pressed
		while device.pressed do
			dt = Actions.waitForRedraw()
			-- Post-mult here does our movement in the room frame before the rest of the transform
			RelativeTo.World:postMult(osg.Matrixd.translate(-wand.forwardVector:x()*rate*dt,0,-wand.forwardVector:z()*rate*dt))
		end
	end

end
Actions.addFrameAction(walking_nav)

--[[Function for driving forklift in scene]]
drive_nav = function(dt)
	local wand = gadget.PositionInterface('VJWand')
	local device = gadget.DigitalInterface("VJButton0")
	local dt = dt
	local rate = 1.5
	while true do
		repeat
			dt = Actions.waitForRedraw()
		until device.pressed
		while device.pressed do
			dt = Actions.waitForRedraw()
			-- Post-mult here does our movement in the room frame before the rest of the transform
			RelativeTo.World:postMult(osg.Matrixd.translate(-wand.forwardVector:x()*rate*dt,0,-wand.forwardVector:z()*rate*dt))
		end
	end

end
Actions.addFrameAction(drive_nav)

--[[Functions for switching between navigation styles]]
--*******cabHeight needs to be adjusted*********
cabHeight = 0

function switchNavigationFromWalkingToDriving()
	Actions.removeFrameAction(walking_nav2)
	RelativeTo.World:preMult(osg.Matrixd.translate(0, -cabHeight, 0))
	drive_nav2 = Actions.addFrameAction(drive_nav)
end

function switchNavigationFromDrivingToWalking()
	Actions.removeFrameAction(drive_nav2)
	RelativeTo.World:preMult(osg.Matrixd.translate(0, cabHeight, 0))
	walking_nav2 = Actions.addFrameAction(walking_nav)
end

--[[Update the position of the tracked head]]
local head = gadget.PositionInterface("VJHead")
updateposTrack = function()
	while true do
		trackhead = RelativeTo.World:getInverseMatrix():preMult(head.position)
		Actions.waitForRedraw()
	end
end
Actions.addFrameAction(updateposTrack)

--[[Add rotation to the scene]]
Actions.addFrameAction(
	function(dt)
		local wand = gadget.PositionInterface("VJWand")
		local device = gadget.DigitalInterface("WMButtonLeft")
		local device2 = gadget.DigitalInterface("WMButtonRight")
		-- local device = gadget.DigitalInterface("VJButton2")
		-- local device2 = gadget.DigitalInterface("VJButton2")
		local dt = dt
		local rate = .5
		while true do
			repeat
				dt = Actions.waitForRedraw()
			until device.pressed or device2.pressed
			
			local wandForward = osg.Vec3d(wand.forwardVector:x(),0,wand.forwardVector:z())
			local rotateMax = osg.Quat()
			local incRotate = osg.Quat()

			while device.pressed or device2.pressed do
				-- first, wait for next frame
				dt = Actions.waitForRedraw()
				
				-- See where they point now.
				local newForwardVec = osg.Vec3d(wand.forwardVector:x(),0,wand.forwardVector:z())
				
				-- Try to make those pointing places the same - rotate one to the other
				rotateMax:makeRotate(newForwardVec, wandForward)
				
				-- slerp scales our incremental rotation by dt
				incRotate:slerp(dt * rate, osg.Quat(), rotateMax)
				
				local deltaMatrix = osg.Matrixd()
				deltaMatrix:preMult(osg.Matrixd.translate(trackhead))
				deltaMatrix:preMult(osg.Matrixd.rotate(incRotate))
				deltaMatrix:preMult(osg.Matrixd.translate(-trackhead))

				RelativeTo.World:preMult(deltaMatrix)
			end
		end
	end
)

--[[Update forkliftxform based on the wand]]
local forkliftxform = osg.MatrixTransform()
RelativeTo.Room:addChild(forkliftxform)

local ForkliftInfo = {
	tracker = gadget.PositionInterface("VJWand");
	-- cornersInCartSpace = returnCorners();
	--TODO: this may need to be adjusted between Metal vs. C6
	--Adjust this to change the positioning of the cart relative to the wand
	wand_forklift_offset = Vec( -.25, -.1, 0);
}

ForkliftInfo.getForwardVector = function()
	local vec = Vec(ForkliftInfo.tracker.forwardVector:x(), 0, ForkliftInfo.tracker.forwardVector:z())
	vec:normalize()
	return vec
end

ForkliftInfo.getAngle = function()
	local fwd = ForkliftInfo.getForwardVector()
	return math.atan2(-fwd:z(), fwd:x()) - 3.14159266
end

drive = function()
	local mat
	while true do
		mat = ForkliftInfo.tracker.matrix
		local forklift_angle = ForkliftInfo.getAngle()
		local quat = osg.Quat(forklift_angle, Vec(0,1,0))
		mat:setRotate(quat)
		mat:setTrans(mat:getTrans():x(), 0, mat:getTrans():z())
		forkliftxform:setMatrix(mat)
		Actions.waitForRedraw()
	end
end

forklift_product_group = Transform{
	position = {ForkliftInfo.wand_forklift_offset:x(), ForkliftInfo.wand_forklift_offset:y(), ForkliftInfo.wand_forklift_offset:z()},
	Model[[Factory Models/OSG/Shop Carts and Fork Lifts/Forklift.osg]]
}
	
forkliftxform:addChild(forklift_product_group)

--[[FrameAction for using the wii-mote to switch between navigation styles]]
Actions.addFrameAction(
	function()
		local toggle_button = gadget.DigitalInterface("VJButton2")
		while true do
			repeat
				Actions.waitForRedraw()
			until toggle_button.justPressed
				switchNavigationFromWalkingToDriving()
				RelativeTo.World:removeChild(forklift)
				Actions.addFrameAction(drive)
			repeat
				Actions.waitForRedraw()
			until toggle_button.justPressed
				switchNavigationFromDrivingToWalking()
				RelativeTo.World:addChild(forklift)
				Actions.removeFrameAction(drive)
		end
	end
)