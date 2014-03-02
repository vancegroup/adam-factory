require "AddAppDirectory"
require "osgUtil"
AddAppDirectory()

runfile "factorylighting.lua"
factory_model = runfile "Factory.lua"
op = osgUtil.Optimizer()
op:optimize(factory_model,osgUtil.Optimizer.OptimizationOptions.ALL_OPTIMIZATIONS)
RelativeTo.World:addChild(model)
