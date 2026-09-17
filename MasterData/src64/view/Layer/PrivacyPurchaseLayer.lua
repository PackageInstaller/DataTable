local PrivacyPurchaseLayer = class("PrivacyPurchaseLayer", function()
	return ccui.Layout:create()
end)

function PrivacyPurchaseLayer:create(arg_2_1, arg_2_2)
	local var_2_0 = PrivacyPurchaseLayer.new()

	var_2_0:init(arg_2_1, arg_2_2)

	return var_2_0
end

function PrivacyPurchaseLayer:init(arg_3_1, arg_3_2)
	self:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self:setTouchEnabled(true)

	local var_3_0 = cc.Sprite:create("update/bg_privacy.png")

	var_3_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self:addChild(var_3_0)

	self.bg = var_3_0
	self.agreehandler = arg_3_1
	self.denyhandler = arg_3_2

	self:initInfo()
	self:initButtons()
end

function PrivacyPurchaseLayer:initInfo()
	local var_4_1 = cc.Label:createWithTTF("本服务需联网，获取网络、账号、交易、身份、通讯、设备、应用信息、以及您主动上传的数据。可能会使用您的相机，用于提供应用内支付服务。\n我们仅收集实现业务功能所必需的个人信息。并提供充分的安全保障措施，确保您的数据安全。详情可参阅", "fonts/yanwenzi.ttf", 23)

	var_4_1:setAnchorPoint(cc.p(0.5, 1))
	var_4_1:setHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
	var_4_1:setMaxLineWidth(500)
	var_4_1:setPosition(cc.p(self.bg:getContentSize().width / 2 + 10, self.bg:getContentSize().height - 130))
	self.bg:addChild(var_4_1)

	local var_4_2 = var_4_1:getContentSize().width
	local var_4_3 = var_4_1:getContentSize().height
	local var_4_4 = ccui.Text:create("关于华为应用内支付与隐私的声明", "fonts/yanwenzi.ttf", 23)

	var_4_4:setColor(cc.c3b(100, 100, 255))
	var_4_4:setAnchorPoint(cc.p(0, 0.5))
	var_4_4:setPosition(cc.p(self.bg:getContentSize().width / 2 - 210, self.bg:getContentSize().height - 150 - var_4_3))
	var_4_4:setTouchEnabled(true)
	var_4_4:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		DeviceManager.openURL("https://developer.huawei.com/consumer/cn/doc/development/HMSCore-Guides/sdk-data-security-0000001050044906")
	end)
	self.bg:addChild(var_4_4)

	local var_4_5 = ccui.Button:create("mainScenebg/login/privacy/mark_frame.png", "mainScenebg/login/privacy/mark_frame.png", "mainScenebg/login/privacy/mark_frame.png")

	var_4_5:setPosition(cc.p(self.bg:getContentSize().width / 2 - 230, self.bg:getContentSize().height - 145 - var_4_3))
	self.bg:addChild(var_4_5)

	local var_4_6 = cc.Sprite:create("mainScenebg/login/privacy/mark.png")

	var_4_6:setPosition(cc.p(var_4_5:getContentSize().width / 2, var_4_5:getContentSize().height / 2))
	var_4_5:addChild(var_4_6)
	var_4_6:setName("mark")
	var_4_6:setVisible(cc.UserDefault:getInstance():getBoolForKey("agreehuaweipurchase", false))
	var_4_5:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_6_0:getChildByName("mark"):setVisible(not arg_6_0:getChildByName("mark"):isVisible())
	end)

	self.checkMark = var_4_5
end

function PrivacyPurchaseLayer:initButtons()
	self.btnSure = ccui.Button:create("update/btn_privacy_sure.png", nil, "update/btn_privacy_sure.png")

	self.btnSure:setPosition(cc.p(self.bg:getContentSize().width / 2 + 125, 80))
	self.bg:addChild(self.btnSure)
	self.btnSure:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.checkMark:getChildByName("mark"):isVisible() then
			global_ShowBlockWords("请先同意隐私声明")

			return
		end

		self:onAgree()
	end)

	self.btnRefuse = ccui.Button:create("update/btn_privacy_refuse.png", nil, "update/btn_privacy_refuse.png")

	self.btnRefuse:setPosition(cc.p(self.bg:getContentSize().width / 2 - 125, 80))
	self.bg:addChild(self.btnRefuse)
	self.btnRefuse:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:onDeny()
	end)
end

function PrivacyPurchaseLayer:onEnter()
	self.bg:runAction(cc.FadeIn:create(0.5))
end

function PrivacyPurchaseLayer:onExit()
	self.bg:runAction(cc.FadeOut:create(0.1))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.RemoveSelf:create()))
end

function PrivacyPurchaseLayer:onAgree()
	cc.UserDefault:getInstance():setBoolForKey("agreehuaweipurchase", true)
	self:onExit()
	self.agreehandler()
end

function PrivacyPurchaseLayer:onDeny()
	cc.UserDefault:getInstance():setBoolForKey("agreehuaweipurchase", false)
	self:onExit()
	self.denyhandler()
end

return PrivacyPurchaseLayer
