require("Actions")

local forklift = Transform {
	position = {0, 0, 0 },
	orientation = AngleAxis(Degrees(-90), Axis{0, 1, 0}),
	Model[[Factory Models/OSG/Shop Carts and Fork Lifts/Forklift.osg]]
}
RelativeTo.Room:addChild(forklift)

Actions.addFrameAction(
	function()
		local wand = gadget.PositionInterface('VJWand')
		local device = gadget.DigitalInterface("VJButton2")
		while true do
			repeat
				Actions.waitForRedraw()
			until device.justPressed
			RelativeTo.Room:removeChild(forklift)
			RelativeTo.World:addChild(forklift)
			repeat
				Actions.waitForRedraw()
			until device.justPressed
			RelativeTo.World:removeChild(forklift)
			RelativeTo.Room:addChild(forklift)
		end
	end
)