require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())

SpartaAppDelegate:replaceRoomModel(dofile(vrjLua.findInModelSearchPath("Factory.lua")))