require "AddAppDirectory"
require "osgUtil"
AddAppDirectory()

runfile[[Factory/factorylighting.lua]]
factory_model = runfile[[Factory/Factory.lua]]
op = osgUtil.Optimizer()
op:optimize(factory_model,osgUtil.Optimizer.OptimizationOptions.ALL_OPTIMIZATIONS)
RelativeTo.World:addChild(factory_model)

runfile[[Factory/frameActionSwitcher.lua]]
runfile[[Factory/navigation.lua]]
runfile[[Factory/helpMenu.lua]]