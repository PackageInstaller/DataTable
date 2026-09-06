-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/config/DivinelongyanConfig.lua

module("logic.extensions.divinelongyan.config.DivinelongyanConfig", package.seeall)

local DivinelongyanConfig = class("DivinelongyanConfig", BaseConfig)

function DivinelongyanConfig:onInit()
	return
end

function DivinelongyanConfig:getNames()
	return {
		"divine_longyan_challenge_activity",
		"divine_longyan_challenge_power_stage",
		"divine_longyan_challenge_support_level",
		"divine_longyan_challenge_skill_strategy",
		"divine_longyan_challenge_line_stage",
		"divine_longyan_challenge_team",
		"divine_longyan_challenge_creeps",
		"divine_longyan_challenge_support"
	}
end

function DivinelongyanConfig:handleConfig(name, content)
	if name == "divine_longyan_challenge_activity" then
		self._divine_longyan_challenge_activity = content
	elseif name == "divine_longyan_challenge_power_stage" then
		self._divine_longyan_challenge_power_stage = content
	elseif name == "divine_longyan_challenge_support_level" then
		self._divine_longyan_challenge_support_level = content
	elseif name == "divine_longyan_challenge_skill_strategy" then
		self._divine_longyan_challenge_skill_strategy = content
	elseif name == "divine_longyan_challenge_line_stage" then
		self._divine_longyan_challenge_line_stage = content
	elseif name == "divine_longyan_challenge_team" then
		self._divine_longyan_challenge_team = content
	elseif name == "divine_longyan_challenge_creeps" then
		self._divine_longyan_challenge_creeps = content
	elseif name == "divine_longyan_challenge_support" then
		self._divine_longyan_challenge_support = content
	end
end

function DivinelongyanConfig:getActCfg(activityId)
	return self._divine_longyan_challenge_activity[activityId]
end

function DivinelongyanConfig:getSkinId(activityId)
	if self._divine_longyan_challenge_activity[activityId] then
		return self._divine_longyan_challenge_activity[activityId].skinId
	end
end

function DivinelongyanConfig:getRuleKey(activityId, ruleKey)
	if self._divine_longyan_challenge_activity[activityId] then
		return self._divine_longyan_challenge_activity[activityId][ruleKey]
	end
end

function DivinelongyanConfig:getMasterCfgById(creepsMasterId)
	return self._divine_longyan_challenge_team[creepsMasterId]
end

function DivinelongyanConfig:getCreepsCfgs(creepsMasterId)
	return self._divine_longyan_challenge_creeps[creepsMasterId]
end

function DivinelongyanConfig:getPowerStageCfgs(activityId, day)
	if self._divine_longyan_challenge_power_stage[activityId] then
		return self._divine_longyan_challenge_power_stage[activityId][day]
	end
end

function DivinelongyanConfig:getPowerStageCfgMaxDay(activityId)
	return #self._divine_longyan_challenge_power_stage[activityId]
end

function DivinelongyanConfig:getLineStageCfgs(activityId)
	return self._divine_longyan_challenge_line_stage[activityId]
end

function DivinelongyanConfig:getSupportPetCfg(supportPetId)
	return self._divine_longyan_challenge_support[supportPetId]
end

function DivinelongyanConfig:getSupportPetLevel(activityId, level)
	local obj = self:getSupportPetLevelCfg(activityId, level)

	if obj then
		return obj.petLevel
	end

	return 1
end

function DivinelongyanConfig:getSupportPetLevelCfgs(activityId)
	return self._divine_longyan_challenge_support_level[activityId]
end

function DivinelongyanConfig:getSupportPetLevelCfg(activityId, level)
	if self._divine_longyan_challenge_support_level[activityId] then
		return self._divine_longyan_challenge_support_level[activityId][level]
	end
end

function DivinelongyanConfig:getSkillCfgList(activityId, skillType)
	local serType = CharacterConfig.skillTypeMap[skillType]
	local obj = self._divine_longyan_challenge_skill_strategy[activityId]

	if obj then
		return obj[serType] or {}
	end

	return {}
end

function DivinelongyanConfig:getAllSkillCfgList(activityId)
	local obj = self._divine_longyan_challenge_skill_strategy[activityId]

	return obj or {}
end

DivinelongyanConfig.instance = DivinelongyanConfig.New()

return DivinelongyanConfig
