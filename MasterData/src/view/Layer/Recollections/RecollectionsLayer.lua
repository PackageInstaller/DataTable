RecollectionsLayer = class("RecollectionsLayer", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = "RecollectionsLayer/"
local RichTextPro = require("view.Sprite.RichTextPro")
local var_0_4 = 3

function RecollectionsLayer:ctor()
	RecollectionsLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.recollections.recollections_manager"):getInstance()
	self.touchIndex = nil
	self.isAnimation = false
end

function RecollectionsLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = RecollectionsLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function RecollectionsLayer.onEnter(arg_3_0)
	RecollectionsLayer.super.onEnter(arg_3_0)
end

function RecollectionsLayer.onExit(arg_4_0)
	RecollectionsLayer.super.onExit(arg_4_0)
end

function RecollectionsLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function RecollectionsLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:_setBack()
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	TempWidget:CreateTempImg(var_0_2 .. "bg.png", var_6_0):align(cc.p(0.5, 0), var_6_0:size().w / 2, 0)
	TempWidget:CreateTempImg(var_0_2 .. "button.png", var_6_0):align(cc.p(0.5, 0), var_6_0:size().w / 2, 0)

	local var_6_1 = TempWidget:CreateTempImg(var_0_2 .. "title.png", var_6_0)

	var_6_1:align(cc.p(0.5, 1), var_6_0:size().w / 2, var_6_0:size().h - 100)
	var_6_1:setOpacity(0)

	self.titleImg = var_6_1

	local var_6_2 = self.manager:getEnterTips()
	local var_6_3 = TempWidget:CreateTempLabel("", FONT_NAME, 24, var_6_0)

	var_6_3:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
	var_6_3:setLineHeight(50)
	var_6_3:align(cc.p(0.5, 1), var_6_0:size().w / 2, var_6_1:pos().y - var_6_1:size().h - 30)

	self.enterText = var_6_3

	var_6_1:runAction(cc.Sequence:create(cc.FadeIn:create(1.5), cc.CallFunc:create(function()
		local var_7_0 = utfstrlen(var_6_2)
		local var_7_1 = 1

		schedule(var_6_3, function()
			if var_7_1 > var_7_0 then
				var_6_3:stopAllActions()
				self.lightTypewritersImg:runAction(cc.Sequence:create(cc.FadeTo:create(1, 255), cc.CallFunc:create(function()
					self.darkTypewritersImg:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
						self.touchIndex = 1

						self.darkTypewritersImg:runAction(cc.RemoveSelf:create())
					end)))
				end)))

				local var_8_0 = self.inputImg
				local var_8_1 = 1
				local var_8_2 = 1.5

				schedule(self.inputImg, function()
					if var_8_1 == 1 then
						var_8_1 = 2

						var_8_0:runAction(cc.FadeTo:create(var_8_2, 100))
					else
						var_8_1 = 1

						var_8_0:runAction(cc.FadeIn:create(var_8_2))
					end
				end, 1.5)
			else
				local var_8_3 = utfmatch(var_6_2, var_7_1)

				var_6_3:setAnchorPoint(0.5, 1)
				var_6_3:setString(var_8_3)

				var_7_1 = var_7_1 + 1
			end
		end, 0.1)
	end)))

	local var_6_4 = TempWidget:CreateTempImg(var_0_2 .. "dark_typewriters.png", var_6_0)

	var_6_4:align(cc.p(0.5, 0), var_6_0:size().w / 2, -var_6_4:size().h)

	self.darkTypewritersImg = var_6_4

	var_6_4:runAction(cc.MoveTo:create(0.7, cc.p(var_6_0:size().w / 2, 120)))

	local var_6_5 = TempWidget:CreateTempImg(var_0_2 .. "light_typewriters.png", var_6_0)

	var_6_5:setOpacity(0)
	var_6_5:align(cc.p(0.5, 0), var_6_0:size().w / 2, 120)

	self.lightTypewritersImg = var_6_5

	local var_6_6 = TempWidget:CreateTempLabel("点击空白区域继续", FONT_NAME, 25, var_6_5)

	var_6_6:setOpacity(0)
	var_6_6:align(cc.p(0.5, 0), var_6_5:size().w / 2, 290)
	var_6_6:_setColor("000000")

	self.nextTipsText = var_6_6

	local var_6_7 = TempWidget:CreateTempImg(var_0_2 .. "input_img.png", var_6_5)

	var_6_7:align(cc.p(0.5, 0), var_6_5:size().w / 2, 32)

	self.inputImg = var_6_7

	local var_6_8 = TempWidget:CreateTempLayout(var_6_0)

	var_6_8:setContentSize(var_6_0:size())

	self.touchLayout = var_6_8
	self.cardTabel = {}

	for iter_6_0 = 1, var_0_4 do
		local var_6_9 = TempWidget:CreateTempLayout(var_6_0)

		var_6_9:setClippingEnabled(true)
		var_6_9:setBackGroundColorOpacity(150)
		var_6_9:setContentSize(cc.size(var_6_0:size().w, var_6_0:size().h - 275))
		var_6_9:align(cc.p(0.5, 1), var_6_0:size().w / 2, var_6_0:size().h)

		local var_6_10 = TempWidget:CreateTempImg(var_0_2 .. "card.png", var_6_9)

		var_6_10:align(cc.p(0.5, 1), var_6_9:size().w / 2, 0)

		self.cardTabel[iter_6_0] = var_6_10
	end

	local var_6_11 = TempWidget:CreateTempBtn(var_0_2 .. "back.png", var_6_0)

	var_6_11:align(cc.p(0, 0), -var_6_11:size().w, 10)
	var_6_11:runAction(cc.EaseBackOut:create(cc.MoveTo:create(0.5, cc.p(10, 10))))

	self.backBtn = var_6_11
end

function RecollectionsLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
	self.touchLayout:_addEvent(function()
		if not self.touchIndex then
			return
		end

		local var_14_0 = require("controller.recollections.recollections_sweepstake_manager"):getInstance()

		if self.touchIndex == 1 then
			if not self.isAnimation then
				var_14_0:readTrigger(self.touchIndex)

				self.isAnimation = true

				self.lightTypewritersImg:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveTo:create(0.5, cc.p(self._root:size().w / 2, -250)), cc.ScaleTo:create(0.5, 1.23)), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
					self:moveCard()
				end)))
				self.titleImg:runAction(cc.FadeTo:create(0.5, 100))
				self.enterText:runAction(cc.FadeTo:create(0.5, 100))
			end
		elseif self.touchIndex ~= 1 and var_0_4 ~= self.touchIndex then
			if not self.isAnimation then
				self.isAnimation = true

				var_14_0:readTrigger(self.touchIndex)
				self:moveCard()
			end
		elseif var_0_4 == self.touchIndex then
			RoleDefault:getInstance():setBoolForKey(self.manager.WATCH_HISTORY, true)
			LayerManager:removePopLayer()
			LayerManager:pushInLayer("RecollectionsSweepstakeLayer")
		end
	end)
	self.backBtn:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function RecollectionsLayer:moveCard()
	if not self.touchIndex then
		return
	end

	self.nextTipsText:stopAllActions()
	self.nextTipsText:runAction(cc.FadeOut:create(1))

	if self.touchIndex ~= 1 then
		self.cardTabel[self.touchIndex - 1]:runAction(cc.RotateBy:create(0.5, math.atan(20)))
	end

	local var_17_0 = self.cardTabel[self.touchIndex]

	self.cardTabel[self.touchIndex]:runAction(cc.Sequence:create(cc.MoveBy:create(3, cc.p(0, self.cardTabel[self.touchIndex]:getParent():size().h - 50)), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		local var_18_0 = RichTextPro:create()

		var_18_0:setMaxWidth(var_17_0:getContentSize().width * 3)
		var_18_0:setText((self.manager:getCardStr(self.touchIndex)))
		var_18_0:setPosition(cc.p(0, var_17_0:getContentSize().height - 50))

		local var_18_1 = cc.ClippingNode:create()

		var_18_1:setAlphaThreshold(0.5)
		var_18_1:setContentSize(var_17_0:getContentSize())
		var_18_1:setAnchorPoint(cc.p(0, 0))
		var_18_1:setPosition(cc.p(0, 0))
		var_18_1:addChild(var_18_0)

		local var_18_2 = cc.Node:create()
		local var_18_3 = TempWidget:CreateTempLayout(var_18_2)

		var_18_3:_setBack()
		var_18_3:setContentSize(var_17_0:getContentSize())
		var_18_2:setPosition(cc.p(0, var_17_0:getContentSize().height))
		var_18_1:setStencil(var_18_2)
		var_17_0:addChild(var_18_1)
		var_18_2:runAction(cc.Sequence:create(cc.MoveBy:create(5, cc.p(0, -var_17_0:getContentSize().height)), cc.CallFunc:create(function()
			local var_19_0 = 2.5

			self.nextTipsText:stopAllActions()
			self.nextTipsText:runAction(cc.Sequence:create(cc.FadeTo:create(0.5, 100), cc.CallFunc:create(function()
				self.nextTipsText:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(var_19_0, 255), cc.FadeTo:create(var_19_0, 100))))
			end)))

			self.touchIndex = self.touchIndex + 1
			self.isAnimation = false
		end)))
	end)))
end

function RecollectionsLayer.updateLayer(arg_21_0)
	return
end

function RecollectionsLayer.updateRed(arg_22_0)
	return
end

return RecollectionsLayer
