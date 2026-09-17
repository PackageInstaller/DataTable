local network = require("network.network")
local array_manager = require("controller.array_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local task_data = require("data.task_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_multi_pt_conf_data = require("data.activity_multi_pt_conf_data")

function ACTIVITY_OBJ_NEW:getActivityMultiPtTask()
	self:getActivityTaskList(nil, function(arg_2_0, arg_2_1)
		if arg_2_0 ~= 1 then
			return
		end

		self.multiPtTaskList = {}

		for iter_2_0, iter_2_1 in pairs(arg_2_1.list) do
			iter_2_1.name = task_data[iter_2_1.taskid].name
			iter_2_1.task_des = task_data[iter_2_1.taskid].task_des
			iter_2_1.image = task_data[iter_2_1.taskid].image
			iter_2_1.drop = task_data[iter_2_1.taskid].drop
			iter_2_1.jump = task_data[iter_2_1.taskid].jump
			iter_2_1.order = task_data[iter_2_1.taskid].order

			if iter_2_1.status == 1 then
				iter_2_1.percent = -1
			end

			table.insert(self.multiPtTaskList, iter_2_1)
		end

		table.sort(self.multiPtTaskList, function(arg_3_0, arg_3_1)
			if arg_3_0.percent == arg_3_1.percent then
				return arg_3_0.order < arg_3_1.order
			else
				return arg_3_0.percent > arg_3_1.percent
			end
		end)
		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, {
			list = self.multiPtTaskList,
			listLen = #self.multiPtTaskList
		})
		activity_manager:updateActivityAlert("multi_pt", self._id, self:isHasCanCompleteMultiPtTask())
	end, false, nil, "multi_pt")
end

function ACTIVITY_OBJ_NEW:getActivityMultiPtTaskData()
	return self.multiPtTaskList
end

function ACTIVITY_OBJ_NEW:isHasCanCompleteMultiPtTask()
	if not self.multiPtTaskList then
		return false
	end

	return self.multiPtTaskList[1].status == 0 and self.multiPtTaskList[1].percent >= 100
end

function ACTIVITY_OBJ_NEW:getMultiPtTaskReward(arg_6_1)
	self:getTaskReward(arg_6_1, function(arg_7_0, arg_7_1)
		if arg_7_0 ~= 1 then
			global_ShowBlockWords(L_BATTLE_PASS.FAIL)

			return
		end

		global_gain(arg_7_1)
		self:getActivityMultiPtTask()
		self:getBMultiPtLevelData()
	end)
end

function ACTIVITY_OBJ_NEW:getMultiPtTaskRewardOneKey()
	self:getActivityTaskList(nil, function(arg_9_0, arg_9_1)
		if arg_9_0 ~= 1 then
			return
		end

		global_gain(arg_9_1)

		self.multiPtTaskList = {}

		for iter_9_0, iter_9_1 in pairs(arg_9_1.list) do
			iter_9_1.name = task_data[iter_9_1.taskid].name
			iter_9_1.task_des = task_data[iter_9_1.taskid].task_des
			iter_9_1.image = task_data[iter_9_1.taskid].image
			iter_9_1.drop = task_data[iter_9_1.taskid].drop
			iter_9_1.jump = task_data[iter_9_1.taskid].jump
			iter_9_1.order = task_data[iter_9_1.taskid].order

			if iter_9_1.status >= 1 then
				iter_9_1.percent = -1
			end

			table.insert(self.multiPtTaskList, iter_9_1)
		end

		table.sort(self.multiPtTaskList, function(arg_10_0, arg_10_1)
			if arg_10_0.percent == arg_10_1.percent then
				return arg_10_0.order < arg_10_1.order
			else
				return arg_10_0.percent > arg_10_1.percent
			end
		end)
		self:getBMultiPtLevelData()
		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_TASK_LIST_UPDATE, {
			list = self.multiPtTaskList,
			listLen = #self.taskList
		})
		activity_manager:updateActivityAlert("multi_pt", self._id, self:isHasCanCompleteMultiPtTask())
	end, true, nil, "multi_pt")
end

function ACTIVITY_OBJ_NEW:getMultiPTLayerName()
	return activity_multi_pt_conf_data[self._id].layerName
end

function ACTIVITY_OBJ_NEW:getMultiPTnum()
	return item_manager:getItemNumber(activity_multi_pt_conf_data[self._id].cost_item or 6800601)
end

function ACTIVITY_OBJ_NEW:getBMultiPtLevelData()
	network:rpc("get_activity_multi_pt_info", {
		activityid = self._id
	}, function(arg_14_0)
		if arg_14_0.result ~= 1 then
			return
		end

		self.multiPtStat = arg_14_0.list

		activity_manager:fireEvent(activity_manager.activityEventId.BATTLE_PASS_LIST_UPDATE, {
			list = self.multiPtStat,
			listLen = #self.multiPtStat
		})
		activity_manager:updateActivityAlert("multi_proceed", self._id, self:isMuiltPtHasRewardCanGet())
	end)
end

function ACTIVITY_OBJ_NEW:isMuiltPtHasRewardCanGet()
	if not self.multiPtStat then
		return
	end

	local var_15_0 = 1

	local function var_15_1(arg_16_0)
		for iter_16_0, iter_16_1 in pairs(arg_16_0) do
			if iter_16_1.stat == 4 then
				return true
			end
		end

		return false
	end

	for iter_15_0, iter_15_1 in pairs(self.multiPtStat) do
		if not var_15_1(iter_15_1.data) then
			var_15_0 = iter_15_0

			break
		end
	end

	if not self.multiPtStat[var_15_0] then
		return false
	end

	for iter_15_2, iter_15_3 in ipairs(self.multiPtStat[var_15_0].data) do
		if iter_15_3.stat == 3 then
			return true
		end
	end

	return false
end

function ACTIVITY_OBJ_NEW:get_multi_pt_reward(arg_17_1, arg_17_2)
	network:rpc("get_multi_pt_reward", {
		activityid = self._id,
		order = arg_17_1,
		index = arg_17_2
	}, function(arg_18_0)
		if arg_18_0.result ~= 1 then
			return
		end

		global_gain(arg_18_0)

		if arg_18_0.costitem then
			for iter_18_0, iter_18_1 in pairs(arg_18_0.costitem) do
				item_manager:deleteItem(iter_18_1.itemid, iter_18_1.num)
			end
		end

		self:getBMultiPtLevelData()
	end)
end
