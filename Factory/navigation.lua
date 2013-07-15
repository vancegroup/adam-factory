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

--Update the position of the tracked wii-mote
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
cabHeight = .25

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
			repeat
				Actions.waitForRedraw()
			until toggle_button.justPressed
				switchNavigationFromDrivingToWalking()
				RelativeTo.World:addChild(forklift)
		end
	end
)

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


local cartxform = osg.MatrixTransform()
RelativeTo.Room:addChild(cartxform)

-- Update cartxform based on the wand
-- returnCorners = function()
	-- return {
		-- Vec(0.25, 0, 0.1); 			--back
		-- Vec(0.25, 0, -0.9); 		--front
		-- Vec(-0.25, 0, -0.9); 		--front
		-- Vec(-0.25, 0, 0.1); 		--back
	-- }
-- end


local CartInfo = {
	-- arbitraryCenterInRoom = Vec(2, 0, 0.7);
	tracker = gadget.PositionInterface("CartDirectionTracker");
	handle = gadget.AnalogInterface("CartHandleInput");
	-- cornersInCartSpace = returnCorners();
	--TODO: this may need to be adjusted between Metal vs. C6
	--Adjust this to change the positioning of the cart relative to the wand
	wand_cart_offset = Vec(-0.2, 0.1, 0);
}

CartInfo.getAngle = function()
	local fwd = CartInfo.getForwardVector()
	--90 degrees = 1.57079633 in radians
	--TODO: check this, why does this method by default return "90" degrees
	--return in radians
	return math.atan2(-fwd:z(), fwd:x()) - 1.57079633
end

CartInfo.getForwardVector = function()
	local vec = Vec(CartInfo.tracker.forwardVector:x(), 0, CartInfo.tracker.forwardVector:z())
	vec:normalize()
	return vec
end

Actions.addFrameAction(
	function()
		local mat
		while true do
			mat = CartInfo.tracker.matrix
			local cart_angle = CartInfo.getAngle()
			--print("Cart angle: " .. cart_angle)
			local quat = osg.Quat(cart_angle, Vec(0,1,0))
			mat:setRotate(quat)
			mat:setTrans(mat:getTrans():x(), 0, mat:getTrans():z())
			cartxform:setMatrix(mat)
			Actions.waitForRedraw()
		end
	end
)


cart_product_group = Transform{
	position = {CartInfo.wand_cart_offset:x(), CartInfo.wand_cart_offset:y(), CartInfo.wand_cart_offset:z()},
	Model[[Factory Models/OSG/Shop Carts and Fork Lifts/Forklift.osg]]
}

cartxform:addChild(cart_product_group)