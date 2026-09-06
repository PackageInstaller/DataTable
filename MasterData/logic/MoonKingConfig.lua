-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/config/MoonKingConfig.lua

module("logic.extensions.moonking.config.MoonKingConfig", package.seeall)

local MoonKingConfig = class("MoonKingConfig", BaseConfig)

function MoonKingConfig:onInit()
	MoonKingConfig.super.onInit(self)

	self._battleBaseCfgs = nil
	self._battlePlanCfgs = nil
	self._battleStageCfgs = nil
	self._battleDifficCfgs = nil
	self._battleGroupCfgs = nil
	self._masterTeamCfgs = nil
	self._masterCreepsCfgs = nil
	self._battlePrizeCfgs = nil
end

function MoonKingConfig:getNames()
	return {
		"moon_shadow_king_challenge",
		"moon_shadow_king_challenge_plan",
		"moon_shadow_king_challenge_stage",
		"moon_shadow_king_challenge_difficulty",
		"moon_shadow_king_challenge_option_group",
		"moon_shadow_king_challenge_master",
		"moon_shadow_king_challenge_creeps",
		"moon_shadow_king_challenge_score_prize"
	}
end

function MoonKingConfig:handleConfig(name, content)
	if name == "moon_shadow_king_challenge" then
		self._battleBaseCfgs = content
	elseif name == "moon_shadow_king_challenge_plan" then
		self._battlePlanCfgs = content
	elseif name == "moon_shadow_king_challenge_stage" then
		self._battleStageCfgs = content
	elseif name == "moon_shadow_king_challenge_difficulty" then
		self._battleDifficCfgs = content
	elseif name == "moon_shadow_king_challenge_option_group" then
		self._battleGroupCfgs = content
	elseif name == "moon_shadow_king_challenge_master" then
		self._masterTeamCfgs = content
	elseif name == "moon_shadow_king_challenge_creeps" then
		self._masterCreepsCfgs = content
	elseif name == "moon_shadow_king_challenge_score_prize" then
		self._battlePrizeCfgs = content
	end
end

function MoonKingConfig:getBattleBaseCfg(chalId)
	chalId = checknumber(chalId)

	if self._battleBaseCfgs == nil or self._battleBaseCfgs[chalId] == nil then
		return nil
	end

	return self._battleBaseCfgs[chalId]
end

function MoonKingConfig:getBattlePlanCfg(planId, groupId)
	planId = checknumber(planId)

	if self._battlePlanCfgs == nil or self._battlePlanCfgs[planId] == nil then
		return nil
	end

	local list = self._battlePlanCfgs[planId]

	groupId = checknumber(groupId)

	if groupId <= 0 or list[groupId] == nil then
		return list
	end

	return list[groupId]
end

function MoonKingConfig:getBattleStageCfgs(planId, stageId)
	planId = checknumber(planId)

	if self._battleStageCfgs == nil or self._battleStageCfgs[planId] == nil then
		return
	end

	local list = self._battleStageCfgs[planId]

	stageId = checknumber(stageId)

	if stageId <= 0 or list[stageId] == nil then
		return list
	end

	return list[stageId]
end

function MoonKingConfig:getBattleDifficCfgs(difficId)
	difficId = checknumber(difficId)

	if self._battleDifficCfgs == nil or self._battleDifficCfgs[difficId] == nil then
		return nil
	end

	return self._battleDifficCfgs[difficId]
end

function MoonKingConfig:getBattleGroupCfgs(groupId)
	groupId = checknumber(groupId)

	if self._battleGroupCfgs == nil or self._battleGroupCfgs[groupId] == nil then
		return nil
	end

	return self._battleGroupCfgs[groupId]
end

function MoonKingConfig:getMasterTeamCfg(masterId)
	masterId = checknumber(masterId)

	if self._masterTeamCfgs == nil or self._masterTeamCfgs[masterId] == nil then
		return nil
	end

	return self._masterTeamCfgs[masterId]
end

function MoonKingConfig:getMasterCreepsCfg(masterId, creepsId)
	masterId = checknumber(masterId)

	if self._masterCreepsCfgs == nil or self._masterCreepsCfgs[masterId] == nil then
		return nil
	end

	local list = self._masterCreepsCfgs[masterId]

	creepsId = checknumber(creepsId)

	if creepsId <= 0 or list[creepsId] == nil then
		return list
	end

	return list[creepsId]
end

function MoonKingConfig:getBattlePrizeCfgs(planId, index)
	planId = checknumber(planId)

	if self._battlePrizeCfgs == nil or self._battlePrizeCfgs[planId] == nil then
		return
	end

	index = checknumber(index)

	if index <= 0 or self._battlePrizeCfgs[planId][index] == nil then
		return self._battlePrizeCfgs[planId]
	end

	return self._battlePrizeCfgs[planId][index]
end

MoonKingConfig.instance = MoonKingConfig.New()

return MoonKingConfig
