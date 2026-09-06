-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/EventTaskMgr.lua

module("logic.extensions.eventtasksummary.view.tab.EventTaskMgr", package.seeall)

local EventTaskMgr = class("EventTaskMgr")

function EventTaskMgr:ctor()
	return
end

function EventTaskMgr:onEnter(activityId)
	self._activityId = activityId
	self._activityType = EventTaskSummaryConfig.instance:getActivityType(self._activityId)
	self._playerTypeTag = ""
	self._taskInfoPool = {}

	self:onResetCfg()
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._handleGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._handleGainTaskPrizeRes, self)
end

function EventTaskMgr:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._handleGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._handleGainTaskPrizeRes, self)
	self:onClearCfg()
	table.clear(self._taskInfoPool)

	self._taskInfoPool = nil
	self._activityId = nil
	self._activityType = nil
	self._playerTypeTag = nil
end

function EventTaskMgr:onDestroy()
	return
end

function EventTaskMgr:_handleGetInfoRes(msg)
	if msg.activityId ~= self._activityId then
		return
	end

	local pool = {}

	for _, info in ipairs(msg.taskInfos) do
		pool[info.taskId] = info
	end

	self._taskInfoPool = pool

	if msg:HasField("playerTypeTag") then
		self._playerTypeTag = msg.playerTypeTag or ""
	end

	self:onResetCfg()
	GlobalDispatcher:dispatch(GlobalNotify.PM_EventTaskTabUpdate)
end

function EventTaskMgr:_handleGainTaskPrizeRes(msg)
	if msg.activityId ~= self._activityId then
		return
	end

	for _, taskId in ipairs(msg.taskId or {}) do
		if self._taskInfoPool[taskId] then
			self._taskInfoPool[taskId].hasGainPrize = true
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_EventTaskTabUpdate)
end

function EventTaskMgr:_getTaskInfo(taskId)
	return self._taskInfoPool[taskId]
end

function EventTaskMgr:getActivityId()
	return self._activityId
end

function EventTaskMgr:getActivityType()
	return self._activityType
end

function EventTaskMgr:getPlayerTypeTag()
	return self._playerTypeTag or ""
end

function EventTaskMgr:isInActTime()
	return ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)
end

function EventTaskMgr:onResetCfg()
	local taskCfgs = EventTaskSummaryConfig.instance:getVisibleTaskCfgs(self._activityId, self:getPlayerTypeTag())
	local idLib = {}

	for taskId, taskData in ipairs(taskCfgs) do
		local inTime = GameUtil.getTimePeriod(taskData.completionStartTime, taskData.completionEndTime) == GameUtil.inTimePeriod and GameUtil.getTimePeriod(taskData.startTime, taskData.endTime) == GameUtil.inTimePeriod

		if inTime then
			if idLib[taskData.pageId] == nil then
				idLib[taskData.pageId] = {}
			end

			if idLib[taskData.pageId][taskData.typeId] == nil then
				idLib[taskData.pageId][taskData.typeId] = {}
			end

			table.insert(idLib[taskData.pageId][taskData.typeId], taskData.taskId)
		end
	end

	self._idLib = idLib
end

function EventTaskMgr:onClearCfg()
	self._idLib = nil
end

function EventTaskMgr:getPageIdList()
	local pageIdList = table.keys(self._idLib or {})

	table.sort(pageIdList, function(a, b)
		return a < b
	end)

	return pageIdList
end

function EventTaskMgr:getTypeIdList(pageId)
	local typeIdList = table.keys(self._idLib[pageId] or {})

	table.sort(typeIdList, function(a, b)
		return a < b
	end)

	return typeIdList
end

function EventTaskMgr:getTaskIdList(pageId, typeId)
	if not self._idLib[pageId] then
		return self._idLib[pageId][typeId] or {}
	end
end

function EventTaskMgr:getTryLightRedOfPage(pageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActTime() then
		result = GameEnum.ResultCode.NotInActTime
		tips = "不在活动时间范围内"
	elseif not self:isCanGainOfPage(pageId) then
		result = GameEnum.ResultCode.NotPrizeCanGet
		tips = ""
	end

	return result, tips
end

function EventTaskMgr:isCanGainOfPage(pageId)
	local isCanGain = false
	local typeIdList = self:getTypeIdList(pageId)

	for _, typeId in ipairs(typeIdList) do
		local result, tips = self:getTryLightRedOfType(pageId, typeId)

		if result == GameEnum.ResultCode.Success then
			isCanGain = true

			break
		end
	end

	return isCanGain
end

function EventTaskMgr:getIsRedOfGroup(groupId)
	local allTaskCfgList = EventTaskSummaryConfig.instance:getVisibleTaskCfgs(self._activityId, self:getPlayerTypeTag()) or {}

	for k, cfg in pairs(allTaskCfgList) do
		if cfg.groupId == groupId then
			local result = self:isCanGainOfType(cfg.pageId, cfg.typeId)

			if result then
				return true
			end
		end
	end

	return false
end

function EventTaskMgr:getIsRedOfPageAndGroup(pageId, groupId)
	local allTaskCfgList = EventTaskSummaryConfig.instance:getVisibleTaskCfgs(self._activityId, self:getPlayerTypeTag()) or {}

	for k, cfg in pairs(allTaskCfgList) do
		if cfg.groupId == groupId and cfg.pageId == pageId then
			local result = self:isCanGainOfType(cfg.pageId, cfg.typeId)

			if result then
				return true
			end
		end
	end

	return false
end

function EventTaskMgr:getTryLightRedOfType(pageId, typeId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActTime() then
		result = GameEnum.ResultCode.NotInActTime
		tips = "不在活动时间范围内"
	elseif not self:isCanGainOfType(pageId, typeId) then
		result = GameEnum.ResultCode.NotPrizeCanGet
		tips = ""
	end

	return result, tips
end

function EventTaskMgr:isCanGainOfType(pageId, typeId)
	local isCanGain = false
	local taskIdList = self:getTaskIdList(pageId, typeId)

	for _, taskId in ipairs(taskIdList) do
		local result, tips = self:getTryGainPrizeResultAndTips(taskId)

		if result == GameEnum.ResultCode.Success then
			isCanGain = true

			break
		end
	end

	return isCanGain
end

function EventTaskMgr:getTryGainPrizeResultAndTips(taskId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActTime() then
		result = GameEnum.ResultCode.NotInActTime
		tips = "不在活动时间范围内"
	elseif self:isHasGainPrizeOfTask(taskId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = "已领取"
	elseif not self:isEnoughProgressOfTask(taskId) then
		result = GameEnum.ResultCode.NotEnoughProgress
		tips = "未满足要求"
	end

	return result, tips
end

function EventTaskMgr:_getTaskState(taskId)
	local isHasGain = self:isHasGainPrizeOfTask(taskId)

	if isHasGain then
		return GameEnum.PrizeState.IsHasGain
	end

	local isEnough = self:isEnoughProgressOfTask(taskId)

	if not isEnough then
		return GameEnum.PrizeState.IsNotEnough
	end

	return GameEnum.PrizeState.IsCanGet
end

function EventTaskMgr:getCurProgressOfTask(taskId)
	local taskInfo = self:_getTaskInfo(taskId)

	return (taskInfo or nil) and taskInfo.curProgress
end

function EventTaskMgr:isCanGainOfTask(taskId)
	return self:_getTaskState(taskId) == GameEnum.PrizeState.IsCanGet
end

function EventTaskMgr:getCanGainTaskIdList(taskIdList)
	local canGainTaskIdList = {}

	for _, taskId in ipairs(taskIdList or {}) do
		if self:isCanGainOfTask(taskId) then
			table.insert(canGainTaskIdList, taskId)
		end
	end

	return canGainTaskIdList
end

function EventTaskMgr:getCanGainTaskIdListByPage(pageId)
	local taskIdList = {}
	local typeIdList = self:getTypeIdList(pageId)

	for _, typeId in ipairs(typeIdList) do
		for _, taskId in ipairs(self:getTaskIdList(pageId, typeId) or {}) do
			if self:isCanGainOfTask(taskId) then
				table.insert(taskIdList, taskId)
			end
		end
	end

	return taskIdList
end

function EventTaskMgr:isHasGainPrizeOfTask(taskId)
	local taskInfo = self:_getTaskInfo(taskId)

	return (taskInfo or nil) and checkbool(taskInfo.hasGainPrize)
end

function EventTaskMgr:isEnoughProgressOfTask(taskId)
	local taskData = EventTaskSummaryConfig.instance:getTaskData(self._activityId, taskId)
	local maxProgress = taskData.maxProgress
	local curProgress = self:getCurProgressOfTask(taskId)

	return maxProgress <= curProgress
end

return EventTaskMgr
