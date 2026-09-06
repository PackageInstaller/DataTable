-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/model/EventTaskSummaryModel.lua

module("logic.extensions.eventtasksummary.model.EventTaskSummaryModel", package.seeall)

local EventTaskSummaryModel = class("EventTaskSummaryModel", BaseModel)

function EventTaskSummaryModel:ctor()
	return
end

function EventTaskSummaryModel:onInit()
	self:onReset()
end

function EventTaskSummaryModel:onReset()
	self._activityId = 0
	self._playerTypeTag = ""
	self._taskInfo = {}
	self._taskInfoMap = {}
end

function EventTaskSummaryModel:onHandleEventTaskSummaryGetInfoRes(msg)
	self._taskInfo = msg.taskInfos
	self._activityId = msg.activityId

	if msg:HasField("playerTypeTag") then
		self._playerTypeTag = msg.playerTypeTag or ""
	end

	self:_updateTaskInfoData(msg.taskInfos)
end

function EventTaskSummaryModel:_updateTaskInfoData(taskInfos)
	self:_updateTaskInfoMap(taskInfos)
	self:_updateTaskInfoList(taskInfos)
end

function EventTaskSummaryModel:_updateTaskInfoMap(taskInfos)
	self._taskInfoMap = {}

	for _, info in ipairs(taskInfos) do
		self._taskInfoMap[info.taskId] = info
	end
end

function EventTaskSummaryModel:_updateTaskInfoList(taskInfos)
	self._taskInfoList = {}

	for _, info in ipairs(taskInfos) do
		table.insert(self._taskInfoList, info)
	end

	ArraySort.sortOn(self._taskInfoList, "taskId")
end

function EventTaskSummaryModel:getCurActivityId()
	return self._activityId
end

function EventTaskSummaryModel:getPlayerTypeTag(activityId)
	if activityId ~= nil and checknumber(self._activityId) ~= checknumber(activityId) then
		return ""
	end

	return self._playerTypeTag or ""
end

function EventTaskSummaryModel:getTaskInfoList()
	return self._taskInfoList
end

function EventTaskSummaryModel:getTaskInfo(taskId)
	return self._taskInfoMap[taskId]
end

function EventTaskSummaryModel:getTaskCurProgress(taskId)
	local taskInfo = self:getTaskInfo(taskId)

	return (taskInfo or nil) and (taskInfo.curProgress or 0)
end

function EventTaskSummaryModel:isTaskHasGainPrize(taskId)
	local taskInfo = self:getTaskInfo(taskId)

	return (taskInfo or nil) and (taskInfo.hasGainPrize or false)
end

function EventTaskSummaryModel:getTotalProgress(activityId, cfgStr)
	local totalProgress = 0

	for _, info in ipairs(self._taskInfoMap) do
		local isGainPrize = self:isTaskHasGainPrize(info.taskId)

		if isGainPrize then
			local itemId = CompetitionKingConfig.instance:getActCfgById(activityId).activityItemId
			local taskPlanId = EventTaskSummaryConfig.instance:getPlanCfg(activityId).taskPlanId
			local taskItemCfg = EventTaskSummaryConfig.instance:getTaskDataById(taskPlanId, info.taskId).prize
			local prizeArr = string.split(taskItemCfg, "#")

			for _, v in ipairs(prizeArr) do
				local matType, matId, matNum = MaterialMgr.getMatParams(v)

				if matId == itemId then
					totalProgress = totalProgress + matNum
				end
			end
		end
	end

	return totalProgress
end

function EventTaskSummaryModel:getTaskInfoMapByActid(activityId)
	if checknumber(self._activityId) ~= checknumber(activityId) then
		return {}
	end

	return self._taskInfoMap or {}
end

EventTaskSummaryModel.instance = EventTaskSummaryModel.New()

return EventTaskSummaryModel
