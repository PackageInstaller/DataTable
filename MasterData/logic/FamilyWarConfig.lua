-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/config/FamilyWarConfig.lua

module("logic.extensions.newfamily.config.FamilyWarConfig", package.seeall)

local FamilyWarConfig = class("FamilyWarConfig", BaseConfig)

function FamilyWarConfig:onInit()
	FamilyWarConfig.super.onInit(self)

	self._activityCfgs = nil
	self._battleNestCfgs = nil
	self._nestEnemyCfgs = nil
	self._nestMasterCfgs = nil
	self._nestCreepsCfgs = nil
	self._nestConditionCfgs = nil
	self._pillarInfoCfgs = nil
	self._pillarLayersCfgs = nil
	self._rankPrizeCfgs = nil
	self._commonParamCfg = nil
	self._battleRulesCfgs = nil
	self._seasonRankCfgs = nil
	self._seasonPrizeCfgs = nil
end

function FamilyWarConfig:getNames()
	return {
		"family_battle",
		"family_battle_nest",
		"family_battle_nest_monster",
		"family_battle_master",
		"family_battle_creeps",
		"family_battle_nest_condition",
		"family_battle_divine_pillar",
		"family_battle_pillar_info",
		"family_battle_rank_prize",
		"family_battle_params",
		"family_battle_rules",
		"family_season_rank",
		"family_season_rank_score_prize"
	}
end

function FamilyWarConfig:handleConfig(name, content)
	if name == "family_battle" then
		self._activityCfgs = content
	elseif name == "family_battle_nest" then
		self._battleNestCfgs = content
	elseif name == "family_battle_nest_monster" then
		self._nestEnemyCfgs = content
	elseif name == "family_battle_master" then
		self._nestMasterCfgs = content
	elseif name == "family_battle_creeps" then
		self._nestCreepsCfgs = content
	elseif name == "family_battle_nest_condition" then
		self._nestConditionCfgs = content
	elseif name == "family_battle_pillar_info" then
		self._pillarInfoCfgs = content
	elseif name == "family_battle_divine_pillar" then
		self._pillarLayersCfgs = content
	elseif name == "family_battle_rank_prize" then
		self._rankPrizeCfgs = content
	elseif name == "family_battle_params" then
		self._commonParamCfg = content
	elseif name == "family_battle_rules" then
		self._battleRulesCfgs = content
	elseif name == "family_season_rank" then
		self._seasonRankCfgs = content
	elseif name == "family_season_rank_score_prize" then
		self._seasonPrizeCfgs = content
	end
end

function FamilyWarConfig:getOpenActivityId()
	if self._activityCfgs == nil or #self._activityCfgs == 0 then
		return -1
	end

	local cfg

	for i = 1, #self._activityCfgs do
		if self._activityCfgs[i] and not string.nilorempty(self._activityCfgs[i].registrationStageStartTime) and not string.nilorempty(self._activityCfgs[i].battleStageEndTime) and GameUtil.checkIsInTimePeriod(self._activityCfgs[i].registrationStageStartTime, self._activityCfgs[i].battleStageEndTime) then
			return self._activityCfgs[i].periodId
		end
	end

	return 0
end

function FamilyWarConfig:getNextOpenActivityCfg()
	local cfg

	for i = 1, #self._activityCfgs do
		if self._activityCfgs[i] and not string.nilorempty(self._activityCfgs[i].registrationStageStartTime) and not string.nilorempty(self._activityCfgs[i].battleStageEndTime) and GameUtil.getTimePeriodType(self._activityCfgs[i].registrationStageStartTime, self._activityCfgs[i].battleStageEndTime) == GameUtil.beforeTimePeriod then
			return self._activityCfgs[i]
		end
	end

	return nil
end

function FamilyWarConfig:getFamilyWarPeriodCfg(periodId)
	if checknumber(periodId) <= 0 or self._activityCfgs == nil then
		return nil
	end

	return self._activityCfgs[periodId]
end

function FamilyWarConfig:getFamilyBattleNestCfgs(planId, nestId)
	if checknumber(planId) < 1 or self._battleNestCfgs == nil then
		return nil
	end

	local list = self._battleNestCfgs[planId]

	nestId = checknumber(nestId)

	if list == nil then
		return nil
	end

	if nestId <= 0 or list[nestId] == nil then
		return list
	end

	return list[nestId]
end

function FamilyWarConfig:getFamilyNestConditionCfgs(cpId)
	if checknumber(cpId) <= 0 or self._nestConditionCfgs == nil then
		return nil
	end

	return self._nestConditionCfgs[cpId]
end

function FamilyWarConfig:getFamilyNestEnemyCfg(planId, nestId)
	if checknumber(planId) <= 0 or checknumber(planId) <= 0 then
		return nil
	end

	if self._nestEnemyCfgs == nil or self._nestEnemyCfgs[planId] == nil then
		return nil
	end

	return self._nestEnemyCfgs[planId][nestId]
end

function FamilyWarConfig:getFamilyNestMasterCfg(enemyId)
	if checknumber(enemyId) <= 0 or self._nestMasterCfgs == nil then
		return nil
	end

	return self._nestMasterCfgs[enemyId]
end

function FamilyWarConfig:getFamilyNestCreepsCfgs(enemyId)
	if checknumber(enemyId) <= 0 or self._nestCreepsCfgs == nil then
		return nil
	end

	return self._nestCreepsCfgs[enemyId]
end

function FamilyWarConfig:getFamilyPillarInfoCfgs(pillarId)
	if checknumber(pillarId) < 1 or self._pillarInfoCfgs == nil then
		return nil
	end

	return self._pillarInfoCfgs[pillarId]
end

function FamilyWarConfig:getFamilyPillarLayersCfgs(planId, layerId)
	if checknumber(planId) < 1 or self._pillarLayersCfgs == nil then
		return nil
	end

	local list = self._pillarLayersCfgs[planId]

	if list == nil then
		return nil
	end

	layerId = checknumber(layerId)

	if layerId <= 0 or list[layerId] == nil then
		return list
	end

	return list[layerId]
end

function FamilyWarConfig:getFamilyPillarLayersAwards(planId, layerId)
	local cfg = self:getFamilyPillarLayersCfgs(planId, layerId)

	if cfg == nil then
		return nil, nil
	end

	local cp, pp

	if not string.nilorempty(cfg.challengePrize) then
		cp = string.split(cfg.challengePrize, "#")
	end

	return cp, (not string.nilorempty(cfg.passPrize_client) or nil) and string.split(cfg.passPrize_client, "#")
end

function FamilyWarConfig:getFamilyWarRankPrizeCfgs(planId)
	if checknumber(planId) <= 0 or self._rankPrizeCfgs == nil then
		return nil
	end

	return self._rankPrizeCfgs[planId]
end

function FamilyWarConfig:getFamilyWarCommonParam(strKey)
	if self._commonParamCfg == nil or self._commonParamCfg[strKey] == nil then
		return
	end

	return self._commonParamCfg[strKey].value
end

function FamilyWarConfig:getFamilyWarLimitLevel()
	local level = self:getFamilyWarCommonParam("FAMILY_LEVEL_LIMIT")

	return checknumber(level)
end

function FamilyWarConfig:getFamilyWarSeasonBadge()
	local str = self:getFamilyWarCommonParam("SEASON_BADGE_STATE")

	if string.nilorempty(str) then
		return {}
	end

	return string.split(str, ",")
end

function FamilyWarConfig:getFamilyBattleRulesCfgs()
	return self._battleRulesCfgs or {}
end

function FamilyWarConfig:getFamilySeasonRankCfg(srType)
	srType = srType or FamilyWarController.SeasonRankType.Season

	if self._seasonRankCfgs == nil or self._seasonRankCfgs[checknumber(srType)] == nil then
		return nil
	end

	return self._seasonRankCfgs[checknumber(srType)]
end

function FamilyWarConfig:getFamilySeasonPrizeCfgs(planId)
	if self._seasonPrizeCfgs == nil or checknumber(planId) <= 0 then
		return nil
	end

	return self._seasonPrizeCfgs[planId]
end

FamilyWarConfig.instance = FamilyWarConfig.New()

return FamilyWarConfig
