require "gldef"

local wiihelp = Transform{
	position={0,1.3,0},
	orientation=AngleAxis(Degrees(90), Axis{1.0,0.0,0.0}),
	scale=.5,
	Model([[helpMenu/helpMenu.ive]]),
}

local ss = wiihelp:getOrCreateStateSet()

ss:setMode(gldef.GL_LIGHTING, osg.StateAttribute.Values.OFF)

-- This line makes it so that it draws over everything (except apparently transparent stuff like the frusta)
ss:setMode(gldef.GL_DEPTH_TEST, osg.StateAttribute.Values.OFF)

-- This line makes it draw after the transparent things.
ss:setRenderingHint(osg.StateSet.RenderingHint.TRANSPARENT_BIN)

-- This changes the render order - see http://forum.openscenegraph.org/viewtopic.php?t=9884
-- Not sure how this interacts with the above line.
-- The number is just an arbitrarily large number, while RenderBin is the sorting method.
ss:setRenderBinDetails(100, "RenderBin")

Actions.addFrameAction(
	function()
		local device = gadget.DigitalInterface("WMButton2")
		-- local device = gadget.DigitalInterface("VJButton2")
		while true do
			repeat
				Actions.waitForRedraw()
			until device.justPressed
			RelativeTo.Room:addChild(wiihelp)
			repeat
				Actions.waitForRedraw()
			until device.justPressed
			RelativeTo.Room:removeChild(wiihelp)
		end
	end
)
