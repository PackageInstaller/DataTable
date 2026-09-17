local CheckPrivacyLayer = class("CheckPrivacyLayer", function()
	return ccui.Layout:create()
end)

function CheckPrivacyLayer:create()
	local var_2_0 = CheckPrivacyLayer.new()

	var_2_0:init()

	return var_2_0
end

function CheckPrivacyLayer:init()
	self:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self:setTouchEnabled(true)

	local var_3_0 = cc.Sprite:create("mainScenebg/login/privacy/bg.png")

	var_3_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self:addChild(var_3_0)

	local var_3_1 = ccui.Button:create("mainScenebg/login/privacy/close.png", "mainScenebg/login/privacy/close.png", "mainScenebg/login/privacy/close.png")

	var_3_1:setPosition(cc.p(var_3_0:getContentSize().width - 20, var_3_0:getContentSize().height - 10))
	var_3_0:addChild(var_3_1, 2)
	var_3_1:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:runAction(cc.RemoveSelf:create())
	end)

	self.bg = var_3_0

	self:addPrivacyItems()
end

function CheckPrivacyLayer:addPrivacyItems()
	local var_5_0 = self.bg:getContentSize().width / 2 + 90
	local var_5_1 = self.bg:getContentSize().height - 70
	local var_5_2 = require("controller.account_manager"):getChannel()
	local var_5_3 = self:createPrivacyItem("查看用户协议", function()
		DeviceManager.openURL("https://h-college.com/protocol/horcrux_v1/user.html")
	end)

	var_5_3:setPosition(cc.p(var_5_0, var_5_1))
	self.bg:addChild(var_5_3)

	local var_5_4 = self:createPrivacyItem("查看隐私政策", function()
		DeviceManager.openURL("https://h-college.com/protocol/horcrux_v1/privacy.html")
	end)

	var_5_4:setPosition(cc.p(var_5_0, var_5_1 - 60))
	self.bg:addChild(var_5_4)

	local var_5_5 = self:createPrivacyItem("查看第三方信息共享清单", function()
		DeviceManager.openURL("https://h-college.com/protocol/horcrux/third.html")
	end)

	var_5_5:setPosition(cc.p(var_5_0, var_5_1 - 60 * 2))
	self.bg:addChild(var_5_5)

	local var_5_6 = self:createPrivacyItem("查看儿童隐私政策", function()
		DeviceManager.openURL("https://h-college.com/protocol/horcrux_v1/child.html")
	end)

	var_5_6:setPosition(cc.p(var_5_0, var_5_1 - 60 * 3))
	self.bg:addChild(var_5_6)

	local var_5_7 = self:createPrivacyItem("查看个人信息清单", function()
		DeviceManager.openURL("https://h-college.com/protocol/horcrux/userinfo.html")
	end)

	var_5_7:setPosition(cc.p(var_5_0, var_5_1 - 60 * 4))
	self.bg:addChild(var_5_7)

	local var_5_8 = self:createPrivacyItem("查看第三方sdk清单", function()
		DeviceManager.openURL("https://h-college.com/protocol/horcrux/sdk.html")
	end)

	var_5_8:setPosition(cc.p(var_5_0, var_5_1 - 60 * 5))
	self.bg:addChild(var_5_8)

	local var_5_9 = self:createPrivacyItem("取消服务条款及隐私政策授权", function()
		if DeviceManager.getPackageChannel() == "FY" then
			FeiyuManager.registerPrivacyHandler(function(arg_13_0, arg_13_1)
				print("Feiyu Privacy Callback: ", arg_13_0, arg_13_1)

				if arg_13_0 ~= 1 then
					global_restart_game()
				end
			end)
			FySDK.showPrivacyDialog(true)
		else
			local var_12_0 = require("view.Layer.PrivacyLayer"):create()

			var_12_0:registerRefuseHandler(global_restart_game)
			cc.Director:getInstance():getRunningScene():addChild(var_12_0, 999)
		end
	end)

	var_5_9:setPosition(cc.p(var_5_0, var_5_1 - 60 * 6))
	self.bg:addChild(var_5_9)
end

function CheckPrivacyLayer:createPrivacyItem(arg_14_1, arg_14_2)
	local var_14_0 = ccui.Button:create("mainScenebg/login/privacy/infobg.png", "mainScenebg/login/privacy/infobg.png", "mainScenebg/login/privacy/infobg.png")
	local var_14_1 = cc.Label:createWithTTF(arg_14_1, FONT_DES, 20)

	var_14_1:setAnchorPoint(cc.p(0, 0.5))
	var_14_1:setPosition(cc.p(20, var_14_0:getContentSize().height / 2))
	var_14_0:addChild(var_14_1)

	local var_14_2 = cc.Sprite:create("mainScenebg/login/privacy/tag.png")

	var_14_2:setAnchorPoint(cc.p(1, 0.5))
	var_14_2:setPosition(cc.p(var_14_0:getContentSize().width - 10, var_14_0:getContentSize().height / 2))
	var_14_0:addChild(var_14_2)
	var_14_0:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_14_2()
	end)

	return var_14_0
end

return CheckPrivacyLayer
