-- MUST REMOVE STANDARD NAVIGATION BEFORE ADDING CUSTOM NAVIGATION
osgnav.removeStandardNavigation()

-- navigation helper functions
runfile[[navigationHelperFunctions.lua]]

-- set up buttons (METaL)
local wand = gadget.PositionInterface('VJWand')
local translateButton = gadget.DigitalInterface("VJButton0")
local dPadRight = gadget.DigitalInterface("WMButtonRight")
local dPadLeft = gadget.DigitalInterface("WMButtonLeft")


function wand_walk_frame_action()
    local rate = 1

	dropUserToGround()
    
	while true do
        repeat
            dt = Actions.waitForRedraw()
        until translateButton.justPressed

        while translateButton.pressed do
            dt = Actions.waitForRedraw()
            local translate_value_x = wand.forwardVector:x() * rate * dt
            local translate_value_z = wand.forwardVector:z() * rate * dt
            translateWorld(-translate_value_x, 0, -translate_value_z)
        end
    end
end

function wand_fly_frame_action()
    local rate = 1
    while true do
        repeat
            dt = Actions.waitForRedraw()
        until translateButton.justPressed

        while translateButton.pressed do
            dt = Actions.waitForRedraw()
            local translate_value_x = wand.forwardVector:x() * rate * dt
            local translate_value_y = wand.forwardVector:y() * rate * dt
            local translate_value_z = wand.forwardVector:z() * rate * dt
            translateWorld(-translate_value_x, -translate_value_y, -translate_value_z)
        end
    end
end


local function rotation_navigation()
	local translationRate = 1
	local rotationRate = 2

	while true do
		local dt = Actions.waitForRedraw()
		
		-- world rotation
		if dPadRight.pressed then
			local incrementalRotation = osg.Quat()
			local angle = rotationRate * dt
			incrementalRotation:makeRotate(angle, Vec(0, 1, 0))
			local newHeadPosition = getHeadPositionInWorld()
			rotateWorldAboutPoint(newHeadPosition, incrementalRotation)
		end
		
		if dPadLeft.pressed then
			local incrementalRotation = osg.Quat()
			local angle = -rotationRate * dt
			incrementalRotation:makeRotate(angle, Vec(0, 1, 0))
			local newHeadPosition = getHeadPositionInWorld()
			rotateWorldAboutPoint(newHeadPosition, incrementalRotation)
		end
	end	
end
Actions.addFrameAction(rotation_navigation)

navigationSwitcher = frameActionSwitcher{
        switchButton = gadget.DigitalInterface("WMButtonPlus"),
        {wand_walk_frame_action,"walking"},
		{wand_fly_frame_action,"flying"},
}