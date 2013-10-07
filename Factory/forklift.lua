require("Actions")

local forklift = Transform{
	position = {7.5, 0, .5},
	orientation = AngleAxis(Degrees(0), Axis{0, 1, 0}),
	Model([[Factory Models/OSG/Shop Carts and Fork Lifts/Forklift.osg]]),
}

RelativeTo.World:addchild(forklift)

Actions.addFrameAction(
	function()
		local wand = gadget.PositionInterface('VJWand')
		local device = gadget.DigitalInterface("WMButtonDown")
		while true do
			repeat
				Actions.waitForRedraw()
			until device.justPressed
			RelativeTo.World:removechild(forklift)
			RelativeTo.Room:addchild(forklift)
			repeat
				Actions.waitForRedraw()
			until device.justPressed
			RelativeTo.Room:removechild(forklift)
			RelativeTo.World:addchild(forklift)
		end
	end
)