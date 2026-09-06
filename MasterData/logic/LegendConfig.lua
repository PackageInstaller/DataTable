-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/config/LegendConfig.lua

module("logic.extensions.legend.config.LegendConfig", package.seeall)

local LegendConfig = class("LegendConfig", BaseConfig)

function LegendConfig:onInit()
	LegendConfig.super.onInit(self)

	self._legendChallengeCommonCfg = nil
	self._legendChallengeCfg = nil
	self._legendChallengeStageCfg = nil
	self._legendChallengeTeam = nil
	self._legendChallengeCreeps = nil
	self._legendBuyTimesPrice = nil
	self._legendChallengeTreasure = nil
	self._legendChallengeSupport = nil
end

function LegendConfig:getNames()
	return {
		"legend_challenge_common_config",
		"legend_challenge",
		"legend_challenge_stage",
		"legend_challenge_team",
		"legend_challenge_creeps",
		"legend_buy_times_price",
		"legend_verify_plan",
		"legend_verify_buff",
		"legend_map",
		"legend_block",
		"legend_challenge_treasure",
		"legend_challenge_support",
		"legend_challenge_map_list",
		"legend_challenge_map_detail"
	}
end

function LegendConfig:handleConfig(name, content)
	if name == "legend_challenge_common_config" then
		self._legendChallengeCommonCfg = content
	elseif name == "legend_challenge" then
		self._legendChallengeCfg = content
	elseif name == "legend_challenge_stage" then
		self._legendChallengeStageCfg = content
	elseif name == "legend_challenge_team" then
		self._legendChallengeTeam = content
	elseif name == "legend_challenge_creeps" then
		self._legendChallengeCreeps = content
	elseif name == "legend_buy_times_price" then
		self._legendBuyTimesPrice = content
	elseif name == "legend_verify_plan" then
		self._legendVerifyPlan = content
	elseif name == "legend_verify_buff" then
		self._legendVerifyBuff = content
	elseif name == "legend_map" then
		self._legendMap = content
	elseif name == "legend_block" then
		self._legendBlock = content
	elseif name == "legend_challenge_treasure" then
		self._legendChallengeTreasure = content
	elseif name == "legend_challenge_support" then
		self._legendChallengeSupport = content
	elseif name == "legend_challenge_map_list" then
		self._legendChallengeMapList = content
	elseif name == "legend_challenge_map_detail" then
		self._legendChallengeMapDetail = content
	end
end

function LegendConfig:getLegendChallengeCommonCfg(strKey)
	return self._legendChallengeCommonCfg[strKey]
end

function LegendConfig:getLegendChallengeCfgs()
	if not self._legendChallengeSortList then
		self._legendChallengeSortList = {}

		for k, v in ipairs(self._legendChallengeCfg) do
			if v.isShow then
				table.insert(self._legendChallengeSortList, v)
			end
		end

		table.sort(self._legendChallengeSortList, function(a, b)
			return a.sort < b.sort
		end)
	end

	return self._legendChallengeSortList
end

function LegendConfig:getLegendChallengeCfg(challengeId)
	return self._legendChallengeCfg[challengeId]
end

function LegendConfig:getLegendChallengeStageCfgList(challengeId)
	return self._legendChallengeStageCfg[challengeId]
end

function LegendConfig:getLegendChallengeStageCfg(challengeId, stageId)
	if self._legendChallengeStageCfg[challengeId] then
		return self._legendChallengeStageCfg[challengeId][stageId]
	end

	return nil
end

function LegendConfig:isLastStageById(challengeId, stageId)
	local cfgs = self:getLegendChallengeStageCfgList(challengeId)

	return cfgs and stageId == #cfgs
end

function LegendConfig:getLegendChallengeTeamCfg(creepsMasterId)
	return self._legendChallengeTeam[creepsMasterId]
end

function LegendConfig:getLegendChallengeCreepsCfgList(creepsMasterId)
	return self._legendChallengeCreeps[creepsMasterId]
end

function LegendConfig:getLegendBuyTimesPriceCfg(typeId, challengeId, times)
	if self._legendBuyTimesPrice[typeId] and self._legendBuyTimesPrice[typeId][challengeId] then
		local result = self._legendBuyTimesPrice[typeId][challengeId][times]

		if result then
			return result
		else
			local count = #self._legendBuyTimesPrice[typeId][challengeId]

			return self._legendBuyTimesPrice[typeId][challengeId][count]
		end
	end

	return nil
end

function LegendConfig:getVerifyPlan(planId)
	return self._legendVerifyPlan[planId]
end

function LegendConfig:getVerifyBuffs(planId)
	local cfg = self._legendVerifyPlan[planId]

	if not cfg then
		return
	end

	local buffPlanId = cfg.buffPlanId
	local data = self._legendVerifyBuff[buffPlanId]
	local ret = {}

	for k, v in pairs(data) do
		table.insert(ret, v)
	end

	return ret
end

function LegendConfig:getMapCfgById(raceId)
	return self._legendMap[raceId]
end

function LegendConfig:getMapCfg()
	return self._legendMap.dataList
end

function LegendConfig:getBlockCfgById(blockId)
	return self._legendBlock[blockId]
end

function LegendConfig:getTreasureByCfg(treasureId)
	return self._legendChallengeTreasure[treasureId]
end

function LegendConfig:getTreasureCfgs()
	return self._legendChallengeTreasure.dataList
end

function LegendConfig:getSupportCfg(supportId)
	return self._legendChallengeSupport[supportId]
end

function LegendConfig:getSuportCfgByChallengeId(challengeId, stageId)
	local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)

	if not cfgStage then
		return nil
	end

	return (LegendConfig.instance:getSupportCfg(cfgStage.supportPetId))
end

function LegendConfig:getCreepsId(challengeId, stageId)
	local cfgSupport = self:getSuportCfgByChallengeId(challengeId, stageId)

	return (cfgSupport or nil) and (cfgSupport.creepsId or 0)
end

function LegendConfig:getMapListCfg(mapId)
	return self._legendChallengeMapList[mapId]
end

function LegendConfig:getMapListCfgs()
	return self._legendChallengeMapList.dataList
end

function LegendConfig:getMapDetailCfg(mapId)
	return self._legendChallengeMapDetail[mapId]
end

function LegendConfig:getMapDetailchallengeCfg(mapId, challengeId)
	return self._legendChallengeMapDetail[mapId][challengeId]
end

LegendConfig.instance = LegendConfig.New()

return LegendConfig
