activityTopDoorSprite = class("activityTopDoorSprite", function()
	return cc.Node:create()
end)

local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local alert_manager = require("controller.alert_manager")
local playermodel = require("model.playermodel")
local activity_return_manager = require("controller.activity_return_manager")
local activity_conf_data = require("data.activity_conf_data")
local novice_award_data = require("data.novice_award_data")
local var_0_12 = "mainScenebg/activity/common/activity_entrance.png"
local var_0_13

function activityTopDoorSprite.create(arg_2_0)
	local var_2_0 = activityTopDoorSprite.new()

	var_2_0:init()

	return var_2_0
end

function activityTopDoorSprite:init(...)
	var_0_13 = self
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(0, 0))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)
	self:initUI()
	self:initActivityList()
	self:registerReturnSignEvent()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_13 = nil

			activity_manager:releaseEventListenerByName("activityTopDoorSprite")

			if self.scheduler then
				for iter_4_0, iter_4_1 in pairs(self.scheduler) do
					time_check_manager:removeUpdatePool(iter_4_1)

					self.scheduler[iter_4_0] = nil
				end
			end
		end
	end)
end

function activityTopDoorSprite.initUI(arg_5_0, ...)
	return
end

function activityTopDoorSprite:initActivityList(...)
	self.iconList = {}

	local var_6_0 = self:getListConfig()

	if not next(var_6_0) then
		self:setVisible(false)

		return
	else
		self:setVisible(true)
	end

	local var_6_1 = 20

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_4 = self:createEntranceIcon(iter_6_1.info)

		self:createBirthBtnTime(var_6_4:getChildByName("timeLabel"), iter_6_1.info.top_door_finishtime)
		var_6_4:setPosition(cc.p(var_6_1 + (iter_6_0 - 1) % 5 * -80, 0 + math.floor((iter_6_0 - 1) / 5) * -120))
		self.rootLayer:addChild(var_6_4)

		self.iconList[iter_6_0] = var_6_4
	end

	self:redrawActivityAlert()
end

function activityTopDoorSprite.registerReturnSignEvent(arg_7_0, ...)
	return
end

function activityTopDoorSprite.createEntranceIcon(arg_8_0, arg_8_1)
	local var_8_0 = (function(arg_9_0)
		if not arg_9_0 then
			return
		end

		return string.gsub(arg_9_0, "@", "/")
	end)(arg_8_1.door_img_path) or var_0_12
	local var_8_1 = ccui.Button:create(var_8_0, nil, var_8_0)

	var_8_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_8_1:setScale(0.65)
	var_8_1:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		require("controller.goto_system_manager")

		if arg_8_1.jump_talk then
			global_basic_scene:addChild(TalkLayer:create(arg_8_1.jump_talk, nil, 1, ""))
		else
			goto_complete_system({
				jump_to_system = arg_8_1.jump
			})
		end

		AnalyticManager.clickActivityEntranceType({
			enterType = "ActivityTopDoor",
			activityid = arg_8_1.configId,
			jumpid = systemID
		})
	end)

	var_8_1.type = "entrance"
	var_8_1.activityid = arg_8_1.configId
	var_8_1.alert_activity_systemid = arg_8_1.alert_activity_systemid

	local var_8_2 = ccui.Text:create("", FONT_BUTTON, 20)

	var_8_2:setName("timeLabel")
	var_8_2:setColor(cc.c3b(254, 242, 242))
	var_8_2:setPosition(cc.p(var_8_1:getContentSize().width / 2, var_8_1:getContentSize().height - 44))

	var_8_2.id = arg_8_1.id

	var_8_1:addChild(var_8_2)

	return var_8_1
end

function activityTopDoorSprite.getEntranceList(arg_11_0)
	local var_11_0 = global_deepCopy(activity_manager:getActivityEntranceList()) or {}

	;(function(...)
		local var_12_3 = {}

		for iter_12_0, iter_12_1 in pairs(var_11_0) do
			if iter_12_1.init_type == BRTH_ACTIVITY then
				table.insert(var_12_3, iter_12_1)
			end
		end

		if #var_12_3 > 1 then
			table.sort(var_12_3, function(arg_13_0, arg_13_1)
				return (arg_13_1.starttime or "0") < (arg_13_0.starttime or "0")
			end)

			var_12_3[1].param = {
				singleMarket = {
					"1-" .. var_12_3[1].jump % 1500000
				},
				showType = "1-" .. var_12_3[1].jump % 1500000
			}

			for iter_12_2 = 2, #var_12_3 do
				table.insert(var_12_3[1].param.singleMarket, "1-" .. var_12_3[iter_12_2].jump % 1500000)

				var_11_0[var_12_3[iter_12_2].id] = nil
			end
		end
	end)()

	local var_11_1 = {}

	local function var_11_2(arg_14_0)
		local var_14_0 = time_check_manager:getCurTime()

		if arg_14_0.top_door_starttime and var_14_0 < os.time(parse_time(arg_14_0.top_door_starttime)) then
			return false
		end

		if arg_14_0.top_door_finishtime and var_14_0 > os.time(parse_time(arg_14_0.top_door_finishtime)) then
			return false
		end

		return true
	end

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		if iter_11_1.isintopactivitydoor and var_11_2(iter_11_1) then
			table.insert(var_11_1, iter_11_1)
		end
	end

	table.sort(var_11_1, function(arg_15_0, arg_15_1)
		return arg_15_0.order < arg_15_1.order
	end)

	return var_11_1
end

function activityTopDoorSprite:getListConfig()
	local var_16_0 = activity_manager:getMainlayerList()
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in pairs((self:getEntranceList())) do
		table.insert(var_16_1, {
			type = "entrance",
			info = iter_16_1
		})
	end

	table.sort(var_16_1, function(arg_17_0, arg_17_1)
		return (arg_17_1.activityid and os.time(parse_time(activity_conf_data[arg_17_1.activityid].starttime)) or os.time(parse_time(arg_17_1.info.top_door_starttime))) < (arg_17_0.activityid and os.time(parse_time(activity_conf_data[arg_17_0.activityid].starttime)) or os.time(parse_time(arg_17_0.info.top_door_starttime)))
	end)

	return var_16_1
end

function activityTopDoorSprite:redrawActivityAlert(...)
	local var_18_0 = false
	local var_18_1 = false

	local function var_18_2(arg_19_0, arg_19_1)
		local var_19_0 = activity_manager:getActivityObj(arg_19_0.activityid)
		local var_19_1 = var_19_0:getMainLayerAlertPos()

		if var_19_0._status == ACTIVITY_ACTIVING or var_19_0._status == ACTIVITY_ENDED then
			if arg_19_0.activityid ~= 15 then
				if activity_manager:getAlertAllStatus(arg_19_0.activityid, arg_19_0.alert_activity_systemid) then
					alert_manager:add_alert_by_config(arg_19_0, true, {
						ALERT_SHOW_REDDOT,
						"",
						(arg_19_1 == 1 or nil) and {
							x = arg_19_0:getContentSize().width - 40,
							y = arg_19_0:getContentSize().height / 2 + 30
						} or {
							x = arg_19_0:getContentSize().width - 15,
							y = arg_19_0:getContentSize().height - 10
						}
					})

					var_18_1 = true
				else
					alert_manager:add_alert_by_config(arg_19_0, false, {
						ALERT_SHOW_REDDOT
					})
				end
			else
				alert_manager:add_alert_by_config(arg_19_0, false, {
					ALERT_SHOW_REDDOT
				})
			end
		end
	end

	local function var_18_3(arg_20_0)
		local var_20_0 = activity_manager:getActivityObj(arg_20_0.activityid)
		local var_20_1 = var_20_0:getMainLayerAlertPos()

		if activity_manager:checkMainNewActivity(arg_20_0.activityid) then
			alert_manager:add_alert_by_config(arg_20_0, true, {
				ALERT_SHOW_NEW,
				"",
				var_20_0:getMainLayerNewAlertPos() or {
					x = arg_20_0:getContentSize().width - 20,
					y = arg_20_0:getContentSize().height - 10
				}
			})

			var_18_0 = true
		end
	end

	for iter_18_0, iter_18_1 in pairs(self.iconList) do
		if iter_18_1.type == "activity" or iter_18_1.type == "entrance" and iter_18_1.activityid then
			var_18_2(iter_18_1, iter_18_0)
			var_18_3(iter_18_1)
		end
	end
end

function activityTopDoorSprite:resetActivityList()
	self.rootLayer:removeAllChildren()
	self:initActivityList()
end

local function var_0_14(arg_22_0)
	if not arg_22_0 then
		return ""
	end

	if arg_22_0 > 86400 then
		return string.format(L_TIME_SINGLE.Day, math.floor(arg_22_0 / 3600 / 24))
	elseif arg_22_0 >= 3600 then
		return string.format(L_TIME_SINGLE.Hour, math.floor(arg_22_0 / 3600))
	elseif arg_22_0 >= 60 then
		return string.format(L_TIME_SINGLE.Minute, math.floor(arg_22_0 % 3600 / 60))
	else
		return string.format(L_TIME_SINGLE.Minute, 1)
	end
end

function activityTopDoorSprite:createBirthBtnTime(arg_23_1, arg_23_2)
	if not arg_23_1 or not arg_23_2 then
		return
	end

	local function var_23_0(arg_24_0)
		if arg_23_1 and arg_23_1.id then
			arg_23_1:setString((var_0_14(arg_24_0)))

			if arg_24_0 <= 0 and arg_23_1 and self.scheduler and self.scheduler[arg_23_1.id] then
				time_check_manager:removeUpdatePool(self.scheduler[arg_23_1.id])

				self.scheduler[arg_23_1.id] = nil
			end
		end
	end

	local var_23_1 = global_get_time_by_date(arg_23_2) - time_check_manager:getCurTime()

	if not var_23_1 then
		return
	end

	var_23_0(var_23_1)

	self.scheduler = self.scheduler or {}
	self.scheduler[arg_23_1.id] = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_23_1, var_23_0)))
end

return activityTopDoorSprite
