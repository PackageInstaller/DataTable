activityLeftDoorSprite = class("activityLeftDoorSprite", function()
	return ccui.Layout:create()
end)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local alert_manager = require("controller.alert_manager")
local playermodel = require("model.playermodel")
local hexie_manager = require("controller.hexie_manager")
local activity_conf_data = require("data.activity_conf_data")
local novice_award_data = require("data.novice_award_data")
local var_0_11 = "mainScenebg/activity/common/dianji.png"
local var_0_12 = "mainScenebg/activity/common/activity_entrance.png"
local var_0_14

function activityLeftDoorSprite.create(arg_3_0)
	local var_3_0 = activityLeftDoorSprite.new()

	var_3_0:init()

	return var_3_0
end

function activityLeftDoorSprite:init(...)
	var_0_14 = self
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(0, 0))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)
	self:initUI()
	self:initActivityList()
	self:registerEventListener()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_14 = nil

			if self.scheduler then
				for iter_5_0, iter_5_1 in pairs(self.scheduler) do
					time_check_manager:removeUpdatePool(iter_5_1)

					self.scheduler[iter_5_0] = nil
				end
			end
		end
	end)
end

function activityLeftDoorSprite.initUI(arg_6_0, ...)
	return
end

function activityLeftDoorSprite:initActivityList(...)
	self.ownIconList = self.ownIconList or {}

	for iter_7_0, iter_7_1 in pairs(self.ownIconList) do
		if self.rootLayer:getChildByName(iter_7_0) then
			self.rootLayer:getChildByName(iter_7_0):setVisible(false)
		end
	end

	self.iconList = {}

	local var_7_0 = self:getListConfig()

	if not next(var_7_0) then
		self:setVisible(false)

		return
	else
		self:setVisible(true)
	end

	local var_7_2 = os.date("*t", playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) and os.time(parse_time("2020-9-19 00:00:00")) + 1209600 or playermodel.create_time + 1209600)
	local var_7_3 = string.format("%d-%d-%d %d:%d:%d", var_7_2.year, var_7_2.month, var_7_2.day, var_7_2.hour, var_7_2.min, var_7_2.sec)
	local var_7_4 = 0
	local var_7_5 = 0

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		local var_7_6

		if iter_7_3.type == "recharge" then
			var_7_6 = self.rootLayer:getChildByName("rechargebtn")

			if not var_7_6 then
				var_7_6 = self:createRechagreIcon()

				var_7_6:setName("rechargebtn")
				self.rootLayer:addChild(var_7_6)
			end

			var_7_6:setVisible(true)
		elseif iter_7_3.type == "return_sevendaytask" then
			var_7_6 = self.rootLayer:getChildByName("returnsevendaytaskBtn")

			if not var_7_6 then
				var_7_6 = self:createReturnSevenDayIcon()

				var_7_6:setName("returnsevendaytaskBtn")

				var_7_6.type = "return_sevendaytask"

				local returnback_conf_data = require("data.returnback_conf_data")
				local var_7_8 = os.date("*t", playermodel.lastreturnbacktime + ((returnback_conf_data.sevenday_timeout or nil) and (returnback_conf_data.sevenday_timeout.value or 14)) * 86400)

				self:createBirthBtnTime(var_7_6:getChildByName("timeLabel"), (string.format("%d-%d-%d %d:%d:%d", var_7_8.year, var_7_8.month, var_7_8.day, var_7_8.hour, var_7_8.min, var_7_8.sec)))
				self.rootLayer:addChild(var_7_6)
			end

			var_7_6:setVisible(true)
		elseif iter_7_3.type == "task_novice" then
			var_7_6 = self.rootLayer:getChildByName("tasknoviceBtn")

			if not var_7_6 then
				var_7_6 = self:createTaskNoviceIcon()

				var_7_6:setName("tasknoviceBtn")

				var_7_6.type = "task_novice"

				local var_7_10 = os.date("*t", playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) and os.time(parse_time("2020-9-19 00:00:00")) + 1209600 or playermodel.create_time + 1209600)

				self:createBirthBtnTime(var_7_6:getChildByName("timeLabel"), (string.format("%d-%d-%d %d:%d:%d", var_7_10.year, var_7_10.month, var_7_10.day, var_7_10.hour, var_7_10.min, var_7_10.sec)))
				self.rootLayer:addChild(var_7_6)
			end

			var_7_6:setVisible(true)
		elseif iter_7_3.type == "activity_2_sign" then
			var_7_6 = self.rootLayer:getChildByName("signbtn")

			if not var_7_6 then
				var_7_6 = self:createActivity2SignIcon()

				var_7_6:setName("signbtn")
				self.rootLayer:addChild(var_7_6)
			end

			var_7_6:setVisible(true)
		elseif iter_7_3.jump == 2041 then
			var_7_6 = self.rootLayer:getChildByName(iter_7_3.path)

			if not var_7_6 then
				var_7_6 = self:createEntranceIcon(iter_7_3)

				var_7_6:setName(iter_7_3.path)
				self:createBirthBtnTime(var_7_6:getChildByName("timeLabel"), var_7_3)
				self.rootLayer:addChild(var_7_6)
			end

			var_7_6:setVisible(true)
		elseif iter_7_3.type == "entrance" then
			var_7_6 = self:creatNewEntranceIncon(iter_7_3)

			var_7_6:setName("btn_entrance" .. iter_7_3.door_img_path)
			self.rootLayer:addChild(var_7_6)
			var_7_6:setVisible(true)
		elseif iter_7_3.type == "newplayer" then
			var_7_6 = self:creatNewPlayerActivityIncon(iter_7_3)

			var_7_6:setName("newplayer_btn")
			self.rootLayer:addChild(var_7_6)
		else
			var_7_6 = self.rootLayer:getChildByName(iter_7_3.path)

			if not var_7_6 then
				var_7_6 = self:createEntranceIcon(iter_7_3)

				var_7_6:setName(iter_7_3.path)
				self:createBirthBtnTime(var_7_6:getChildByName("timeLabel"), iter_7_3.left_door_finishtime)
				self.rootLayer:addChild(var_7_6)
			end

			var_7_6:setVisible(true)
		end

		var_7_6:setPosition(var_7_4, var_7_5)

		self.iconList[iter_7_2] = var_7_6
		self.ownIconList[var_7_6:getName()] = true
		var_7_5 = var_7_5 + var_7_6:getContentSize().height * var_7_6:getScale()

		if #var_7_0 > 3 and iter_7_2 == 3 then
			var_7_4 = var_7_4 + var_7_6:getContentSize().width * var_7_6:getScale()
			var_7_5 = 10
		end
	end

	self:redrawActivityAlert()
end

local function var_0_15(arg_8_0)
	if not arg_8_0 then
		return
	end

	return string.gsub(arg_8_0, "@", "/")
end

function activityLeftDoorSprite:creatNewEntranceIncon(arg_9_1)
	local var_9_0 = (function(arg_10_0)
		if not arg_10_0 then
			return
		end

		return string.gsub(arg_10_0, "@", "/")
	end)(arg_9_1.door_img_path) or var_0_12
	local var_9_1 = ccui.Button:create(var_9_0, nil, var_9_0)

	var_9_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_9_1:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		require("controller.goto_system_manager")
		goto_complete_system({
			jump_to_system = arg_9_1.jump
		})
		AnalyticManager.clickActivityEntranceType({
			enterType = "ActivityDoor",
			activityid = arg_9_1.configId,
			jumpid = arg_9_1.jump
		})
	end)

	var_9_1.type = "entrance"
	var_9_1.activityid = arg_9_1.configId
	var_9_1.alert_activity_systemid = arg_9_1.alert_activity_systemid
	arg_9_1.is_show_time = true

	if arg_9_1.is_show_time then
		self:createTimeLabel(var_9_1, arg_9_1)
	end

	return var_9_1
end

function activityLeftDoorSprite:createTimeLabel(arg_12_1, arg_12_2)
	local var_12_0 = ccui.Text:create("", FONT_BUTTON, 16)

	var_12_0:setName("timeLabel")
	var_12_0:setColor(cc.c3b(254, 242, 242))
	var_12_0:setPosition(cc.p(50, 8))

	var_12_0.id = arg_12_2.id

	arg_12_1:addChild(var_12_0)

	local var_12_1 = arg_12_2.finishtime

	if not arg_12_2.finishtime then
		var_12_0:setString(L_ALL_TIME)

		return
	end

	if arg_12_2.configId == 4 then
		if playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) then
			local var_12_2 = os.date("*t", os.time(parse_time("2020-9-19 00:00:00")) + 1209600)

			var_12_1 = string.format("%d-%d-%d %d:%d:%d", var_12_2.year, var_12_2.month, var_12_2.day, var_12_2.hour, var_12_2.min, var_12_2.sec)
		else
			local var_12_3 = os.date("*t", playermodel.create_time + 1209600)

			var_12_1 = string.format("%d-%d-%d %d:%d:%d", var_12_3.year, var_12_3.month, var_12_3.day, var_12_3.hour, var_12_3.min, var_12_3.sec)
		end
	end

	local function var_12_4(arg_13_0)
		if var_12_0 and var_12_0.id then
			var_12_0:setString((formatTimeStr_2(arg_13_0)))

			if arg_13_0 <= 0 and var_12_0 and self.scheduler and self.scheduler[var_12_0.id] then
				time_check_manager:removeUpdatePool(self.scheduler[var_12_0.id])

				self.scheduler[var_12_0.id] = nil
			end
		end
	end

	local var_12_5 = global_get_time_by_date(var_12_1) - time_check_manager:getCurTime()

	if not var_12_5 then
		return
	end

	var_12_4(var_12_5)

	if var_12_5 < 86400 then
		var_12_0:setColor(cc.c3b(248, 99, 99))
	end

	self.scheduler = self.scheduler or {}
	self.scheduler[var_12_0.id] = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_12_5, var_12_4)))
end

function activityLeftDoorSprite.createEntranceIcon(arg_14_0, arg_14_1)
	local var_14_0 = var_0_15(arg_14_1.door_img_path) or var_0_12
	local var_14_1 = ccui.Button:create(var_14_0, nil, var_14_0)

	var_14_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_14_1:setName(arg_14_1.path)
	var_14_1:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		require("controller.goto_system_manager")

		if arg_14_1.jump_talk then
			global_basic_scene:addChild(TalkLayer:create(arg_14_1.jump_talk, nil, 1, ""))
		else
			goto_complete_system({
				jump_to_system = arg_14_1.jump
			})
		end

		AnalyticManager.clickActivityEntranceType({
			enterType = "ActivityLeftDoor",
			activityid = arg_14_1.configId,
			jumpid = arg_14_1.jump
		})
	end)

	var_14_1.type = "entrance"
	var_14_1.activityid = arg_14_1.configId
	var_14_1.alert_activity_systemid = arg_14_1.alert_activity_systemid

	local var_14_2 = ccui.Text:create("", FONT_BUTTON, 16)

	var_14_2:setName("timeLabel")
	var_14_2:setColor(cc.c3b(254, 242, 242))
	var_14_2:setPosition(cc.p(var_14_1:getContentSize().width / 2, 8))

	var_14_2.id = arg_14_1.id

	var_14_1:addChild(var_14_2)

	return var_14_1
end

function activityLeftDoorSprite.getEntranceList(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(activity_manager:getActivityEntranceList() or {}) do
		if iter_16_1.isinleftactivitydoor then
			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function activityLeftDoorSprite:getListConfig()
	local var_18_0 = activity_manager:getMainlayerList()
	local var_18_1 = {}

	if activity_manager:isShowNoviceSummary() then
		table.insert(var_18_1, {
			type = "task_novice"
		})
	end

	if self:checkIsShowRecharge() then
		table.insert(var_18_1, 3, {
			type = "recharge"
		})
	end

	if self:showPlayerIcon() then
		table.insert(var_18_1, {
			type = "newplayer"
		})
	end

	if require("controller.activity_return_manager"):is_return_sevendaytask_ongoing() then
		table.insert(var_18_1, {
			type = "return_sevendaytask"
		})
	end

	for iter_18_0, iter_18_1 in pairs((self:getEntranceList())) do
		if iter_18_1.id ~= 480 then
			iter_18_1.type = "entrance"

			table.insert(var_18_1, iter_18_1)
		end
	end

	return var_18_1
end

function activityLeftDoorSprite:redrawActivityAlert(...)
	local var_19_0 = false
	local var_19_1 = false

	local function var_19_2(arg_20_0, arg_20_1)
		local var_20_0 = activity_manager:getActivityObj(arg_20_0.activityid)
		local var_20_1 = var_20_0:getMainLayerAlertPos()

		if var_20_0._status == ACTIVITY_ACTIVING or var_20_0._status == ACTIVITY_ENDED then
			if arg_20_0.activityid ~= 15 then
				if activity_manager:getAlertAllStatus(arg_20_0.activityid, arg_20_0.alert_activity_systemid) then
					alert_manager:add_alert_by_config(arg_20_0, true, {
						ALERT_SHOW_REDDOT,
						"",
						(arg_20_1 == 1 or arg_20_0.activityid == 4 or arg_20_0.type == "entrance" or nil) and {
							x = arg_20_0:getContentSize().width - 15,
							y = arg_20_0:getContentSize().height / 2 + 30
						} or {
							x = arg_20_0:getContentSize().width - 15,
							y = arg_20_0:getContentSize().height - 10
						}
					})

					var_19_1 = true
				else
					alert_manager:add_alert_by_config(arg_20_0, false, {
						ALERT_SHOW_REDDOT
					})
				end
			else
				alert_manager:add_alert_by_config(arg_20_0, false, {
					ALERT_SHOW_REDDOT
				})
			end
		end
	end

	local function var_19_3(arg_21_0)
		local var_21_0 = activity_manager:getActivityObj(arg_21_0.activityid)
		local var_21_1 = var_21_0:getMainLayerAlertPos()

		if activity_manager:checkMainNewActivity(arg_21_0.activityid) then
			alert_manager:add_alert_by_config(arg_21_0, true, {
				ALERT_SHOW_NEW,
				"",
				var_21_0:getMainLayerNewAlertPos() or {
					x = arg_21_0:getContentSize().width - 20,
					y = arg_21_0:getContentSize().height - 10
				}
			})

			var_19_0 = true
		end
	end

	local function var_19_4(arg_22_0)
		if activity_manager:is_show_novicesummary() then
			alert_manager:add_alert_by_config(arg_22_0, true, {
				ALERT_SHOW_REDDOT,
				"",
				{
					x = arg_22_0:getContentSize().width - 20,
					y = arg_22_0:getContentSize().height - 15
				}
			})
		else
			alert_manager:add_alert_by_config(arg_22_0, false, {
				ALERT_SHOW_REDDOT
			})
		end
	end

	local function var_19_5(arg_23_0)
		if activity_manager:getAlertStatus(2, "sign") then
			alert_manager:add_alert_by_config(arg_23_0, true, {
				ALERT_SHOW_REDDOT,
				"",
				{
					x = arg_23_0:getContentSize().width - 20,
					y = arg_23_0:getContentSize().height - 15
				}
			})
		else
			alert_manager:add_alert_by_config(arg_23_0, false, {
				ALERT_SHOW_REDDOT
			})
		end
	end

	local function var_19_6(arg_24_0)
		if activity_manager:getAlertStatus(176, "return_sevenday") then
			alert_manager:add_alert_by_config(arg_24_0, true, {
				ALERT_SHOW_REDDOT,
				"",
				{
					x = arg_24_0:getContentSize().width - 20,
					y = arg_24_0:getContentSize().height - 15
				}
			})
		else
			alert_manager:add_alert_by_config(arg_24_0, false, {
				ALERT_SHOW_REDDOT
			})
		end
	end

	for iter_19_0, iter_19_1 in pairs(self.iconList) do
		if iter_19_1.type == "activity" or iter_19_1.type == "entrance" and iter_19_1.activityid then
			var_19_2(iter_19_1, iter_19_0)
			var_19_3(iter_19_1)
		elseif iter_19_1.type == "sign" then
			var_19_5(iter_19_1)
		elseif iter_19_1.type == "return_sevendaytask" then
			var_19_6(iter_19_1)
		elseif iter_19_1.type == "task_novice" then
			var_19_4(iter_19_1)
		elseif iter_19_1.type == "newplayer" then
			hx_print("更新新手红点")

			if self:newPlayerAlert() then
				alert_manager:add_alert_by_config(iter_19_1, true, {
					ALERT_SHOW_REDDOT,
					"",
					{
						x = iter_19_1:getContentSize().width - 20,
						y = iter_19_1:getContentSize().height - 15
					}
				})
			else
				alert_manager:add_alert_by_config(iter_19_1, false, {
					ALERT_SHOW_REDDOT
				})
			end
		end
	end

	self:checkRechargeAlert()
end

function activityLeftDoorSprite:resetActivityList()
	self:initActivityList()
end

local function var_0_16(arg_26_0)
	if not arg_26_0 then
		return ""
	end

	if arg_26_0 > 86400 then
		return string.format(L_TIME_SINGLE.Day, math.floor(arg_26_0 / 3600 / 24))
	elseif arg_26_0 >= 3600 then
		return string.format(L_TIME_SINGLE.Hour, math.floor(arg_26_0 / 3600))
	elseif arg_26_0 >= 60 then
		return string.format(L_TIME_SINGLE.Minute, math.floor(arg_26_0 % 3600 / 60))
	else
		return string.format(L_TIME_SINGLE.Minute, 1)
	end
end

function activityLeftDoorSprite:createBirthBtnTime(arg_27_1, arg_27_2)
	if not arg_27_1 or not arg_27_2 then
		return
	end

	local function var_27_0(arg_28_0)
		if arg_27_1 and arg_27_1.id then
			arg_27_1:setString((var_0_16(arg_28_0)))

			if arg_28_0 <= 0 and arg_27_1 and self.scheduler and self.scheduler[arg_27_1.id] then
				time_check_manager:removeUpdatePool(self.scheduler[arg_27_1.id])

				self.scheduler[arg_27_1.id] = nil
			end
		end
	end

	local var_27_1 = global_get_time_by_date(arg_27_2) - time_check_manager:getCurTime()

	if not var_27_1 then
		return
	end

	var_27_0(var_27_1)

	self.scheduler = self.scheduler or {}
	self.scheduler[arg_27_1.id] = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_27_1, var_27_0)))
end

function activityLeftDoorSprite:createRechagreIcon()
	self.rechargeBtn = ccui.Button:create(var_0_11, nil, var_0_11)

	self.rechargeBtn:setName("rechargebtn")
	self.rechargeBtn:setAnchorPoint(cc.p(0.5, 0.5))
	self.rechargeBtn:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_30_0:isBright() then
			return
		end

		self:createAwardPanel({
			paneltype = 1
		})
		AnalyticManager.clickActivityEntranceType({
			jumpid = 101,
			enterType = "ActivityLeftDoor"
		})
	end)

	local var_29_0 = ccui.ImageView:create("mainScenebg/activity/common/effect.png")

	var_29_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_29_0:setPosition(cc.p(self.rechargeBtn:getContentSize().width / 2, self.rechargeBtn:getContentSize().height / 2))
	self.rechargeBtn:addChild(var_29_0)
	var_29_0:setOpacity(40)
	var_29_0:setScale(0.5)
	var_29_0:runAction((cc.RepeatForever:create((cc.Sequence:create(cc.Spawn:create(cc.EaseOut:create(cc.ScaleTo:create(1, 3, 3), 2), cc.Sequence:create(cc.FadeTo:create(1 / 3, 255), cc.FadeTo:create(1 * 2 / 3, 40))), cc.CallFunc:create(function()
		var_29_0:setOpacity(40)
		var_29_0:setScale(0.5)
	end), cc.DelayTime:create(1 / 2))))))
	self:checkRechargeAlert()

	return self.rechargeBtn
end

function activityLeftDoorSprite:createTaskNoviceIcon()
	self.tasknoviceBtn = ccui.Button:create("mainScenebg/activity/branch2/novice_task.png", nil, "mainScenebg/activity/branch2/novice_task.png")

	self.tasknoviceBtn:setName("tasknoviceBtn")
	self.tasknoviceBtn:setAnchorPoint(cc.p(0.5, 0.5))
	self.tasknoviceBtn:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_33_0:isBright() then
			return
		end

		LayerManager:switchShowLayer("NoviceSummaryLayer", {
			isHideOther = true,
			layerName = "ActivityNoviceTaskLayer"
		})
	end)
	self:checkActivityNoticeTaskAlert()

	local var_32_0 = ccui.Text:create("", FONT_BUTTON, 16)

	var_32_0:setName("timeLabel")
	var_32_0:setColor(cc.c3b(254, 242, 242))
	var_32_0:setPosition(cc.p(self.tasknoviceBtn:getContentSize().width / 2, 8))

	var_32_0.id = -1

	self.tasknoviceBtn:addChild(var_32_0)

	return self.tasknoviceBtn
end

function activityLeftDoorSprite:createReturnSevenDayIcon()
	self.returnsevendaytaskBtn = ccui.Button:create("mainScenebg/activity/branch176/sevenday_task.png", nil, "mainScenebg/activity/branch176/sevenday_task.png")

	self.returnsevendaytaskBtn:setName("returnsevendaytaskBtn")
	self.returnsevendaytaskBtn:setAnchorPoint(cc.p(0.5, 0.5))
	self.returnsevendaytaskBtn:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_35_0:isBright() then
			return
		end

		LayerManager:switchShowLayer("ReturnBackSevenTaskLayer")
	end)

	local var_34_0 = ccui.Text:create("", FONT_BUTTON, 16)

	var_34_0:setName("timeLabel")
	var_34_0:setColor(cc.c3b(254, 242, 242))
	var_34_0:setPosition(cc.p(self.returnsevendaytaskBtn:getContentSize().width / 2, 8))

	var_34_0.id = -1

	self.returnsevendaytaskBtn:addChild(var_34_0)

	return self.returnsevendaytaskBtn
end

function activityLeftDoorSprite.checkActivityNoticeTaskAlert(arg_36_0)
	return
end

function activityLeftDoorSprite:checkRechargeAlert(...)
	if not self.rechargeBtn then
		return
	end

	local var_37_0

	while novice_award_data[1 + 1] do
		if playermodel.rechargeamountxinxiya >= novice_award_data[1 + 1].recharge_rmb then
			var_37_0 = 1 + 1
		end
	end

	if var_37_0 and (var_37_0 > playermodel.novice_award_process_xinxiya or var_37_0 > playermodel.novice_award_process_lucun) or activity_manager:getActivityObj(136) and activity_manager:getAlertAllStatus(136) then
		global_add_alert_tag(self.rechargeBtn, {
			x = 110,
			y = 110
		})
	else
		global_remove_alert_tag(self.rechargeBtn)
	end
end

function activityLeftDoorSprite.checkIsShowRecharge(arg_38_0)
	local novice_award_data = require("data.novice_award_data")

	if hexie_manager:isChannelInShenheTime() then
		return false
	end

	return playermodel.novice_award_process_xinxiya < #novice_award_data or playermodel.novice_award_process_lucun < #novice_award_data or activity_manager:getActivityObj(136)
end

function activityLeftDoorSprite.checkIsRechargeFirst(arg_39_0)
	local var_39_0 = os.date("*t", playermodel.create_time)
	local var_39_1 = os.date("*t", time_check_manager:getCurTime())

	if math.abs(var_39_0.year - var_39_1.year) > 1 or math.abs(var_39_0.month - var_39_1.month) > 1 then
		return false
	else
		return true
	end
end

function activityLeftDoorSprite.createAwardPanel(arg_40_0, arg_40_1)
	function arg_40_1.callback()
		if activitydoorspriteInstance then
			SwitchManageLayer:switchAniUIElemen(SwitchManageLayer.activeLayerName, true)

			if not activitydoorspriteInstance:checkIsShowRecharge() then
				activitydoorspriteInstance:resetActivityList()
			end
		end
	end

	LayerManager:pushInLayer("PopNoviceAwardLayer", arg_40_1)
end

function activityLeftDoorSprite.createActivity2SignIcon(arg_42_0, ...)
	local var_42_0 = ccui.Button:create("mainScenebg/activity/branch2/sign.png", nil, "mainScenebg/activity/branch2/sign.png")

	var_42_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_42_0:setName("signbtn")

	var_42_0.type = "sign"

	var_42_0:addTouchEventListener(function(arg_43_0, arg_43_1)
		local var_43_0

		if arg_43_1 ~= ccui.TouchEventType.ended then
			do return end

			var_43_0 = {
				activityid = 2,
				activityUIObjName = "ActivitySignFmlLayer"
			}
		end

		function var_43_0.exit_set_bright_callback()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end

		LayerManager:pushInLayer("ActivitySignBaseLayer", var_43_0)
		AnalyticManager.clickActivityEntranceType({
			activityid = 2,
			jumpid = 104,
			enterType = "ActivityLeftDoor"
		})
	end)

	return var_42_0
end

function activityLeftDoorSprite:registerEventListener(...)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("UPDATE_AC_MODULE_STAT", function(arg_46_0)
		self:resetActivityList()
	end), self)
end

function activityLeftDoorSprite:creatNewPlayerActivityIncon()
	local var_47_0 = ccui.Button:create("mainScenebg/activity/branch2/newplayer.png", nil, "mainScenebg/activity/branch2/newplayer.png")

	var_47_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_47_0:addTouchEventListener(function(arg_48_0, arg_48_1)
		if arg_48_1 ~= ccui.TouchEventType.ended then
			return
		end

		require("controller.goto_system_manager")
		LayerManager:switchShowLayer("NewPlayerActivityLayer")
		AnalyticManager.clickActivityEntranceType({
			enterType = "ActivityDoor",
			layerName = "NewPlayerActivityLayer"
		})
	end)

	local var_47_1 = ccui.Text:create("福利", FONT_BUTTON, 16)

	var_47_1:setName("timeLabel")
	var_47_1:setColor(cc.c3b(254, 242, 242))
	var_47_1:setPosition(cc.p(50, 8))
	var_47_0:addChild(var_47_1)

	if self:newPlayerAlert() then
		alert_manager:add_alert_by_config(var_47_0, true, {
			ALERT_SHOW_REDDOT,
			"",
			{
				x = var_47_0:getContentSize().width - 20,
				y = var_47_0:getContentSize().height - 15
			}
		})
	else
		alert_manager:add_alert_by_config(var_47_0, false, {
			ALERT_SHOW_REDDOT
		})
	end

	return var_47_0
end

function activityLeftDoorSprite.newPlayerAlert(arg_49_0)
	if activity_manager:getAlertStatus(2, "sign") then
		return true
	end

	if activity_manager:getAlertAllStatus(480) then
		return true
	end

	if activity_manager:getAlertAllStatus(136) or activity_manager:getAlertStatus(255, "bpg") then
		return true
	end

	return false
end

function activityLeftDoorSprite.showPlayerIcon(arg_50_0)
	if not activity_manager:is_module_stat_finished(2, "sign") then
		return true
	end

	if activity_manager:isShowNoviceSummary() then
		return true
	end

	if not activity_manager:is_module_stat_finished(480, "sign") then
		return true
	end

	if activity_manager:getActivityObj(136) ~= nil or activity_manager:getActivityObj(255) ~= nil then
		return true
	end

	return false
end

return activityLeftDoorSprite
