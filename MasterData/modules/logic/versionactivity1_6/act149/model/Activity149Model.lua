-- chunkname: @modules/logic/versionactivity1_6/act149/model/Activity149Model.lua

module("modules.logic.versionactivity1_6.act149.model.Activity149Model", package.seeall)

local Activity149Model = class("Activity149Model", BaseModel)

function Activity149Model:onInit()
	self._act149MoDict = {}
	self._preScore = 0
	self._curMaxScore = 0
	self._totalScore = 0
	self._hasGetBonusIds = {}
end

function Activity149Model:reInit()
	self._act149MoDict = {}
	self._curMaxScore = 0
	self._totalScore = 0
	self._hasGetBonusIds = {}
end

function Activity149Model:onReceiveInfos(msg)
	self._act149MoDict = {}
	self._hasGetBonusIds = {}
	self._actId = msg.activityId

	local episodeInfos = msg.episodeInfos

	self._preScore = self._curMaxScore
	self._curMaxScore = msg.currMaxScore
	self._totalScore = msg.totalScore

	local hasGetBonusIds = msg.hasGetBonusIds

	for _, info in ipairs(episodeInfos) do
		local id = info.id

		self._act149MoDict[id] = Activity149Mo.New(id, self._actId)
	end

	for _, id in ipairs(hasGetBonusIds) do
		self._hasGetBonusIds[id] = true
	end
end

function Activity149Model:onReceiveScoreInfos(msg)
	local hasGetBonusIds = msg.hasGetBonusIds

	for i, id in ipairs(hasGetBonusIds) do
		self._hasGetBonusIds[id] = true
	end
end

function Activity149Model:HasGotHigherScore()
	return self._curMaxScore > self._preScore
end

function Activity149Model:applyPreScoreToCurScore()
	self._preScore = self._curMaxScore
end

function Activity149Model:setFightScore(num)
	self._fightPreScore = self:getFightScore()
	self._fightCurScore = num
end

function Activity149Model:noticeFightScore(num)
	local last = self._fightPreScore

	num = num or self._fightCurScore

	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.DungeonBossFightScoreChange, last, num)
end

function Activity149Model:getFightScore()
	return self._fightCurScore or 0
end

function Activity149Model:getPreFightScore()
	return self._fightPreScore
end

function Activity149Model:getAct149MoByOrder(order)
	for id, act149Mo in pairs(self._act149MoDict) do
		if order == act149Mo.cfg.order then
			return act149Mo
		end
	end
end

function Activity149Model:getAct149MoByEpisodeId(episodeId)
	for id, act149Mo in pairs(self._act149MoDict) do
		if episodeId == act149Mo.cfg.episodeId then
			return act149Mo
		end
	end
end

function Activity149Model:getAct149EpisodeCfgIdByOrder(order)
	local maxBossOrder = VersionActivity1_6DungeonEnum.bossMaxOrder

	if order == maxBossOrder then
		local actInfoMo = ActivityModel.instance:getActMO(self._actId)
		local openDayNum = actInfoMo:getOpeningDay()

		return self:getMaxOrderAct149EpisodeCfg(openDayNum)
	else
		return Activity149Config.instance:getAct149EpisodeCfgByOrder(order)
	end
end

function Activity149Model:getMaxOrderAct149EpisodeCfg(openDayNum)
	local day = Activity149Config.instance:getAlternateDay()
	local id = openDayNum % day + VersionActivity1_6DungeonEnum.bossMaxOrder

	return Activity149Config.instance:getAct149EpisodeCfg(id)
end

function Activity149Model:getCurBossEpisodeRemainDay()
	local actInfoMo = ActivityModel.instance:getActMO(self._actId)
	local openDayNum = actInfoMo:getOpeningDay()

	return 3 - openDayNum % 3
end

function Activity149Model:isLastBossEpisode()
	local actInfoMo = ActivityModel.instance:getActMO(self._actId)
	local remainDay = actInfoMo:getRemainDay()
	local openDayNum = actInfoMo:getOpeningDay()
	local curBossRemainDay = 2 - openDayNum % 3

	return remainDay < curBossRemainDay
end

function Activity149Model:getMaxOrderMo()
	if not self._act149MoDict then
		return nil
	end

	local maxOrder = 0
	local maxOrderId = 1

	for id, act149Mo in pairs(self._act149MoDict) do
		local order = act149Mo.cfg.order

		if maxOrder < order then
			maxOrder = order
			maxOrderId = id
		end
	end

	local maxOrderMo = self._act149MoDict[maxOrderId]

	return maxOrderMo, maxOrder
end

function Activity149Model:getCurMaxScore()
	return self._curMaxScore
end

function Activity149Model:getAleadyGotBonusIds()
	return self._hasGetBonusIds
end

function Activity149Model:getTotalScore()
	return self._totalScore
end

function Activity149Model:getScheduleViewRewardList()
	local res = {}
	local rewardCfgList = Activity149Config.instance:getBossRewardCfgList()

	for _, cfg in ipairs(rewardCfgList) do
		local id = cfg.id
		local isGot = self._hasGetBonusIds[id]

		res[#res + 1] = {
			isGot = isGot,
			rewardCfg = cfg
		}
	end

	return res
end

function Activity149Model:checkAbleGetReward(pointNum)
	local rewardCfgList = Activity149Config.instance:getBossRewardCfgList()
	local hasRewardToGet = false
	local index = 0
	local lastGotRewardIdx = 0

	for i, rewardCfg in ipairs(rewardCfgList) do
		local id = rewardCfg.id
		local rewardPointNum = rewardCfg.rewardPointNum
		local isGot = self._hasGetBonusIds[id]

		if isGot then
			lastGotRewardIdx = i
			index = i
		elseif rewardPointNum <= pointNum then
			hasRewardToGet = true
			index = i
		end
	end

	return hasRewardToGet, lastGotRewardIdx, index
end

function Activity149Model:checkEpisodePassedByOrder(order)
	local maxBossOrder = VersionActivity1_6DungeonEnum.bossMaxOrder

	if order == maxBossOrder then
		local bossCfgs = Activity149Config.instance:getAct149EpisodeCfgByOrder(order, true)
		local isPassed = false

		for idx, cfg in ipairs(bossCfgs) do
			local episodeInfo = DungeonModel.instance:getEpisodeInfo(cfg.episodeId)

			if episodeInfo and episodeInfo.star > 1 then
				isPassed = true

				break
			end
		end

		return isPassed
	else
		local bossCfg = Activity149Config.instance:getAct149EpisodeCfgByOrder(order)
		local episodeInfo = DungeonModel.instance:getEpisodeInfo(bossCfg.episodeId)

		return episodeInfo and episodeInfo.star > 1
	end
end

Activity149Model.instance = Activity149Model.New()

return Activity149Model
