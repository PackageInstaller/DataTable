-- chunkname: @modules/logic/versionactivity1_3/chess/model/Activity122TaskListModel.lua

module("modules.logic.versionactivity1_3.chess.model.Activity122TaskListModel", package.seeall)

local Activity122TaskListModel = class("Activity122TaskListModel", ListScrollModel)
local TaskMOAllFinishId = -100

function Activity122TaskListModel:init(actId)
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity122)
	local data = {}
	local rewardCount = 0

	if taskDict ~= nil then
		local taskCfgList = Activity122Config.instance:getTaskByActId(actId)

		for _, taskCfg in ipairs(taskCfgList) do
			local mo = Activity122TaskMO.New()
			local taskMO = taskDict[taskCfg.id]

			mo:init(taskCfg, taskMO)

			if mo:haveRewardToGet() then
				rewardCount = rewardCount + 1
			end

			table.insert(data, mo)
		end
	end

	if rewardCount > 1 then
		local allMO = Activity122TaskMO.New()

		allMO.id = TaskMOAllFinishId
		allMO.activityId = actId

		table.insert(data, allMO)
	end

	table.sort(data, Activity122TaskListModel.sortMO)
	self:setList(data)
end

function Activity122TaskListModel.sortMO(objA, objB)
	local sidxA = Activity122TaskListModel.getSortIndex(objA)
	local sidxB = Activity122TaskListModel.getSortIndex(objB)

	if sidxA ~= sidxB then
		return sidxA < sidxB
	elseif objA.id ~= objB.id then
		return objA.id < objB.id
	end
end

function Activity122TaskListModel.getSortIndex(objA)
	if objA.id == TaskMOAllFinishId then
		return 1
	elseif objA:haveRewardToGet() then
		return 2
	elseif objA:alreadyGotReward() then
		return 100
	end

	return 50
end

function Activity122TaskListModel:createMO(co, taskMO)
	local mo = {}

	mo.config = taskMO.config
	mo.originTaskMO = taskMO

	return mo
end

Activity122TaskListModel.instance = Activity122TaskListModel.New()

return Activity122TaskListModel
