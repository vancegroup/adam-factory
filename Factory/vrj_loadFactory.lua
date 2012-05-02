require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

RelativeTo.World:addChild(dofile(vrjLua.findInModelSearchPath("Factory.lua")))