-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/model/SummontowerModel.lua

module("logic.extensions.summer.model.SummontowerModel", package.seeall)

local SummontowerModel = class("SummontowerModel", BaseModel)

SummontowerModel.SummonCareerName = {
	[GameEnum.RaceType.Cao] = lang("text_summon_careername_cao"),
	[GameEnum.RaceType.Shui] = lang("text_summon_careername_shui"),
	[GameEnum.RaceType.Huo] = lang("text_summon_careername_huo"),
	[GameEnum.RaceType.Guang] = lang("text_summon_careername_guang"),
	[GameEnum.RaceType.An] = lang("text_summon_careername_an"),
	[GameEnum.RaceType.Chuang] = lang("创系召唤师")
}
SummontowerModel.WishType = {
	SummonMaster = 2,
	Pet = 1
}

function SummontowerModel:onInit()
	self:onReset()
end

function SummontowerModel:onReset()
	self._activityId = 0
	self._activityInfo = nil
	self._gameDataReady = false
	self.rankListMap = {}
end

function SummontowerModel:isActivityDataReady()
	return self._activityInfo and self._activityId == self._activityInfo.activityId
end

function SummontowerModel:setActivityId(activityId)
	self._activityId = activityId
end

function SummontowerModel:getActivityId()
	return self._activityId
end

function SummontowerModel:setActivityInfo(activityInfo)
	self._activityInfo = nil
	self._gameDataReady = false

	if not activityInfo then
		return
	end

	self._activityInfo = SummonTowerActivityMO.New()
	self._activityInfo.activityId = activityInfo.activityId
	self._activityInfo.todayGameTimes = activityInfo.todayGameTimes
	self._activityInfo.todayGameBuyTimes = activityInfo.todayGameBuyTimes
	self._activityInfo.curStage = activityInfo.curStage
	self._activityInfo.hasChooseSummomMaster = activityInfo.hasChooseSummomMaster
	self._activityInfo.everMaxPassStage = activityInfo.everMaxPassStage
	self._activityInfo.gainedFirstPassPrizeIds = {}
	self._activityInfo.everMaxScore = activityInfo.everMaxScore

	for i = 1, #activityInfo.gainedFirstPassPrizeIds do
		table.insert(self._activityInfo.gainedFirstPassPrizeIds, activityInfo.gainedFirstPassPrizeIds[i])
	end

	if activityInfo.familiarCreepsId ~= 0 and activityInfo.everMaxPassStage ~= 0 and activityInfo.everMaxScore ~= 0 then
		self._activityInfo.record = SummonRecordMO.New()
		self._activityInfo.record.summonRaceId = activityInfo.familiarCreepsId
		self._activityInfo.record.maxLevel = activityInfo.everMaxPassStage
		self._activityInfo.record.maxScores = activityInfo.everTotalScore
	end
end

function SummontowerModel:getDailyPlayTimes()
	return SummontowerConfig.instance:getParamsInt("DAILY_FREE_TIMES")
end

function SummontowerModel:getExchangePushItem()
	return SummontowerConfig.instance:getParamsString("EXCHANGE_PUSH_ITEM")
end

function SummontowerModel:getPlayerSpineRes()
	return "effect/prefabs/ui/20211028/zhiren_aoqi/zhiren_aoqi-ui_p.prefab"
end

function SummontowerModel:getPlayTimes()
	if self._activityInfo then
		return self._activityInfo.todayGameTimes
	end

	return 0
end

function SummontowerModel:costPlayTimes(times)
	if self._activityInfo and times then
		self._activityInfo.todayGameTimes = self._activityInfo.todayGameTimes - 1
	end
end

function SummontowerModel:addSweepScore()
	if self._activityInfo or self._activityInfo.record then
		self._activityInfo.record.maxScores = checknumber(self._activityInfo.record.maxScores) + checknumber(self:getSweepScores())
	end
end

function SummontowerModel:getDailyBuyTimes()
	return SummontowerConfig.instance:getMaxBuyTimes()
end

function SummontowerModel:getBuyTimes()
	if self._activityInfo then
		return self._activityInfo.todayGameBuyTimes
	end

	return 0
end

function SummontowerModel:setBuyTimes(todayGameBuyTimes)
	if self._activityInfo then
		self._activityInfo.todayGameBuyTimes = todayGameBuyTimes
	end
end

function SummontowerModel:getCanPlayTimes()
	return self:getPlayTimes()
end

function SummontowerModel:getCurSeason()
	if self._activityId == 0 then
		return 0
	end

	local acCo = SummontowerConfig.instance:getActivitieCo(self._activityId)

	return acCo.seasonId
end

function SummontowerModel:hasGainedFirstPassPrize(id)
	if not self._activityInfo then
		return false
	end

	if not self._activityInfo.gainedFirstPassPrizeIds then
		return false
	end

	return table.indexof(self._activityInfo.gainedFirstPassPrizeIds, id) ~= false
end

function SummontowerModel:canSpeep()
	if not self._activityInfo then
		return false
	end

	return self._activityInfo.everMaxPassStage >= SummontowerConfig.instance:getStageNumById(self._activityId)
end

function SummontowerModel:getSweepScores()
	if not self._activityInfo then
		return 0
	end

	return self._activityInfo.everMaxScore
end

function SummontowerModel:isLevelPassed(levelId)
	if not self._activityInfo then
		return false
	end

	return levelId <= self._activityInfo.everMaxPassStage or levelId < self:getCurLevelId()
end

function SummontowerModel:getRecord()
	if self._activityInfo then
		return self._activityInfo.record
	end
end

function SummontowerModel:getScoresItemCfg()
	local activityId = self:getActivityId()
	local activitiCo = SummontowerConfig.instance:getActivitieCo(activityId)

	return activitiCo.scoreItemKey
end

function SummontowerModel:getCurLevelId()
	if self._activityInfo then
		return self._activityInfo.curStage
	end

	return 0
end

function SummontowerModel:setCurLevelId(curStage)
	if self._activityInfo then
		self._activityInfo.curStage = curStage
	end
end

function SummontowerModel:isNextBossLevel()
	local levelId = self:getCurLevelId()

	if levelId == 0 then
		return false
	end

	local stageCo = SummontowerConfig.instance:getStageCo(levelId + 1)

	if not stageCo then
		return false
	end

	return stageCo.isBoss or false
end

function SummontowerModel:getActivityEndTimeStamp()
	if self._activityId == 0 then
		return 0
	end

	local activitiCo = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.Summontower, self._activityId)

	return GameUtil.string2time(activitiCo.endTime)
end

function SummontowerModel:isGameInfoReady()
	return self._gameDataReady
end

function SummontowerModel:onGameInfo(msg)
	self._activityInfo.curStage = msg.curStage
	self._gameDataReady = true
end

function SummontowerModel:onGetRankInfoMsg(msg)
	local activityId = msg.activityId
	local obj = {}

	obj.rankList = msg.rankInfos
	obj.myRank = msg.myRank
	self.rankListMap[activityId] = obj
end

function SummontowerModel:getRankInfo(activityId)
	return self.rankListMap[activityId] or {}
end

function SummontowerModel:onSelectSummonMaster(msg)
	self._activityInfo.hasChooseSummomMaster = true
end

function SummontowerModel:hasSummonMaster()
	if self._activityInfo then
		return self._activityInfo.hasChooseSummomMaster
	end

	return false
end

function SummontowerModel:getPlayerLevel()
	local currExp = SummonTowerItemsModel.instance:getPlayerExp()

	return SummontowerConfig.instance:getPlayerLevel(currExp)
end

function SummontowerModel:onGainFirstPassPrize(msg)
	if self._activityInfo and msg.activityId == self._activityId then
		self._activityInfo.gainedFirstPassPrizeIds = self._activityInfo.gainedFirstPassPrizeIds or {}

		table.insert(self._activityInfo.gainedFirstPassPrizeIds, msg.prizeId)
	end
end

SummontowerModel.instance = SummontowerModel.New()

return SummontowerModel
