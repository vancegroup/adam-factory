require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())
local newroom = Transform{
	position = {2.5, 0, 2.5},
	dofile(vrjLua.findInModelSearchPath("Factory.lua"))
}
local optim = osgUtil.Optimizer()
optim:optimize(newroom)
SpartaAppDelegate:replaceRoomModel(newroom)