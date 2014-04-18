print("Loading PlaySound.lua. Wav files must be 16bit float.")
require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

--for testing with hydra
-- vrjKernel.loadConfigFile[[H:/Documents/adam-factory/factory/RazerHydra.jconf]]

-- navigation helper functions
runfile[[navigationHelperFunctions.lua]]

SoundWav = function(wavPath)
	snx.changeAPI("OpenAL")
	--create a sound info object 
	local soundInfo = snx.SoundInfo()
	-- set the filename attribute of the soundFile (path to your sound file)
	soundInfo.filename = wavPath
	--create a new sound handle and pass it the filename from the soundInfo object
	soundHandle = snx.SoundHandle(soundInfo.filename)
	--configure the soundHandle to use the soundInfo
	soundHandle:configure(soundInfo)
	--play or "trigger" the sound
	return soundHandle
end

SoundMp3 = function(mp3Path)
	snx.changeAPI("Audiere")
	--create a sound info object 
	soundInfo = snx.SoundInfo()
	-- set the filename attribute of the soundFile (path to your sound file)
	soundInfo.filename = mp3Path
	--create a new sound handle and pass it the filename from the soundInfo object
	soundHandle = snx.SoundHandle(soundInfo.filename)
	--configure the soundHandle to use the soundInfo
	soundHandle:configure(soundInfo)
	--play or "trigger" the sound
	return soundHandle
end

forklift_startup_sound = SoundWav(vrjLua.findInModelSearchPath("Sounds/forklift_start.wav"))
play_forklift_startup_sound = function()
	forklift_startup_sound:trigger(1)
end

forklift_running_sound = SoundWav(vrjLua.findInModelSearchPath("Sounds/forklift_running.wav"))
play_forklift_running_sound = function()
	forklift_running_sound:trigger(-1)
end

forklift_backup_sound = SoundWav(vrjLua.findInModelSearchPath("Sounds/forklift_backup.wav"))
play_forklift_backup_sound = function()
	forklift_backup_sound:trigger(-1)
end

forklift_engine_stop_sound = SoundWav(vrjLua.findInModelSearchPath("Sounds/forklift_engine_stop.wav"))
play_forklift_engine_stop = function()
	forklift_engine_stop_sound:trigger(1)
end

-- set up buttons (METaL)
local switchButton = gadget.DigitalInterface("WMButtonPlus")
local joystickX = gadget.AnalogInterface("WMNunchukJoystickX")
local joystickY = gadget.AnalogInterface("WMNunchukJoystickY")

-- set up buttons (Hydra)
-- local switchButton = gadget.DigitalInterface("HydraLeftBumper")
-- local joystickX = gadget.AnalogInterface("HydraLeftJSX")
-- local joystickY = gadget.AnalogInterface("HydraLeftJSY")
		
-- function tests if y-axis of joystick is in center
local function joystickXIsCentered()
	if joystickX.centered > -.2 and joystickX.centered < .2 then
		return true
	else
		return false
	end
end

-- function tests if x-axis of joystick is in center
local function joystickYIsCentered()
	if joystickY.centered > -.2 and joystickY.centered < .2 then
		return true
	else
		return false
	end
end

-- returns the distance between the user and forklift
local function forklift_distance_from_user()
	local forklift_position = forklift:getMatrix():getTrans()
	local user_position = getHeadPositionInWorld()
	local distance = math.sqrt((forklift_position:x() - user_position:x())^2 + (forklift_position:z() - user_position:z())^2)
	return distance
end

Actions.addFrameAction(
	function()
		while true do
			-- rc mode
			repeat
				if not joystickYIsCentered() or not joystickXIsCentered() then
					play_forklift_running_sound()
					forklift_running_sound:setPitchBend((math.abs(joystickY.centered) * .5 + 1))
					forklift_running_sound:setVolume((forklift_distance_from_user() + 1)^-1.1)
				end
				
				if joystickYIsCentered() and joystickXIsCentered() then
					forklift_running_sound:stop()
				end
		
				if joystickY.centered < -.5 then
					play_forklift_backup_sound()
					forklift_backup_sound:setVolume((forklift_distance_from_user() + 1)^-1.1)
				end
				
				if joystickY.centered > -.5 then
					forklift_backup_sound:stop()
					forklift_backup_sound:setVolume((forklift_distance_from_user() + 1)^-1.1)
				end
				
				Actions.waitForRedraw()
			until switchButton.justPressed
			
			play_forklift_startup_sound()
			Actions.waitSeconds(1)
			play_forklift_running_sound()
			
			-- driving mode
			repeat
			
				forklift_running_sound:setPitchBend((math.abs(joystickY.centered) * .5 + 1))
		
				if joystickY.centered < -.5 then
					play_forklift_backup_sound()
				end
				
				if joystickY.centered > -.5 then
					forklift_backup_sound:stop()
				end
				
				Actions.waitForRedraw()
			until switchButton.justPressed
			
			play_forklift_engine_stop()
		end
	end
)