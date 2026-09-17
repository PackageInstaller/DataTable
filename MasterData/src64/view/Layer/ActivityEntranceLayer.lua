ActivityEntranceLayer = class("ActivityEntranceLayer", function()
	return ccui.Layout:create()
end)

local NewLinkActivityEntranceLayer = require("view.Layer.NewLinkActivityEntranceLayer")
local level_manager = require("controller.level_manager")
local activity_entrance_data = require("data.activity_entrance_data")
local playermodel = require("model.playermodel")
local alert_manager = require("controller.alert_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_return_manager = require("controller.activity_return_manager")
local hexie_manager = require("controller.hexie_manager")
local recharge_data = require("data.recharge_data")
local event_notice_data = require("data.event_notice_data")

require("view.Sprite.MovingView")

local var_0_11 = config._DEBUG and 0 or 1
local var_0_12 = 0
local var_0_13 = 4
local var_0_14 = {}

var_0_14[1] = 4
var_0_14[2] = 3
var_0_14[3] = 1
var_0_14[4] = 2

local var_0_15

function ActivityEntranceLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityEntranceLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityEntranceLayer:init()
	self.rootlayer = cc.Layer:create()

	self:addChild(self.rootlayer)

	self.activityLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityEntrance.json" or "ActivityEntrance.ExportJson")

	self.activityLayer:setPositionY(-GameDisplay.fix_y)
	self.rootlayer:addChild(self.activityLayer)

	local var_3_0 = NewLinkActivityEntranceLayer:create()

	var_3_0:setVisible(false)
	self.rootlayer:addChild(var_3_0)

	self.linklayer = var_3_0
	self.copyUnit = ccui.Helper:seekWidgetByName(self.activityLayer, "copy_unit")

	self.copyUnit:removeFromParent()
	self.copyUnit:retain()

	self.selectTab = var_0_15 or 1

	self:initUI()
	self:initBottomList()
	self:fullScreen()
	self:registerActivityEventListener()
	activity_manager:updateActivityEntranceList()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			self.copyUnit:release()
			activity_manager:releaseEventListenerByName("ActivityEntranceLayer")
		end
	end)
end

function ActivityEntranceLayer:updateEntranceListData()
	local var_5_0 = {}
	local var_5_1 = 1

	for iter_5_0, iter_5_1 in pairs((global_deepCopy(activity_manager:getActivityEntranceList()))) do
		if iter_5_1.image ~= 3000001 and not iter_5_1.is_not_in_entrance then
			if iter_5_1.tab and iter_5_1.tab == 3 and time_check_manager:getCurTime() > playermodel.create_time + 2592000 then
				iter_5_1.tab = 2
			end

			if iter_5_0 == 8061 then
				if not activity_manager:is_module_stat_finished(2, "sign") then
					var_5_0[var_5_1] = iter_5_1
					var_5_1 = var_5_1 + 1
				end
			elseif iter_5_0 == 480 then
				if not activity_manager:is_module_stat_finished(480, "sign") and not hexie_manager:isChannelInShenheTime() then
					var_5_0[var_5_1] = iter_5_1
					var_5_1 = var_5_1 + 1
				end
			elseif iter_5_0 == 8065 then
				local novice_pass_level_data = require("data.novice_pass_level_data")
				local var_5_3 = {}

				for iter_5_2, iter_5_3 in pairs(playermodel.novice_pass_level_award) do
					var_5_3[iter_5_3] = true
				end

				local var_5_4

				for iter_5_4, iter_5_5 in pairs(novice_pass_level_data) do
					if not var_5_3[iter_5_5.id] then
						var_5_4 = true

						break
					end
				end

				if var_5_4 then
					var_5_0[var_5_1] = iter_5_1
					var_5_1 = var_5_1 + 1
				end
			elseif iter_5_0 == 8062 then
				local novice_award_data = require("data.novice_award_data")

				if not hexie_manager:isChannelInShenheTime() and (playermodel.novice_award_process_xinxiya < #novice_award_data or playermodel.novice_award_process_lucun < #novice_award_data) then
					var_5_0[var_5_1] = iter_5_1
					var_5_1 = var_5_1 + 1
				end
			elseif iter_5_0 == 8063 then
				if not activity_manager:is_module_stat_finished(2, "wake_fund") then
					var_5_0[var_5_1] = iter_5_1
					var_5_1 = var_5_1 + 1
				end
			elseif iter_5_0 == 8064 then
				if not activity_manager:is_module_stat_finished(2, "task_novice") then
					if (playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) and os.time(parse_time("2020-9-19 00:00:00")) + 1209600 or playermodel.create_time + 1209600) > time_check_manager:getCurTime() then
						var_5_0[var_5_1] = iter_5_1
						var_5_1 = var_5_1 + 1
					end
				end
			elseif iter_5_0 == 1371008 then
				if activity_manager:getActivityObj(iter_5_1.configId) then
					if (playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) and os.time(parse_time("2020-9-19 00:00:00")) + 1209600 or playermodel.create_time + 1209600) > time_check_manager:getCurTime() then
						var_5_0[var_5_1] = iter_5_1
						var_5_1 = var_5_1 + 1
					end
				end
			elseif iter_5_0 == 8068 then
				if playermodel.create_time + recharge_data[20001].canbuy_timeout * 24 * 60 * 60 > time_check_manager:getCurTime() then
					var_5_0[var_5_1] = iter_5_1
					var_5_1 = var_5_1 + 1
				end
			elseif iter_5_0 == 8066 then
				if not activity_return_manager:isReturnSignFinish() then
					var_5_0[var_5_1] = iter_5_1
					var_5_1 = var_5_1 + 1
				end
			elseif iter_5_0 == 8067 then
				if activity_return_manager:isShowReturnBp() then
					var_5_0[var_5_1] = iter_5_1
					var_5_1 = var_5_1 + 1
				end
			elseif iter_5_0 == 176 then
				if activity_return_manager:isShowReturnBp() then
					var_5_0[var_5_1] = iter_5_1
					var_5_1 = var_5_1 + 1
				end
			elseif iter_5_0 == 2230001 then
				if playermodel.rechargeamountTGV and playermodel.rechargeamountTGV >= 100 then
					var_5_0[var_5_1] = iter_5_1
				end
			else
				var_5_0[var_5_1] = iter_5_1
				var_5_1 = var_5_1 + 1
			end
		end
	end

	local function var_5_8(arg_6_0)
		if arg_6_0 == 2860001 then
			return DeviceManager.getChannelID() == "270048"
		end

		if arg_6_0 == 3280001 then
			return DeviceManager:getChannelID() == "270048"
		end

		return false
	end

	local function var_5_9(arg_7_0)
		if arg_7_0.linkage == 1 and DeviceManager:getChannelID() == "999" then
			return false
		end

		return true
	end

	local var_5_10 = {}

	for iter_5_6, iter_5_7 in pairs(var_5_0) do
		if not var_5_8(iter_5_7.id) and var_5_9(iter_5_7) then
			table.insert(var_5_10, iter_5_7)
		end
	end

	local var_5_11 = var_5_10

	for iter_5_8, iter_5_9 in pairs(var_5_10) do
		if iter_5_9.unlocklevel and not level_manager:isPlayerPassLevel(iter_5_9.unlocklevel) then
			iter_5_9.unlock = true
			iter_5_9.order = -iter_5_9.order
		end
	end

	table.sort(var_5_10, function(arg_8_0, arg_8_1)
		if arg_8_0.isbigBanner == arg_8_1.isbigBanner then
			return arg_8_0.order < arg_8_1.order
		else
			return arg_8_0.isbigBanner and not arg_8_1.isbigBanner
		end
	end)

	self.listLen = var_5_1 - 1
	self.entranceActivityList = {}

	local var_5_12 = {}

	for iter_5_10, iter_5_11 in pairs(var_5_10) do
		if iter_5_11.tab then
			var_5_12[iter_5_11.tab] = true
		end
	end

	for iter_5_12, iter_5_13 in pairs(var_0_14) do
		if var_5_12[iter_5_13] then
			self.selectTab = var_0_15 or iter_5_13

			break
		end
	end

	local function var_5_13(...)
		if not self.selectTab then
			return
		end

		if self.selectTab > var_0_13 then
			return
		end

		for iter_9_0, iter_9_1 in pairs(var_5_11) do
			if iter_9_1.tab == self.selectTab then
				table.insert(self.entranceActivityList, iter_9_1)
			end
		end

		if not next(self.entranceActivityList) then
			self.selectTab = self.selectTab + 1

			var_5_13()
		end
	end

	var_5_13()

	self.cellConfs = {}

	for iter_5_14, iter_5_15 in ipairs(self.entranceActivityList) do
		self.cellConfs[iter_5_14] = {
			size = {
				width = 520,
				height = iter_5_15.isbigBanner and 320 or 230
			}
		}
	end

	self.openTab = {}

	for iter_5_16, iter_5_17 in pairs(var_5_10) do
		if iter_5_17.tab then
			self.openTab[iter_5_17.tab] = true
		end
	end

	self:updateBtnType()
end

function ActivityEntranceLayer:drawEntranceList()
	self:updateEntranceListData()

	if self.tableView then
		self.tableView:removeFromParent()
	end

	local function var_10_0(arg_11_0)
		index = arg_11_0.index - 1

		local var_11_0 = self.entranceActivityList[index + 1]
		local var_11_1 = arg_11_0:getChildByTag(100)

		if not var_11_1 then
			var_11_1 = self:createEntrance(self.entranceActivityList[index + 1])

			var_11_1:setAnchorPoint(cc.p(0.5, 0.5))
			var_11_1:setPosition(cc.p(arg_11_0:getContentSize().width / 2, arg_11_0:getContentSize().height / 2))
			var_11_1:setScale(0.95, 0.95)

			if self.entranceActivityList[index + 1].unlock then
				var_11_1:setOpacity(122)

				var_11_1.unlock = true
			else
				var_11_1:setOpacity(255)
			end

			self:drawEntranceAlert(var_11_1, index)
			arg_11_0:addChild(var_11_1)
		end

		self:updateEntrance(var_11_1, self.entranceActivityList[index + 1])
		self:drawEntranceAlert(var_11_1, index)
		var_11_1:setSwallowTouches(false)
		var_11_1:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_12_0:getTouchBeganPosition().y - arg_12_0:getTouchEndPosition().y) > 50 then
				return
			end

			if var_11_0.unlock then
				global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(var_11_0.unlocklevel)))

				return
			end

			activity_manager:openNewActivity(activity_manager:checkActClickId(arg_12_0:getName()))

			if var_11_0.id == 8061 then
				self:onClickFengmolongSignEvent()

				return
			end

			if var_11_0.id == 480 then
				self:onClickThirtySignEvent()

				return
			end

			if var_11_0.id == 8066 or var_11_0.id == 176 then
				self:executeReturnBackJump(var_11_0)

				return
			end

			if var_11_0.id == 2470002 then
				self:showWeixinActivity()

				return
			end

			if var_11_0.id == 2470003 then
				self:jumpToWeiBo()

				return
			end

			if var_11_0.id == 2470004 then
				self:jumpToBilibili()

				return
			end

			if var_11_0.id == 1371008 and not level_manager:isPlayerPassLevel(UNLOCK_ACTIVITY_LIULI) then
				global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(UNLOCK_ACTIVITY_LIULI)))

				return
			end

			if var_11_0.id == 7300001 then
				LayerManager:switchShowLayer("CommonFlopLayer", {
					activityId = 730
				})
				AnalyticManager.clickActivityEntranceType({
					enterType = "ActivityEntranceLayer",
					activityid = var_11_0.configId,
					jumpid = var_11_0.jump,
					id = var_11_0.id
				})

				return
			end

			if var_11_0.id == 7310001 then
				LayerManager:switchShowLayer("CommonRouletteLayer", {
					activityId = 731
				})
				AnalyticManager.clickActivityEntranceType({
					enterType = "ActivityEntranceLayer",
					activityid = var_11_0.configId,
					jumpid = var_11_0.jump,
					id = var_11_0.id
				})

				return
			end

			AnalyticManager.clickActivityEntranceType({
				enterType = "ActivityEntranceLayer",
				activityid = var_11_0.configId,
				jumpid = var_11_0.jump,
				id = var_11_0.id
			})
			print("Entrance id", var_11_0.id)
			require("controller.goto_system_manager")

			if var_11_0.init_type == WEB_ACTIVITY then
				self:showWebActivity(var_11_0.id)
			else
				goto_complete_system({
					jump_to_system = var_11_0.jump
				})
			end
		end)
	end

	local var_10_1 = {}

	var_10_1.width = ccui.Helper:seekWidgetByName(self.activityLayer, "Panel_tableview"):getContentSize().width
	var_10_1.height = 980 + GameDisplay.fix_y * 2
	var_10_1.direction = cc.SCROLLVIEW_DIRECTION_VERTICAL
	var_10_1.cellConfs = self.cellConfs
	var_10_1.registerCellFunc = var_10_0
	self.tableView = MovingView:create(var_10_1)

	self.tableView:updateCells()
	self.tableView:setPosition(75, var_0_12)
	ccui.Helper:seekWidgetByName(self.activityLayer, "Panel_tableview"):addChild(self.tableView)
end

function ActivityEntranceLayer.onClickFengmolongSignEvent(arg_13_0)
	LayerManager:pushInLayer("ActivitySignBaseLayer", {
		activityUIObjName = "ActivitySignFmlLayer",
		activityid = 2
	})
end

function ActivityEntranceLayer.onClickThirtySignEvent(arg_14_0)
	LayerManager:switchShowLayer("NoviceSummaryLayer", {
		layerName = "ActivityNoviceThirtyTaskLayer",
		isHideOther = true,
		exitCallback = callback
	})
end

function ActivityEntranceLayer:updateShowingCells()
	self.tableView:updateCells()
end

function ActivityEntranceLayer:registerActivityEventListener()
	activity_manager:registerEventListener("ActivityEntranceLayer", activity_manager.activityEventId.UPDATE_NEW_ACTIVITY_LIST, function(arg_17_0)
		self:updateShowingCells()
		alert_manager:check_current_alert("ActivityEntranceLayer")
	end)
	activity_manager:registerEventListener("ActivityEntranceLayer", activity_manager.activityEventId.ACTIVITY_GET_REWARD_CHANGED, function(arg_18_0)
		activity_manager:updateActivityEntranceList()
	end)
	activity_manager:registerEventListener("ActivityEntranceLayer", activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function(arg_19_0)
		self:drawEntranceList()
		alert_manager:check_current_alert("ActivityEntranceLayer")
	end)
	activity_manager:registerEventListener("ActivityEntranceLayer", activity_manager.activityEventId.ACTIVITY_STATE_CHANGED, function(arg_20_0)
		activity_manager:updateActivityEntranceList()
	end)
	activity_manager:registerEventListener("ActivityEntranceLayer", activity_manager.activityEventId.ACTIVITY_ENTRANCE_LIST_UPDATE, function(arg_21_0)
		self:drawEntranceList()
		alert_manager:check_current_alert("ActivityEntranceLayer")
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("alertmanager_unregister_alert", function(arg_22_0)
		self:updateBtnType()
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_23_0)
		if arg_23_0.eventType ~= NEXT_DAY then
			return
		end

		activity_manager:updateActivityEntranceList()
	end), self)
end

function ActivityEntranceLayer:drawEntranceAlert(arg_24_1, arg_24_2)
	if arg_24_1.unlock then
		return
	end

	local var_24_0 = self.entranceActivityList[arg_24_2 + 1].id
	local var_24_1 = {
		x = arg_24_1:getContentSize().width - 10,
		y = arg_24_1:getContentSize().height - 10
	}

	if activity_manager:isActivityInEntranceNeedAlert(self.entranceActivityList[arg_24_2 + 1].id) then
		global_add_alert_tag(arg_24_1, var_24_1)
	else
		global_remove_alert_tag(arg_24_1)
	end

	if activity_manager:isNewActivity(self.entranceActivityList[arg_24_2 + 1].image) then
		alert_manager:add_new_mark(arg_24_1, true, {
			x = arg_24_1:getContentSize().width - 40,
			y = arg_24_1:getContentSize().height - 10
		})
		activity_manager:checkRedNode(arg_24_1)
	else
		alert_manager:add_new_mark(arg_24_1, false)

		if activity_manager:checkRedNode(arg_24_1) then
			activity_manager:checkRedNode(arg_24_1):setVisible(true)
		end
	end

	local var_24_2 = ({
		["1000003"] = {
			ALERT_SIGN
		},
		["1000005"] = {
			ALERT_TWISTEGG,
			ALERT_ACTIVTIYNEWLOG_TWISTEGG
		},
		["1000008"] = {
			ALERT_MIDAS
		}
	})[arg_24_1:getName()]

	if var_24_2 then
		for iter_24_0, iter_24_1 in pairs(var_24_2) do
			if alert_manager.alertsys[iter_24_1] then
				alert_manager:add_redDot(arg_24_1, true, var_24_1)
			end
		end
	end

	if var_24_0 == 8066 and activity_return_manager:get_can_sign() then
		alert_manager:add_redDot(arg_24_1, true, var_24_1)
	end
end

local function var_0_16(arg_25_0)
	local var_25_1 = (arg_25_0 - arg_25_0 % 60 - (arg_25_0 - arg_25_0 % 60) % 3600 / 60 * 60) / 3600 % 24
	local var_25_2 = math.floor((arg_25_0 - arg_25_0 % 60 - (arg_25_0 - arg_25_0 % 60) % 3600 / 60 * 60) / 3600 / 24)

	if var_25_2 > 0 then
		return string.format(L_TIME_FORMAT[1], var_25_2, var_25_1)
	elseif var_25_1 > 0 then
		return string.format(L_TIME_FORMAT[2], var_25_1, (arg_25_0 - arg_25_0 % 60) % 3600 / 60)
	elseif (arg_25_0 - arg_25_0 % 60) % 3600 / 60 > 0 then
		return string.format(L_TIME_FORMAT[3], (arg_25_0 - arg_25_0 % 60) % 3600 / 60)
	else
		return L_TIME_FORMAT[4]
	end
end

function ActivityEntranceLayer:createEntrance(arg_26_1)
	local var_26_0 = self.copyUnit:clone()

	if arg_26_1.isbigBanner then
		var_26_0:setContentSize(cc.size(600, 350))
	else
		var_26_0:setContentSize(cc.size(600, 252))
	end

	assert(arg_26_1.image, dump(arg_26_1))
	var_26_0:loadTextures("mainScenebg/activity_entrance/" .. arg_26_1.image .. ".png", nil, "mainScenebg/activity_entrance/" .. arg_26_1.image .. ".png")

	if arg_26_1.image == 8380001 and time_check_manager:getCurTime() > global_get_time_by_date("2025-10-03 00:00:00") and time_check_manager:getCurTime() < global_get_time_by_date("2025-10-09 23:59:59") then
		var_26_0:loadTextures("mainScenebg/activity_entrance/" .. arg_26_1.image .. "_replace.png", "mainScenebg/activity_entrance/" .. arg_26_1.image .. "_replace.png", "mainScenebg/activity_entrance/" .. arg_26_1.image .. "_replace.png")
	end

	var_26_0:setTag(100)
	var_26_0:setName(tostring(arg_26_1.image))

	local var_26_1 = var_26_0:getChildByName("panel_time_bg")

	var_26_1:setAnchorPoint(cc.p(1, 1))

	local var_26_2 = var_26_0:getChildByName("panel_time_bg"):getChildByName("left_label")
	local var_26_3 = arg_26_1.finishtime and os.time(parse_time(arg_26_1.finishtime))

	if arg_26_1.id == 8064 or arg_26_1.id == 1371008 then
		var_26_3 = playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) and os.time(parse_time("2020-9-19 00:00:00")) + 1209600 or playermodel.create_time + 1209600
	elseif arg_26_1.id == 8066 or arg_26_1.id == 8067 or arg_26_1.id == 176 or arg_26_1.id == 8069 then
		var_26_3 = activity_return_manager:getFinishtime()
	elseif arg_26_1.id == 8068 then
		var_26_3 = playermodel.create_time + recharge_data[20001].canbuy_timeout * 24 * 60 * 60
	end

	if arg_26_1.id ~= 7300001 then
		if arg_26_1.id == 7310001 then
			local var_26_4 = arg_26_1.id == 7300001 and "commonFlop" or "commonRoulette"

			for iter_26_0, iter_26_1 in ipairs((require("data.common_flop_roulette_turns_conf"))) do
				if global_is_in_time(iter_26_1.starttime, iter_26_1.finishtime) and iter_26_1.moudle == var_26_4 then
					var_26_3 = os.time(parse_time(iter_26_1.finishtime))
				end
			end
		elseif arg_26_1.id == 7350001 then
			for iter_26_2, iter_26_3 in ipairs((require("data.common_flop_roulette_turns_conf"))) do
				if global_is_in_time(iter_26_3.starttime, iter_26_3.finishtime) and iter_26_3.moudle == "airplane" then
					var_26_3 = os.time(parse_time(iter_26_3.finishtime))
				end
			end
		end

		if var_26_3 and var_26_3 > time_check_manager:getCurTime() and var_26_3 - time_check_manager:getCurTime() < 31536000 then
			local var_26_5 = var_26_3 - time_check_manager:getCurTime()

			var_26_2:setString((var_0_16(var_26_5)))
			var_26_2:runAction((cc.RepeatForever:create((cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
				var_26_5 = var_26_5 - 1

				if var_26_5 >= 0 then
					var_26_2:setString((var_0_16(var_26_5)))
				else
					var_26_2:stopAction(seqre)
					self:drawEntranceList()
				end
			end))))))

			if var_26_5 < 86400 then
				var_26_1:setBackGroundImage("PopActivityEntrance/time_bg.png", var_0_11)
				var_26_2:setColor(cc.c3b(255, 255, 255))
			else
				var_26_1:setBackGroundImage("PopActivityEntrance/time_gary_bg.png", var_0_11)
				var_26_2:setColor(cc.c3b(255, 229, 158))
			end

			goto label_26_0
		end
	end

	var_26_1:setVisible(false)

	::label_26_0::

	local var_26_6 = ccui.ImageView:create("public/button/fight_lock.png", var_0_11)

	var_26_6:setName("lock_icon")
	var_26_6:setVisible(false)
	var_26_6:setPosition(cc.p(var_26_0:getContentSize().width - 28, var_26_0:getContentSize().height - 30))
	var_26_0:addChild(var_26_6, 1000)

	return var_26_0
end

function ActivityEntranceLayer:initBottomList()
	local var_28_0 = ccui.Layout:create()

	var_28_0:setContentSize(cc.size(640, 200))
	var_28_0:setTouchEnabled(true)
	var_28_0:setPosition(0, -GameDisplay.fix_y)
	self.rootlayer:addChild(var_28_0)
end

function ActivityEntranceLayer:createTitleSprite()
	local var_29_0 = ccui.ImageView:create("PopActivityEntrance/top_activity.png", var_0_11)

	var_29_0:setPositionX(330)
	var_29_0:setPositionY(1136 - var_29_0:getContentSize().height / 2 + GameDisplay.fix_y * 2)
	self.activityLayer:addChild(var_29_0, 999)
end

function ActivityEntranceLayer.updateEntrance(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_2.isbigBanner then
		arg_30_1:setContentSize(cc.size(600, 350))
	else
		arg_30_1:setContentSize(cc.size(600, 252))
	end

	arg_30_1:loadTextures("mainScenebg/activity_entrance/" .. arg_30_2.image .. ".png", "mainScenebg/activity_entrance/" .. arg_30_2.image .. ".png", "mainScenebg/activity_entrance/" .. arg_30_2.image .. ".png")

	if arg_30_2.image == 8380001 and time_check_manager:getCurTime() > global_get_time_by_date("2025-10-03 00:00:00") and time_check_manager:getCurTime() < global_get_time_by_date("2025-10-09 23:59:59") then
		arg_30_1:loadTextures("mainScenebg/activity_entrance/" .. arg_30_2.image .. "_replace.png", "mainScenebg/activity_entrance/" .. arg_30_2.image .. "_replace.png", "mainScenebg/activity_entrance/" .. arg_30_2.image .. "_replace.png")
	end

	arg_30_1:setTag(100)
	arg_30_1:setName(tostring(arg_30_2.image))

	local var_30_0 = arg_30_1:getChildByName("panel_time_bg")

	var_30_0:setAnchorPoint(cc.p(1, 0))
	var_30_0:setPosition(cc.p(arg_30_1:getContentSize().width - 10, 10))

	local var_30_1 = arg_30_1:getChildByName("panel_time_bg"):getChildByName("left_label")
	local var_30_2 = arg_30_2.finishtime and os.time(parse_time(arg_30_2.finishtime))

	if arg_30_2.id == 8064 or arg_30_2.id == 1371008 then
		var_30_2 = playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) and os.time(parse_time("2020-9-19 00:00:00")) + 1209600 or playermodel.create_time + 1209600
	elseif arg_30_2.id == 8066 or arg_30_2.id == 8067 or arg_30_2.id == 176 or arg_30_2.id == 8069 then
		var_30_2 = activity_return_manager:getFinishtime()
	elseif arg_30_2.id == 8068 then
		var_30_2 = playermodel.create_time + recharge_data[20001].canbuy_timeout * 24 * 60 * 60
	end

	if arg_30_2.id ~= 7300001 then
		if arg_30_2.id == 7310001 then
			local var_30_3 = arg_30_2.id == 7300001 and "commonFlop" or "commonRoulette"

			for iter_30_0, iter_30_1 in ipairs((require("data.common_flop_roulette_turns_conf"))) do
				if global_is_in_time(iter_30_1.starttime, iter_30_1.finishtime) and iter_30_1.moudle == var_30_3 then
					var_30_2 = os.time(parse_time(iter_30_1.finishtime))
				end
			end
		elseif arg_30_2.id == 7350001 then
			for iter_30_2, iter_30_3 in ipairs((require("data.common_flop_roulette_turns_conf"))) do
				if global_is_in_time(iter_30_3.starttime, iter_30_3.finishtime) and iter_30_3.moudle == "airplane" then
					var_30_2 = os.time(parse_time(iter_30_3.finishtime))
				end
			end
		end

		if var_30_2 and var_30_2 > time_check_manager:getCurTime() and var_30_2 - time_check_manager:getCurTime() < 31536000 then
			local var_30_4 = var_30_2 - time_check_manager:getCurTime()

			var_30_1:setString((var_0_16(var_30_4)))
			var_30_1:runAction((cc.RepeatForever:create((cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
				var_30_4 = var_30_4 - 1

				if var_30_4 >= 0 then
					var_30_1:setString((var_0_16(var_30_4)))
				else
					var_30_1:stopAction(seqre)
					arg_30_0:drawEntranceList()
				end
			end))))))

			if var_30_4 < 86400 then
				var_30_0:setBackGroundImage("PopActivityEntrance/time_bg.png", var_0_11)
				var_30_1:setColor(cc.c3b(255, 255, 255))
			else
				var_30_0:setBackGroundImage("PopActivityEntrance/time_gary_bg.png", var_0_11)
				var_30_1:setColor(cc.c3b(255, 229, 158))
			end

			goto label_30_0
		end
	end

	var_30_0:setVisible(false)

	::label_30_0::

	if arg_30_2.id == 1371008 then
		arg_30_1:getChildByName("lock_icon"):setVisible(not level_manager:isPlayerPassLevel(UNLOCK_ACTIVITY_LIULI))
	end
end

local var_0_17 = false

function ActivityEntranceLayer.showWebActivity(arg_32_0, arg_32_1)
	activity_manager:get_activity_memory_session(arg_32_1, function(arg_33_0)
		if var_0_17 then
			return
		end

		var_0_17 = true

		local var_33_0 = ccui.Layout:create()

		var_33_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
		var_33_0:setTouchEnabled(true)
		var_33_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_33_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_33_0:setBackGroundColorOpacity(150)
		global_basic_scene:addChild(var_33_0, 999)

		local var_33_1 = cc.Sprite:create("mainScenebg/noticebg.jpg")

		var_33_1:setAnchorPoint(cc.p(0.5, 1))
		var_33_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.height))
		var_33_0:addChild(var_33_1)
		var_33_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
			local var_34_0 = ccexp.WebView:create()

			var_34_0:setVisible(true)
			var_34_0:setScalesPageToFit(true)
			var_34_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height - 50))
			var_34_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 25))
			var_34_0:loadURL(arg_33_0)
			var_34_0:setOnDidFinishLoading(function(arg_35_0, arg_35_1)
				return
			end)
			var_33_0:addChild(var_34_0, 10)

			local var_34_1 = ccui.Button:create("equipment/closebtn.png", nil, "equipment/closebtn.png")

			var_34_1:setScale(0.5)
			var_34_1:setPosition(cc.p(GameDisplay.width - 40, GameDisplay.height - 25))
			var_33_0:addChild(var_34_1, 100)
			var_34_1:addTouchEventListener(function(arg_36_0, arg_36_1)
				if arg_36_1 ~= ccui.TouchEventType.ended then
					return
				end

				var_0_17 = false

				var_33_0:runAction(cc.RemoveSelf:create())
			end)
		end)))
	end)
end

function ActivityEntranceLayer.fullScreen(arg_37_0)
	return
end

function ActivityEntranceLayer:initUI(...)
	ccui.Helper:seekWidgetByName(self.activityLayer, "Image_tab_bg"):setVisible(false)

	for iter_38_0 = 1, 4 do
		local var_38_0 = ccui.Button:create()

		var_38_0:setName("Button_btn_type_" .. iter_38_0)
		self.rootlayer:addChild(var_38_0)

		local var_38_1 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_11)

		var_38_0:addChild(var_38_1)
		var_38_1:setName("Image_reddot")
	end

	while self.rootlayer:getChildByName("Button_btn_type_" .. 1) do
		local var_38_2 = self.rootlayer:getChildByName("Button_btn_type_" .. 1)

		var_38_2:setVisible(false)

		var_38_2.tab = var_0_14[1]

		var_38_2:addTouchEventListener(function(arg_39_0, arg_39_1)
			if arg_39_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.linklayer:setVisible(false)
			self:setLinkBrightAllFalse()
			self.activityLayer:setVisible(true)

			self.selectTab = arg_39_0.tab

			print("self.selectTab", self.selectTab)

			var_0_15 = self.selectTab

			self:drawEntranceList()
			AnalyticManager.clickActivityEntranceType({
				enterType = "summary_tabs",
				tab = arg_39_0.tab
			})
		end)
	end

	local var_38_4 = 1

	while ccui.Helper:seekWidgetByName(self.activityLayer, "Button_btn_type_" .. var_38_4) do
		ccui.Helper:seekWidgetByName(self.activityLayer, "Button_btn_type_" .. var_38_4):setVisible(false)

		var_38_4 = var_38_4 + 1
	end

	self:updateBtnType()

	self.selectTab = 1
	var_0_15 = self.selectTab

	self:drawEntranceList()
	self:initLinkBtn()
end

function ActivityEntranceLayer:updateBtnType()
	local var_40_0 = 1020 + GameDisplay.fix_y
	local var_40_1 = activity_manager:getActivityEntranceListAlertStatus()
	local var_40_2 = false

	self.btnCount = 0

	local var_40_3 = 1

	while self.rootlayer:getChildByName("Button_btn_type_" .. var_40_3) do
		local var_40_4 = self.rootlayer:getChildByName("Button_btn_type_" .. var_40_3)

		var_40_4:loadTextures("PopActivityEntrance/btn_type_on_" .. var_0_14[var_40_3] .. ".png", nil, "PopActivityEntrance/btn_type_" .. var_0_14[var_40_3] .. ".png", var_0_11)

		if self.selectTab == var_40_4.tab then
			var_40_4:setBright(true)
		else
			var_40_4:setBright(false)
		end

		if self.openTab then
			if self.openTab[var_40_4.tab] then
				var_40_4:setVisible(true)

				self.btnCount = self.btnCount + 1

				var_40_4:setPosition(35, var_40_0)

				var_40_0 = var_40_0 - 190
			else
				var_40_4:setVisible(false)
			end
		end

		if var_40_1[var_40_4.tab] and next(var_40_1[var_40_4.tab]) then
			var_40_4:getChildByName("Image_reddot"):setPosition(50, 170)
			var_40_4:getChildByName("Image_reddot"):setVisible(true)

			var_40_2 = true
		else
			var_40_4:getChildByName("Image_reddot"):setVisible(false)
		end

		var_40_3 = var_40_3 + 1
	end

	if var_40_2 then
		global_add_alert_tag(self.btn1, {
			x = 170,
			y = 70
		})
		global_add_alert_tag(self.btn2, {
			x = 170,
			y = 70
		})
		alert_manager:register_alert(ALERT_RED_ACTIVITY)
	else
		global_remove_alert_tag(self.btn1)
		global_remove_alert_tag(self.btn2)
		alert_manager:unregister_alert(ALERT_RED_ACTIVITY)
	end
end

function ActivityEntranceLayer:initLinkBtn()
	local var_41_0 = ccui.Button:create("PopActivityEntrance/btn_link_on.png", nil, "PopActivityEntrance/btn_link_off.png", var_0_11)

	var_41_0:setPosition(35, 1020 + GameDisplay.fix_y - self.btnCount * 190)
	self:addChild(var_41_0, 999)
	var_41_0:addTouchEventListener(function(arg_42_0, arg_42_1)
		if arg_42_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.clickActivityEntranceType({
			tab = 5,
			enterType = "summary_tabs"
		})
		self.linklayer:setVisible(true)
		self.linklayer.tableView:setVisible(true)
		self.linklayer.previewTableView:setVisible(false)
		self.activityLayer:setVisible(false)
		arg_42_0:setBright(true)
		self.previewBtn:setBright(false)
		self:setBrightAllFalse()
	end)
	var_41_0:setBright(false)

	self.linkBtn = var_41_0

	if self.linklayer.haveRed then
		global_add_alert_tag(self.linkBtn, {
			x = 70,
			y = 190
		})
	else
		global_remove_alert_tag(self.linkBtn)
	end

	local var_41_1 = ccui.Button:create("PopActivityEntrance/btn_preview_on.png", nil, "PopActivityEntrance/btn_preview_off.png", var_0_11)

	var_41_1:setPosition(35, 1020 + GameDisplay.fix_y - (self.btnCount + 1) * 190)
	var_41_1:setTouchEnabled(true)
	var_41_1:addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.clickActivityEntranceType({
			tab = 6,
			enterType = "summary_tabs"
		})
		self.linklayer:setVisible(true)
		self.linklayer.tableView:setVisible(false)
		self.linklayer.previewTableView:setVisible(true)
		self.activityLayer:setVisible(false)
		arg_43_0:setBright(true)
		self.linkBtn:setBright(false)
		self:setBrightAllFalse()
	end)
	self:addChild(var_41_1, 999)
	var_41_1:setBright(false)

	self.previewBtn = var_41_1

	if hexie_manager:isChannelInShenheTime() or DeviceManager:getChannelID() == "270057" then
		var_41_0:setVisible(false)
		var_41_1:setVisible(false)
	end
end

function ActivityEntranceLayer:setBrightAllFalse()
	while self.rootlayer:getChildByName("Button_btn_type_" .. 1) do
		self.rootlayer:getChildByName("Button_btn_type_" .. 1):setBright(false)
	end
end

function ActivityEntranceLayer:setLinkBrightAllFalse()
	self.linkBtn:setBright(false)
	self.previewBtn:setBright(false)
end

function ActivityEntranceLayer.executeReturnBackJump(arg_46_0, arg_46_1)
	local var_46_0 = {}

	if arg_46_1.id == 8066 then
		var_46_0 = {
			index = 1
		}
	elseif arg_46_1.id == 176 then
		var_46_0 = {
			index = 2
		}
	end

	local var_46_1 = {
		jump_to_system = 3036,
		config = var_46_0
	}

	if var_46_1.config then
		var_46_1.config.exitCallback = createExitCallback({
			jump_to_system = 1400
		})
	end

	goto_complete_system(var_46_1)
end

function ActivityEntranceLayer.showWeixinActivity(arg_47_0)
	AnalyticManager.clickWeixin()
	LayerManager:pushInLayer("PopWeixinActivityLayer")
end

function ActivityEntranceLayer.jumpToWeiBo(arg_48_0)
	AnalyticManager.clickWeibo()
	DeviceManager.openURL("https://weibo.com/u/6590148271")
	require("network.network"):rpc("activity_click_weibo_or_bili", {
		clicktype = "weibo",
		activityid = 241
	}, function(...)
		return
	end)
end

function ActivityEntranceLayer.jumpToBilibili(arg_50_0)
	AnalyticManager.clickBilibili()
	DeviceManager.openURL("https://space.bilibili.com/307460405?from=search&seid=18142802944347035987&spm_id_from=333.337.0.0")
	require("network.network"):rpc("activity_click_weibo_or_bili", {
		clicktype = "bilibili",
		activityid = 241
	}, function(...)
		return
	end)
end

return ActivityEntranceLayer
