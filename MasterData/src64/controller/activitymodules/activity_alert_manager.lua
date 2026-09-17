local activity_base_manager = require("controller.activitymodules.activity_base_manager")
local activity_entrance_data = require("data.activity_entrance_data")
local alert_manager = require("controller.alert_manager")
local network = require("network.network")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local task_data = require("data.task_data")
local activity_conf_data = require("data.activity_conf_data")
local time_check_manager = require("controller.time_check_manager")

local function var_0_13(...)
	local activity_task_index_data = require("data.activity_task_index_data")

	return (playermodel.create_time > os.time(parse_time("2021-05-28 00:00:00")) or nil) and require("data.activity_sevendays_index_data")
end

activity_base_manager.newActivityList = {}

function activity_base_manager.checkNewActivityList(arg_2_0)
	network:rpc("check_new_activity_list", nil, function(arg_3_0)
		arg_2_0.newActivityList = {}

		for iter_3_0, iter_3_1 in pairs(arg_3_0.list) do
			arg_2_0.newActivityList[iter_3_1] = true
		end

		arg_2_0:fireEvent(arg_2_0.activityEventId.UPDATE_NEW_ACTIVITY_LIST)
	end)
end

function activity_base_manager:openNewActivity(arg_4_1)
	if not arg_4_1 then
		return
	end

	network:rpc("open_new_activity", {
		id = arg_4_1
	})

	self.newActivityList[arg_4_1] = false

	self:fireEvent(self.activityEventId.UPDATE_NEW_ACTIVITY_LIST)
end

function activity_base_manager:checkActClickId(arg_5_1)
	local var_5_0

	for iter_5_0, iter_5_1 in pairs(self.newActivityList) do
		if activity_entrance_data[iter_5_0] ~= nil and activity_entrance_data[iter_5_0].image == tonumber(arg_5_1) then
			var_5_0 = iter_5_0

			break
		end
	end

	return var_5_0
end

function activity_base_manager:isNewActivity(arg_6_1)
	self:checkActClickId(arg_6_1)

	return self.newActivityList[nil]
end

function activity_base_manager.checkRedNode(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getChildByName("reddot")

	if var_7_0 then
		var_7_0:setVisible(false)
	end

	return var_7_0
end

function activity_base_manager:checkMainNewActivity(arg_8_1)
	self:checkActClickId(name)

	return self.newActivityList[nil]
end

activity_base_manager.alertactivity = {}

function activity_base_manager:updateActivityAlert(arg_9_1, arg_9_2, arg_9_3)
	arg_9_3 = arg_9_3 == nil and true or arg_9_3
	self.alertactivity[arg_9_1] = self.alertactivity[arg_9_1] or {}

	if arg_9_3 then
		if type(arg_9_2) == "number" then
			if self.alertactivity[arg_9_1][arg_9_2] then
				return
			end

			self.alertactivity[arg_9_1][arg_9_2] = true
		elseif type(arg_9_2) == "table" then
			for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
				self.alertactivity[arg_9_1][iter_9_1] = self.alertactivity[arg_9_1][iter_9_1] or true
			end
		end
	else
		self.alertactivity[arg_9_1][arg_9_2] = nil
	end

	if self.alertactivity.task and self.alertactivity.task[169] then
		self.alertactivity.pt = self.alertactivity.pt or {}
		self.alertactivity.pt[167] = true
	elseif self.alertactivity.pt then
		self.alertactivity.pt[167] = nil
	end

	self:fireEvent(activity_base_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, {
		alerttype = arg_9_1,
		activity = arg_9_2
	})
end

function activity_base_manager:cleanAllActivityAlert()
	for iter_10_0, iter_10_1 in pairs(self.alertactivity) do
		iter_10_1 = {}
	end
end

AAA = activity_base_manager.alertactivity

function activity_base_manager:getAlertStatus(arg_11_1, arg_11_2)
	if not self.alertactivity[arg_11_2] then
		return false
	end

	if not self.alertactivity[arg_11_2][arg_11_1] then
		return false
	end

	return self.alertactivity[arg_11_2][arg_11_1]
end

function activity_base_manager:getAlertAllStatus(arg_12_1, arg_12_2)
	if not arg_12_1 then
		return
	end

	local var_12_0
	local var_12_1 = {}

	if arg_12_2 then
		if arg_12_2:find("@") then
			var_12_1 = string.split(arg_12_2, "@")
		else
			table.insert(var_12_1, arg_12_2)
		end
	end

	if next(var_12_1) then
		for iter_12_0, iter_12_1 in pairs(var_12_1) do
			if self.alertactivity[iter_12_1] and self.alertactivity[iter_12_1][arg_12_1] then
				var_12_0 = true
			end
		end
	else
		for iter_12_2, iter_12_3 in pairs(self.alertactivity) do
			if self.alertactivity[iter_12_2][arg_12_1] then
				var_12_0 = true

				break
			end
		end
	end

	return var_12_0
end

function activity_base_manager.isActivityEntranceNeedAlert(arg_13_0)
	local var_13_0 = not playermodel.haveopenaward or playermodel.haveopenaward ~= true

	if not playermodel.haverechargeaward or playermodel.haverechargeaward ~= true then
		var_13_0 = true
	end

	if AlertManager.alertsys[ALERT_MIDAS] == true or AlertManager.alertsys[ALERT_SIGN] == true then
		var_13_0 = true
	end

	return (require("controller.level_manager"):isPlayerPassLevel(UNLOCK_TWIST) and AlertManager.alertsys[ALERT_TWISTEGG] == true or nil) and true
end

function activity_base_manager.rechargeAward(arg_14_0)
	local novice_award_data = require("data.novice_award_data")

	for iter_14_0 = 1, #novice_award_data do
		if playermodel.rechargeamountxinxiya >= novice_award_data[iter_14_0].recharge_rmb and (iter_14_0 > playermodel.novice_award_process_xinxiya or iter_14_0 > playermodel.novice_award_process_lucun) then
			return iter_14_0
		end
	end

	return nil
end

function activity_base_manager:isActivityInEntranceNeedAlert(arg_15_1)
	local var_15_0 = false

	if activity_entrance_data[arg_15_1] == nil then
		return var_15_0
	end

	if activity_entrance_data[arg_15_1].configId ~= nil then
		var_15_0 = self:getAlertAllStatus(activity_entrance_data[arg_15_1].configId, activity_entrance_data[arg_15_1].alert_activity_systemid)
	elseif activity_entrance_data[arg_15_1].init_type == OPEN_AWARD and playermodel.haveopenaward ~= true then
		var_15_0 = true
	elseif activity_entrance_data[arg_15_1].init_type == RECHARGE_AWARD and self:rechargeAward() then
		var_15_0 = true
	end

	return var_15_0
end

activity_base_manager:registerEventListener("activity_manager", activity_base_manager.activityEventId.EXIT_FORM_PURCHASE_LAYER, function()
	activity_base_manager:update_alert_by_model("multi_pt")
	activity_base_manager:update_alert_by_model("flop")
	activity_base_manager:update_alert_by_model("bp_proceed")
end)

local var_0_14 = 1
local var_0_15 = 2

local function var_0_16(arg_21_0, arg_21_1)
	local var_21_0 = false

	if arg_21_0 == 2 then
		local var_21_1 = var_0_13()
		local time_check_manager = require("controller.time_check_manager")

		local function var_21_3(arg_22_0)
			for iter_22_0, iter_22_1 in pairs(var_21_1) do
				if iter_22_1.taskid == arg_22_0 then
					if not iter_22_1.stage then
						return true
					else
						if iter_22_1.stage == 7 then
							return true
						end

						local var_22_0 = time_check_manager:getCurTime()
						local var_22_1 = os.date("*t", playermodel.create_time)
						local var_22_2 = os.time({
							hour = 0,
							min = 0,
							sec = 1,
							year = var_22_1.year,
							month = var_22_1.month,
							day = var_22_1.day
						})

						if iter_22_1.stage < 7 then
							return var_22_0 > var_22_2 + 86400 * (iter_22_1.stage - 2)
						else
							return var_22_0 > var_22_2 + 86400 * (iter_22_1.stage - 3)
						end
					end
				end
			end

			return true
		end

		for iter_21_0, iter_21_1 in pairs(arg_21_1) do
			if iter_21_1.status == 0 and iter_21_1.percent == 100 and var_21_3(iter_21_1.taskid) then
				var_21_0 = true

				break
			end
		end
	else
		for iter_21_2, iter_21_3 in pairs(arg_21_1) do
			if iter_21_3.status == 0 and iter_21_3.percent == 100 then
				var_21_0 = true

				break
			end
		end
	end

	return var_21_0
end

local var_0_17 = {
	wake_fund = function(arg_17_0, arg_17_1)
		local var_17_0 = false

		for iter_17_0, iter_17_1 in pairs(arg_17_1) do
			if iter_17_1.status == 0 and iter_17_1.percent == 100 then
				var_17_0 = true

				break
			end

			local var_17_1 = require("data.activity_modules.activity_wake_fund_conf")[arg_17_0].extra_drop_vip

			if task_data[iter_17_1.taskid].extra_drop and iter_17_1.extra_award == 0 and (iter_17_1.status == 0 and iter_17_1.percent == 100 or iter_17_1.status == 1 or iter_17_1.status == 2) and var_17_1 and item_manager:getItemNumber(var_17_1) > 0 then
				var_17_0 = true

				break
			end
		end

		return var_17_0
	end,
	sign = function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_1.signTag
		local var_18_1 = arg_18_1.signstats
		local var_18_2 = arg_18_1.signdate

		return ({
			[var_0_14] = function()
				return var_18_0
			end,
			[var_0_15] = function()
				local activity_sign_data = require("data.activity_sign_data")
				local var_20_1 = os.time(parse_time((os.date("%Y-%m-%d 00:00:00", require("controller.time_check_manager"):getCurTime()))))

				for iter_20_0, iter_20_1 in pairs(var_18_2) do
					local var_20_2 = os.time(parse_time(iter_20_1 .. " 00:00:00"))

					if var_20_2 == var_20_1 and var_18_1[iter_20_0] == false then
						return true
					elseif var_20_2 < var_20_1 and var_18_1[iter_20_0] == false and activity_sign_data[arg_18_0 .. "-" .. iter_20_0].cansupplement == 1 and activity_sign_data[arg_18_0 .. "-" .. iter_20_0].supplementcost == 0 then
						return true
					end
				end

				return false
			end
		})[arg_18_1.signType]()
	end,
	freeexplorer = function(arg_23_0, arg_23_1)
		local activity_explore_conf = require("data.activity_modules.activity_explore_conf")

		if config._DEBUG then
			assert(arg_23_0, "TM SB :.: ？")
			assert(activity_explore_conf[arg_23_0], string.format("activityExploreConf id is nil:%s", arg_23_0))
			assert(activity_explore_conf[arg_23_0].explorefile, string.format("activityExploreConf[%s].explorefile is nil", arg_23_0))
		elseif not arg_23_0 or not activity_explore_conf[arg_23_0] or not activity_explore_conf[arg_23_0].explorefile then
			return false
		end

		local var_23_1 = require(string.format("data.activity_%s.%s", arg_23_0, activity_explore_conf[arg_23_0].explorefile))
		local var_23_2 = time_check_manager:getCurTime()

		for iter_23_0, iter_23_1 in pairs(arg_23_1.explore_info) do
			if var_23_1[iter_23_1.id].explore_type == 1 and var_23_1[iter_23_1.id].isrepeat and arg_23_1.finish_step < 1 then
				return true
			elseif arg_23_1.finish_step >= var_23_1[iter_23_1.id].limit_state then
				while var_23_1[iter_23_1.id]["need_item" .. 1] do
					if not item_manager:isHaveEnoughItem(var_23_1[iter_23_1.id]["need_item" .. 1], var_23_1[iter_23_1.id]["need_num" .. 1]) then
						return false
					end
				end

				if var_23_1[iter_23_1.id].is_daily then
					if var_23_1[iter_23_1.id].starttime and var_23_2 > global_get_time_by_date(var_23_1[iter_23_1.id].starttime) and var_23_1[iter_23_1.id].finishtime and var_23_2 < global_get_time_by_date(var_23_1[iter_23_1.id].finishtime) and iter_23_1.daily_times and iter_23_1.daily_times < var_23_1[iter_23_1.id].daily_times then
						return true
					end
				end

				if arg_23_1.finish_step == var_23_1[iter_23_1.id].limit_state and var_23_1[iter_23_1.id].explore_type == 1 then
					return true
				end
			elseif arg_23_1.finish_step <= var_23_1[iter_23_1.id].limit_state and var_23_1[iter_23_1.id].explore_type == 1 then
				return true
			end
		end

		return false
	end,
	flop = function(arg_24_0)
		local var_24_0 = require("controller.activity_manager"):canFlop(arg_24_0)

		if type(var_24_0) == "table" then
			return false
		else
			return var_24_0
		end
	end,
	once = function(arg_27_0)
		local time_check_manager = require("controller.time_check_manager")
		local activity_manager = require("controller.activity_manager")

		if io.exists("./src/data/activity_main/uiconfig/activity_main_uiconfig_" .. arg_27_0 .. "_data.lua") then
			for iter_27_0, iter_27_1 in pairs((require("data.activity_main.uiconfig.activity_main_uiconfig_" .. arg_27_0 .. "_data"))) do
				if iter_27_1.open_reddot == "once" then
					local var_27_4 = RoleDefault:getInstance():getIntegerForKey(arg_27_0 .. iter_27_0 .. "reddot", 0)

					if var_27_4 == 0 then
						if iter_27_1.locktime and time_check_manager:getCurTime() < os.time(parse_time(iter_27_1.locktime)) then
							activity_manager:updateActivityAlert(iter_27_0, arg_27_0, false)
						else
							RoleDefault:getInstance():setIntegerForKey(arg_27_0 .. iter_27_0 .. "reddot", 1)
							activity_manager:updateActivityAlert(iter_27_0, arg_27_0, true)
						end
					elseif var_27_4 == 1 then
						activity_manager:updateActivityAlert(iter_27_0, arg_27_0, true)
					elseif var_27_4 == 2 then
						activity_manager:updateActivityAlert(iter_27_0, arg_27_0, false)
					end
				end
			end
		end

		return nil
	end,
	multi_pt = function(arg_25_0)
		local activity_manager = require("controller.activity_manager")

		if not require("data.activity_multi_pt_conf_data")[arg_25_0] then
			return false
		end

		return activity_manager:isMuiltPtHasRewardCanGet(arg_25_0) and activity_manager:getAlertStatus(arg_25_0, "task_mulit_pt")
	end,
	bp_proceed = function(arg_26_0)
		activity_base_manager:getBattlePassLevelData(arg_26_0, false)
		activity_base_manager:getActivityTask(arg_26_0, false)
	end
}

setmetatable(var_0_17, {
	__index = function(arg_28_0, arg_28_1)
		if arg_28_1:find("task") or arg_28_1:find("pass_level") or arg_28_1:find("nmsl") or arg_28_1:find("total_twist") or arg_28_1:find("total_recharge") or arg_28_1:find("total_consume_diamond") or arg_28_1:find("consume_giftcard") or arg_28_1:find("have_skin") or arg_28_1:find("airplane") then
			return var_0_16
		end

		return function()
			return
		end
	end
})

function activity_base_manager.update_alert(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = var_0_17[arg_30_2](arg_30_1, arg_30_3)

	if var_30_0 ~= nil then
		activity_base_manager:updateActivityAlert(arg_30_2, arg_30_1, var_30_0)
	end
end

function activity_base_manager.update_daily_alert(arg_31_0)
	network:rpc("check_system_alert", nil, function(arg_32_0)
		if arg_32_0.alert_activity then
			for iter_32_0, iter_32_1 in ipairs(arg_32_0.alert_activity) do
				arg_31_0:updateActivityAlert(iter_32_1.alerttype, iter_32_1.activities)
			end
		end
	end)
end

function activity_base_manager:update_alert_by_model(arg_33_1)
	for iter_33_0, iter_33_1 in pairs(self:getCurrentActivites()) do
		self:update_alert(iter_33_0, arg_33_1)
	end
end

function activity_base_manager:getAlertStatusByJumpid(arg_34_1)
	if type(arg_34_1) == "string" and arg_34_1:find("@") then
		return
	end

	if type(arg_34_1) == "string" then
		arg_34_1 = tonumber(arg_34_1)
	end

	if arg_34_1 >= 1900001 and arg_34_1 <= 1999999 then
		local activity_task_conf = require("data.activity_modules.activity_task_conf")
		local var_34_1 = {}

		assert(activity_task_conf[arg_34_1 % 100000], "activity_task_conf id is nil " .. arg_34_1 % 100000)

		while activity_task_conf[arg_34_1 % 100000]["module" .. 1] do
			table.insert(var_34_1, activity_task_conf[arg_34_1 % 100000]["module" .. 1])
		end

		for iter_34_0, iter_34_1 in pairs(var_34_1) do
			if self:getAlertStatus(arg_34_1 % 100000, iter_34_1) then
				return true
			end
		end
	end
end

function activity_base_manager:getActivityEntranceListAlertStatus(...)
	local activity_return_manager = require("controller.activity_return_manager")
	local var_35_1 = {
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
	}
	local var_35_2 = {}
	local var_35_3 = 1
	local var_35_4 = self:getActivityEntranceList()

	if var_35_4 then
		for iter_35_0, iter_35_1 in pairs(var_35_4) do
			if iter_35_1.image ~= 3000001 and not iter_35_1.is_not_in_entrance then
				if iter_35_0 == 8061 then
					if not self:is_module_stat_finished(2, "sign") then
						var_35_2[var_35_3] = iter_35_1
						var_35_3 = var_35_3 + 1
					end
				elseif iter_35_0 == 8065 then
					local novice_pass_level_data = require("data.novice_pass_level_data")
					local level_manager = require("controller.level_manager")
					local var_35_7 = {}

					for iter_35_2, iter_35_3 in pairs(playermodel.novice_pass_level_award) do
						var_35_7[iter_35_3] = true
					end

					local var_35_8

					for iter_35_4, iter_35_5 in pairs(novice_pass_level_data) do
						if not var_35_7[iter_35_5.id] then
							var_35_8 = true

							break
						end
					end

					if var_35_8 then
						var_35_2[var_35_3] = iter_35_1
						var_35_3 = var_35_3 + 1
					end
				elseif iter_35_0 == 8062 then
					local novice_award_data = require("data.novice_award_data")

					if playermodel.novice_award_process_xinxiya < #novice_award_data or playermodel.novice_award_process_lucun < #novice_award_data then
						var_35_2[var_35_3] = iter_35_1
						var_35_3 = var_35_3 + 1
					end
				else
					var_35_2[var_35_3] = iter_35_1
					var_35_3 = var_35_3 + 1
				end
			end
		end
	end

	local var_35_10 = {}

	for iter_35_6, iter_35_7 in pairs(var_35_2) do
		if self:isActivityInEntranceNeedAlert(iter_35_7.id) then
			assert(iter_35_7.tab, "exntrance data " .. iter_35_7.id .. "tab is nil")

			var_35_10[iter_35_7.tab] = var_35_10[iter_35_7.tab] or {}
			var_35_10[iter_35_7.tab][iter_35_7.id] = true
		elseif var_35_1[tostring(iter_35_7.image)] and (var_35_1[tostring(iter_35_7.image)][1] and alert_manager.alertsys[var_35_1[tostring(iter_35_7.image)][1]] or var_35_1[tostring(iter_35_7.image)][2] and alert_manager.alertsys[var_35_1[tostring(iter_35_7.image)][2]]) then
			var_35_10[iter_35_7.tab] = var_35_10[iter_35_7.tab] or {}
			var_35_10[iter_35_7.tab][iter_35_7.id] = true
		end

		if iter_35_7.id == 8066 then
			if activity_return_manager:get_can_sign() then
				var_35_10[iter_35_7.tab] = var_35_10[iter_35_7.tab] or {}
				var_35_10[iter_35_7.tab][iter_35_7.id] = true
			end
		elseif iter_35_7.id == 8064 then
			if not self:is_module_stat_finished(2, "task_novice") then
				if (playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) and os.time(parse_time("2020-9-19 00:00:00")) + 1209600 or playermodel.create_time + 1209600) <= time_check_manager:getCurTime() then
					var_35_10[iter_35_7.tab] = var_35_10[iter_35_7.tab] or {}
					var_35_10[iter_35_7.tab][iter_35_7.id] = nil
				end
			end
		elseif iter_35_7.id == 176 and activity_return_manager:isShowReturnBpRedDot() then
			var_35_10[iter_35_7.tab] = var_35_10[iter_35_7.tab] or {}
			var_35_10[iter_35_7.tab][iter_35_7.id] = true
		end
	end

	return var_35_10
end

function activity_base_manager:is_show_novicesummary(...)
	local novice_pass_level_data = require("data.novice_pass_level_data")
	local level_manager = require("controller.level_manager")

	if self:getAlertAllStatus(2, "task") then
		return true
	end
end
