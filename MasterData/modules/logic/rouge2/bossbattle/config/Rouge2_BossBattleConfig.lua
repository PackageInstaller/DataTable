-- chunkname: @modules/logic/rouge2/bossbattle/config/Rouge2_BossBattleConfig.lua

module("modules.logic.rouge2.bossbattle.config.Rouge2_BossBattleConfig", package.seeall)

local Rouge2_BossBattleConfig = class("Rouge2_BossBattleConfig", BaseConfig)

function Rouge2_BossBattleConfig:reqConfigNames()
	return {
		"rouge2_boss_rush",
		"rouge2_boss_reward",
		"rouge2_boss_assess"
	}
end

function Rouge2_BossBattleConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge2_boss_rush" then
		self:_onLoadBossRushConfig(configTable)
	elseif configName == "rouge2_boss_reward" then
		self:_onLoadBossRewardConfig(configTable)
	elseif configName == "rouge2_boss_assess" then
		self:_onLoadBossAssessConfig(configTable)
	end
end

function Rouge2_BossBattleConfig:_onLoadBossRushConfig(configTable)
	self._boss2RewardIdList = {}
	self._episodeId2BossCoMap = {}

	for _, bossCo in ipairs(configTable.configList) do
		local bossId = bossCo.id

		self._boss2RewardIdList[bossId] = string.splitToNumber(bossCo.reward, "#")

		local episodeId = bossCo.levelId

		self._episodeId2BossCoMap[episodeId] = bossCo
	end
end

function Rouge2_BossBattleConfig:_onLoadBossRewardConfig(configTable)
	self._rewardId2ItemList = {}

	for _, rewardCo in ipairs(configTable.configList) do
		local rewardId = rewardCo.id

		self._rewardId2ItemList[rewardId] = GameUtil.splitString2(rewardCo.reward, true)
	end
end

function Rouge2_BossBattleConfig:_onLoadBossAssessConfig(configTable)
	self._assessCoNum = 0
	self._assessCoList = {}
	self._score2AssessCoMap = {}

	for _, assessCo in ipairs(configTable.configList) do
		local needScore = assessCo.needScore

		self._score2AssessCoMap[needScore] = assessCo

		table.insert(self._assessCoList, assessCo)

		self._assessCoNum = self._assessCoNum + 1
	end

	table.sort(self._assessCoList, self._sortAssessConfigFunc)
end

function Rouge2_BossBattleConfig._sortAssessConfigFunc(aAssessCo, bAssessCo)
	return aAssessCo.level < bAssessCo.level
end

function Rouge2_BossBattleConfig:_checkBuildRewardMap()
	if self._boss2RewardCoList then
		return
	end

	self._boss2RewardCoList = {}

	for bossId, rewardIdList in pairs(self._boss2RewardIdList) do
		self._boss2RewardCoList[bossId] = {}

		for _, rewardId in ipairs(rewardIdList) do
			local rewardCo = self:getRewardConfig(rewardId)

			table.insert(self._boss2RewardCoList[bossId], rewardCo)
		end

		table.sort(self._boss2RewardCoList[bossId], SortUtil.keyLower("stage"))
	end
end

function Rouge2_BossBattleConfig:getRewardListByBossId(bossId)
	self:_checkBuildRewardMap()

	if self._boss2RewardCoList then
		if not self._boss2RewardCoList then
			logError(string.format("肉鸽首领奖励配置不存在, bossId: %s", bossId))
		end

		return self._boss2RewardCoList
	end
end

function Rouge2_BossBattleConfig:getItemListByRewardId(rewardId)
	if self._rewardId2ItemList then
		if not self._rewardId2ItemList then
			logError(string.format("肉鸽首领奖励物品配置不存在, rewardId: %s", rewardId))
		end

		return self._rewardId2ItemList
	end
end

function Rouge2_BossBattleConfig:getRewardConfig(rewardId)
	local rewardCo = lua_rouge2_boss_reward.configDict[rewardId]

	if not rewardCo then
		logError(string.format("肉鸽首领奖励配置不存在, rewardId: %s", rewardId))
	end

	return rewardCo
end

function Rouge2_BossBattleConfig:getBossRewardScoreRange(bossId)
	local rewardList = self:getRewardListByBossId(bossId)

	if rewardList then
		if not #rewardList then
			local rewardNum = 0
			local lastReward = rewardList and rewardList[rewardNum]

			if lastReward then
				if not lastReward.score then
					local maxRewardScore = 0

					return 0, maxRewardScore
				end
			end
		end
	end
end

function Rouge2_BossBattleConfig:getAllBossConfigList()
	return lua_rouge2_boss_rush.configList
end

function Rouge2_BossBattleConfig:getBossConfig(bossId)
	local bossCo = lua_rouge2_boss_rush.configDict[bossId]

	if not bossCo then
		logError(string.format("肉鸽首领配置不存在, bossId: %s", bossId))
	end

	return bossCo
end

function Rouge2_BossBattleConfig:getBossConfigByEpisodeId(episodeId)
	if self._episodeId2BossCoMap then
		if not self._episodeId2BossCoMap then
			logError(string.format("肉鸽首领配置不存在, levelId: %s", episodeId))
		end

		return self._episodeId2BossCoMap
	end
end

function Rouge2_BossBattleConfig:getBossTagList(bossId)
	local tagList
	local bossCo = self:getBossConfig(bossId)
	local tagStr = bossCo and bossCo.tag

	return (not string.nilorempty(tagStr) or nil) and string.split(tagStr, "#") or {}
end

function Rouge2_BossBattleConfig:getAssessConfigByScore(score)
	for i = 1, self._assessCoNum do
		local assessCo = self._assessCoList[i]

		if assessCo then
			if not assessCo.needScore then
				local needScore = 0

				if score < needScore then
					return self._assessCoList[i - 1]
				end
			end
		end
	end

	return self._assessCoList and self._assessCoList[self._assessCoNum]
end

function Rouge2_BossBattleConfig:getAssessConfigByLevel(level)
	level = level or 0

	return lua_rouge2_boss_assess.configDict[level]
end

function Rouge2_BossBattleConfig:getAssessSpriteName(score)
	local assessCo = self:getAssessConfigByScore(score)

	if assessCo then
		return assessCo.spriteName, assessCo.level, assessCo.strLevel, assessCo.bossIcon
	end

	return "", -1, ""
end

Rouge2_BossBattleConfig.instance = Rouge2_BossBattleConfig.New()

return Rouge2_BossBattleConfig
