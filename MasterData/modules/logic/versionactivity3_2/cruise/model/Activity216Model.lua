-- chunkname: @modules/logic/versionactivity3_2/cruise/model/Activity216Model.lua

module("modules.logic.versionactivity3_2.cruise.model.Activity216Model", package.seeall)

local Activity216Model = class("Activity216Model", BaseModel)

function Activity216Model:onInit()
	self:reInit()
end

function Activity216Model:reInit()
	self._actInfos = {}
end

function Activity216Model:setAct216Info(info)
	self._actInfos[info.activityId] = self._actInfos[info.activityId] or Activity216InfoMO.New()

	self._actInfos[info.activityId]:init(info)
end

function Activity216Model:updateGetBonusState(get, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	if not self._actInfos[actId] then
		return
	end

	self._actInfos[actId]:updateGetBonusState(get)
end

function Activity216Model:updateUseItemState(use, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	if not self._actInfos[actId] then
		return
	end

	self._actInfos[actId]:updateUseItemState(use)
end

function Activity216Model:updateTaskList(taskInfos, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	if not self._actInfos[actId] then
		return
	end

	self._actInfos[actId]:updateTaskList(taskInfos)
end

function Activity216Model:getAllUnlockTasks(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	if not self._actInfos[actId] then
		return {}
	end

	return self._actInfos[actId].taskInfos
end

function Activity216Model:getTaskInfo(taskId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	if not self._actInfos[actId] then
		return
	end

	return self._actInfos[actId]:getTaskInfo(taskId)
end

function Activity216Model:getAllShowTasks(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	local taskInfos = self:getAllUnlockTasks(actId)
	local taskList = {}

	for _, taskInfo in pairs(taskInfos) do
		local isFinished = self:isTaskFinished(taskInfo.taskId, actId)

		if isFinished then
			self:_addTaskId(taskList, taskInfo.taskId)
		else
			local taskCo = Activity216Config.instance:getTaskCO(taskInfo.taskId)

			if LuaUtil.isEmptyStr(taskCo.prepose) then
				self:_addTaskId(taskList, taskInfo.taskId)
			else
				local isPreFinished = self:isTaskFinished(tonumber(taskCo.prepose), actId)

				if isPreFinished then
					self:_addTaskId(taskList, taskInfo.taskId)
				end
			end
		end
	end

	table.sort(taskList, function(a, b)
		local aCanGet = self:isTaskCanGet(a)
		local bCanGet = self:isTaskCanGet(b)
		local aFinish = self:isTaskFinished(a)
		local bFinish = self:isTaskFinished(b)
		local aValue = aFinish and 3 or aCanGet and 1 or 2
		local bValue = bFinish and 3 or bCanGet and 1 or 2
		local aCo = Activity216Config.instance:getTaskCO(a)
		local bCo = Activity216Config.instance:getTaskCO(b)

		if aValue ~= bValue then
			return aValue < bValue
		elseif aCo.sortId ~= bCo.sortId then
			return aCo.sortId < bCo.sortId
		else
			return aCo.id < bCo.id
		end
	end)

	return taskList
end

function Activity216Model:getAllFinishedTaskCount(actId)
	local taskList = self:getAllShowTasks(actId)
	local count = 0

	for _, taskId in pairs(taskList) do
		local finished = self:isTaskFinished(taskId, actId)

		if finished then
			count = count + 1
		end
	end

	return count
end

function Activity216Model:_addTaskId(taskList, taskId)
	if LuaUtil.tableContains(taskList, taskId) then
		return
	end

	local isOnlyOneTask, taskIds = self:getOnlyOneTask(taskId)

	if not isOnlyOneTask then
		table.insert(taskList, taskId)

		return
	end

	if #taskIds > 0 then
		for _, id in pairs(taskIds) do
			if LuaUtil.tableContains(taskList, id) then
				tabletool.removeValue(taskList, id)
			end
		end

		local taskIdList = self:getOnlyOneTaskList(taskId)

		table.insert(taskList, taskIdList[1])
	end
end

function Activity216Model:isSingleTaskFinished(taskId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	if not self._actInfos[actId] then
		return false
	end

	return self._actInfos[actId]:isTaskFinished(taskId)
end

function Activity216Model:isSingleTaskCanGet(taskId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	if not self._actInfos[actId] then
		return false
	end

	return self._actInfos[actId]:isTaskCanGet(taskId)
end

function Activity216Model:getOnlyOneTask(taskId)
	local taskCos = Activity216Config.instance:getOnlyOneTasksCos()

	for _, taskCo in pairs(taskCos) do
		local taskIds = string.splitToNumber(taskCo.taskIds, "#")

		for _, id in ipairs(taskIds) do
			if id == taskId then
				table.sort(taskIds, self._sortTask)

				return true, taskIds, taskCo.id
			end
		end
	end

	return false
end

function Activity216Model:getOnlyOneTaskList(taskId)
	local taskCos = Activity216Config.instance:getOnlyOneTasksCos()

	for _, taskCo in pairs(taskCos) do
		local taskIds = string.splitToNumber(taskCo.taskIds, "#")

		for _, id in ipairs(taskIds) do
			if id == taskId then
				return taskIds
			end
		end
	end

	return {}
end

function Activity216Model._sortTask(a, b)
	local aCanFinished = Activity216Model.instance:isSingleTaskFinished(a) and 0 or 1
	local bCanFinished = Activity216Model.instance:isSingleTaskFinished(b) and 0 or 1
	local aCanGet = Activity216Model.instance:isSingleTaskCanGet(a) and 0 or 1
	local bCanGet = Activity216Model.instance:isSingleTaskCanGet(b) and 0 or 1

	if aCanFinished ~= bCanFinished then
		return aCanFinished < bCanFinished
	elseif aCanGet ~= bCanGet then
		return aCanGet < bCanGet
	end

	return a < b
end

function Activity216Model:isTaskFinished(taskId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	if not self._actInfos[actId] then
		return false
	end

	local isOnlyOneTask, taskIds = self:getOnlyOneTask(taskId)

	if isOnlyOneTask then
		for _, id in ipairs(taskIds) do
			if self._actInfos[actId]:isTaskFinished(id) then
				return true
			end
		end

		return false
	else
		return self._actInfos[actId]:isTaskFinished(taskId)
	end
end

function Activity216Model:isTaskCanGet(taskId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	if not self._actInfos[actId] then
		return false
	end

	if self:isTaskFinished(taskId, actId) then
		return false
	end

	local isOnlyOneTask, taskIds = self:getOnlyOneTask(taskId)

	if isOnlyOneTask then
		for _, id in ipairs(taskIds) do
			if self._actInfos[actId]:isTaskCanGet(id) then
				return true
			end
		end

		return false
	else
		return self._actInfos[actId]:isTaskCanGet(taskId)
	end
end

function Activity216Model:isOnceBonusGet(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	if not self._actInfos[actId] then
		return false
	end

	return self._actInfos[actId].getOnceBonus
end

function Activity216Model:isTalentItemHasUse(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	if not self._actInfos[actId] then
		return false
	end

	return self._actInfos[actId].hasUseTalentItem
end

function Activity216Model:getMileStoneBonusState(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	local needCount = Activity216Config.instance:getOnceBonusCO(actId).needFinishTaskNum
	local finishedCount = self:getAllFinishedTaskCount(actId)
	local bonusGet = self:isOnceBonusGet(actId)

	if bonusGet then
		return Activity216Enum.MileStoneBonusState.Finished
	elseif needCount <= finishedCount then
		return Activity216Enum.MileStoneBonusState.CanGet
	else
		return Activity216Enum.MileStoneBonusState.Normal
	end
end

function Activity216Model:isActHasRewardCouldGet(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	local taskIds = self:getAllShowTasks(actId)

	for _, taskId in ipairs(taskIds) do
		if self:isTaskCanGet(taskId, actId) then
			return true
		end
	end

	local onceBonusState = self:getMileStoneBonusState(actId)

	if onceBonusState == Activity216Enum.MileStoneBonusState.CanGet then
		return true
	end

	return false
end

Activity216Model.instance = Activity216Model.New()

return Activity216Model
