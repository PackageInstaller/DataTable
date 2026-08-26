-- chunkname: @modules/logic/versionactivity1_5/act142/model/Activity142TaskListModel.lua

module("modules.logic.versionactivity1_5.act142.model.Activity142TaskListModel", package.seeall)

local Activity142TaskListModel = class("Activity142TaskListModel", ListScrollModel)

local function getSortIndex(objA)
	if objA.id == Activity142Enum.TASK_ALL_RECEIVE_ITEM_EMPTY_ID then
		return 1
	elseif objA:haveRewardToGet() then
		return 2
	elseif objA:alreadyGotReward() then
		return 100
	end

	return 50
end

local function sortMO(objA, objB)
	local sidxA = getSortIndex(objA)
	local sidxB = getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function Activity142TaskListModel:init(actId)
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity142)
	local list = {}
	local rewardCount = 0

	if taskDict then
		local act142TaskCfgList = Activity142Config.instance:getTaskByActId(actId)

		for _, taskCfg in ipairs(act142TaskCfgList) do
			local taskMO = taskDict[taskCfg.id]
			local act142TaskMO = Activity142TaskMO.New()

			act142TaskMO:init(taskCfg, taskMO)

			if act142TaskMO:haveRewardToGet() then
				rewardCount = rewardCount + 1
			end

			table.insert(list, act142TaskMO)
		end
	end

	if rewardCount > 1 then
		local allMO = Activity142TaskMO.New()

		allMO.id = Activity142Enum.TASK_ALL_RECEIVE_ITEM_EMPTY_ID
		allMO.activityId = actId

		table.insert(list, allMO)
	end

	table.sort(list, sortMO)
	self:setList(list)
end

Activity142TaskListModel.instance = Activity142TaskListModel.New()

return Activity142TaskListModel
