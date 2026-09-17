local PrivacyLayer = class("PrivacyLayer", function()
	return ccui.Layout:create()
end)

function PrivacyLayer:create()
	local var_2_0 = PrivacyLayer.new()

	var_2_0:init()

	return var_2_0
end

function PrivacyLayer:init()
	self:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self:setTouchEnabled(true)
	self:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self:setBackGroundColor(cc.c3b(0, 0, 0))
	self:setBackGroundColorOpacity(150)

	self._agreecallback = nil
	self._refusecallback = nil

	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "enter" then
			self:onEnter()
		end
	end)
end

local var_0_1 = "       欢迎您使用《魂器学院》！如您之前未使用本游戏及相关服务，在您使用本游戏的服务前，请您务必审慎阅读、充分理解《用户协议》、《隐私条款》、《儿童隐私保护条款》的各条款，了解我们对您个人信息的处理规则。\n       同时您应特别注意前述协议中免除或者限制我们责任的条款、对您权利进行限制的条款、约定争议解决方式和司法管辖的条款，未经您同意，我们不会提供给任何第三方进行使用，我们会采用业界领先的安全措施保护您的个人信息安全。\n        您可以阅读以下几项条款了解详细信息。如您同意，请勾选以下几项条款并点击“同意”开始接受我们的服务。"
local var_0_2 = "https://h-college.com/protocol/horcrux_v1/user.html"
local var_0_3 = "https://h-college.com/protocol/horcrux_v1/privacy.html"
local var_0_4 = "https://h-college.com/protocol/horcrux_v1/child.html"

function PrivacyLayer:initUI()
	self._bg = ccui.ImageView:create("update/bg_privacy.png")

	self:addChild(self._bg)

	local var_5_0 = cc.Label:createWithTTF(var_0_1, "fonts/yanwenzi.ttf", 23)

	var_5_0:setAnchorPoint(cc.p(0.5, 1))
	var_5_0:setHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
	var_5_0:setMaxLineWidth(500)
	self._bg:addChild(var_5_0)
	self._bg:setPosition(cc.p(320, GameDisplay.height / 2))
	var_5_0:setPosition(cc.p(self._bg:getContentSize().width / 2, self._bg:getContentSize().height - 160))
	self._bg:setOpacity(0)
	self:addPrivacyLabels()
	self:addPrivacyButtons()
end

function PrivacyLayer:addPrivacyLabels()
	local function var_6_0(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		local var_7_0 = ccui.Text:create(arg_7_0, "fonts/yanwenzi.ttf", 22)

		var_7_0:setAnchorPoint(cc.p(0, 0.5))
		var_7_0:setColor(arg_7_1)
		self._bg:addChild(var_7_0)

		if arg_7_2 then
			var_7_0:setTouchEnabled(true)
			var_7_0:addTouchEventListener(function(arg_8_0, arg_8_1)
				if arg_8_1 ~= ccui.TouchEventType.ended then
					return
				end

				arg_7_2()
			end)
		end

		if arg_7_3 then
			var_7_0:setPosition(cc.p(arg_7_3:getPositionX() + arg_7_3:getContentSize().width + 2, arg_7_3:getPositionY()))
		end

		return var_7_0
	end

	local var_6_1 = var_6_0("点击查看", cc.c3b(255, 255, 255))

	var_6_1:setPosition(cc.p(80, 220))

	local var_6_2 = var_6_0("儿童隐私保护条款", cc.c3b(100, 100, 255), function()
		DeviceManager.openURL(var_0_4)
	end, (var_6_0("和", cc.c3b(255, 255, 255), nil, (var_6_0("隐私条款", cc.c3b(100, 100, 255), function()
		DeviceManager.openURL(var_0_3)
	end, (var_6_0("、", cc.c3b(255, 255, 255), nil, (var_6_0("用户协议", cc.c3b(100, 100, 255), function()
		DeviceManager.openURL(var_0_2)
	end, var_6_1)))))))))
end

function PrivacyLayer:addPrivacyButtons()
	self._btnSure = ccui.Button:create("update/btn_privacy_sure.png", nil, "update/btn_privacy_sure.png")

	self._btnSure:setPosition(cc.p(self._bg:getContentSize().width / 2 + 125, 80))
	self._bg:addChild(self._btnSure)
	self._btnSure:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_13_0:isBright() then
			return
		end

		arg_13_0:setBright(false)
		self:onAgreePrivacy()
	end)

	self._btnRefuse = ccui.Button:create("update/btn_privacy_refuse.png", nil, "update/btn_privacy_refuse.png")

	self._btnRefuse:setPosition(cc.p(self._bg:getContentSize().width / 2 - 125, 80))
	self._bg:addChild(self._btnRefuse)
	self._btnRefuse:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_14_0:isBright() then
			return
		end

		arg_14_0:setBright(false)
		self:onRefusePrivacy()
	end)
end

function PrivacyLayer:onAgreePrivacy()
	cc.UserDefault:getInstance():setBoolForKey("agreeprivacy", true)

	if self._agreecallback then
		self._agreecallback()
	end

	self:onExit()
end

function PrivacyLayer:onRefusePrivacy()
	cc.UserDefault:getInstance():setBoolForKey("agreeprivacy", false)

	if self._refusecallback then
		self._refusecallback()
	end

	self:onExit()
end

function PrivacyLayer:registerAgreeHandler(arg_17_1)
	self._agreecallback = arg_17_1
end

function PrivacyLayer:registerRefuseHandler(arg_18_1)
	self._refusecallback = arg_18_1
end

function PrivacyLayer:onEnter()
	self._bg:runAction(cc.FadeIn:create(0.5))
end

function PrivacyLayer:onExit()
	self._bg:runAction(cc.FadeOut:create(0.5))
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.RemoveSelf:create()))
end

return PrivacyLayer
