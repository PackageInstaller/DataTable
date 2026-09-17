ConfirmDialogSprite = class("ConfirmDialogSprite", function()
	return ccui.Layout:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = {
	ScoreArenaLayer = false,
	PopFriendIntroduceLayer = true,
	PopComponentStrengthenLayer = false,
	MarketLayer = true,
	HorcruxInfoLayerNew = true,
	ActivitySignLayer_4_1 = true,
	noTitle = false,
	InviteLayer = true,
	BagLayer = true,
	TwisteggLayer = true,
	CommunityMainLayer = true
}

function ConfirmDialogSprite.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	local var_2_0 = ConfirmDialogSprite.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)

	return var_2_0
end

function ConfirmDialogSprite:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ConfirmDialogSprite.json" or "ConfirmDialogSprite.ExportJson")

	self:addChild(self.rootLayer)

	self.sureCallback = arg_3_3.surecallback
	self.cancelCallback = arg_3_3.cancelCallback

	local var_3_0 = arg_3_3.btnLabel

	self.layerType = arg_3_3.layerType or "noTitle"
	self.headImage = arg_3_3.headImage or nil
	self.btnNo = ccui.Helper:seekWidgetByName(self.rootLayer, "button_no")

	if var_0_1[self.layerType] then
		local var_3_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_head")

		var_3_1:loadTexture("public/title/title_operation_comfirm.png", var_0_0)
		var_3_1:setPositionX(var_3_1:getPositionX() - 8)
		var_3_1:setPositionY(var_3_1:getPositionY() + 5)
		ccui.Helper:seekWidgetByName(self.rootLayer, "title"):setVisible(false)

		if self.headImage then
			var_3_1:loadTexture(self.headImage, var_0_0)
		end
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_head"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "title"):setString(arg_3_1)
		ccui.Helper:seekWidgetByName(self.rootLayer, "title"):setVisible(true)
	end

	local var_3_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "description")

	self.btnYes = ccui.Helper:seekWidgetByName(self.rootLayer, "button_yes")

	if var_3_0 then
		self.btnYes:getChildByName("button_label"):setString(var_3_0)
	end

	self.imageConsume = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_25")

	if self.layerType and self.layerType == "PopFriendIntroduceLayer" then
		self.btnYes:setPositionX(189)
		ccui.Helper:seekWidgetByName(self.rootLayer, "button_no"):setPositionX(450)
	end

	if self.layerType and self.layerType == "CommunityMainLayer" then
		if arg_3_3.assgin == 1 then
			self.btnYes:setPositionX(189)
			self.btnNo:setPositionX(450)
			self.btnYes:loadTextures("public/button/public_button_blue.png", nil, nil, var_0_0)
			self.btnNo:loadTextures("public/button/public_button_orange.png", nil, nil, var_0_0)
		end

		if arg_3_3.btntext then
			if arg_3_3.btntext.yes then
				self.btnYes:getChildByName("button_label"):setString(arg_3_3.btntext.yes)
			end

			if arg_3_3.btntext.yes then
				self.btnNo:getChildByName("button_label"):setString(arg_3_3.btntext.no)
			end
		end
	end

	if arg_3_4 then
		self.imageConsume:setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "button_no"):setVisible(false)
		self.btnYes:setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_25"):getPositionX() + 25)
		self.btnYes:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "button_yes"):getPositionY() - 10)
		self.btnYes:loadTextures("public/button/public_button_orange_big.png", nil, nil, var_0_0)

		local var_3_3 = self.btnYes:getContentSize()

		self.btnYes:getChildByName("button_label"):setPosition(cc.p(var_3_3.width / 2 - 10, var_3_3.height / 2 - 5))

		local var_3_4 = ccui.Helper:seekWidgetByName(self.rootLayer, "box"):getContentSize()

		var_3_2:setPosition(cc.p(var_3_4.width / 2, var_3_4.height / 2 - 10))
	end

	if arg_3_5 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_25"):setVisible(false)
	end

	if arg_3_2 then
		if arg_3_3.name == "equip" then
			var_3_2:ignoreContentAdaptWithSize(false)
			var_3_2:setContentSize(cc.size(550, 100))
			var_3_2:setPositionY(var_3_2:getPositionY() - 15)
		end

		var_3_2:setString(arg_3_2)
	end

	if arg_3_3.more then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Back"):setString(arg_3_3.more)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Back"):setScaleY(0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Back"):runAction(cc.ScaleTo:create(0.1, 1))
	self:changeData(arg_3_3)
	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Back"):runAction(cc.ScaleTo:create(0.1, 1, 0))
		end), cc.DelayTime:create(0.1), cc.RemoveSelf:create(), cc.CallFunc:create(function()
			if arg_3_6 then
				arg_3_6()
			end
		end)))
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "button_no"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.cancelCallback then
			self.cancelCallback(arg_7_0, arg_7_1)
		end

		self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
			ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Back"):runAction(cc.ScaleTo:create(0.1, 1, 0))
		end), cc.DelayTime:create(0.1), cc.RemoveSelf:create()))
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Back"):setTouchEnabled(false)
	self.btnNo:getChildByName("button_label"):setString(L_BUTTON_TEXT.Can_cel)
	self.btnYes:getChildByName("button_label"):setString(L_BUTTON_TEXT.Sure)
	self:fullScreen(self.rootLayer, arg_3_3.parenttype)
end

function ConfirmDialogSprite:changeData(arg_9_1)
	local var_9_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_16")

	if arg_9_1.cost then
		if arg_9_1.cost == 0 then
			var_9_0:setString(L_FREE_FOR_CHARGE)
			self.imageConsume:setVisible(false)
		else
			var_9_0:setVisible(false)
			self.imageConsume:getChildByName("Label_26"):setString(arg_9_1.cost)
		end
	end

	if arg_9_1.remaintimes and arg_9_1.remaintimes <= 0 then
		self.btnYes:loadTextures("public/button/public_button_off.png", "public/button/public_button_off.png", "public/button/public_button_off_click.png", var_0_0)
		var_9_0:setVisible(false)
		self.imageConsume:setVisible(false)
		self.btnYes:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords(L_NO_TIMES)
		end)
	else
		self:judgeHandleType(arg_9_1)
	end
end

function ConfirmDialogSprite:judgeHandleType(arg_11_1)
	if arg_11_1.cost and arg_11_1.own < arg_11_1.cost and not arg_11_1.ignorecost then
		if arg_11_1.costtype == "diamond" then
			self.imageConsume:loadTexture(IMAGE_DIAMOND, var_0_0)
			self.btnYes:addTouchEventListener(function(arg_12_0, arg_12_1)
				if arg_12_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_11_1.cancelCallback then
					arg_11_1.cancelCallback()
				end

				LayerManager:pushInLayer("PopGoBuyDiamond", {
					is_need_pop_layer = 0,
					releaselayer = self
				})
			end)
		elseif arg_11_1.costtype == "gold" then
			self.imageConsume:loadTexture(IMAGE_GOLD, var_0_0)
			self.btnYes:addTouchEventListener(function(arg_13_0, arg_13_1)
				if arg_13_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_11_1.cancelCallback then
					arg_11_1.cancelCallback()
				end

				LayerManager:pushInLayer("PopGoLayer", {
					targetlayer = "HandOfMidasLayer",
					labels = L_GO_BUY_GOLD,
					releaselayer = self
				})
			end)
		end
	else
		self.btnYes:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.sureCallback then
				self.sureCallback(arg_14_0, arg_14_1)
			end

			self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
				ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Back"):runAction(cc.ScaleTo:create(0.1, 1, 0))
			end), cc.DelayTime:create(0.1), cc.RemoveSelf:create()))
		end)
	end
end

function ConfirmDialogSprite.fullScreen(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:setContentSize((GameDisplay.getScreenSize()))
	arg_16_1:getChildByName("Panel_Back"):setPositionY(arg_16_1:getChildByName("Panel_Back"):getPositionY() + GameDisplay.fix_y)

	if arg_16_2 and arg_16_2 == 1 then
		arg_16_1:setPositionY(arg_16_1:getPositionY() - GameDisplay.fix_y)
	end
end
