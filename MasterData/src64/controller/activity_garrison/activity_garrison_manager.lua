local ActivityGarrisonManager = class("ActivityGarrisonManager", (require("controller.base_manager")))

ActivityGarrisonManager.MULTITON_MSG = "ActivityGarrisonManager instancealready constructed!"
ActivityGarrisonManager.STATUS = {
	DOING = 2,
	DELAY = 1,
	LOCK = 0,
	COMPLETE = 3
}

function ActivityGarrisonManager:ctor()
	ActivityGarrisonManager.super.ctor(self)

	self._data = setmetatable({}, {
		__index = function(arg_2_0, arg_2_1)
			self._data[arg_2_1] = {}

			return self._data[arg_2_1]
		end
	})
	self._config = {}
	self._proConfig = {}
end

function ActivityGarrisonManager:requestInfo(arg_3_1, arg_3_2)
	require("network.network"):rpc("activity_patrol_data", {
		activityid = arg_3_1
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			self:handlerInfo(arg_4_0, arg_3_1)

			if arg_3_2 then
				arg_3_2(arg_4_0)
			end
		end
	end)
end

function ActivityGarrisonManager:requestStart(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = {}
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_3) do
		var_5_0[iter_5_1] = 1
		var_5_1[#var_5_1 + 1] = iter_5_1
	end

	local var_5_2 = self:getConfig(arg_5_1)[arg_5_2].id

	require("network.network"):rpc("activity_patrol_start", {
		activityid = arg_5_1,
		id = var_5_2,
		servantids = var_5_1
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			local var_6_0 = false

			for iter_6_0, iter_6_1 in pairs(self._data[arg_5_1]) do
				if iter_6_1.id == var_5_2 then
					self._data[arg_5_1][iter_6_0] = arg_6_0.patrol
					var_6_0 = true

					break
				end
			end

			if not var_6_0 then
				self._data[arg_5_1][#self._data[arg_5_1] + 1] = arg_6_0.patrol
			end

			sendNotification("ActivityGarrisonStart")
		elseif arg_6_0.result == 2 then
			global_ShowBlockWords("学员不存在")
		elseif arg_6_0.result == 3 then
			global_ShowBlockWords("学员不满足条件")
		elseif arg_6_0.result == 4 then
			global_ShowBlockWords("学员已驻守")
		elseif arg_6_0.result == 5 then
			global_ShowBlockWords("节点已被驻守")
		elseif arg_6_0.result == 6 then
			global_ShowBlockWords("驻守点未解锁")
		end
	end)
end

function ActivityGarrisonManager:requestFinish(arg_7_1, arg_7_2)
	require("network.network"):rpc("activity_patrol_finish", {
		activityid = arg_7_1,
		id = (arg_7_2 or nil) and self:getConfig(arg_7_1)[arg_7_2].id
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			self._data[arg_7_1] = arg_8_0.patrols

			global_gain(arg_8_0)
			sendNotification("ActivityGarrisonFinish", arg_8_0)
		elseif arg_8_0.result == 2 then
			global_ShowBlockWords("未开始驻守")
		elseif arg_8_0.result == 3 then
			global_ShowBlockWords("驻守未完成")
		end
	end)
end

function ActivityGarrisonManager:handlerInfo(arg_9_1, arg_9_2)
	if arg_9_1.result == 1 then
		self._data[arg_9_2] = arg_9_1.patrols

		if self.layer then
			self.layer:updateLayer()
		end
	end
end

function ActivityGarrisonManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function ActivityGarrisonManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function ActivityGarrisonManager:getGarrisonGirls(arg_12_1)
	local var_12_0 = self:getData(arg_12_1)
	local var_12_1 = {}
	local var_12_2 = {}

	for iter_12_0 = 1, #var_12_0 do
		if var_12_0[iter_12_0].servantids then
			for iter_12_1, iter_12_2 in pairs(var_12_0[iter_12_0].servantids) do
				var_12_1[#var_12_1 + 1] = iter_12_2
				var_12_2[iter_12_2] = 1
			end
		end
	end

	return var_12_1, var_12_2
end

function ActivityGarrisonManager:getNeedGirls(arg_13_1)
	local var_13_0 = {}
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs((self:getConfig(arg_13_1))) do
		local var_13_2 = string.split(iter_13_1.need_servants, ",")

		for iter_13_2 = 1, #var_13_2 do
			local var_13_3 = tonumber(var_13_2[iter_13_2])

			if not var_13_1[var_13_3] then
				var_13_0[#var_13_0 + 1] = var_13_3
				var_13_1[var_13_3] = 1
			end
		end
	end

	return var_13_0, var_13_1
end

function ActivityGarrisonManager:getData(arg_14_1)
	return self._data[arg_14_1] or {}
end

function ActivityGarrisonManager:getProConfig(arg_15_1)
	if not self._proConfig[arg_15_1] then
		self._proConfig[arg_15_1] = {}

		for iter_15_0, iter_15_1 in pairs((require("data.acitvity_patrol_proceed_" .. arg_15_1))) do
			self._proConfig[arg_15_1][tonumber(string.split(iter_15_1.id, "_")[2])] = iter_15_1
		end
	end

	return self._proConfig[arg_15_1]
end

function ActivityGarrisonManager:getConfig(arg_16_1)
	if not self._config[arg_16_1] then
		self._config[arg_16_1] = {}

		for iter_16_0, iter_16_1 in pairs((require("data.activity_patrol_data_" .. arg_16_1))) do
			self._config[arg_16_1][math.fmod(iter_16_1.id, arg_16_1)] = iter_16_1
		end
	end

	return self._config[arg_16_1]
end

function ActivityGarrisonManager:getGarrisonNum(arg_17_1)
	return #self:getConfig(arg_17_1)
end

function ActivityGarrisonManager:getTaskLevel(arg_18_1)
	local var_18_0 = self:getProConfig(arg_18_1)
	local var_18_1 = require("controller.item_manager"):getItemNumber(var_18_0[1].level_item)
	local var_18_2 = 0

	for iter_18_0 = 0, #var_18_0 do
		if var_18_1 >= var_18_0[iter_18_0].num1 then
			var_18_2 = iter_18_0
		else
			break
		end
	end

	return var_18_2
end

function ActivityGarrisonManager:isMaxLevel(arg_19_1)
	return self:getTaskLevel(arg_19_1) >= #self:getProConfig(arg_19_1)
end

function ActivityGarrisonManager:getTsakLevelProgress(arg_20_1)
	local var_20_0 = self:getProConfig(arg_20_1)

	return require("controller.item_manager"):getItemNumber(var_20_0[1].level_item), var_20_0[self:getTaskLevel(arg_20_1) + 1].num1
end

function ActivityGarrisonManager:isUnlockLevel(arg_21_1, arg_21_2)
	return self:getTaskLevel(arg_21_1) >= self:getConfig(arg_21_1)[arg_21_2].unlock_level
end

function ActivityGarrisonManager:isUnlockGirl(arg_22_1, arg_22_2)
	return arg_22_2 <= self:getProConfig(arg_22_1)[self:getTaskLevel(arg_22_1)].go_into_battle_num2
end

function ActivityGarrisonManager:getLevelInfo(arg_23_1)
	local time_check_manager = require("controller.time_check_manager")
	local var_23_1 = self:getConfig(arg_23_1)
	local var_23_2 = {}

	for iter_23_0 = 1, #var_23_1 do
		var_23_2[iter_23_0] = clone(var_23_1[iter_23_0])
		var_23_2[iter_23_0].getSataus = function()
			var_23_2[iter_23_0].stime = nil
			var_23_2[iter_23_0].etime = nil

			for iter_24_0, iter_24_1 in pairs((self:getData(arg_23_1))) do
				if next(iter_24_1) and math.fmod(iter_24_1.id, arg_23_1) == iter_23_0 then
					if iter_24_1.stime then
						var_23_2[iter_23_0].stime = iter_24_1.stime
						var_23_2[iter_23_0].etime = iter_24_1.stime + var_23_2[iter_23_0].patrol_time
					end

					break
				end
			end

			if var_23_2[iter_23_0].stime and var_23_2[iter_23_0].etime then
				if time_check_manager:getCurTime() > var_23_2[iter_23_0].etime then
					return ActivityGarrisonManager.STATUS.COMPLETE
				else
					return ActivityGarrisonManager.STATUS.DOING
				end
			elseif self:getTaskLevel(arg_23_1) >= var_23_2[iter_23_0].unlock_level then
				return ActivityGarrisonManager.STATUS.DELAY
			else
				return ActivityGarrisonManager.STATUS.LOCK
			end
		end
		var_23_2[iter_23_0].getReaminTime = function()
			var_23_2[iter_23_0].stime = nil
			var_23_2[iter_23_0].etime = nil

			for iter_25_0, iter_25_1 in pairs((self:getData(arg_23_1))) do
				if next(iter_25_1) and math.fmod(iter_25_1.id, arg_23_1) == iter_23_0 then
					if iter_25_1.stime then
						var_23_2[iter_23_0].stime = iter_25_1.stime
						var_23_2[iter_23_0].etime = iter_25_1.stime + var_23_2[iter_23_0].patrol_time
					end

					break
				end
			end

			if var_23_2[iter_23_0].stime and var_23_2[iter_23_0].etime then
				local var_25_0 = math.floor(var_23_2[iter_23_0].etime - time_check_manager:getCurTime())

				if var_25_0 > 0 then
					return var_25_0
				end
			end

			return 0
		end
		var_23_2[iter_23_0].getReaminTimeStr = function()
			local var_26_0 = var_23_2[iter_23_0].getReaminTime()
			local var_26_1 = math.floor(var_26_0 / 3600)
			local var_26_2 = math.floor((var_26_0 - var_26_1 * 3600) / 60)
			local var_26_3 = var_26_0 - var_26_1 * 3600 - var_26_2 * 60
			local var_26_4

			if var_26_1 < 10 then
				var_26_4 = "0" .. var_26_1 or var_26_1

				local var_26_5

				if var_26_2 < 10 then
					var_26_5 = "0" .. var_26_2 or var_26_2

					local var_26_6

					if var_26_3 < 10 then
						var_26_6 = "0" .. var_26_3 or var_26_3
					end
				end
			end

			return var_26_4 .. ":" .. var_26_5 .. ":" .. var_26_6
		end
	end

	return var_23_2
end

return ActivityGarrisonManager
