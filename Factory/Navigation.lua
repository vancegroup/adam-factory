-- MUST REMOVE STANDARD NAVIGATION BEFORE ADDING CUSTOM NAVIGATION
osgnav.removeStandardNavigation()

-- navigation frame actions
function wand_drive_frame_action()
    local moveButton1 = gadget.DigitalInterface("VJButton0")
    local wand = gadget.PositionInterface('VJWand')
    local rate = 1
	
    while true do
        repeat
            dt = Actions.waitForRedraw()
        until moveButton1.justPressed

        while moveButton1.pressed do
            dt = Actions.waitForRedraw()
            local translate_value_z = wand.forwardVector:z() * rate * dt
            print("DRIVING")
            translateWorld(0, 0, -translate_value_z)
        end
    end
end

function wand_walk_frame_action()
    local moveButton2 = gadget.DigitalInterface("VJButton0")
    local wand = gadget.PositionInterface('VJWand')
    local rate = 1
	
	dropUserToGround()
    
	while true do
        repeat
            dt = Actions.waitForRedraw()
        until moveButton2.justPressed

        while moveButton2.pressed do
            dt = Actions.waitForRedraw()
            local translate_value_x = wand.forwardVector:x() * rate * dt
            local translate_value_z = wand.forwardVector:z() * rate * dt
            print("WALKING")
            translateWorld(-translate_value_x, 0, -translate_value_z)
        end
    end
end

function wand_fly_frame_action()
    local moveButton3 = gadget.DigitalInterface("VJButton0")
    local wand = gadget.PositionInterface('VJWand')
    local rate = 1
    while true do
        repeat
            dt = Actions.waitForRedraw()
        until moveButton3.justPressed

        while moveButton3.pressed do
            dt = Actions.waitForRedraw()
            local translate_value_x = wand.forwardVector:x() * rate * dt
            local translate_value_y = wand.forwardVector:y() * rate * dt
            local translate_value_z = wand.forwardVector:z() * rate * dt
            print("FLYING")
            translateWorld(-translate_value_x, -translate_value_y, -translate_value_z)
        end
    end
end

function wrist_deviation_rotation_frame_action()
	local rotateButton1 = gadget.DigitalInterface("WMButtonRight")
	local rotateButton2 = gadget.DigitalInterface("WMButtonLeft")
	local wand = gadget.PositionInterface('VJWand')
	local rotRate = 0.5

	local function getWandForwardVectorWithoutY()
		return osg.Vec3d(wand.forwardVector:x(), 0, wand.forwardVector:z())
	end

	while true do
		repeat
			dt = Actions.waitForRedraw()
		until rotateButton1.pressed or rotateButton2.pressed  

		local initialWandForwardVector = getWandForwardVectorWithoutY()
		local maximumRotation = osg.Quat()
		local incrementalRotation = osg.Quat()

		while rotateButton1.pressed or rotateButton2.pressed do
			local dt = Actions.waitForRedraw()
			local newForwardVec = getWandForwardVectorWithoutY()
			maximumRotation:makeRotate(newForwardVec, initialWandForwardVector)
			incrementalRotation:slerp(dt * rotRate, osg.Quat(), maximumRotation)
			local newHeadPosition = getHeadPositionInWorld()
			rotateWorldAboutPoint(newHeadPosition, incrementalRotation)
		end
	end
end

function nunchuck_rotation_frame_action()
	local leftJoystickX = gadget.AnalogInterface("WMNunchukJoystickX")
	local rotRate = 1

	local function joystickIsCentered()
		if leftJoystickX.centered > -.05 and leftJoystickX.centered < .05 then
			return true
		else
			return false
		end
	end
	
	while true do
		repeat
				dt = Actions.waitForRedraw()
		until not joystickIsCentered()

		local incrementalRotation = osg.Quat()

		while not joystickIsCentered() do
			local angle = leftJoystickX.centered * rotRate * dt
			incrementalRotation:makeRotate(angle, Vec(0, 1, 0))
			local newHeadPosition = getHeadPositionInWorld()
			rotateWorldAboutPoint(newHeadPosition, incrementalRotation)
			local dt = Actions.waitForRedraw()
		end
	end
end

-- frame action switcher for walking and flying translation
navigationSwitcher = frameActionSwitcher{
        switchButton = gadget.DigitalInterface("WMButtonPlus"),
        {wand_walk_frame_action,"walking frame action"},
		{wand_drive_frame_action,"driving frame action"},
        {wand_fly_frame_action,"flying frame action"},
}

-- frame action switcher for walking and driving rotation
rotation_walk_drive_Switcher = frameActionSwitcher{
        switchButton = gadget.DigitalInterface("WMButtonMinus"),
        {wrist_deviation_rotation_frame_action,"wrist deviation rotation frame action"},
        {nunchuck_rotation_frame_action,"nunchuck rotation frame action"},
}