local AssetsLayer = class("AssetsLayer", function()
	return cc.Layer:create()
end)

require("data.constants")
require("data.language_constants")
require("data.audio_constants")
require("controller.helper")
require("controller.global_func")

local TempWidget = require("view.Sprite.TempWidget")
local var_0_2 = 1
local assets_ui_manager = require("controller.assets_ui_manager")
local load_assets_manager = require("controller.load_assets_manager")
local var_0_5
local var_0_6 = {
	bar = "update/upgrade.png",
	loadsp = "update/sp.png",
	barbg = "update/upgrade_background.png",
	bg = "mainScenebg/loginBG.jpg",
	loadingbg = "update/load.png"
}

function AssetsLayer:create(arg_2_1)
	local var_2_0 = AssetsLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function AssetsLayer.getInstance()
	return var_0_5
end

function AssetsLayer:init(arg_4_1)
	package.loaded["controller.base_manager"] = nil
	package.loaded["data.global_constants_data"] = nil
	package.loaded["controller.base_manager"] = nil
	package.loaded["controller/layer_notification_manager"] = nil
	package.loaded["controller.layer_notification_manager"] = nil
	package.loaded["controller.account_manager"] = nil
	package.loaded["controller.account.account_palmpi"] = nil
	package.loaded["controller.account.account_feiyu"] = nil
	package.loaded["network.network"] = nil
	package.loaded["network.sproto.proto"] = nil

	require("network.sproto.proto").reload()

	var_0_5 = self
	self.loadhandler = arg_4_1

	self:initLoadingBar()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_5 = nil

			if self.loadScheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.loadScheduler)
			end
		end
	end)
end

function AssetsLayer:initLoadingBar()
	local var_6_0 = cc.Sprite:create(var_0_6.loadingbg)

	var_6_0:setAnchorPoint(cc.p(0.5, 0))
	var_6_0:setPosition(cc.p(320, 0))
	self:addChild(var_6_0, 1)

	self.barbg = TempWidget:CreateTempLayout()

	self.barbg:setAnchorPoint(cc.p(0.5, 0))
	self.barbg:setContentSize(cc.size(GameDisplay.width, 14))
	self.barbg:setPosition(cc.p(var_6_0:getContentSize().width / 2, var_6_0:getContentSize().height - 5))
	var_6_0:addChild(self.barbg, 1)

	self.bar = cc.ProgressTimer:create(cc.Sprite:create(var_0_6.bar))

	self.bar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.bar:setBarChangeRate(cc.p(1, 0))
	self.bar:setMidpoint(cc.p(0, 0))
	self.bar:setAnchorPoint(cc.p(0.5, 0.5))
	self.bar:setPosition(cc.p(self.barbg:getContentSize().width / 2, self.barbg:getContentSize().height / 2))
	self.barbg:addChild(self.bar, 2)
	self.bar:setPercentage(0)

	self.loadSp = cc.Sprite:create(var_0_6.loadsp)

	self.loadSp:setPosition(cc.p(self.barbg:getContentSize().width * 0 / 100, self.barbg:getContentSize().height / 2))
	self.barbg:addChild(self.loadSp, 3)

	self.loadInfo = cc.Label:createWithTTF(L_LOADING_MSG.Loading_Bar_Text, "fonts/number.ttf", 18)

	self.loadInfo:setAnchorPoint(cc.p(0.5, 0))
	self.loadInfo:setPosition(cc.p(var_6_0:getContentSize().width / 2, 18))
	var_6_0:addChild(self.loadInfo, 3)

	local var_6_1 = assets_ui_manager:getLoadAni()

	self.ani = sp.SkeletonAnimation:create(var_6_1 .. ".json", var_6_1 .. ".atlas", 1)

	self.ani:setPosition(cc.p(self.barbg:getContentSize().width * 0 / 100, self.barbg:getContentSize().height))
	self.barbg:addChild(self.ani, 4)
	self.ani:setAnimation(0, "run", true)

	local var_6_2 = TempWidget:CreateTempLabel("0%", "fonts/name.ttf", 24)

	self.ani:addChild(var_6_2)
	var_6_2:align(cc.p(1, 0.5), -var_6_2:size().w + 10, self.ani:getContentSize().height / 2 + 10)
	var_6_2:_setColor("#FFE076")

	self.percentText = var_6_2
end

function AssetsLayer:startLoading()
	load_assets_manager.start()

	var_0_2 = 1
	self.loadScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		if AssetsLayer.getInstance() then
			self:updateLoading()
		end
	end, 0, false)
end

function AssetsLayer:updateLoading()
	local var_9_0 = load_assets_manager.getProcess()

	var_9_0 = var_9_0 < 100 and var_9_0 or 100

	self.bar:setPercentage(var_9_0)
	self.percentText:setString(string.format("%d", var_9_0) .. "%")
	self.loadSp:setPosition(cc.p(self.barbg:getContentSize().width * var_9_0 / 100, self.barbg:getContentSize().height / 2))
	self.ani:setPositionX(self.barbg:getContentSize().width * var_9_0 / 100)

	if var_9_0 >= 100 then
		if var_0_2 > 1 then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.loadScheduler)

			self.loadScheduler = nil

			self.loadhandler()
		else
			var_0_2 = var_0_2 + 1
		end
	end
end

return AssetsLayer
