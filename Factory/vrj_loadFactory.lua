require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())
dofile(vrjLua.findInModelSearchPath([[simpleLights.lua]]))
RelativeTo.World:addChild(dofile(vrjLua.findInModelSearchPath("Factory.lua")))