-- chunkname: @modules/logic/versionactivity2_5/challenge/model/Act183Model.lua

module("modules.logic.versionactivity2_5.challenge.model.Act183Model", package.seeall)

local Act183Model = class("Act183Model", BaseModel)

function Act183Model:reInit()
	self._activityId = nil
	self._actInfo = nil
	self._readyUseBadgeNum = nil
	self._selectConditions = nil
	self._recordRepressEpisodeId = nil

	self:clearBattleFinishedInfo()

	self._unfinishTaskMap = nil
	self._initDone = false
end

function Act183Model:init(activityId, actInfo)
	self._activityId = activityId
	self._actInfo = Act183InfoMO.New()

	self._actInfo:init(actInfo)

	self._initDone = true
end

function Act183Model:isInitDone()
	return self._initDone
end

function Act183Model:getActInfo()
	return self._actInfo
end

function Act183Model:getGroupEpisodeMo(groupId)
	if self._actInfo then
		local groupMo = self._actInfo:getGroupEpisodeMo(groupId)

		return self._actInfo
	end
end

function Act183Model:getEpisodeMo(groupId, episodeId)
	local groupMo = self:getGroupEpisodeMo(groupId)

	if groupMo then
		return groupMo:getEpisodeMo(episodeId)
	end
end

function Act183Model:getEpisodeMoById(episodeId)
	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)

	if episodeCo then
		return self:getEpisodeMo(episodeCo.groupId, episodeId)
	end
end

function Act183Model:setActivityId(activityId)
	if activityId then
		self._activityId = activityId
	end
end

function Act183Model:getActivityId()
	return self._activityId
end

function Act183Model:getBadgeNum()
	if not self._actInfo then
		logError("活动数据不存在")

		return
	end

	return (self._actInfo:getBadgeNum())
end

function Act183Model:recordEpisodeReadyUseBadgeNum(badgeNum)
	self._readyUseBadgeNum = badgeNum or 0
end

function Act183Model:getEpisodeReadyUseBadgeNum()
	return self._readyUseBadgeNum or 0
end

function Act183Model:clearEpisodeReadyUseBadgeNum()
	self._readyUseBadgeNum = nil
end

function Act183Model:getUnlockSupportHeros()
	if self._actInfo then
		local unlockSupportHeros = self._actInfo:getUnlockSupportHeros()

		return self._actInfo
	end
end

function Act183Model:recordBattleFinishedInfo(info)
	self:clearBattleFinishedInfo()

	self._battleFinishedInfo = info

	if self._actInfo and self._battleFinishedInfo then
		self:recordNewFinishEpisodeId()
		self:recordNewFinishGroupId()
	end
end

function Act183Model:getBattleFinishedInfo()
	return self._battleFinishedInfo
end

function Act183Model:clearBattleFinishedInfo()
	self._battleFinishedInfo = nil
	self._newFinishEpisodeId = nil
	self._newFinishGroupId = nil
end

function Act183Model:isHeroRepressInEpisode(episodeId, heroId)
	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
	local groupId = episodeCo and episodeCo.groupId
	local groupEpisodeMo = self:getGroupEpisodeMo(groupId)

	return groupEpisodeMo and groupEpisodeMo:isHeroRepress(heroId)
end

function Act183Model:isHeroRepressInPreEpisode(episodeId, heroId)
	local episodeCo = Act183Config.instance:getEpisodeCo(episodeId)
	local groupId = episodeCo and episodeCo.groupId
	local groupEpisodeMo = self:getGroupEpisodeMo(groupId)

	return groupEpisodeMo and groupEpisodeMo:isHeroRepressInPreEpisode(episodeId, heroId)
end

function Act183Model:recordEpisodeSelectConditions(conditionStatusMap)
	self._selectConditions = {}

	for conditionId, status in pairs(conditionStatusMap) do
		if status == true then
			table.insert(self._selectConditions, conditionId)
		end
	end
end

function Act183Model:getRecordEpisodeSelectConditions()
	return self._selectConditions
end

function Act183Model:recordNewFinishEpisodeId()
	local win = self._battleFinishedInfo.win

	if win then
		local newEpisodeMo = self._battleFinishedInfo.episodeMo
		local episodeId = newEpisodeMo:getEpisodeId()
		local originEpisodeMo = self:getEpisodeMoById(episodeId)
		local originStatus = originEpisodeMo:getStatus()
		local newStatus = newEpisodeMo:getStatus()
		local isNewFinished = originStatus ~= newStatus

		if isNewFinished then
			self._newFinishEpisodeId = episodeId
		end
	end
end

function Act183Model:recordNewFinishGroupId()
	local win = self._battleFinishedInfo.win
	local groupHasFinished = self._battleFinishedInfo.groupFinished

	if win and groupHasFinished then
		local newFinishEpisodeMo = self._battleFinishedInfo.episodeMo
		local groupId = newFinishEpisodeMo:getGroupId()
		local passOrder = newFinishEpisodeMo:getPassOrder()
		local originGroupEpisode = self:getGroupEpisodeMo(groupId)
		local isOriginFinished = originGroupEpisode and originGroupEpisode:isGroupFinished()
		local episodeCount = originGroupEpisode and originGroupEpisode:getEpisodeCount() or 0

		if not isOriginFinished and episodeCount <= passOrder then
			self._newFinishGroupId = groupId
		end
	end
end

function Act183Model:getNewFinishEpisodeId()
	return self._newFinishEpisodeId
end

function Act183Model:isEpisodeNewUnlock(episodeId)
	local episodeMo = self:getEpisodeMoById(episodeId)
	local status = episodeMo and episodeMo:getStatus()

	if status ~= Act183Enum.EpisodeStatus.Unlocked then
		return
	end

	if not self._battleFinishedInfo then
		return
	end

	local preEpisodeIds = episodeMo:getPreEpisodeIds()

	if preEpisodeIds then
		local newFinishEpisodeMo = self._battleFinishedInfo.episodeMo
		local newFinishEpisodeId = newFinishEpisodeMo and newFinishEpisodeMo:getEpisodeId()

		return tabletool.indexOf(preEpisodeIds, newFinishEpisodeId) ~= nil
	end
end

function Act183Model:getNewFinishGroupId()
	return self._newFinishGroupId
end

function Act183Model:initTaskStatusMap()
	if self._initUnfinishTaskMapDone then
		return
	end

	self._unfinishTaskMap = {}

	local allTasks = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity183, self._activityId)

	if allTasks then
		for _, taskMo in ipairs(allTasks) do
			local taskCo = taskMo.config
			local groupId = taskCo and taskCo.groupId

			self._unfinishTaskMap[groupId] = self._unfinishTaskMap[groupId] or {}

			local isTaskFinished = Act183Helper.isTaskFinished(taskCo.id)

			if not isTaskFinished then
				table.insert(self._unfinishTaskMap[groupId], taskCo.id)
			end
		end
	end

	self._initUnfinishTaskMapDone = true
end

function Act183Model:getUnfinishTaskMap()
	return self._unfinishTaskMap
end

function Act183Model:recordLastRepressEpisodeId(episodeId)
	self._recordRepressEpisodeId = episodeId
end

function Act183Model:getRecordLastRepressEpisodeId()
	return self._recordRepressEpisodeId
end

function Act183Model:clearRecordLastRepressEpisodeId()
	self._recordRepressEpisodeId = nil
end

Act183Model.instance = Act183Model.New()

return Act183Model
