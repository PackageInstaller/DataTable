local var_0_0 = cc.Director:getInstance():getWinSize()
local var_0_1 = var_0_0.width
local var_0_2 = var_0_0.height

ufl_text = require("view.Sprite.UnitConSprite")
UnlockFigureLayer = class("UnlockFigureLayer", function()
	return cc.Layer:create()
end)

function UnlockFigureLayer.create(arg_2_0)
	local var_2_0 = UnlockFigureLayer.new()

	var_2_0:init()

	return var_2_0
end

function UnlockFigureLayer:initBackButton(arg_3_1)
	local var_3_0 = ccui.Button:create("ui/smeltScene/UI_smeltScene_buttonBlueOn.png", "ui/smeltScene/UI_smeltScene_buttonBlue.png")

	if nil ~= nil then
		var_3_0:setPosition(cc.p(-150, 50))
		var_3_0:addTouchEventListener(function(arg_4_0, arg_4_1)
			if touchType == ccui.TouchEventType.began then
				var_3_0:setTouchEnabled(true)
			elseif arg_4_1 == ccui.TouchEventType.ended then
				self:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.RemoveSelf:create(true)))
				var_3_0:setTouchEnabled(false)
			elseif touchType == ccui.TouchEventType.canceled then
				var_3_0:setTouchEnabled(true)
			end
		end)
		ufl_text:strToTTF(var_3_0, L_BUTTON_TEXT.Sure, 74, 33.5, 28)
		self:addChild(var_3_0, 10)
		var_3_0:runAction(cc.Sequence:create(cc.DelayTime:create(1.8), cc.EaseSineOut:create(cc.MoveTo:create(0.2, cc.p(var_0_1 / 2, 50)))))
	end

	local var_3_1 = cc.Sprite:create("ui/word_bg.png")

	var_3_1:setCascadeOpacityEnabled(true)
	var_3_1:setPosition(cc.p(-250, 125))
	ufl_text:strToTTF(var_3_1, L_UNLOCKFIGURE_NEW .. arg_3_1 .. "！", 240, 20.5, 32)
	var_3_1:getChildByTag(1000):setColor(cc.c3b(255, 222, 173))
	var_3_1:runAction(cc.Sequence:create(cc.DelayTime:create(1.6), cc.EaseSineOut:create(cc.MoveTo:create(0.2, cc.p(var_0_1 / 2, 125)))))
	self:addChild(var_3_1, 10)
end

function UnlockFigureLayer:unlocalFigure(arg_5_1)
	local var_5_0 = cc.Sprite:create("loading/loading.jpg")

	var_5_0:setPosition(cc.p(var_0_1 / 2, var_0_2 / 2))

	local var_5_1 = ccui.Button:create("levelScene/grayBg.png", "levelScene/grayBg.png")

	var_5_1:setPosition(cc.p(var_0_1 / 2, var_0_2 / 2))
	self:getChildByTag(1):runAction(cc.Sequence:create(cc.Spawn:create(cc.ScaleTo:create(0.5, 1.8), cc.FadeIn:create(0.5)), cc.EaseSineOut:create(cc.RotateBy:create(0.5, 270)), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		self:getChildByTag(1):runAction(cc.RepeatForever:create((cc.Sequence:create(cc.DelayTime:create(1), cc.ScaleBy:create(1, 1.1), cc.ScaleBy:create(1, 0.9090909090909091)))))
	end)))
	self:getChildByTag(1):runAction(cc.Sequence:create(cc.DelayTime:create(1.5), action2))
	self:getChildByTag(2):runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.Spawn:create(cc.ScaleTo:create(0.5, 0.7), cc.FadeIn:create(0.5)), cc.CallFunc:create(function()
		self:getChildByTag(2):runAction(cc.RepeatForever:create((cc.Sequence:create(cc.DelayTime:create(1), cc.ScaleTo:create(1, 0.77), cc.ScaleTo:create(1, 0.7)))))
	end)))
	self:addChild(var_5_0, -1)
	self:addChild(var_5_1, 0)
end

function UnlockFigureLayer:init()
	self:unlocalFigure("guide/talk/20181.png")
	self:initBackButton(L_UNLOCKFIGURE_BACK_BTN)
end

return UnlockFigureLayer
