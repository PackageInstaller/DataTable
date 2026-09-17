GuideClipping = class("GuideClipping", function()
	return cc.ClippingNode:create()
end)

local var_0_0 = "Guide/guide_frame.png"

function GuideClipping.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = GuideClipping.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3)

	return var_2_0
end

function GuideClipping:init(arg_3_1, arg_3_2, arg_3_3)
	self:setInverted(true)
	self:initTouchListener(arg_3_1)
	self:initClippingShelter(arg_3_2)
	self:initClippingFrame(arg_3_3)
end

function GuideClipping:initClippingFrame(arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0

	if config._DEBUG then
		var_4_0 = cc.Scale9Sprite:create(var_0_0) or cc.Scale9Sprite:createWithSpriteFrameName(var_0_0)
	end

	var_4_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_4_0:setPosition(arg_4_1.pos)
	var_4_0:setCapInsets(cc.rect(50, 25, 50, 20))
	var_4_0:setPreferredSize(cc.size(arg_4_1.rect.width + 38, arg_4_1.rect.height + 38))
	self:addChild(var_4_0, 5)
end

function GuideClipping:initClippingShelter(arg_5_1)
	if not arg_5_1 then
		self:initClippingWithEmpty()

		return
	end

	local var_5_0 = cc.LayerColor:create(cc.c4b(0, 0, 0, 153), GameDisplay.width, GameDisplay.height)

	var_5_0:setPosition(cc.p(-GameDisplay.fix_x, -GameDisplay.fix_y))
	self:addChild(var_5_0)

	if arg_5_1.shelterdelay then
		var_5_0:setOpacity(0)
		var_5_0:runAction(cc.FadeTo:create(arg_5_1.shelterdelay, 153))
	end

	if arg_5_1.resource then
		self:initClippingWithResource(arg_5_1)
	else
		self:initClippingWithRect(arg_5_1)
	end
end

function GuideClipping:initClippingWithEmpty()
	self._stencilnode = cc.DrawNode:create()

	self._stencilnode:drawSolidRect(cc.p(0, 0), cc.p(10, 10), cc.c4f(1, 1, 1, 1))
	self:setStencil(self._stencilnode)
end

function GuideClipping:initClippingWithResource(arg_7_1)
	if arg_7_1.resource:find("mainScenebg") or arg_7_1.resource:find("equipment/") or arg_7_1.resource:find("roleimage/") then
		self._stencilnode = cc.Sprite:create(arg_7_1.resource)
	elseif config._DEBUG then
		self._stencilnode = cc.Sprite:create(arg_7_1.resource) or cc.Sprite:createWithSpriteFrameName(arg_7_1.resource)
	end

	self._stencilnode:setPosition(arg_7_1.pos)
	self:setStencil(self._stencilnode)
	self:setAlphaThreshold(arg_7_1.alphathreshold or 0.5)
end

function GuideClipping:initClippingWithRect(arg_8_1)
	self._stencilnode = cc.DrawNode:create()

	self._stencilnode:drawSolidRect(cc.p(arg_8_1.rect.x, arg_8_1.rect.y), cc.p(arg_8_1.rect.x + arg_8_1.rect.width, arg_8_1.rect.y + arg_8_1.rect.height), cc.c4f(1, 1, 1, 1))
	self:setStencil(self._stencilnode)
end

function GuideClipping:initTouchListener(arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_1.rect
	local var_9_1 = cc.EventListenerTouchOneByOne:create()

	var_9_1:setSwallowTouches(true)
	var_9_1:registerScriptHandler(function(arg_10_0, arg_10_1)
		if cc.rectContainsPoint(var_9_0, (self:convertTouchToNodeSpace(arg_10_0))) then
			return false
		else
			return true
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_9_1:registerScriptHandler(function(arg_11_0, arg_11_1)
		return
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_9_1, self)
end
