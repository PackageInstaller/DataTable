local holeClipping = class("holeClipping", function()
	return cc.ClippingNode:create()
end)

function holeClipping:ctor()
	self:setInverted(true)
	self:setAlphaThreshold(0.5)

	self.stencil = cc.Node:create()
	self.holes = cc.Node:create()

	self:setStencil(self.stencil)
	self:addChild(self.holes)
end

function holeClipping:addHole(arg_3_1)
	local var_3_0 = arg_3_1 or cc.p(0, 0)

	self.stencil:addChild((function()
		local var_4_0 = cc.Sprite:create("explore/circle.png")

		var_4_0:setPosition(cc.p(var_3_0.x, var_3_0.y + var_4_0:getContentSize().height / 3))
		var_4_0:setName("stencilimg")

		return var_4_0
	end)())
end

function holeClipping:addContent(arg_5_1)
	self.holes:addChild(arg_5_1)
end

function holeClipping:setStencilAnchorPoint(arg_6_1)
	if self.stencil:getChildByName("stencilimg") then
		self.stencil:getChildByName("stencilimg"):setAnchorPoint(arg_6_1)
	end
end

function holeClipping:setStencilScale(arg_7_1)
	if self.stencil:getChildByName("stencilimg") then
		self.stencil:getChildByName("stencilimg"):setScale(arg_7_1)
	end
end

function holeClipping:setStencilSetPostion(arg_8_1)
	if self.stencil:getChildByName("stencilimg") then
		self.stencil:getChildByName("stencilimg"):setPosition(cc.p(arg_8_1.x, arg_8_1.y + self.stencil:getChildByName("stencilimg"):getContentSize().height / 3))
	end
end

function holeClipping:create()
	return (holeClipping.new())
end

return holeClipping
