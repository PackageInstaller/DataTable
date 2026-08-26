-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/model/MiniPartyTaskModel.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.model.MiniPartyTaskModel", package.seeall)

local MiniPartyTaskModel = class("MiniPartyTaskModel", BaseModel)

function MiniPartyTaskModel:onInit()
	self:reInit()
end

function MiniPartyTaskModel:reInit()
	return
end

function MiniPartyTaskModel:setCurTaskType(type)
	self._curTaskType = type
end

function MiniPartyTaskModel:getCurTaskType()
	self._curTaskType = self._curTaskType or MiniPartyEnum.TaskType.GroupTask

	return self._curTaskType
end

function MiniPartyTaskModel:isTaskUnlock(taskId, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceMiniParty

	local taskMo = TaskModel.instance:getTaskById(taskId)
	local couldUnlock = false

	if taskMo.config.showDay >= 0 then
		local actStartTime = ActivityModel.instance:getActStartTime(VersionActivity3_4Enum.ActivityId.LaplaceMiniParty) / 1000
		local diffDay = math.floor((ServerTime.now() - actStartTime) / TimeUtil.OneDaySecond)
		local hasOffline = false

		if not LuaUtil.isEmptyStr(taskMo.config.showOfflineTime) then
			local endTime = TimeUtil.stringToTimestamp(taskMo.config.showOfflineTime) - ServerTime.clientToServerOffset()
			local limitTime = endTime - ServerTime.now()
			local canGet = self:isTaskCanGet(taskId, actId)
			local hasFinished = self:isTaskFinished(taskId, actId)

			if not canGet and not hasFinished then
				hasOffline = limitTime <= 0
			end
		end

		if diffDay >= taskMo.config.showDay - 1 and not hasOffline then
			couldUnlock = true
		end
	end

	if not couldUnlock then
		return false
	end

	if LuaUtil.isEmptyStr(taskMo.config.prepose) then
		return true
	else
		local isPreFinished = self:isTaskFinished(tonumber(taskMo.config.prepose), actId)

		if isPreFinished then
			return self:isTaskUnlock(tonumber(taskMo.config.prepose))
		else
			return false
		end
	end

	return false
end

function MiniPartyTaskModel:getAllUnlockTasks(typeId, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceMiniParty

	local taskMos = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.MiniParty, VersionActivity3_4Enum.ActivityId.LaplaceMiniParty)
	local typeTasks = {}

	for _, taskMo in pairs(taskMos) do
		if taskMo.config.teamType == typeId and self:isTaskUnlock(taskMo.id, actId) then
			table.insert(typeTasks, taskMo.id)
		end
	end

	table.sort(typeTasks, function(a, b)
		local aCanGet = self:isTaskCanGet(a)
		local bCanGet = self:isTaskCanGet(b)
		local aFinish = self:isTaskFinished(a)
		local bFinish = self:isTaskFinished(b)
		local aValue = aFinish and 3 or aCanGet and 1 or 2
		local bValue = bFinish and 3 or bCanGet and 1 or 2
		local aCo = MiniPartyConfig.instance:getTaskCo(a)
		local bCo = MiniPartyConfig.instance:getTaskCo(b)

		if aValue ~= bValue then
			return aValue < bValue
		elseif aCo.sortId ~= bCo.sortId then
			return aCo.sortId < bCo.sortId
		else
			return aCo.id < bCo.id
		end
	end)

	return typeTasks
end

function MiniPartyTaskModel:isTaskCanGet(taskId, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceMiniParty

	local taskMo = TaskModel.instance:getTaskById(taskId)

	return taskMo and taskMo.progress >= taskMo.config.maxProgress and taskMo.finishCount == 0
end

function MiniPartyTaskModel:isTaskFinished(taskId, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceMiniParty

	local taskMo = TaskModel.instance:getTaskById(taskId)

	return taskMo and taskMo.finishCount > 0
end

function MiniPartyTaskModel:getCanGetTaskCount(typeId, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceMiniParty

	local tasks = self:getAllUnlockTasks(typeId, actId)
	local count = 0

	for _, taskId in pairs(tasks) do
		if self:isTaskCanGet(taskId, actId) then
			count = count + 1
		end
	end

	return count
end

function MiniPartyTaskModel:needWaitingTaskItem(typeId, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceMiniParty

	local isAllFinished = self:isAllTaskFinihshed(typeId)

	if isAllFinished then
		return false
	end

	local tasks = self:getAllUnlockTasks(typeId, actId)

	for _, taskId in pairs(tasks) do
		if not self:isTaskFinished(taskId, actId) then
			return false
		end
	end

	return true
end

function MiniPartyTaskModel:isAllTaskFinihshed(typeId, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceMiniParty

	local taskCos = MiniPartyConfig.instance:getTaskCosByTaskType(typeId)

	for _, taskCo in pairs(taskCos) do
		if not self:isTaskFinished(taskCo.id, actId) then
			return false
		end
	end

	return true
end

function MiniPartyTaskModel:getAllUnfinishedTasks(typeId, actId)
	actId = actId or VersionActivity3_4Enum.ActivityId.LaplaceMiniParty

	local tasks = self:getAllUnlockTasks(typeId, actId)
	local taskList = {}

	for _, taskId in pairs(tasks) do
		if not self:isTaskFinished(taskId, actId) then
			table.insert(taskList, taskId)
		end
	end

	return taskList
end

function MiniPartyTaskModel:hasLucyRainUnfinished()
	local taskStr = MiniPartyConfig.instance:getConstCO(MiniPartyEnum.ConstId.LucyRainTasks).value2
	local rainTaskIds = string.splitToNumber(taskStr, "#")

	for _, taskId in pairs(rainTaskIds) do
		local taskMo = TaskModel.instance:getTaskById(taskId)

		if taskMo and self:isTaskUnlock(taskId) and not self:isTaskFinished(taskId) then
			return true
		end
	end

	return false
end

MiniPartyTaskModel.instance = MiniPartyTaskModel.New()

return MiniPartyTaskModel
