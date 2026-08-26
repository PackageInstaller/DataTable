-- chunkname: @modules/logic/versionactivity1_4/act128/model/Activity128Model.lua

module("modules.logic.versionactivity1_4.act128.model.Activity128Model", package.seeall)

local Activity128Model = class("Activity128Model", BaseModel)

function Activity128Model:onInit()
	self:reInit()
end

function Activity128Model:reInit()
	self.__config = false
	self.__stageInfos = {}
	self.__stageHasGetBonusIds = {}
	self._layer4Score = {}
	self._layer4HighestScore = {}
	self._actId = nil
end

function Activity128Model:_internal_set_config(config)
	assert(isTypeOf(config, Activity128Config), debug.traceback())

	self.__config = config
end

function Activity128Model:getConfig()
	return assert(self.__config, "pleaes call self:_internal_set_config(config) first")
end

function Activity128Model:getActivityId()
	self._actId = self._actId or self.__config:getActivityId()

	return self._actId
end

function Activity128Model:getStageInfo(stage)
	return self.__stageInfos[stage]
end

function Activity128Model:hasPassLevel(stage, layer)
	local episodeId = self.__config:getDungeonEpisodeId(stage, layer)

	return DungeonModel.instance:hasPassLevel(episodeId)
end

function Activity128Model:isBossLayerOpen(stage, layer)
	if not self:isBossOnline(stage) then
		return false
	end

	if layer <= 1 then
		return true
	end

	local preEpisodeCO = self.__config:getEpisodeCO(stage, layer - 1)

	if preEpisodeCO then
		return self:hasPassLevel(stage, layer - 1)
	end

	local episodeCO = self.__config:getDungeonEpisodeCO(stage, layer)

	if episodeCO and episodeCO.preEpisode ~= 0 then
		return DungeonModel.instance:hasPassLevel(episodeCO.preEpisode)
	end

	return true
end

function Activity128Model:hasGetBonusIds(stage, id)
	local hasGetBonusIds = self.__stageHasGetBonusIds[stage]

	if type(hasGetBonusIds) ~= "table" then
		return false
	end

	return not not hasGetBonusIds[id]
end

function Activity128Model:getTaskMoList()
	local activityId = self:getActivityId()

	return TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity128, activityId)
end

function Activity128Model:getHighestPoint(stage)
	local info = self:getStageInfo(stage)

	return (info or nil) and (info.highestPoint or 0)
end

function Activity128Model:setHighestPoint(stage, point, isClamp)
	if type(point) ~= "number" then
		return
	end

	local stageInfo = self:getStageInfo(stage)

	if not stageInfo[stage] then
		return
	end

	if isClamp then
		point = GameUtil.clamp(point, 0, self.__config:getStageCOMaxPoints(stage))
	end

	stageInfo.highestPoint = math.max(self:getHighestPoint(stage), point)
end

function Activity128Model:getTotalPoint(stage)
	local info = self:getStageInfo(stage)

	return (info or nil) and (info.totalPoint or 0)
end

function Activity128Model:setTotalPoint(stage, point)
	if type(point) ~= "number" then
		return
	end

	local stageInfo = self:getStageInfo(stage)

	if not stageInfo[stage] then
		return
	end

	stageInfo.totalPoint = math.max(self:getTotalPoint(stage), point)
end

function Activity128Model:getStageOpenServerTime(stage)
	local openDay = self.__config:getEpisodeCOOpenDay(stage) or 1
	local openTs = self:getRealStartTimeStamp()

	return openTs + (openDay - 1) * 86400
end

function Activity128Model:getActMO()
	local activityId = self:getActivityId()

	return ActivityModel.instance:getActMO(activityId)
end

function Activity128Model:isActOnLine()
	local activityId = self:getActivityId()

	return ActivityHelper.getActivityStatus(activityId, true) == ActivityEnum.ActivityStatus.Normal
end

function Activity128Model:getRealStartTimeStamp()
	local actMo = self:getActMO()

	return actMo and actMo:getRealStartTimeStamp() or 0
end

function Activity128Model:getRealEndTimeStamp()
	local actMo = self:getActMO()

	return (actMo or nil) and (self:getActMO():getRealEndTimeStamp() or 0)
end

function Activity128Model:getRemainTimeStr()
	local activityId = self:getActivityId()
	local second = ActivityModel.instance:getRemainTimeSec(activityId)

	if not self.__config then
		return
	end

	return self.__config:getRemainTimeStrWithFmt(second)
end

function Activity128Model:isBossOnline(stage)
	return ServerTime.now() >= self:getStageOpenServerTime(stage)
end

function Activity128Model:isBossOpen(stage)
	local stageLayerInfos = BossRushModel.instance:getStageLayersInfo(stage)

	for _, info in pairs(stageLayerInfos) do
		if info.isOpen then
			return true
		end
	end

	return false
end

function Activity128Model:getBossUnlockEpisode(stage)
	local episodeId = self:_getUnlockEpisodeId(stage)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterCo = DungeonConfig.instance:getChapterCO(episodeCo and episodeCo.chapterId)
	local actCo = ActivityConfig.instance:getActivityCo(chapterCo and chapterCo.actId)
	local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(episodeId)

	return actCo and actCo.name, episodeDisplay
end

function Activity128Model:_getUnlockEpisodeId(stage)
	local stageLayerInfos = BossRushModel.instance:getStageLayersInfo(stage)

	for _, info in pairs(stageLayerInfos) do
		local episodeCO = BossRushConfig.instance:getDungeonEpisodeCO(stage, info.layer)

		if episodeCO and episodeCO.preEpisode ~= 0 then
			return episodeCO.preEpisode
		end
	end
end

function Activity128Model:_updateHasGetBonusIds(stage, pbHasGetBonusIds)
	self.__stageHasGetBonusIds[stage] = {}

	local tmp = self.__stageHasGetBonusIds[stage]

	for _, v in ipairs(pbHasGetBonusIds) do
		tmp[v] = true
	end
end

function Activity128Model:_updateSingleHasGetBonusIds(stage, id)
	self.__stageHasGetBonusIds[stage] = self.__stageHasGetBonusIds[stage] or {}
	self.__stageHasGetBonusIds[stage][id] = true
end

function Activity128Model:_updateAll(msg)
	self._activityId = msg.activityId

	for _, v in ipairs(msg.bossDetail) do
		local stage = v.bossId

		self.__stageInfos[stage] = v

		self:_updateHasGetBonusIds(stage, v.hasGetBonusIds)
		self:_setLayer4Score(v.bossId, (v or nil) and (v.layer4TotalPoint or 0))
		self:_setLayer4HightScore(v.bossId, (v or nil) and (v.layer4HighestPoint or 0))
	end
end

function Activity128Model:onReceiveGet128InfosReply(msg)
	self:_updateAll(msg)
	self:_onReceiveGet128InfosReply(msg)
end

function Activity128Model:_setLayer4Score(stage, value)
	self._layer4Score[stage] = tonumber(value)
end

function Activity128Model:getLayer4CurScore(stage)
	return self._layer4Score[stage] or 0
end

function Activity128Model:_setLayer4HightScore(stage, value)
	self._layer4HighestScore[stage] = tonumber(value)
end

function Activity128Model:getLayer4HightScore(stage)
	return self._layer4HighestScore[stage] or 0
end

function Activity128Model:onReceiveAct128GetTotalRewardsReply(msg)
	local stage = msg.bossId
	local hasGetBonusIds = msg.hasGetBonusIds

	V3a9_BossRushModel.instance:refreshHasGetBonusIds(msg.activityId, stage, hasGetBonusIds)
	self:_updateHasGetBonusIds(stage, hasGetBonusIds)
	self:_onReceiveAct128GetTotalRewardsReply(msg)
end

function Activity128Model:onReceiveAct128SingleRewardReply(msg)
	local stage = msg.bossId
	local rewardId = msg.rewardId

	V3a9_BossRushModel.instance:refreshSingleHasGetBonusIds(msg.activityId, stage, rewardId)
	self:_updateSingleHasGetBonusIds(stage, rewardId)
	self:_onReceiveAct128SingleRewardReply(msg)
end

function Activity128Model:onReceiveAct128DoublePointReply(msg)
	local bossId = msg.bossId
	local doubleNum = msg.doubleNum
	local totalPoint = msg.totalPoint
	local stageInfo = self:getStageInfo(bossId)

	stageInfo.doubleNum = doubleNum
	stageInfo.totalPoint = totalPoint

	self:_onReceiveAct128DoublePointReply(msg)
end

function Activity128Model:onReceiveAct128InfoUpdatePush(msg)
	self:_updateAll(msg)
	self:_onReceiveAct128InfoUpdatePush(msg)
end

function Activity128Model:_onReceiveGet128InfosReply(msg)
	return
end

function Activity128Model:_onReceiveAct128GetTotalRewardsReply(msg)
	return
end

function Activity128Model:_onReceiveAct128DoublePointReply(msg)
	return
end

return Activity128Model
