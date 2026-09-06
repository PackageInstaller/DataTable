-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/model/MakeCakeModel.lua

module("logic.extensions.anniversarycake.model.MakeCakeModel", package.seeall)

local MakeCakeModel = class("MakeCakeModel", BaseModel)

function MakeCakeModel:ctor()
	return
end

function MakeCakeModel:onInit()
	self:onReset()
end

function MakeCakeModel:onReset()
	self._activityId = 0
	self._worldProgress = 0
	self._gainedWorldPrizeIds = {}
	self._personalScore = 0
	self._gainedPersonalPrizeIds = {}
	self._maxPassedStage = 1
	self._todayRemainGameTimes = 0
	self._dailyFreeTimes = 0
	self._stageRanks = {}
	self._eatTodayGameTimes = 0
	self._eatCakeScore = 0
	self._eatGainedEatCakePrizeIds = {}
	self._eatWorldProgress = 0
	self._eatGainedWorldPrizeIds = {}
end

function MakeCakeModel:resetGameCount()
	self._eatTodayGameTimes = 0
end

function MakeCakeModel:getActivityId()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.AnniversaryCake)

	if cfg then
		self._activityId = cfg.activityId or 140001
	end

	return self._activityId
end

function MakeCakeModel:getStagePlanId(activityId)
	local cfg = MakeCakeConfig.instance:getActivityCfg(activityId)

	return (cfg or nil) and (cfg.makeCakeStagePlan or 0)
end

function MakeCakeModel:getWorldPrizePlanId()
	local cfg = MakeCakeConfig.instance:getActivityCfg(self._activityId)

	return (cfg or nil) and (cfg.worldPrizePlan or 0)
end

function MakeCakeModel:getPlayerPrizePlanId()
	local cfg = MakeCakeConfig.instance:getActivityCfg(self._activityId)

	return (cfg or nil) and (cfg.personalPrizePlan or 0)
end

function MakeCakeModel:getEatWorldPrizePlanId()
	local cfg = MakeCakeConfig.instance:getActivityCfg(self._activityId)

	return (cfg or nil) and (cfg.eatCakeWorldPrizePlan or 0)
end

function MakeCakeModel:getEatPlayerPrizePlanId()
	local cfg = MakeCakeConfig.instance:getActivityCfg(self._activityId)

	return (cfg or nil) and (cfg.eatCakePrizePlan or 0)
end

function MakeCakeModel:getEatCakeStartTime()
	local cfg = MakeCakeConfig.instance:getActivityCfg(self._activityId)

	return (cfg or nil) and (cfg.eatCakeStartTime or "2022-04-15 05:00:00")
end

function MakeCakeModel:getMaxEatCakeCount()
	local cfg = MakeCakeConfig.instance:getActivityCfg(self._activityId)

	return (cfg or nil) and (cfg.maxEatCakeCount or 0)
end

function MakeCakeModel:getFreeAddPipeCount()
	local cfg = MakeCakeConfig.instance:getActivityCfg(self._activityId)

	return (cfg or nil) and (cfg.dailyAddPipeTimes or 0)
end

function MakeCakeModel:onGetMakeCakeInfoRes(msg)
	self._worldProgress = msg.worldProgress
	self._gainedWorldPrizeIds = GameUtil.pbToTable(msg.gainedWorldPrizeIds) or {}
	self._personalScore = msg.personalScore
	self._gainedPersonalPrizeIds = GameUtil.pbToTable(msg.gainedPersonalPrizeIds) or {}
	self._maxPassedStage = msg.maxPassedStage
	self._todayRemainGameTimes = msg.todayRemainGameTimes
	self._dailyFreeTimes = msg.dailyFreeTimes
end

function MakeCakeModel:onGainMakeCakePersonalPrizeRes(msg)
	if not TableUtil.isHad(self._gainedPersonalPrizeIds, msg.personalPrizeId) then
		table.insert(self._gainedPersonalPrizeIds, msg.personalPrizeId)
	end
end

function MakeCakeModel:onGainMakeCakeWorldPrizeRes(msg)
	if not TableUtil.isHad(self._gainedWorldPrizeIds, msg.worldPrizeId) then
		table.insert(self._gainedWorldPrizeIds, msg.worldPrizeId)
	end
end

function MakeCakeModel:onStartMakeCakeRes(msg)
	return
end

function MakeCakeModel:onEndMakeCakeRes(msg)
	if self._maxPassedStage < msg.stage then
		self._maxPassedStage = msg.stage

		if self._todayRemainGameTimes > 0 then
			self._todayRemainGameTimes = self._todayRemainGameTimes - 1
		end
	end
end

function MakeCakeModel:onGetEatCakeInfoRes(msg)
	self._eatTodayGameTimes = msg.todayGameTimes
	self._eatCakeScore = msg.eatCakeScore
	self._eatGainedEatCakePrizeIds = msg.gainedEatCakePrizeIds
	self._eatWorldProgress = msg.worldProgress
	self._eatGainedWorldPrizeIds = msg.gainedWorldPrizeIds
end

function MakeCakeModel:onGainEatCakePrizeRes(msg)
	if not TableUtil.isHad(self._eatGainedEatCakePrizeIds, msg.eatCakePrizeId) then
		table.insert(self._eatGainedEatCakePrizeIds, msg.eatCakePrizeId)
	end
end

function MakeCakeModel:onGainEatCakeWorldPrizeRes(msg)
	if not TableUtil.isHad(self._eatGainedWorldPrizeIds, msg.worldPrizeId) then
		table.insert(self._eatGainedWorldPrizeIds, msg.worldPrizeId)
	end
end

function MakeCakeModel:onStartEatCakeRes(msg)
	return
end

function MakeCakeModel:onEndEatCakeRes(msg)
	self._eatCakeScore = msg.newEatCakeScore
	self._eatTodayGameTimes = self._eatTodayGameTimes + 1
end

function MakeCakeModel:GetRankInfoRes(msg)
	table.clear(self._stageRanks)

	local list = GameUtil.pbToTable(msg.stageRanks) or {}

	for i, v in ipairs(list) do
		self._stageRanks[v.stage] = v.rankInfos
	end
end

function MakeCakeModel:onMakeCakeAddPipeRes(msg)
	self._dailyFreeTimes = self._dailyFreeTimes - 1

	if self._dailyFreeTimes > 0 then
		self._dailyFreeTimes = self._dailyFreeTimes or 0
	end
end

function MakeCakeModel:getPersonalScore()
	return self._personalScore
end

function MakeCakeModel:getEatPersonalScore()
	return self._eatCakeScore
end

function MakeCakeModel:getWorldProgress()
	return self._worldProgress
end

function MakeCakeModel:getEatWorldProgress()
	return self._eatWorldProgress
end

function MakeCakeModel:isWorldRewardCanGet(prizeId, needScore)
	local isScoreEnough = needScore <= self._worldProgress

	if isScoreEnough then
		local isGeted = self:isWorldRewardGeted(prizeId)

		return not isGeted
	else
		return false
	end
end

function MakeCakeModel:isWorldRewardGeted(prizeId)
	return TableUtil.isHad(self._gainedWorldPrizeIds, prizeId)
end

function MakeCakeModel:isPlayerRewardCanGet(prizeId, needScore)
	local isScoreEnough = needScore <= self._personalScore

	if isScoreEnough then
		local isGeted = self:isPlayerRewardGeted(prizeId)

		return not isGeted
	else
		return false
	end
end

function MakeCakeModel:isPlayerRewardGeted(prizeId)
	return TableUtil.isHad(self._gainedPersonalPrizeIds, prizeId)
end

function MakeCakeModel:isEatWorldRewardCanGet(prizeId, needScore)
	local isScoreEnough = needScore <= self._eatWorldProgress

	if isScoreEnough then
		local isGeted = self:isEatWorldRewardGeted(prizeId)

		return not isGeted
	else
		return false
	end
end

function MakeCakeModel:isEatWorldRewardGeted(prizeId)
	return TableUtil.isHad(self._eatGainedWorldPrizeIds, prizeId)
end

function MakeCakeModel:isEatPlayerRewardCanGet(prizeId, needScore)
	local isScoreEnough = needScore <= self._eatCakeScore

	if isScoreEnough then
		local isGeted = self:isEatPlayerRewardGeted(prizeId)

		return not isGeted
	else
		return false
	end
end

function MakeCakeModel:isEatPlayerRewardGeted(prizeId)
	return TableUtil.isHad(self._eatGainedEatCakePrizeIds, prizeId)
end

function MakeCakeModel:getStageRankInfo(stage)
	return self._stageRanks[stage]
end

function MakeCakeModel:isExistGameCountToday()
	return self._todayRemainGameTimes > 0
end

function MakeCakeModel:getCurLeftGameCount()
	return self._todayRemainGameTimes
end

function MakeCakeModel:getEatCurLeftGameCount()
	local cfg = MakeCakeConfig.instance:getActivityCfg(self._activityId)

	if cfg then
		local maxCount = cfg.eatCakeTimesLimit
		local curCount = self._eatTodayGameTimes

		if maxCount <= curCount then
			return 0
		else
			return maxCount - curCount
		end
	else
		return 0
	end
end

function MakeCakeModel:isStageOpen(stageId)
	if stageId <= self._maxPassedStage then
		return true
	end

	if self._maxPassedStage + 1 == stageId then
		local stagePlanId = self:getStagePlanId(self._activityId)
		local cfg = MakeCakeConfig.instance:getStageCfg(stagePlanId, stageId)

		if cfg and ServerTime.now() >= GameUtil.string2time(cfg.openTime) then
			return true
		end
	end

	return false
end

function MakeCakeModel:isStagePass(stageId)
	return stageId <= self._maxPassedStage
end

function MakeCakeModel:getMaxPassStageId()
	return self._maxPassedStage
end

function MakeCakeModel:isAllMakeCakeWorldPrizeCanGet()
	local prizePlanId = self:getWorldPrizePlanId()
	local cfgs = MakeCakeConfig.instance:getPrizeCfgList(prizePlanId)

	if cfgs then
		for i, v in ipairs(cfgs) do
			if self:isWorldRewardCanGet(v.prizeId, v.needScore) then
				return true
			end
		end

		return false
	else
		return false
	end
end

function MakeCakeModel:isAllEatCakeWorldPrizeCanGet()
	local prizePlanId = self:getEatWorldPrizePlanId()
	local cfgs = MakeCakeConfig.instance:getPrizeCfgList(prizePlanId)

	if cfgs then
		for i, v in ipairs(cfgs) do
			if self:isEatWorldRewardCanGet(v.prizeId, v.needScore) then
				return true
			end
		end

		return false
	else
		return false
	end
end

function MakeCakeModel:getLeftDailyFreeTimes()
	return self._dailyFreeTimes
end

MakeCakeModel.instance = MakeCakeModel.New()

return MakeCakeModel
