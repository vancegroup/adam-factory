require "AddAppDirectory"
AddAppDirectory()

runfile "factorylighting.lua"
RelativeTo.World:addChild(runfile "Factory.lua")
