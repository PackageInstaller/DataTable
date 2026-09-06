-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/psychicedtower/config/PsychicedTowerConfig.lua

module("logic.extensions.psychicedtower.config.PsychicedTowerConfig", package.seeall)

local PsychicedTowerConfig = class("PsychicedTowerConfig", BaseConfig)

function PsychicedTowerConfig:onInit()
	PsychicedTowerConfig.super.onInit(self)
end

function PsychicedTowerConfig:getNames()
	return {
		"psychiced_tower_activity",
		"psychiced_tower_tower",
		"psychiced_tower_stage",
		"psychiced_tower_stage_buff",
		"psychiced_tower_daily_buff",
		"psychiced_tower_support",
		"psychiced_tower_team",
		"psychiced_tower_creeps"
	}
end

function PsychicedTowerConfig:handleConfig(name, content)
	if name == "psychiced_tower_activity" then
		self._psychiced_tower_activity = content
	elseif name == "psychiced_tower_tower" then
		self._psychiced_tower_tower = content
	elseif name == "psychiced_tower_stage" then
		self._psychiced_tower_stage = content
	elseif name == "psychiced_tower_stage_buff" then
		self._psychiced_tower_stage_buff = content

		self:handleStageBuff()
	elseif name == "psychiced_tower_daily_buff" then
		self._psychiced_tower_daily_buff = content
	elseif name == "psychiced_tower_support" then
		self._psychiced_tower_support = content
	elseif name == "psychiced_tower_team" then
		self._psychiced_tower_team = content
	elseif name == "psychiced_tower_creeps" then
		self._psychiced_tower_creeps = content
	end
end

function PsychicedTowerConfig:getActivityCfg(activityId)
	return self._psychiced_tower_activity[activityId]
end

function PsychicedTowerConfig:getTowerCfgs(activityId)
	return self._psychiced_tower_tower[activityId]
end

function PsychicedTowerConfig:getTowerCfg(activityId, towerId)
	return self._psychiced_tower_tower[activityId][towerId]
end

function PsychicedTowerConfig:getStageCfgs(activityId, towerId)
	return self._psychiced_tower_stage[activityId][towerId]
end

function PsychicedTowerConfig:getStageCfg(activityId, towerId, stageId)
	return self._psychiced_tower_stage[activityId][towerId][stageId]
end

function PsychicedTowerConfig:handleStageBuff()
	self._buffMaxStar = {}

	for i, cfgs_1 in ipairs(self._psychiced_tower_stage_buff) do
		local maxStar = 0

		for j, cfgs_2 in ipairs(cfgs_1) do
			local maxCfg = cfgs_2[#cfgs_2]

			maxStar = maxStar + maxCfg.starNum
		end

		self._buffMaxStar[i] = maxStar
	end
end

function PsychicedTowerConfig:getStageBuff(buffPlanId)
	return self._psychiced_tower_stage_buff[buffPlanId]
end

function PsychicedTowerConfig:getMaxStar(buffPlanId)
	return self._buffMaxStar[buffPlanId]
end

function PsychicedTowerConfig:getSupportPetCfg(petId)
	return self._psychiced_tower_support[petId]
end

function PsychicedTowerConfig:getDailyBuffs(activityId, towerId)
	return self._psychiced_tower_daily_buff[activityId][towerId]
end

function PsychicedTowerConfig:getDailyBuff(activityId, towerId, buffLevel)
	return self._psychiced_tower_daily_buff[activityId][towerId][buffLevel]
end

function PsychicedTowerConfig:getTeamCfg(creepsMasterId)
	return self._psychiced_tower_team[creepsMasterId]
end

function PsychicedTowerConfig:getCreepsCfg(creepsMasterId)
	return self._psychiced_tower_creeps[creepsMasterId]
end

PsychicedTowerConfig.instance = PsychicedTowerConfig.New()

return PsychicedTowerConfig
