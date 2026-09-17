ActivityMenuLayer = class("ActivityMenuLayer", function()
	return (cc.Layer:create())
end)

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local playermodel = require("model.playermodel")
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = "sign_id1"

local function var_0_5(...)
	local activity_task_index_data = require("data.activity_task_index_data")

	return (playermodel.create_time > os.time(parse_time("2021-05-28 00:00:00")) or nil) and require("data.activity_sevendays_index_data")
end

function ActivityMenuLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ActivityMenuLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ActivityMenuLayer:init(arg_4_1)
	self.rootLayer = cc.Layer:create()

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 1)
	self:initUI()
	self:registerActivityEventListener()
	self:redrawActivityAlert()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "enter" then
			self.needTaskAlert = false
		elseif arg_5_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityMenuLayer")

			if self.needTaskAlert ~= true then
				activity_manager:updateActivityAlert("task", 2, false)
			end

			if arg_4_1 and arg_4_1.callback then
				arg_4_1.callback()
			end
		end
	end)
end

function ActivityMenuLayer.registerActivityEventListener(arg_6_0)
	activity_manager:registerEventListener("ActivityMenuLayer", activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function()
		arg_6_0:redrawActivityAlert()
	end)
end

function ActivityMenuLayer:initUI()
	self:initTitle()
	self:initBottomList()
	self:initActiviyBtns()
end

function ActivityMenuLayer:initTitle()
	self.titleSprite = ccui.ImageView:create("Activity_DaKaActivity/top.png", var_0_3)

	self.titleSprite:setPosition(cc.p(320, GameDisplay.getUiScreenSize().height - self.titleSprite:getContentSize().height / 2))
	self.rootLayer:addChild(self.titleSprite)
end

function ActivityMenuLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("MainLayer")
	end)

	self.bottomList:setName("bottomlist")
	self.bottomList:setAnchorPoint(cc.p(0, 0))
	self.bottomList:setPositionY(0)
	self.rootLayer:addChild(self.bottomList, 2)
end

function ActivityMenuLayer:initActiviyBtns()
	self.btnSign = ccui.Button:create("mainScenebg/activity/branch2/2-3.png", nil, "mainScenebg/activity/branch2/2-3.png")

	self.btnSign:setPosition(cc.p(320, GameDisplay.getUiScreenSize().height * 5 / 6))
	self.rootLayer:addChild(self.btnSign)
	self.btnSign:addTouchEventListener(function(arg_13_0, arg_13_1)
		local var_13_0

		if arg_13_1 ~= ccui.TouchEventType.ended then
			do return end

			var_13_0 = {
				activityid = 2,
				activityUIObjName = "ActivitySignFmlLayer"
			}
		end

		function var_13_0.exit_set_bright_callback()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end

		LayerManager:pushInLayer("ActivitySignBaseLayer", var_13_0)
	end)

	self.btnPt = ccui.Button:create("mainScenebg/activity/branch2/2-1.png", nil, "mainScenebg/activity/branch2/2-1.png")

	self.btnPt:setPosition(cc.p(320, GameDisplay.getUiScreenSize().height * 4 / 6))
	self.rootLayer:addChild(self.btnPt)
	self.btnPt:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("ActivityPointLayer", {
			id = "2-1",
			activity_type = "proceed_id1",
			jumpbackID = 1200,
			activityID = 2
		})
	end)

	self.btnTask = ccui.Button:create("mainScenebg/activity/branch2/2-2.png", nil, "mainScenebg/activity/branch2/2-2.png")

	self.btnTask:setPosition(cc.p(320, GameDisplay.getUiScreenSize().height * 3 / 6))
	self.rootLayer:addChild(self.btnTask)
	self.btnTask:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("ActivityNoviceTaskLayer")
	end)

	self.btnShop = ccui.Button:create("mainScenebg/activity/branch2/2-4.png", nil, "mainScenebg/activity/branch2/2-4.png")

	self.btnShop:setPosition(cc.p(320, GameDisplay.getUiScreenSize().height * 2 / 6))
	self.rootLayer:addChild(self.btnShop)
	self.btnShop:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSupermarketLayer", {
			initSelectPage = 3
		})
	end)

	self.btnShop = ccui.Button:create("mainScenebg/activity/branch2/2-5.png", nil, "mainScenebg/activity/branch2/2-5.png")

	self.btnShop:setPosition(cc.p(320, GameDisplay.getUiScreenSize().height * 1 / 6))
	self.rootLayer:addChild(self.btnShop)
	self.btnShop:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.clickActivityEntranceType({
			activityid = 2,
			jumpid = 2600002,
			enterType = "ActivityMenuLayer"
		})
		LayerManager:pushInLayer("ActivityWakefundBaseLayer", {
			activityid = 2
		})
	end)
end

function ActivityMenuLayer:getAutoPopLayerConfig(arg_19_1)
	local var_19_0 = activity_manager:getActivityListData()[arg_19_1.activityID].list
	local var_19_1 = {}

	for iter_19_0 = 1, #var_19_0 do
		if var_19_0[iter_19_0].activity_type == var_0_4 then
			var_19_1 = var_19_0[iter_19_0]

			break
		end
	end

	var_19_1.activityID = self.id or 2
	var_19_1.isAutoPop = true

	return var_19_1
end

function ActivityMenuLayer:redrawActivityAlert()
	local var_20_0 = {
		x = 580,
		y = 175
	}

	if activity_manager:getAlertStatus(2, "sign") then
		global_add_alert_tag(self.btnSign, var_20_0)
	else
		global_remove_alert_tag(self.btnSign)
	end

	if activity_manager:getAlertStatus(2, "proceed") then
		global_add_alert_tag(self.btnPt, var_20_0)
	else
		global_remove_alert_tag(self.btnPt)
	end

	self:checkActivityPtTaskAlert()
	self:checkActivityNoticeTaskAlert()
	self:checkActivityWakefundAlert()
end

function ActivityMenuLayer.checkActivityPtTaskAlert(arg_21_0)
	local var_21_0 = activity_manager:getActivityObj(2)

	if var_21_0 then
		var_21_0:getActivityTaskList(1, function(arg_22_0, arg_22_1)
			if arg_22_0 ~= 1 then
				return
			end

			for iter_22_0, iter_22_1 in pairs(arg_22_1.list) do
				if iter_22_1.status == 0 and iter_22_1.percent >= 100 then
					global_add_alert_tag(arg_21_0.btnPt, {
						x = 580,
						y = 175
					})

					arg_21_0.needTaskAlert = true

					return
				end
			end
		end, false)
	end
end

local function var_0_6(arg_23_0)
	return var_0_5()[require("data.task_data")[arg_23_0].index].stage > 1
end

local function var_0_7(arg_24_0)
	local var_24_0 = var_0_5()[require("data.task_data")[arg_24_0].index].stage

	if var_24_0 == 7 then
		return false
	end

	local var_24_1 = time_check_manager:getCurTime()
	local var_24_2 = os.date("*t", playermodel.create_time)
	local var_24_3 = os.time({
		hour = 0,
		min = 0,
		sec = 1,
		year = var_24_2.year,
		month = var_24_2.month,
		day = var_24_2.day
	})

	if var_24_0 < 7 then
		return var_24_1 < var_24_3 + 86400 * (var_24_0 - 2)
	else
		return var_24_1 < var_24_3 + 86400 * (var_24_0 - 3)
	end
end

function ActivityMenuLayer.checkActivityNoticeTaskAlert(arg_25_0)
	local var_25_0 = activity_manager:getActivityObj(2)

	if var_25_0 then
		var_25_0:getActivityTaskList(nil, function(arg_26_0, arg_26_1)
			if arg_26_0 ~= 1 then
				return
			end

			for iter_26_0, iter_26_1 in pairs(arg_26_1.list) do
				if var_0_6(iter_26_1.taskid) and not var_0_7(iter_26_1.taskid) and iter_26_1.status == 0 and iter_26_1.percent >= 100 then
					arg_25_0.needAlert = true

					global_add_alert_tag(arg_25_0.btnTask, {
						x = 580,
						y = 175
					})

					return
				end
			end

			global_remove_alert_tag(arg_25_0.btnTask)
		end, false)
	end
end

function ActivityMenuLayer:checkActivityWakefundAlert()
	if activity_manager:getAlertStatus(2, "wake_fund") then
		global_add_alert_tag(self.btnShop, {
			x = 580,
			y = 175
		})
	else
		global_remove_alert_tag(self.btnShop)
	end
end
