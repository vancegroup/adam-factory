
require("Actions")
require("TransparentGroup")
require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())
local device = gadget.PositionInterface("VJWand")

local stateSet = RelativeTo.World:getOrCreateStateSet()
local stateSet2 = RelativeTo.Room:getOrCreateStateSet()

--Regular lighting for when lumos is not in effect
light1 = osg.Light()
lightsource1 = osg.LightSource()
lightsource1:setLight(light1)

light2 = osg.Light()
light2:setLightNum(1)
lightsource2 = osg.LightSource()
lightsource2:setLight(light2)

light1:setAmbient(osg.Vec4(.3, .3, 0.3, 1))
light2:setAmbient(osg.Vec4(.3, .3, 0.3, 1))

--set diffuse lighting
light1:setDiffuse(osg.Vec4(.8, .8, .8, 1))
light2:setDiffuse(osg.Vec4(.8, .8, .8, 1))

--Set attenuation (different amounts of light depending on distance)
--Combine constant, linear and quadratic attenuation for desired effect
light1:setConstantAttenuation(.7)
light2:setConstantAttenuation(.7)

--set Position
light1:setPosition(osg.Vec4(-15,5,-20, 1.0))
light2:setPosition(osg.Vec4(15,5,10, 1.0))

--Set background light to always be present
lightsource1:setLocalStateSetModes(osg.StateAttribute.Values.ON)
stateSet:setAssociatedModes(light1, osg.StateAttribute.Values.ON)
stateSet2:setAssociatedModes(light1, osg.StateAttribute.Values.ON)
lightsource2:setLocalStateSetModes(osg.StateAttribute.Values.ON)
stateSet:setAssociatedModes(light2, osg.StateAttribute.Values.ON)
stateSet2:setAssociatedModes(light2, osg.StateAttribute.Values.ON)
RelativeTo.World:addChild(lightsource1)
RelativeTo.World:addChild(lightsource2)



