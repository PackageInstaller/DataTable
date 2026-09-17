local DailyWeeklyManager = class("DailyWeeklyManager", (require("controller.base_manager")))

DailyWeeklyManager.MULTITON_MSG = "DailyWeeklyManager instancealready constructed!"
DailyWeeklyManager.BoxNum = 3

local var_0_1 = 263
local var_0_2 = 3

function DailyWeeklyManager:ctor()
	DailyWeeklyManager.super.ctor(self)

	self._data = {
		refreshNum = 0,
		boxInfo = 0,
		activeNum = 0,
		weeklyNum = 0,
		dailyNum = 0,
		list = {}
	}
	self._config = require("data/activity_dailytask_conf_data")
end

function DailyWeeklyManager:requestInfo(arg_2_1)
	require("network.network"):rpc("get_activity_dailytask_info", {
		activityid = var_0_1
	}, function(arg_3_0)
		if arg_3_0.result == 1 then
			self:handlerInfo(arg_3_0)

			if arg_2_1 then
				arg_2_1(arg_3_0)
			end
		end
	end)
end

function DailyWeeklyManager:requestRefreshInfo(arg_4_1)
	require("network.network"):rpc("get_activity_dailytask_info", {
		activityid = var_0_1
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			local var_5_0 = clone(arg_5_0)

			var_5_0.result = nil

			UpdataTableData(self._data, var_5_0)

			if arg_4_1 then
				arg_4_1(arg_5_0)
			end
		end
	end)
end

function DailyWeeklyManager:requestRefresh(arg_6_1, arg_6_2)
	print("index", arg_6_1)

	local var_6_0 = self:getRefreshRemainTime()

	if var_6_0 < 0 then
		global_ShowBlockWords("剩余刷新次数不足")

		return
	end

	local network = require("network.network")

	LayerManager:pushInLayer("PopDoLayer", {
		remaintimes = 1,
		totaltimes = 3,
		own = require("model.playermodel").diamond,
		surecallback = function()
			if var_6_0 > 0 then
				network:rpc("refresh_activity_dailytask", {
					activityid = var_0_1,
					taskid = self._data.list[arg_6_1].taskid
				}, function(arg_8_0)
					if arg_8_0.result == 1 then
						self._data.list[arg_6_1] = arg_8_0.newTask
						self._data.refreshNum = arg_8_0.refreshNum

						if arg_6_2 then
							arg_6_2(arg_8_0)
						end
					elseif arg_8_0.result == 4 then
						global_ShowBlockWords("任务不存在或已失效")
					end
				end)
			else
				global_ShowBlockWords("剩余刷新次数不足")
			end
		end,
		labels = {
			button = L_DAILY_WEEKLY_REFRESH,
			des = string.format(L_DAILY_WEEKLY_REFRESH_DES, var_6_0)
		}
	})
end

function DailyWeeklyManager:requestGetReward(arg_9_1, arg_9_2)
	require("network.network"):rpc("do_activity_dailytask", {
		activityid = var_0_1,
		taskid = self._data.list[arg_9_1].taskid
	}, function(arg_10_0)
		if arg_10_0.result == 1 then
			self._data.list[arg_9_1] = arg_10_0.newTask
			self._data.activeNum = self._data.activeNum + arg_10_0.activeNum

			if arg_9_2 then
				arg_9_2(arg_10_0)
			end
		end
	end)
end

function DailyWeeklyManager:requestGetRewardByTaskId(arg_11_1, arg_11_2)
	local var_11_0

	for iter_11_0 = 1, #self._data.list do
		if self._data.list[iter_11_0].taskid == arg_11_1 then
			var_11_0 = iter_11_0

			break
		end
	end

	require("network.network"):rpc("do_activity_dailytask", {
		activityid = var_0_1,
		taskid = arg_11_1
	}, function(arg_12_0)
		if arg_12_0.result == 1 then
			local var_12_0

			for iter_12_0 = 1, #self._data.list do
				if self._data.list[iter_12_0].taskid == arg_11_1 then
					var_12_0 = iter_12_0

					break
				end
			end

			self._data.list[var_12_0] = arg_12_0.newTask
			self._data.activeNum = self._data.activeNum + arg_12_0.activeNum

			if arg_11_2 then
				local var_12_1 = clone(arg_12_0)

				var_12_1.changeIndex = var_11_0

				arg_11_2(arg_12_0.result, var_12_1)
			end

			self:showPopPurchaseResultLayer(arg_12_0.activeNum)
		end
	end)
end

function DailyWeeklyManager:requestGetBoxReward(arg_13_1)
	local var_13_0, var_13_1 = self:haveBoxReward()

	if var_13_0 then
		require("network.network"):rpc("finish_activity_dailytask", {
			activityid = var_0_1
		}, function(arg_14_0)
			if arg_14_0.result == 1 then
				global_gain(arg_14_0)

				self._data.boxInfo = arg_14_0.boxInfo
				self._data.dailyNum = self._data.dailyNum + 1
				self._data.weeklyNum = self._data.weeklyNum + 1
				self._data.activeNum = 0

				if arg_13_1 then
					arg_13_1(arg_14_0)
				end
			end
		end)
	else
		global_ShowBlockWords(string.format(L_DAILY_WEEKLY_BOX_ACTIVE_NUM_TIPS, var_13_1))
	end
end

function DailyWeeklyManager:requestAlert()
	local time_check_manager = require("controller.time_check_manager")

	require("network.network"):rpc("get_activity_dailytask_info", {
		activityid = var_0_1
	}, function(arg_16_0)
		if arg_16_0.result == 1 then
			self:handlerInfo(arg_16_0)

			if time_check_manager:getCurTime() >= DailyWeeklyManager:getOpenTime() and (self:haveTaskComplete() or self:haveBoxReward()) then
				require("controller.alert_manager"):register_alert(ALERT_TOP_PLOT)
			end
		end
	end)
end

function DailyWeeklyManager:handlerInfo(arg_17_1)
	local task_data = require("data.task_data")

	self._data = arg_17_1

	table.sort(self._data.list, function(arg_18_0, arg_18_1)
		if arg_18_0.percent == arg_18_1.percent then
			local var_18_0 = task_data[arg_18_0.taskid]
			local var_18_1 = task_data[arg_18_1.taskid]

			if task_data[arg_18_0.taskid].task_type == task_data[arg_18_1.taskid].task_type then
				return var_18_0.order < var_18_1.order
			else
				return var_18_0.task_type < var_18_1.task_type
			end
		else
			return arg_18_0.percent > arg_18_1.percent
		end
	end)
end

function DailyWeeklyManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function DailyWeeklyManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function DailyWeeklyManager:getRefreshRemainTime()
	return tonumber(self._config.refreshnum.value) - self._data.refreshNum
end

function DailyWeeklyManager:getBoxsData()
	local function var_22_0(arg_24_0)
		return (tonumber(arg_24_0, 2))
	end

	local var_22_1 = (function(arg_23_0)
		local var_23_0 = {}

		for iter_23_0 = 11, 0, -1 do
			var_23_0[#var_23_0 + 1] = math.floor(arg_23_0 / 2^iter_23_0)
			arg_23_0 = arg_23_0 % 2^iter_23_0
		end

		return table.concat(var_23_0)
	end)(self._data.boxInfo)
	local var_22_2 = {}

	for iter_22_0 = 1, var_0_2 do
		var_22_2[iter_22_0] = {}
		var_22_2[iter_22_0].rarity = var_22_0((string.sub(var_22_1, 1 + (var_0_2 - iter_22_0) * 4, 1 + (var_0_2 - iter_22_0) * 4 + 3)))
		var_22_2[iter_22_0].percent = self._data.activeNum / tonumber(self._config["boxactivenum" .. var_22_2[iter_22_0].rarity].value) * 100

		if var_22_2[iter_22_0].percent < 0 then
			var_22_2[iter_22_0].percent = 0
		elseif var_22_2[iter_22_0].percent > 100 then
			var_22_2[iter_22_0].percent = 100
		end

		var_22_2[iter_22_0].progressStr = self._data.activeNum .. "/" .. self._config["boxactivenum" .. var_22_2[iter_22_0].rarity].value
	end

	return var_22_2
end

function DailyWeeklyManager:getFirstBoxReward()
	local var_25_0 = 0

	if self._data.dailyNum == 0 then
		var_25_0 = var_25_0 + tonumber(self._config.dailydiamond1.value)
	end

	if self._data.weeklyNum < 3 then
		var_25_0 = var_25_0 + tonumber(self._config["weeklydiamond" .. self._data.weeklyNum + 1].value)
	end

	return var_25_0
end

function DailyWeeklyManager:getBoxRewardByIndex(arg_26_1)
	local var_26_0 = 0

	if self._data.dailyNum == 0 and self._config["dailydiamond" .. arg_26_1] then
		var_26_0 = var_26_0 + tonumber(self._config["dailydiamond" .. arg_26_1].value)
	end

	if self._data.weeklyNum < DailyWeeklyManager.BoxNum and self._config["weeklydiamond" .. self._data.weeklyNum + arg_26_1] then
		var_26_0 = var_26_0 + tonumber(self._config["weeklydiamond" .. self._data.weeklyNum + arg_26_1].value)
	end

	return var_26_0
end

function DailyWeeklyManager:getTaskDataNum()
	return #self._data.list
end

function DailyWeeklyManager:getTaskData()
	return self._data.list
end

function DailyWeeklyManager:getTaskDataByIndex(arg_29_1)
	return self._data.list[arg_29_1]
end

function DailyWeeklyManager:getMaxPercentData()
	local var_30_0 = {
		percent = 0
	}

	for iter_30_0 = 1, #self._data.list do
		if self._data.list[iter_30_0].percent >= var_30_0.percent then
			var_30_0 = self._data.list[iter_30_0]
		end
	end

	return var_30_0
end

function DailyWeeklyManager:haveTaskComplete()
	for iter_31_0 = 1, #self._data.list do
		if self._data.list[iter_31_0].percent >= 100 then
			return true
		end
	end

	return false
end

function DailyWeeklyManager:haveBoxReward()
	local var_32_0 = tonumber(self._config["boxactivenum" .. self:getBoxsData()[1].rarity].value)

	return var_32_0 <= self._data.activeNum, var_32_0 - self._data.activeNum
end

function DailyWeeklyManager:getOpenTime()
	return 0
end

function DailyWeeklyManager:getCloseTime()
	return 1667750400
end

function DailyWeeklyManager:showPopPurchaseResultLayer(arg_35_1)
	local playermodel = require("model.playermodel")
	local var_35_1 = {
		itemtype = 90
	}

	var_35_1.entityid = 9000010
	var_35_1.itemid = 9000010
	var_35_1.number = arg_35_1
	playermodel.items[9000010] = var_35_1

	LayerManager:pushInLayer("PopPurchaseResultLayer", {
		items = {
			{
				entityid = 9000010
			}
		}
	})

	playermodel.items[9000010] = nil
end

return DailyWeeklyManager
