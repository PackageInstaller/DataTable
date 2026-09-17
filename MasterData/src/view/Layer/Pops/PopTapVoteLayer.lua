PopTapVoteLayer = class("PopTapVoteLayer", function()
	return PopBaseLayer:create()
end)

local activity_calendar_data = require("data.activity_calendar_data")
local time_check_manager = require("controller.time_check_manager")

function PopTapVoteLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopTapVoteLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopTapVoteLayer:init(arg_3_1)
	print("open poplayer : PopTapVoteLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopTapVoteLayer.json" or "PopTapVoteLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self:addChild(self.rootLayer)
	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function PopTapVoteLayer:initUI()
	self:initExitTouchEvent()
	self:initBtns()
	self:playJoinInEffect()
end

function PopTapVoteLayer:initExitTouchEvent()
	self.rootpanel = ccui.ImageView:create("mainScenebg/activity/branch286/vote_bg.png")

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.rootpanel, -1)
	self.rootpanel:setTouchEnabled(true)
	self.rootpanel:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_7_0:isBright() then
			return
		end

		arg_7_0:setBright(false)
		self:exit()
	end)
end

local function var_0_3(arg_8_0)
	return ({
		[820] = 0.12,
		[880] = 0.87,
		[840] = 0.38,
		[870] = 0.75,
		[900] = 1,
		[890] = 0.9,
		[860] = 0.62,
		[830] = 0.25,
		[850] = 0.5
	})[arg_8_0] or 0
end

function PopTapVoteLayer:initBtns()
	local var_9_0 = {
		["270051"] = true,
		palmpi = true,
		["270001"] = true,
		["270049"] = true,
		["270050"] = true
	}

	self.btnReturn = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_11")

	self.btnReturn:setTouchEnabled(true)
	self.btnReturn:setPositionY(self.btnReturn:getPositionY() - GameDisplay.fix_y)
	self.btnReturn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			LayerManager:removePopLayer(self.__queueindex)
		end)))
	end)

	self.prebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "pre_btn")
	self.pre = ccui.Helper:seekWidgetByName(self.rootLayer, "pre_top")
	self.btnVote = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_10")

	self.btnVote:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_12_0 = DeviceManager:getChannelID()

		if var_12_0 == "270049" and cc.Native:hasInstalledTapTap() then
			DeviceManager.openURL("taptap://taptap.com/app?app_id=42949")
		elseif var_9_0[var_12_0] then
			DeviceManager.openURL("https://www.taptap.com/app/42949/review")
		else
			return
		end

		AnalyticManager.PopTapVoteLayer({
			channelid = var_12_0
		})
	end)
	require("network.network"):rpc("get_taptap_support", {}, function(arg_13_0)
		self.prebtn:setPositionX(self.pre:getPositionX() + self.pre:getContentSize().width * var_0_3(arg_13_0.score))
		self.pre:setScaleX(var_0_3(arg_13_0.score))
	end)
end

function PopTapVoteLayer:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopTapVoteLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopTapVoteLayer:initBg(arg_17_1)
	local var_17_0 = ccui.Layout:create()

	var_17_0:setTouchEnabled(true)
	var_17_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_17_0:setAnchorPoint(cc.p(0, 0))
	var_17_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_17_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_17_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_17_0:setOpacity(0)
	self:addChild(var_17_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_18_0)
		self:addChild(arg_18_0, -2)
		arg_18_0:setPositionY(arg_18_0:getPositionY() - GameDisplay.fix_y)

		local var_18_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_18_0:setAnchorPoint(cc.p(0, 0))
		var_18_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_18_0, -1)
		self:init(arg_17_1)
		var_17_0:setOpacity(102)
		var_17_0:setTouchEnabled(false)
	end)
end
