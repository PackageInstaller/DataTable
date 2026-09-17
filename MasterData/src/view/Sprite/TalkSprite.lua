TalkSprite = class("TalkSprite", function()
	return ccui.Button:create("mainScenebg/word_bg_1.png", "mainScenebg/word_bg_1.png", "mainScenebg/word_bg_1.png")
end)

local item_data = require("data.item_data")

function TalkSprite.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = TalkSprite.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)

	return var_2_0
end

function TalkSprite:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_2 = arg_3_2 or 160
	arg_3_3 = arg_3_3 or "fonts/yanwenzi.ttf"

	self:setScale9Enabled(true)
	self:setCapInsets(cc.rect(65, 20, 30, 10))
	self:setAnchorPoint(cc.p(0.25, 0))
	self:setFlippedY(true)
	self:setPositionY(arg_3_2)
	self:setScale(0.1)

	local var_3_0 = cc.Label:createWithTTF(arg_3_1, arg_3_3, 24)

	var_3_0:setMaxLineWidth(250)
	var_3_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_0:setColor(cc.c3b(219, 228, 255))
	var_3_0:setName("talk_label")
	self:addChild(var_3_0)

	wid, het = var_3_0:getContentSize().width, var_3_0:getContentSize().height

	self:setContentSize(cc.size(wid + 40, het + 37))
	var_3_0:setPosition(cc.p((wid + 40) / 2, (het + 37) / 2 + 5))
	self:createArrow()
	self:runAction(cc.Sequence:create(cc.ScaleTo:create(0.3, 1.5), cc.ScaleTo:create(0.1, 1)))

	arg_3_4 = arg_3_4 or 3

	self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_3_4), cc.CallFunc:create(function()
		self:touchDisappear(arg_3_5)
	end)))
	self:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:setTouchEnabled(false)
		self:stopAllActions()
		self:touchDisappear(arg_3_5)
	end)
end

function TalkSprite:updateString(arg_6_1, arg_6_2, arg_6_3)
	arg_6_2 = arg_6_2 or 3

	self:getChildByName("talk_label"):setString(arg_6_1)

	local var_6_0 = self:getChildByName("talk_label"):getContentSize().width
	local var_6_1 = self:getChildByName("talk_label"):getContentSize().height

	self:setContentSize(cc.size(var_6_0 + 40, var_6_1 + 37))
	self:getChildByName("talk_label"):setPosition(cc.p((var_6_0 + 40) / 2, (var_6_1 + 37) / 2 + 5))
	self:setScale(1)
	self:stopAllActions()
	self:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(function()
		self:touchDisappear(arg_6_3)
	end)))
end

function TalkSprite:touchDisappear(arg_8_1)
	self:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 0.1), cc.CallFunc:create(function()
		if arg_8_1 then
			arg_8_1()
		end
	end), cc.RemoveSelf:create()))
end

function TalkSprite:createArrow()
	self.arrow = ccui.ImageView:create("mainScenebg/word_bg_2.png")

	self.arrow:setFlippedY(true)
	self.arrow:setName("arrow")
	self.arrow:setAnchorPoint(cc.p(0.5, 1))
	self.arrow:setPosition(cc.p(self:getContentSize().width / 4, 2))
	self:addChild(self.arrow)
end

function TalkSprite:setArrowPositionX(arg_11_1)
	if not self.arrow then
		return
	end

	self.arrow:setPositionX(arg_11_1)
end

function TalkSprite:setArrowPositionY(arg_12_1)
	if not self.arrow then
		return
	end

	self.arrow:setPositionY(arg_12_1)
end
