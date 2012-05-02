--dofile([[X:\users\lpberg\VRJuggLua\examples\lys\simpleLights.lua]])
require("DebugAxes")
require("getScriptFilename")
vrjLua.appendToModelSearchPath(getScriptFilename())
dofile(vrjLua.findInModelSearchPath("forklift_function.lua"))
--dofile(vrjLua.findInModelSearchPath([[simpleLights.lua]]))

factory = Transform{
	position = {0,0,0},
}
room = Transform{
	position = {-10,0,5},
	scale = 1.65,
	Model("Factory Models/OSG/Assembly Line/basicfactory.ive"),
}	

milling  = Transform{
	position = {7,0,-9},
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
Diffuser = Transform{
	Model("Factory Models/OSG/Structural/HVACdiffuser.osg"), 
}

Workbench = Transform{
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Work Bench.osg"),
}	

Beam = Transform{
	Model("Factory Models/OSG/Structural/beam.osg"), 
}

Barrel = Transform{
	Model("Factory Models/OSG/Storage and Barrels/OilBarrels.osg"), 
}
HoseReel = Transform{
	Model("Factory Models/OSG/Tools/Hose Reel.osg"),
}
FireExtenguisher = Transform{
	Model("Factory Models/OSG/Tools/Fire_extinguisher.osg"),
	position = {0,1.5,.245},
}	
Wrenches = Transform{
	Model("Factory Models/OSG/Tools/wrenches.osg"),
	position = {-1,.875,0},
}
Chair = Transform{
	position = {-1,0,0},
	orientation = AngleAxis(Degrees(180), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Industrial Chair.osg"),
}
Computer = Transform{
	position = {0,0,-1.5},
	orientation = AngleAxis(Degrees(0), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/Computer.osg"),
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
		position = {11.6,0,-17.4},
		roller2,
	},
	Transform {
		position = {11.6,0,-15.2},
		roller2,
	},
	Transform {
		position = {11.6,0,-13},
		roller2,
	},
	Transform {
		position = {11.6,0,-10.8},
		roller2,
	},
	Transform {
		position = {11.6,0,-8.6},
		roller2,
	},
		Transform {
		position = {11.6,0,-6.4},
		roller2,
	}
}
palletGroup = Group{
	Transform{
		position = {-9,0,-2.4},
		Pallet,
	},
	Transform{
		position = {-8,0,-2.4},
		Pallet,
	},	
	Transform{
		position = {-7,0,-2.4},
		Pallet,
	},	
	Transform{
		position = {-10,0,-2.4},
		Pallet,
	},	
	Transform{
		position = {-10,0,-1.4},
		Pallet,
	},	
	Transform{
		position = {-9,0,-1.4},
		Pallet,
	},	
	Transform{
		position = {-8,0,-1.4},
		Pallet,
	},	
	Transform{
		position = {-7,0,-1.4},
		Pallet,
	},	
}
HVACGroup = Group{
Transform{
		position = {-3.2,7,-10},
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
DiffuserGroup = Group{
	Transform{
	position = {-3.2,6.5,-9},
	Diffuser,
},
	Transform{
	position = {-3.2,6.5,-4},
	Diffuser,
},
	Transform{
	position = {-3.2,6.5,1},
	Diffuser,
},
	Transform{
	position = {3.7,6.5,-4},
	Diffuser,
},
	Transform{
	position = {3.7,6.5,1},
	Diffuser,
},
	Transform{
	position = {10.6,6.5,-9},
	Diffuser,
},
	Transform{
	position = {10.6,6.5,-4},
	Diffuser,
},
	Transform{
	position = {10.6,6.5,1},
	Diffuser,
},
	}
WorkbenchGroup = Group{
	Transform{
	position = {1,0,-10},
	Workbench,
},
	Transform{
	position = {1,0,-6},
	Workbench,
},
	Transform{
	position = {1,0,-2},
	Workbench,
},
	Transform{
	position ={7,0,-13},
	
	Workbench,
},
	Transform{
	position = {11.2,0,-13},
	orientation = AngleAxis(Degrees(180), Axis{0,1,0}),
	Workbench,
},
	Transform{
	position ={11.2,0,-9},
	orientation = AngleAxis(Degrees(180), Axis{0,1,0}),
	Workbench,
},
}
BeamGroup = Group{
	Transform{
		position = {-1.6,0,-2},
		Beam,
	},	
Transform{
		position = {-1.6,0,-9},
		Beam,
	},	
Transform{
		position = {8.4,0,-9},
		Beam,
	},
Transform{
		position = {8.4,0,-2},
		Beam,
	},
}		
	BarrelGroup = Group{
	Transform{
		position = {-9,.0,-7},
		Barrel,
},
	Transform{
		position = {-9,0,-5.7},
		Barrel,
},
	Transform{
		position ={-9,0,-4.4},
		Barrel,
},
	Transform{
		position ={-7.7,0,-7},
		Barrel,
},
	Transform{
		position =  {-7.7,0,-5.7},
		Barrel,
},
	Transform{
		position = {-7.7,0,-4.4},
		Barrel,
},
}
HoseReelGroup = Group{
	Transform{
		position = {1,7.5,-10},
		HoseReel,
},
	Transform{		
		position = {1,7.5,-6},
		HoseReel,
},
	Transform{
		position = {1,7.5,-2},
		HoseReel,
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

StorageBinBlue = Transform{
	position = {-1.5,0,-13.7},
	orientation = AngleAxis(Degrees(180), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/Storage Bin2Blue.osg"),
}
StorageBinRed = Transform{
	position = {-1.0,0,2.5},
	orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/Storage Bin2Red.osg"),
}
StorageBinYellow = Transform{
	position = {15.5,0,-8.8},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/Storage Bin2Yellow.osg"),
}
StorageBinGreen = Transform{
	position = {-2.7,0,-15},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Storage and Barrels/Storage Bin2Green.osg"),
}
Lathe =Transform{
	position = {8,0,4},
	orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/lathe.osg"),
}
Compressor =Transform{
	position = {7,0,-10.5},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Tools/air compressor.osg"),
}
ToolBox =Transform{
	position = {4.1,0,-6},
	orientation = AngleAxis(Degrees(180), Axis{0,1,0}),
	Model("Factory Models/OSG/Workbench/Snapon Tool Box.osg"),
}	
	
Welder=Transform{
	position = {-8,.5,-3},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Tools/Mig Welding Cart.osg"),
}	
DrillPress = Transform{
	position = {5.2,0,-6},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/Drill Press.osg"),
}
BandSaw = Transform{
	--ebugAxes.node,
	position = {3,0,-2},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Machines/bandsaw.osg"),
}
RP = Transform{
	position = {3.2,0,-10},
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
GarageDoor3=Transform{
	position = {16.5,0,-16},
	orientation = AngleAxis(Degrees(180), Axis{0,1,0}),
	Model("Factory Models/OSG/Shop Carts and Fort Lifts/IndustrialDoor.osg"), 
}	
GarageDoor4=Transform{
	position = {16.5,0,-12},
	orientation = AngleAxis(Degrees(180), Axis{0,1,0}),
	Model("Factory Models/OSG/Shop Carts and Fort Lifts/IndustrialDoor.osg"), 
}	
ForkliftPath =Transform{
	position = {-8,.01,5},
	--orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Shop Carts and Fort Lifts/Path.osg"), 
}	
packaging = Transform{
	position = {14.18,.001,7},
	orientation = AngleAxis(Degrees(90), Axis{0,1,0}),
	Model("Factory Models/OSG/Assembly Line/packaging.osg"), 
}
Ladder = Transform{
position = {12,.5,-19},
	orientation = AngleAxis(Degrees(-90), Axis{0,1,0}),
	Model("Factory Models/OSG/Structural/Ladder.osg"), 
}

factory:addChild(room)	
factory:addChild(milling)
factory:addChild(Lathe)
factory:addChild(robot)
factory:addChild(robot2)
factory:addChild(rollerGroup)
factory:addChild(rollerGroup2)
factory:addChild(palletGroup)
factory:addChild(HVACGroup)
factory:addChild(DiffuserGroup)
factory:addChild(WorkbenchGroup)
factory:addChild(BeamGroup)
factory:addChild(BarrelGroup)
factory:addChild(HoseReelGroup)
factory:addChild(StorageBinBlue)
factory:addChild(StorageBinRed)
factory:addChild(StorageBinYellow)
--factory:addChild(StorageBinGreen)
factory:addChild(room)
factory:addChild(Compressor)
factory:addChild(ToolBox)
factory:addChild(Welder)
factory:addChild(DrillPress)
factory:addChild(BandSaw)
factory:addChild(RP)
factory:addChild(MetalBender) 
--factory:addChild(WaterJet) 
factory:addChild(ShopCart) 
factory:addChild(OpenCart) 
factory:addChild(Ladder)
factory:addChild(GarageDoor1)
factory:addChild(GarageDoor2)
factory:addChild(GarageDoor3)
factory:addChild(GarageDoor4)
factory:addChild(packaging)
--factory:addChild(ForkliftPath)
factory:addChild(Ladder)
Beam:addChild(FireExtenguisher)
Workbench:addChild(Wrenches)
Workbench:addChild(Chair)
Workbench:addChild(Computer)
forkliftmatrix = osg.MatrixTransform()

forklift = Transform {
	position = {8,0,1},
	Model("Factory Models/OSG/Shop Carts and Fort Lifts/Forklift.osg"),
}	
forkliftmatrix:addChild(forklift)
factory:addChild(forkliftmatrix)

return factory
