Actions.addFrameAction(
	function()
		local mat
		while true do
			mat = CartInfo.tracker.matrix
			local cart_angle = CartInfo.getAngle()
			--print("Cart angle: " .. cart_angle)
			local quat = osg.Quat(cart_angle, Vec(0,1,0))
			mat:setRotate(quat)
			mat:setTrans(mat:getTrans():x(), 0, mat:getTrans():z())
			cartxform:setMatrix(mat)
			Actions.waitForRedraw()
		end
	end
)


cart_product_group = DisableLightingOn(
	Group{
		Transform{
			position = {CartInfo.wand_cart_offset:x(), CartInfo.wand_cart_offset:y(), CartInfo.wand_cart_offset:z()},
			Model("Factory_Models/OSG/Shop_Carts_and_Fork_Lifts/Forklift.osg")
		}
	}
)