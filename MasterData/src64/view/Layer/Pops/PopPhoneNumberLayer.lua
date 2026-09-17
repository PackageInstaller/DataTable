PopPhoneNumberLayer = class("PopPhoneNumberLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local time_check_manager = require("controller.time_check_manager")
local network = require("network.network")

local function var_0_3(arg_2_0)
	return string.match(arg_2_0, "^1[3-9]%d%d%d%d%d%d%d%d%d$")
end

function PopPhoneNumberLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = PopPhoneNumberLayer.new()

	var_3_0:initBg(arg_3_1)

	return var_3_0
end

function PopPhoneNumberLayer:init(arg_4_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Layout:create()

	self.rootpanel:setContentSize(GameDisplay.getScreenSize())
	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2)
	self.rootLayer:addChild(self.rootpanel)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end
	end, 0)
	self:initUI()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			if self.scheduler then
				time_check_manager:removeUpdatePool(self.scheduler)

				self.scheduler = nil
			end

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end
	end)
end

function PopPhoneNumberLayer:initUI()
	local var_7_0 = ccui.ImageView:create("PopPhoneNumberLayer/bg.png", var_0_0)

	var_7_0:setPosition(cc.p(320, 660 - GameDisplay.fix_y))
	self.rootpanel:addChild(var_7_0)

	local var_7_1 = ccui.ImageView:create("PopPhoneNumberLayer/phone.png", var_0_0)

	var_7_1:setPosition(cc.p(250, 300))
	var_7_0:addChild(var_7_1)

	local var_7_2 = cc.EditBox:create(cc.size(257, 50), (config._DEBUG or nil) and (cc.Scale9Sprite:create("PopPhoneNumberLayer/editbox.png") or cc.Scale9Sprite:createWithSpriteFrameName("PopPhoneNumberLayer/editbox.png")))

	var_7_2:setAnchorPoint(cc.p(0, 0.5))
	var_7_2:setPosition(cc.p(290, 300))
	var_7_2:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	var_7_2:setFontSize(23)
	var_7_2:setPlaceholderFontColor(cc.c3b(96, 108, 155))
	var_7_2:setPlaceHolder(L_INPUT_PHONE_NUM)
	var_7_0:addChild(var_7_2)

	self.btnSend = ccui.Button:create("PopPhoneNumberLayer/get_btn.png", nil, "PopPhoneNumberLayer/get_btn.png", var_0_0)

	self.btnSend:setPosition(cc.p(422, 240))
	var_7_0:addChild(self.btnSend)

	self.waitLbl = cc.Label:createWithTTF("sadasdsad", "fonts/number.ttf", 23)

	self.waitLbl:setPosition(cc.p(self.btnSend:getContentSize().width / 2, self.btnSend:getContentSize().height / 2))
	self.waitLbl:setVisible(false)
	self.btnSend:addChild(self.waitLbl)

	local function var_7_3(arg_8_0)
		self.btnSend:loadTextures("PopPhoneNumberLayer/re_send.png", nil, "PopPhoneNumberLayer/re_send.png", var_0_0)
		self.waitLbl:setString(string.format(L_PHONE_WAIT_TIME, 60))
		self.waitLbl:setVisible(true)

		self.scheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(arg_8_0, function(arg_9_0)
			self.waitLbl:setString(string.format(L_PHONE_WAIT_TIME, arg_9_0))

			if arg_9_0 <= 0 and self.scheduler then
				self.waitLbl:setVisible(false)
				self.btnSend:loadTextures("PopPhoneNumberLayer/get_btn.png", nil, "PopPhoneNumberLayer/get_btn.png", var_0_0)
				time_check_manager:removeUpdatePool(self.scheduler)

				self.scheduler = nil
			end
		end)))
	end

	self.btnSend:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.scheduler then
			return
		end

		local var_10_0 = var_7_2:getText()

		if var_0_3(var_10_0) then
			var_7_3(60)
			network:rpc("send_sms_code", {
				phone = var_10_0
			}, function(arg_11_0)
				if arg_11_0.result == 1 then
					global_ShowBlockWords(L_SMS_PHONE_SUCCESS)
				end
			end)
		else
			global_ShowBlockWords(L_PHONE_NUMBER_ERROR)
		end
	end)

	local var_7_4 = cc.EditBox:create(cc.size(257, 50), (config._DEBUG or nil) and (cc.Scale9Sprite:create("PopPhoneNumberLayer/editbox.png") or cc.Scale9Sprite:createWithSpriteFrameName("PopPhoneNumberLayer/editbox.png")))

	var_7_4:setAnchorPoint(cc.p(0, 0.5))
	var_7_4:setPosition(cc.p(290, 180))
	var_7_4:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	var_7_4:setFontSize(23)
	var_7_4:setPlaceholderFontColor(cc.c3b(96, 108, 155))
	var_7_4:setPlaceHolder(L_INPUT_PHONE_CODE)
	var_7_0:addChild(var_7_4)

	local var_7_5 = ccui.Button:create("PopPhoneNumberLayer/bind.png", nil, "PopPhoneNumberLayer/bind.png", var_0_0)

	var_7_5:setPosition(cc.p(345, 70))
	var_7_0:addChild(var_7_5)
	var_7_5:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		network:rpc("verify_sms_code", {
			code = var_7_4:getText()
		}, function(arg_13_0)
			print(dump(arg_13_0))

			if arg_13_0.result == 1 then
				global_ShowBlockWords(L_VERIFY_PHONE_SUCCESS)
				global_gain(arg_13_0)
				LayerManager:removePopLayer(self.__queueindex)
			else
				global_ShowBlockWords(L_VERIFY_PHONE_FAIL)
			end
		end)
	end)

	self.btnClose = ccui.Button:create("PopPhoneNumberLayer/close.png", nil, "PopPhoneNumberLayer/close.png", var_0_0)

	self.btnClose:setPosition(cc.p(600, 550))
	var_7_0:addChild(self.btnClose)
	self.btnClose:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
end

function PopPhoneNumberLayer:initBg(arg_16_1)
	local var_16_0 = ccui.Layout:create()

	var_16_0:setTouchEnabled(true)
	var_16_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_16_0:setAnchorPoint(cc.p(0, 0))
	var_16_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_16_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_16_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_16_0:setOpacity(0)
	self:addChild(var_16_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_17_0)
		self:addChild(arg_17_0, -2)
		arg_17_0:setPositionY(arg_17_0:getPositionY() - GameDisplay.fix_y)

		local var_17_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_17_0:setAnchorPoint(cc.p(0, 0))
		var_17_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_17_0, -1)
		self:init(arg_16_1)
		var_16_0:setOpacity(102)
		var_16_0:setTouchEnabled(false)
	end)
end
