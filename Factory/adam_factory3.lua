dofile([[X:\users\lpberg\VRJuggLua\examples\lys\litfactory.lua]])
dofile([[X:\users\lpberg\VRJuggLua\examples\movetools.lua]])
--vrjLua.appendToModelSearchPath([[X:/users/lpberg/VRJuggLua/models/]])
require("Actions")
require("getScriptFilename")
fn = getScriptFilename()
print(fn)
assert(fn, "Have to load this from file, not copy and paste, or we can't find our models!")
vrjLua.appendToModelSearchPath(fn)


--Origin Sphere Representation
RelativeTo.World:addChild(Sphere{radius=.25})

factory = Transform{
	position = {0,0,0},
}
room = Transform{
	position = {-10,0,5},
	--orientation = AngleAxis(Degrees(-90), Axis{1.0, 0.0, 0.0}),
	scale = 1.65,
	Model("Factory Models/OSG/Assembly Line/basicfactory2.ive"),
}	
milling  = Transform{
	position = {9.5,0,-9},
	orientation = AngleAxis(Degrees(-90), Axis{0.0, 1.0, 0.0}),
	Model("Factory Models/OSG/Machines/milling machine.osg"),
}
roller = Transform{
	Model("Factory Models/OSG/Assembly Line/Rollers.osg"),
}
roller2 = Transform{
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Assembly Line/Rollers.osg"),
}
Pallet = Transform{
	Model("Factory Models/OSG/Shop Carts and Fort Lifts/pallet.osg")
}	
HVAC = Transform{
	Model("Factory Models/OSG/Structural/HVAC48Tube.osg"),
}
	
rollerGroup = Group{
	Transform {
		position = {-11,0,-13},
		roller,
	},
	Transform {
		position = {-8.8,0,-13},
		roller,
	},
		Transform {
		position = {-6.6,0,-13},
		roller,
	},
		
		Transform {
		position = {-3,0,-15},
		roller,
	},
		Transform {
		position = {-.8,0,-15},
		roller,
	},
		Transform {
		position = {1.6,0,-15},
		roller,
	},
		Transform {
		position = {6,0,-15},
		roller,
	},	
		Transform {
		position = {3.8,0,-15},
		roller,
	},
		Transform {
		position = {8.2,0,-15},
		roller,
	},
	
}

rollerGroup2 = Group{
	Transform {
		position = {-1.5,0,-13.5},
		roller2,
	},
		Transform {
		position = {-1.5,0,-11.3},
		roller2,
	},
		Transform {
		position = {-1.5,0,-9.1},
		roller2,
	},
		Transform {
		position = {-1.5,0,-6.9},
		roller2,
	},
		Transform {
		position = {-1.5,0,-4.7},
		roller2,
	},
	Transform {
		position = {13.8,0,-13},
		roller2,
	},
	Transform {
		position = {13.8,0,-10.8},
		roller2,
	},
	Transform {
		position = {13.8,0,-8.6},
		roller2,
	},
	Transform {
		position = {13.8,0,-6.4},
		roller2,
	},
	Transform {
		position = {13.8,0,-4.4},
		roller2,
	},
		Transform {
		position = {13.8,0,-2.4},
		roller2,
	}
}

palletGroup = Group{
	Transform{
		position = {-9,0,-2.4},
		Pallet,
	},
	Transform{
		position = {-9,0,-2.4},
		Pallet,
	},	
	Transform{
		position = {-9,0,-2.4},
		Pallet,
	},	
	Transform{
		position = {-9,0,-2.4},
		Pallet,
	},	
	Transform{
		position = {-9,0,-2.4},
		Pallet,
	},	
	Transform{
		position = {-9,0,-2.4},
		Pallet,
	},	
	Transform{
		position = {-9,0,-2.4},
		Pallet,
	},	
	Transform{
		position = {-9,0,-2.4},
		Pallet,
	},	
}

HVACGroup = Group{
Transform{
		position = {-3.2,7,-10},,
		HVAC,
	},
Transform{
		position = {-3.2,7,0},
		HVAC,
	},
Transform{
		position = {-3.2,7,5},
		HVAC,
	},
Transform{
		position = {3.7,7,-10},
		HVAC,
	},
	Transform{
		position = {3.7,7,0},
		HVAC,
	},
Transform{
		position = {10.6,7,-10},
		HVAC,
	},
Transform{
		position = {3.7,7,5},
		HVAC,
	},	
Transform{
		position = {10.6,7,0},
		HVAC,
	},	
Transform{
		position = {10.6,7,5},
		HVAC,
	},	
}	


	
robot = Transform {
	position = {-3,0,-12},
	Model("Factory Models/OSG/Machines/Robot.osg"),
}
robot2 = Transform {
	position = {-3,0,-15},
	--orientation = AngleAxis(Degrees(180), Axis{0.0,1.0,0.0}),
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
StorageBinBlue = Transform{
	position = {-1.5,0,-13.7},
	orientation = AngleAxis(Degrees(180), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/Storage Bin2Blue.osg"),
}
StorageBinRed = Transform{
	position = {1.5,0,.5},
	orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/Storage Bin2Red.osg"),
}
StorageBinYellow = Transform{
	position = {12.9,0,-2},
	orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/Storage Bin2Yellow.osg"),
}
StorageBinGreen = Transform{
	position = {-2.7,0,-15},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/Storage Bin2Green.osg"),
}
Lathe =Transform{
	position = {-9,0,-6},
	orientation = AngleAxis(Degrees(30), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/mini_lathe.osg"),
}
Compressor =Transform{
	position = {7,0,-10.5},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Tools/air compressor.osg"),
}
Workbench = Transform{
	position = {3,0,-10},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Work Bench.osg"),
}	
Workbench2 = Transform{
	position = {3,0,-6},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Work Bench.osg"),
}	
Workbench3 = Transform{
	position = {3,0,-2},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Work Bench.osg"),
}	
Workbench4 = Transform{
	position = {7,0,-13},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Work Bench.osg"),
}	
Workbench5 = Transform{
	position = {11.2,0,-13},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Work Bench.osg"),
}	
Workbench6 = Transform{
	position = {11.2,0,-9},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Work Bench.osg"),
}	
Workbench7 = Transform{
	position = {11.2,0,-5},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Work Bench.osg"),
}	
ToolBox =Transform{
	position = {5.5,0,-6},
	orientation = AngleAxis(Degrees(180), Axis{0,1,0}),
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
	position = {4.2,0,-6},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/Drill Press.osg"),
}
BandSaw = Transform{
	position = {4.2,0,-2},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/bandsaw.osg"),
}

RP = Transform{
	position = {4.2,0,-10},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/Rapid Prototype.osg"),
}
MetalBender = Transform{
	position = {4.2,0,-13},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/Box Pan Brake.osg"),
}
WaterJet =Transform{
	position = {-2.5,0,-5},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/Water Jet.osg"),
}
ShopCart=Transform{
	position = {2.6,0,-3.5},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Shop Carts and Fort Lifts/ShopCart.osg"),
}
OpenCart=Transform{
	position = {-2,0,0},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Shop Carts and Fort Lifts/OpenCart.osg"),
}
GarageDoor1 = Transform{
	position = {-10,0,-12.5},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Shop Carts and Fort Lifts/IndustrialDoor.osg"), 
}	
GarageDoor2 = Transform{
	position = {-10,0,-8.5},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Shop Carts and Fort Lifts/IndustrialDoor.osg"), 
}	
ForkliftPath =Transform{
	position = {-8,.01,2},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Shop Carts and Fort Lifts/Path.osg"), 
}	
Barrel =Transform{
	position = {-9,.0,-7},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/OilBarrels.osg"), 
}	
Barrel2 =Transform{
	position = {-9,0,-5.7},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/OilBarrels.osg"), 
}	
Barrel3 =Transform{
	position = {-9,0,-4.4},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/OilBarrels.osg"), 
}	
Barrel4 =Transform{
	position = {-7.7,0,-7},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/OilBarrels.osg"), 
}	
Barrel5 =Transform{
	position = {-7.7,0,-5.7},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/OilBarrels.osg"), 
}	
Barrel6 =Transform{
	position = {-7.7,0,-4.4},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/OilBarrels.osg"), 
}	


Wrenches =Transform{
	position = {-1,1,0},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Tools/wrenches.osg"), 
}	
Diffuser1 =Transform{
	position = {-3.2,6.5,-9},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/HVACdiffuser.osg"), 
}	
Diffuser2 =Transform{
	position = {-3.2,6.5,-4},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/HVACdiffuser.osg"), 
}	
Diffuser3 =Transform{
	position = {-3.2,6.5,1},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/HVACdiffuser.osg"), 
}	
Diffuser4=Transform{
	position = {3.7,6.5,-9},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/HVACdiffuser.osg"), 
}
Diffuser5 =Transform{
	position = {3.7,6.5,-4},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/HVACdiffuser.osg"), 
}	
Diffuser6 =Transform{
	position = {3.7,6.5,1},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/HVACdiffuser.osg"), 
}
Diffuser7=Transform{
	position = {10.6,6.5,-9},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/HVACdiffuser.osg"), 
}
Diffuser8 =Transform{
	position = {10.6,6.5,-4},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/HVACdiffuser.osg"), 
}	
Diffuser9 =Transform{
	position = {10.6,6.5,1},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/HVACdiffuser.osg"), 
	}

Beam1=Transform{
	position = {-1.6,0,-2},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/beam.osg"), 
}
Beam2=Transform{
	position = {-1.6,0,-9},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/beam.osg"), 
}
Beam3=Transform{
	position = {8.4,0,-9},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/beam.osg"), 
}
Beam4=Transform{
	position = {8.4,0,-2},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/beam.osg"), 
}
RelativeTo.World:addChild(factory)
factory:addChild(room)	
factory:addChild(milling)
--factory:addChild(Lathe)
factory:addChild(robot)
factory:addChild(robot2)
--factory:addChild(robot3)
factory:addChild(rollerGroup)
factory:addChild(rollerGroup2)
factory:addChild(palletGroup)
factory:addChild(HVACGroup)

--factory:addChild(cnc)
factory:addChild(StorageBinBlue)
factory:addChild(StorageBinRed)
factory:addChild(StorageBinYellow)
--factory:addChild(StorageBinGreen)
factory:addChild(forklift)
factory:addChild(Compressor)
factory:addChild(Workbench)
factory:addChild(Workbench2)
factory:addChild(Workbench3)
factory:addChild(Workbench4)
factory:addChild(Workbench5)
factory:addChild(Workbench6)
factory:addChild(Workbench7)

factory:addChild(ToolBox)
factory:addChild(Chair)
factory:addChild(Welder)
factory:addChild(DrillPress)
factory:addChild(BandSaw)
factory:addChild(RP)
factory:addChild(MetalBender) 
--factory:addChild(WaterJet) 
factory:addChild(ShopCart) 
factory:addChild(OpenCart) 

factory:addChild(GarageDoor1)
factory:addChild(GarageDoor2)

--factory:addChild(ForkliftPath)
factory:addChild(Barrel)
factory:addChild(Barrel2)
factory:addChild(Barrel3)
factory:addChild(Barrel4)
factory:addChild(Barrel5)
factory:addChild(Barrel6)

Workbench3:addChild(Wrenches)

factory:addChild(Diffuser1)
factory:addChild(Diffuser2)
factory:addChild(Diffuser3)
factory:addChild(Diffuser4)
factory:addChild(Diffuser5)
factory:addChild(Diffuser6)
factory:addChild(Diffuser7)
factory:addChild(Diffuser8)
factory:addChild(Diffuser9)


factory:addChild(Beam1)
factory:addChild(Beam2)
factory:addChild(Beam3)
factory:addChild(Beam4)
