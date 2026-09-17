ActivityNinifaExploreLayer = class("ActivityNinifaExploreLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")
local activity_ninifa_manager = require("controller.activity_ninifa_manager")

function ActivityNinifaExploreLayer.create(arg_2_0)
	local var_2_0 = ActivityNinifaExploreLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityNinifaExploreLayer:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityNinifaExploreLayer.json" or "ActivityNinifaExploreLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:initBtnTouchEventListener()
	self:fullScreen()
	self:registerActivityEventListener()
	activity_ninifa_manager:getNinifaExploreInfo()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityNinifaExploreLayer")
		end
	end)
end

function ActivityNinifaExploreLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("ActivityNinifaExploreLayer", activity_manager.activityEventId.ACTIVITY_EXPLORE_DATA_UPDATE, function(arg_6_0)
		if arg_6_0.data.finish_step == 0 then
			arg_5_0:begin_explore_by_activity()
		end

		arg_5_0:updateBossBtn(arg_6_0.data)
		arg_5_0:updateTodayNum(arg_6_0.data)
	end)
end

function ActivityNinifaExploreLayer:initUI()
	self:initBG()
	self:initBottomList()
end

function ActivityNinifaExploreLayer:initBG()
	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_bg"):setBackGroundImage("mainScenebg/activity/branch11/bg_child.jpg")
	require("view.Sprite.TitleSprite")

	self.titleSprite = TitleSprite:create("ActivityNinifaExploreLayer/title.png", 2)

	self.titleSprite:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56 - GameDisplay.fix_y))
	self.rootLayer:addChild(self.titleSprite)
end

function ActivityNinifaExploreLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("ActivityNinifaLayer")
	end)

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 2)
end

function ActivityNinifaExploreLayer:initBtnTouchEventListener()
	self.btnRoom_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_3")

	self.btnRoom_3:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:beginExplore(arg_12_0, 5)
	end)

	self.btnRoom_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_2")

	self.btnRoom_2:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:beginExplore(arg_13_0, 4)
	end)

	self.btnRoom_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_1")

	self.btnRoom_1:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:beginExplore(arg_14_0, 3)
	end)

	self.btnBoss = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_17")

	self.btnBoss:setVisible(false)
end

function ActivityNinifaExploreLayer:updateBossBtn(arg_15_1)
	self.btnBoss:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_16_0

		if arg_15_1.finish_step ~= 5 then
			global_ShowBlockWords(L_ACTIVITY_NINIFA.CAN_NOT_GO_BOSS)

			do return end

			var_16_0 = {}
		end

		var_16_0.data = require("data.levelmode_basic_data")[1011]

		LayerManager:pushInLayer("AdventureNewDetailLayer", var_16_0)
	end)
end

function ActivityNinifaExploreLayer:fullScreen()
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.btnBoss:setAnchorPoint(cc.p(0.5, 1))
	self.btnBoss:setPositionY(GameDisplay.height - GameDisplay.fix_y)
end

function ActivityNinifaExploreLayer.beginExplore(arg_18_0, arg_18_1, arg_18_2)
	arg_18_1:setBright(false)
	explore_manager:begin_explore({
		activityid = 11,
		type = "activity",
		returnLayer = "ActivityNinifaExploreLayer",
		activity_explore_id = arg_18_2,
		cancelCallback = function(arg_19_0)
			arg_18_1:setBright(true)

			if arg_19_0 == 2 then
				global_ShowBlockWords("活动已关闭")
			elseif arg_19_0 == 3 then
				global_ShowBlockWords("前置关卡已通关")
			elseif arg_19_0 == 4 then
				global_ShowBlockWords("前置关卡未通关")
			elseif arg_19_0 == 5 then
				global_ShowBlockWords("服务器客户端数据不同步")
			elseif arg_19_0 == 6 then
				global_ShowBlockWords("开启时间未到")
			elseif arg_19_0 == 7 then
				global_ShowBlockWords("该关卡每日探险次数已用尽")
			elseif arg_19_0 == 8 then
				global_ShowBlockWords("不能反复刷")
			elseif arg_19_0 == 0 then
				global_ShowBlockWords("活动探险未开放")
			end
		end
	})
end

function ActivityNinifaExploreLayer.begin_explore_by_activity(arg_20_0)
	local function var_20_0(arg_21_0)
		if arg_21_0 == 2 then
			global_ShowBlockWords("活动已关闭")
		elseif arg_21_0 == 3 then
			global_ShowBlockWords("前置关卡已通关")
		elseif arg_21_0 == 4 then
			global_ShowBlockWords("前置关卡未通关")
		elseif arg_21_0 == 5 then
			global_ShowBlockWords("服务器客户端数据不同步")
		elseif arg_21_0 == 6 then
			global_ShowBlockWords("开启时间未到")
		elseif arg_21_0 == 7 then
			global_ShowBlockWords("该关卡每日探险次数已用尽")
		elseif arg_21_0 == 8 then
			global_ShowBlockWords("不能反复刷")
		elseif arg_21_0 == 0 then
			global_ShowBlockWords("活动探险未开放")
		end
	end

	explore_manager:begin_explore_by_activity(11, 2, nil, function(arg_22_0)
		if arg_22_0 == 1 then
			LayerManager:switchShowLayer("ExploreMapLayer", {
				returnUiLayer = "ActivityNinifaLayer"
			})
		else
			var_20_0(arg_22_0)
		end
	end)
end

function ActivityNinifaExploreLayer:updateTodayNum(arg_23_1)
	if not self.hasNumBtn then
		self.hasNumBtn = true

		local var_23_0 = ccui.ImageView:create("ActivityNinifaExploreLayer/today_num.png", var_0_0)

		var_23_0:setPosition(cc.p(475, 35))
		var_23_0:setName("num_btn_bg")
		self.bottomList:addChild(var_23_0)

		local var_23_1 = cc.Label:createWithTTF(3 + arg_23_1.buy_times - arg_23_1.total_daily_times .. "/3", FONT_NAME, 24)

		var_23_1:setPosition(cc.p(560, 35))
		var_23_1:setName("num_lbl")
		self.bottomList:addChild(var_23_1)

		return
	end

	self.bottomlist:getChildByName("num_lbl"):setString(3 + arg_23_1.buy_times - arg_23_1.total_daily_times .. "/3")
end
