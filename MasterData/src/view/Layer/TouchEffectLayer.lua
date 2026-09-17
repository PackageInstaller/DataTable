TouchEffectLayer = class("TouchEffectLayer", function()
	return cc.Layer:create()
end)
TouchEffectLayer.touchTail = nil
TouchEffectLayer.tailEmissionRate = 0
TouchEffectLayer.lastTouchPos = cc.p(0, 0)

local audio_manager = require("controller.audio_manager")
local var_0_2 = 1.5
local var_0_3 = 16
local var_0_4 = (function(arg_2_0)
	local var_2_0 = {
		255,
		255,
		255
	}
	local var_2_1 = {
		-1,
		-1,
		-1
	}

	for iter_2_0 = 1, #var_2_1 do
		var_2_1[iter_2_0] = var_2_1[iter_2_0] * 5
	end

	return function()
		local var_3_0 = math.random(3)

		var_2_0[var_3_0] = var_2_0[var_3_0] + var_2_1[var_3_0]

		if var_2_0[var_3_0] > 255 then
			var_2_0[var_3_0] = 255
			var_2_1[var_3_0] = var_2_1[var_3_0] * -1
		elseif var_2_0[var_3_0] < 100 then
			var_2_0[var_3_0] = 100
			var_2_1[var_3_0] = var_2_1[var_3_0] * -1
		end

		return var_2_0[0], var_2_0[1], var_2_0[2]
	end
end)(10)

local function var_0_5(arg_4_0)
	local var_4_0 = cc.Sprite:create("effect/particle/fire.png")

	var_4_0:setScaleX(var_0_2)
	var_4_0:setScaleY(var_0_2 * 0.5)
	var_4_0:setOpacity(200)
	var_4_0:setRotation(arg_4_0)
	var_4_0:runAction(cc.Sequence:create(cc.FadeTo:create(0.5, 0), cc.RemoveSelf:create()))

	return var_4_0
end

function TouchEffectLayer:createTail(arg_5_1, arg_5_2)
	local var_5_0 = cc.pSub(arg_5_2, arg_5_1)
	local var_5_1 = cc.pNormalize(var_5_0)

	while var_0_3 < cc.pGetLength(var_5_0) do
		local var_5_2 = var_0_5(cc.pGetAngle(var_5_0, cc.p(1, 0)) * 180 / 3.14)

		var_5_2:setPosition(cc.p(arg_5_1.x + var_5_1.x * var_0_3, arg_5_1.y + var_5_1.y * var_0_3))
		self:addChild(var_5_2)
	end
end

function TouchEffectLayer.createTouchCircle(arg_6_0)
	local var_6_0 = cc.Node:create()
	local var_6_1 = cc.Sprite:create("effect/touchEffect/touchCircle1.png")
	local var_6_2 = cc.Sprite:create("effect/touchEffect/touchCircle2.png")
	local var_6_3 = cc.Sprite:create("effect/touchEffect/touchCircle3.png")

	var_6_1:runAction(cc.FadeTo:create(0.7, 0))
	var_6_2:runAction(cc.FadeTo:create(0.7, 0))
	var_6_2:runAction(cc.ScaleTo:create(0.7, 1.5))
	var_6_3:runAction(cc.FadeTo:create(0.7, 0))
	var_6_3:runAction(cc.ScaleTo:create(0.7, 1.5))
	var_6_0:addChild(var_6_3)
	var_6_0:addChild(var_6_2)
	var_6_0:addChild(var_6_1)
	var_6_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.7), cc.RemoveSelf:create()))

	return var_6_0
end

function TouchEffectLayer.initTouchLayer(arg_7_0)
	local var_7_0 = cc.EventListenerTouchOneByOne:create()

	var_7_0:setSwallowTouches(false)
	var_7_0:registerScriptHandler(function(arg_8_0, arg_8_1)
		if arg_7_0.touching then
			return false
		end

		arg_7_0.touching = true
		arg_7_0.unTouchCount = 0

		local var_8_0 = var_0_5(cc.pGetAngle(cc.pSub(arg_7_0.lastTouchPos, arg_8_0:getLocation()), cc.p(1, 0)) * 180 / 3.14)

		var_8_0:setPosition(arg_8_0:getLocation())
		arg_7_0:addChild(var_8_0)

		arg_7_0.lastTouchPos = arg_8_0:getLocation()

		local var_8_1 = arg_7_0:createTouchCircle()

		var_8_1:setPosition(arg_8_0:getLocation())
		arg_7_0:addChild(var_8_1)
		audio_manager:playeffectMusic(SWITCH_EFFECT, false, 0.5)

		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_7_0:registerScriptHandler(function(arg_9_0, arg_9_1)
		local var_9_0 = var_0_5(cc.pGetAngle(cc.pSub(arg_7_0.lastTouchPos, arg_9_0:getLocation()), cc.p(1, 0)) * 180 / 3.14)

		var_9_0:setPosition(arg_9_0:getLocation())
		arg_7_0:addChild(var_9_0)

		if cc.pGetLength(arg_9_0:getLocation(), arg_7_0.lastTouchPos) > var_0_3 then
			arg_7_0:createTail(arg_7_0.lastTouchPos, arg_9_0:getLocation())
		end

		arg_7_0.lastTouchPos = arg_9_0:getLocation()
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_7_0:registerScriptHandler(function(arg_10_0, arg_10_1)
		arg_7_0.touching = false
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_7_0:registerScriptHandler(function(arg_11_0, arg_11_1)
		arg_7_0.touching = false
	end, cc.Handler.EVENT_TOUCH_CANCELLED)
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(var_7_0, arg_7_0)
end

function TouchEffectLayer.create(arg_12_0)
	local var_12_0 = TouchEffectLayer.new()

	var_12_0:init()

	return var_12_0
end

function TouchEffectLayer:init()
	self.touching = false

	self:initTouchLayer()
	self:initCleanListener()
end

function TouchEffectLayer:initCleanListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("cleanTouchEffect", function()
		self:removeAllChildren()
	end), self)
end
