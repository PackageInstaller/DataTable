local activity_base_manager = require("controller.activitymodules.activity_base_manager")
local network = require("network.network")
local playermodel = require("model.playermodel")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local activity_proceed_data = require("data.activity_proceed_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_time_data = require("data.activity_time_data")
local task_data = require("data.task_data")
local item_data = require("data.item_data")

function activity_base_manager:getPTProceed(arg_1_1, arg_1_2)
	self:getActivityObj(arg_1_1):getActivityProceed(function(arg_2_0, arg_2_1)
		if arg_2_0 ~= 1 then
			return
		end

		local var_2_0 = {}

		for iter_2_0, iter_2_1 in pairs(arg_2_1) do
			var_2_0[iter_2_1.id] = {}
			var_2_0[iter_2_1.id].stat = iter_2_1.status
			var_2_0[iter_2_1.id].level = iter_2_1.id
			var_2_0[iter_2_1.id].limitpoint = activity_proceed_data[arg_1_1 .. "pt-" .. iter_2_1.id].num1
			var_2_0[iter_2_1.id].drop = activity_proceed_data[arg_1_1 .. "pt-" .. iter_2_1.id].drop
		end

		self.ptLevelList = var_2_0

		self:updateActivityAlert("pt_proceed", arg_1_1, self:isPTHasRewardCanGet(arg_1_1))
		arg_1_2({
			list = var_2_0,
			listLen = #var_2_0
		})
	end, "pt")
end

function activity_base_manager:getPTTaskList(arg_3_1, arg_3_2)
	self:getActivityObj(arg_3_1):getActivityTaskList(nil, function(arg_4_0, arg_4_1)
		if arg_4_0 ~= 1 then
			return
		end

		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs(arg_4_1.list) do
			iter_4_1.name = task_data[iter_4_1.taskid].name
			iter_4_1.task_des = task_data[iter_4_1.taskid].task_des
			iter_4_1.image = task_data[iter_4_1.taskid].image or "113"
			iter_4_1.drop = task_data[iter_4_1.taskid].drop
			iter_4_1.jump = task_data[iter_4_1.taskid].jump
			iter_4_1.order = task_data[iter_4_1.taskid].order

			if iter_4_1.status == 1 then
				iter_4_1.percent = -1
			end

			table.insert(var_4_0, iter_4_1)
		end

		table.sort(var_4_0, function(arg_5_0, arg_5_1)
			if arg_5_0.percent == arg_5_1.percent then
				return arg_5_0.order < arg_5_1.order
			else
				return arg_5_0.percent > arg_5_1.percent
			end
		end)

		self.ptTaskList = var_4_0

		self:updateActivityAlert("pt", arg_3_1, self:isPTHasCanCompleteTask())
		arg_3_2({
			list = var_4_0,
			listLen = #var_4_0
		})
	end, activity_conf_data[arg_3_1].isautoget and true or false, nil, "pt")
end

function activity_base_manager:getPTProceedAward(arg_6_1, arg_6_2, arg_6_3)
	self:getActivityObj(arg_6_1):getActivityProceedAward(arg_6_2, function(arg_7_0, arg_7_1)
		if arg_7_0 ~= 1 then
			global_ShowBlockWords(L_PT_PROCEED_AWARD_FAIL[arg_7_0] or L_BATTLE_PASS.FAIL)
		else
			global_gain(arg_7_1)
		end

		if arg_6_3 then
			arg_6_3(arg_7_0)
		end
	end, "pt")
end

function activity_base_manager:getPTTaskReward(arg_8_1, arg_8_2, arg_8_3)
	self:getActivityObj(arg_8_1):getTaskReward(arg_8_2, function(arg_9_0, arg_9_1)
		if arg_9_0 ~= 1 then
			global_ShowBlockWords(L_BATTLE_PASS.FAIL)
		else
			global_gain(arg_9_1)
		end

		self:updateActivityAlert("pt_proceed", arg_8_1, self:isPTHasRewardCanGet(arg_8_1))

		if arg_8_3 then
			arg_8_3(arg_9_0)
		end
	end)
end

function activity_base_manager:getPTTaskRewardOneKey(arg_10_1, arg_10_2)
	self:getActivityObj(arg_10_1):getActivityTaskList(nil, function(arg_11_0, arg_11_1)
		if arg_11_0 ~= 1 then
			arg_10_2(arg_11_0)

			return
		end

		local var_11_0 = {}

		for iter_11_0, iter_11_1 in pairs(arg_11_1.list) do
			iter_11_1.name = task_data[iter_11_1.taskid].name
			iter_11_1.task_des = task_data[iter_11_1.taskid].task_des
			iter_11_1.image = task_data[iter_11_1.taskid].image or "113"
			iter_11_1.drop = task_data[iter_11_1.taskid].drop
			iter_11_1.jump = task_data[iter_11_1.taskid].jump
			iter_11_1.order = task_data[iter_11_1.taskid].order

			if iter_11_1.status == 1 then
				iter_11_1.percent = -1
			end

			table.insert(var_11_0, iter_11_1)
		end

		self.ptTaskList = var_11_0

		global_gain(arg_11_1)
		self:updateActivityAlert("pt_proceed", arg_10_1, self:isPTHasRewardCanGet(arg_10_1))
		arg_10_2(arg_11_0)
	end, true, nil, "pt")
end

function activity_base_manager.getPTPointItemId(arg_13_0, arg_13_1)
	return activity_proceed_data[arg_13_1 .. "pt-1"].item1 or 123010001
end

function activity_base_manager:getPTProceedLevel(arg_14_1)
	local var_14_0 = item_manager:getItemNumber((self:getPTPointItemId(arg_14_1)))
	local var_14_1 = 0

	if not self.ptLevelList then
		return var_14_1
	end

	for iter_14_0, iter_14_1 in ipairs(self.ptLevelList) do
		if var_14_0 < iter_14_1.limitpoint then
			break
		end

		var_14_1 = iter_14_0
	end

	return var_14_1
end

function activity_base_manager.getPTProceedMaxLevel(arg_15_0, arg_15_1)
	local var_15_0 = 1

	while activity_proceed_data[arg_15_1 .. "pt-" .. var_15_0] do
		var_15_0 = var_15_0 + 1
	end

	return var_15_0 - 1
end

function activity_base_manager.getPTDrop(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return {}
	end

	local var_16_0 = drop_manager:getAllDrops(arg_16_1)

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		return arg_17_0.index < arg_17_1.index
	end)

	if drop_manager:getGold(arg_16_1) > 0 then
		table.insert(var_16_0, {
			dropid = "gold",
			dropNum = drop_manager:getGold(arg_16_1)
		})
	end

	if drop_manager:getDiamond(arg_16_1) > 0 then
		table.insert(var_16_0, {
			dropid = "diamond",
			dropNum = drop_manager:getDiamond(arg_16_1)
		})
	end

	return var_16_0
end

function activity_base_manager.checkBtnBuyVisible(arg_18_0, arg_18_1)
	if not activity_time_data[arg_18_1] then
		return true
	end

	local var_18_0 = time_check_manager:getCurTime()

	if activity_time_data[arg_18_1].start_time and var_18_0 < global_get_time_by_date(activity_time_data[arg_18_1].start_time) then
		return false
	end

	if activity_time_data[arg_18_1].finish_time and var_18_0 > global_get_time_by_date(activity_time_data[arg_18_1].finish_time) then
		return false
	end

	return true
end

function activity_base_manager.getActivityPTEndTime(arg_19_0, arg_19_1)
	return global_get_time_by_date(activity_conf_data[arg_19_1].finishtime) - time_check_manager:getCurTime()
end

function activity_base_manager:canPTLevelUp(arg_20_1, arg_20_2)
	local var_20_0 = self:getPTPointItemId(arg_20_1)

	return arg_20_2 + self:getPTProceedLevel(arg_20_1) <= self:getPTProceedMaxLevel(arg_20_1)
end

function activity_base_manager:getPTLevelUpCost(arg_21_1, arg_21_2)
	local var_21_0 = self:getPTPointItemId(arg_21_1)
	local var_21_1 = self:getPTProceedLevel(arg_21_1) + arg_21_2

	if not activity_proceed_data[arg_21_1 .. "pt-" .. var_21_1] then
		return 0
	end

	return math.abs((activity_proceed_data[arg_21_1 .. "pt-" .. var_21_1].num1 - item_manager:getItemNumber(activity_proceed_data[arg_21_1 .. "pt-" .. var_21_1].item1)) * (item_data[activity_proceed_data[arg_21_1 .. "pt-" .. var_21_1].item1].price_diamond or 1))
end

function activity_base_manager.buyPTProceedLevel(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	local function var_22_0(arg_23_0, arg_23_1)
		if arg_23_0 ~= 1 then
			global_ShowBlockWords(L_BUY_BATTLEPASS_LEVEL[arg_23_0])

			return
		end

		playermodel.diamond = playermodel.diamond - arg_23_1.cost_diamond

		global_update_gold_stone_diamond(nil, nil, arg_23_1.cost_diamond)

		if arg_23_1.consumes then
			for iter_23_0, iter_23_1 in ipairs(arg_23_1.consumes) do
				item_manager:deleteItem(iter_23_1.entityid, iter_23_1.num)
			end
		end

		global_gain(arg_23_1)

		if arg_22_5 then
			arg_22_5()
		end
	end

	network:rpc("activity_pt_buy_proceed", {
		activityid = arg_22_1,
		level = arg_22_2
	}, function(arg_24_0)
		var_22_0(arg_24_0.result, arg_24_0)
	end)
end

function activity_base_manager:getPTLevelupCanGetDrop(arg_25_1, arg_25_2)
	local var_25_0 = self:getPTProceedLevel(arg_25_1)

	if var_25_0 + arg_25_2 > self:getPTProceedMaxLevel(arg_25_1) then
		return {}
	end

	local var_25_1 = 1
	local var_25_2 = {}

	while var_25_1 <= arg_25_2 do
		if activity_proceed_data[arg_25_1 .. "pt-" .. var_25_0 + 1].specialDrop then
			for iter_25_0, iter_25_1 in pairs((self:getPTDrop(activity_proceed_data[arg_25_1 .. "pt-" .. var_25_0 + 1].specialDrop))) do
				iter_25_1.level = var_25_0 + var_25_1
				var_25_2[var_25_1] = var_25_2[var_25_1] or {}

				table.insert(var_25_2[var_25_1], iter_25_1)
			end
		end

		if activity_proceed_data[arg_25_1 .. "pt-" .. var_25_0 + 1].drop then
			for iter_25_2, iter_25_3 in pairs((self:getPTDrop(activity_proceed_data[arg_25_1 .. "pt-" .. var_25_0 + 1].drop))) do
				iter_25_3.level = var_25_0 + var_25_1
				var_25_2[var_25_1] = var_25_2[var_25_1] or {}

				table.insert(var_25_2[var_25_1], iter_25_3)
			end
		end

		var_25_1 = var_25_1 + 1
	end

	return var_25_2
end

function activity_base_manager:isPTHasRewardCanGet(arg_26_1)
	local var_26_0 = item_manager:getItemNumber((self:getPTPointItemId(arg_26_1)))

	for iter_26_0, iter_26_1 in ipairs(self.ptLevelList) do
		if iter_26_1.stat <= 0 and var_26_0 >= iter_26_1.limitpoint then
			return true
		end
	end

	return false
end

function activity_base_manager:isPTHasCanCompleteTask()
	if not self.ptTaskList then
		return false
	end

	return self.ptTaskList[1].status == 0 and self.ptTaskList[1].percent == 100
end
