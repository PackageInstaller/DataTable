-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/config/DivineNuoYaChallengeConfig.lua

module("logic.extensions.divinenuoyachallenge.config.DivineNuoYaChallengeConfig", package.seeall)

local DivineNuoYaChallengeConfig = class("DivineNuoYaChallengeConfig", BaseConfig)

function DivineNuoYaChallengeConfig:onInit()
	DivineNuoYaChallengeConfig.super.onInit(self)

	self.divine_nuo_ya_clg_activity = nil
	self.divine_nuo_ya_clg_support_pet = nil
	self.divine_nuo_ya_normal_clg_stage = nil
	self.divine_nuo_ya_extreme_clg_stage = nil
	self.divine_nuo_ya_extreme_clg_monster = nil
	self.divine_nuo_ya_clg_creeps_master = nil
	self.divine_nuo_ya_clg_creeps = nil
end

function DivineNuoYaChallengeConfig:getNames()
	return {
		"divine_nuo_ya_clg_activity",
		"divine_nuo_ya_clg_support_pet",
		"divine_nuo_ya_normal_clg_stage",
		"divine_nuo_ya_extreme_clg_stage",
		"divine_nuo_ya_extreme_clg_monster",
		"divine_nuo_ya_clg_creeps_master",
		"divine_nuo_ya_clg_creeps"
	}
end

function DivineNuoYaChallengeConfig:handleConfig(name, content)
	if name == "divine_nuo_ya_clg_activity" then
		self.divine_nuo_ya_clg_activity = content
	elseif name == "divine_nuo_ya_clg_support_pet" then
		self.divine_nuo_ya_clg_support_pet = content
	elseif name == "divine_nuo_ya_normal_clg_stage" then
		self.divine_nuo_ya_normal_clg_stage = content
	elseif name == "divine_nuo_ya_extreme_clg_stage" then
		self.divine_nuo_ya_extreme_clg_stage = content
	elseif name == "divine_nuo_ya_extreme_clg_monster" then
		self.divine_nuo_ya_extreme_clg_monster = content
	elseif name == "divine_nuo_ya_clg_creeps_master" then
		self.divine_nuo_ya_clg_creeps_master = content
	elseif name == "divine_nuo_ya_clg_creeps" then
		self.divine_nuo_ya_clg_creeps = content
	end
end

function DivineNuoYaChallengeConfig:getActivityCfg(id)
	return self.divine_nuo_ya_clg_activity[id]
end

function DivineNuoYaChallengeConfig:getSupportPetPlanIdList(activityId)
	return self.divine_nuo_ya_clg_support_pet[activityId]
end

function DivineNuoYaChallengeConfig:getSupportPetList(activityId, planId)
	return self.divine_nuo_ya_clg_support_pet[activityId] and self.divine_nuo_ya_clg_support_pet[activityId][planId]
end

function DivineNuoYaChallengeConfig:getNormalStageList(activityId)
	return self.divine_nuo_ya_normal_clg_stage[activityId]
end

function DivineNuoYaChallengeConfig:getNormalStage(activityId, stageId)
	return self.divine_nuo_ya_normal_clg_stage[activityId] and self.divine_nuo_ya_normal_clg_stage[activityId][stageId]
end

function DivineNuoYaChallengeConfig:getExtremeStageList(activityId)
	return self.divine_nuo_ya_extreme_clg_stage[activityId]
end

function DivineNuoYaChallengeConfig:getExtremeStage(activityId, stageId)
	return self.divine_nuo_ya_extreme_clg_stage[activityId] and self.divine_nuo_ya_extreme_clg_stage[activityId][stageId]
end

function DivineNuoYaChallengeConfig:getMonsterList(activityId, stageId)
	return self.divine_nuo_ya_extreme_clg_monster[activityId] and self.divine_nuo_ya_extreme_clg_monster[activityId][stageId]
end

function DivineNuoYaChallengeConfig:getMonster(activityId, stageId, monsterId)
	return self.divine_nuo_ya_extreme_clg_monster[activityId] and self.divine_nuo_ya_extreme_clg_monster[activityId][stageId] and self.divine_nuo_ya_extreme_clg_monster[activityId][stageId][monsterId]
end

function DivineNuoYaChallengeConfig:getMaster(creepsMasterId)
	return self.divine_nuo_ya_clg_creeps_master[creepsMasterId]
end

function DivineNuoYaChallengeConfig:getCreeps(creepsMasterId)
	return self.divine_nuo_ya_clg_creeps[creepsMasterId]
end

DivineNuoYaChallengeConfig.instance = DivineNuoYaChallengeConfig.New()

return DivineNuoYaChallengeConfig
