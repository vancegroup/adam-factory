--Factory
dofile([[X:\users\lpberg\VRJuggLua\examples\lys\litfactory.lua]])
vrjLua.appendToModelSearchPath([[X:/users/lpberg/VRJuggLua/models/]])
require("getScriptFilename")
fn = getScriptFilename()
print(fn)
assert(fn, "Have to load this from file, not copy and paste, or we can't find our models!")
vrjLua.appendToModelSearchPath(fn)



--Origin Sphere Representation
RelativeTo.World:addChild(Sphere{radius=.25})

factory = Transform{
	position = {9.5,0,-4.5},
}
room = Transform{
	orientation = AngleAxis(Degrees(-90), Axis{1.0, 0.0, 0.0}),
	scale = .04,--ScaleFrom.inches,
	Model("basicfactory.ive"),
}	
milling  = Transform {
	position = {-9,0,-3},
	Model("Factory Models/OSG/Machines/milling machine.osg"),
}

rollers = Transform {
	position = {10,0,-13.7},
	orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Assembly Line/Rollers.osg"),
}

rollers1 = Transform {
	position = {10,0,-11.5},
	orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Assembly Line/Rollers.osg"),
}
rollers2 = Transform {
	position = {10,0,-9.3},
	orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Assembly Line/Rollers.osg"),
}
rollers3 = Transform {
	position = {10,0,-7.1},
	orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Assembly Line/Rollers.osg"),
}	
rollers4 = Transform {
	position = {10,0,-4.9},
	orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Assembly Line/Rollers.osg"),
}
rollers5 = Transform {
	position = {10,0,-2.7},
	orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Assembly Line/Rollers.osg"),
}
rollers6 = Transform {
	position = {10,0,-.5},
	orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Assembly Line/Rollers.osg"),
}
rollers7 = Transform {
	position = {7.3,0,-.5},
	--orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Assembly Line/Rollers.osg"),
}
rollers8 = Transform {
	position = {9.5,0,-.5},
	--orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Assembly Line/Rollers.osg"),
}
rollers9 = Transform {
	position = {11.7,0,-.5},
	--orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Assembly Line/Rollers.osg"),
}

robot = Transform {
	position = {7.5,0,-9},
	Model("Factory Models/OSG/Machines/Robot.osg"),
}
robot2 = Transform {
	position = {10.5,0,-7},
	orientation = AngleAxis(Degrees(180), Axis{0.0,1.0,0.0}),
	Model("Factory Models/OSG/Machines/Robot.osg"),
}
robot3 = Transform {
	position = {7.5,0,-5},
	Model("Factory Models/OSG/Machines/Robot.osg"),
}	
cnc = Transform{
	position = {-2,0,-4},
	orientation = AngleAxis(Degrees(-90), Axis{0.0,1.0,0.0}),
	Model("Factory Models/OSG/Machines/CNC.osg"),
}

forklift = Transform {
	position = {9,0,1},
	Model("Factory Models/OSG/Shop Carts and Fort Lifts/Forklift.osg"),
}	
StorageBin = Transform{
	position = {-8.7,0,-15},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/Storage Bin.osg"),
}
StorageBin2 = Transform{
	position = {-6.7,0,-15},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/Storage Bin.osg"),
}
StorageBin3 = Transform{
	position = {-4.7,0,-15},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/Storage Bin.osg"),
}
StorageBin4 = Transform{
	position = {-2.7,0,-15},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/Storage Bin.osg"),
}
Lathe =Transform{
	position = {-9,0,-6},
	orientation = AngleAxis(Degrees(30), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/mini_lathe.osg"),
}
Compressor =Transform{
	position = {-9,0,-1.5},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Tools/air compressor.osg"),
}
Workbench = Transform{
	position = {-9.3,0,2},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Work Bench.osg"),
}	
Workbench2 = Transform{
	position = {2,0,-7},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Work Bench.osg"),
}	
Workbench3 = Transform{
	position = {1,0,-8},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Work Bench.osg"),
}	
ToolBox =Transform{
	position = {-8,0,4},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Snapon Tool Box.osg"),
}	
Chair=Transform{
	position = {-8,0,2},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Industrial Chair.osg"),
}	
Welder=Transform{
	position = {-8,.5,-3},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Tools/Mig Welding Cart.osg"),
}	
DrillPress = Transform{
	position = {-8,0,-8},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/Drill Press.osg"),
}
BandSaw = Transform{
	position = {-6,0,-8},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/bandsaw.osg"),
}

RP = Transform{
	position = {-5,0,-7.5},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/Rapid Prototype.osg"),
}
MetalBender = Transform{
	position = {0,0,-4},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/Box Pan Brake.osg"),
}
WaterJet =Transform{
	position = {-1.5,0,-15},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/Water Jet.osg"),
}
ShopCart=Transform{
	position = {0,0,0},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Shop Carts and Fort Lifts/ShopCart.osg"),
}
OpenCart=Transform{
	position = {-2,0,0},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Shop Carts and Fort Lifts/OpenCart.osg"),
}
RelativeTo.World:addChild(factory)
factory:addChild(room)	
--factory:addChild(milling)
--factory:addChild(Lathe)
--factory:addChild(robot)
--factory:addChild(robot2)
--factory:addChild(robot3)
factory:addChild(rollers)
factory:addChild(rollers1)
factory:addChild(rollers2)
factory:addChild(rollers3)
factory:addChild(rollers4)
factory:addChild(rollers5)
factory:addChild(rollers6)
factory:addChild(rollers7)
factory:addChild(rollers8)
factory:addChild(rollers9)
--factory:addChild(cnc)
--factory:addChild(StorageBin)
--factory:addChild(StorageBin2)
--factory:addChild(StorageBin3)
--factory:addChild(StorageBin4)
--factory:addChild(forklift)
--factory:addChild(Compressor)
--factory:addChild(Workbench)
--factory:addChild(Workbench2)
--factory:addChild(Workbench3)
--factory:addChild(ToolBox)
--factory:addChild(Chair)
--factory:addChild(Welder)
--factory:addChild(DrillPress)
--factory:addChild(BandSaw)
--factory:addChild(RP)
--factory:addChild(MetalBender) 
--factory:addChild(WaterJet) 
--factory:addChild(ShopCart) 
--factory:addChild(OpenCart) 