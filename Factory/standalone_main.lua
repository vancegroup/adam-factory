require "AddAppDirectory"
AddAppDirectory()

runfile "simpleLights.lua"
RelativeTo.World:addChild(runfile "Factory.lua")
