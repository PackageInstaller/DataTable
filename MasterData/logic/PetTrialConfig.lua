-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettrial/config/PetTrialConfig.lua

module("logic.extensions.pettrial.config.PetTrialConfig", package.seeall)

local PetTrialConfig = class("PetTrialConfig", BaseConfig)

function PetTrialConfig:onInit()
	PetTrialConfig.super.onInit(self)

	self._stageCfg = nil
	self._teamCfg = nil
	self._creepsCfg = nil
end

function PetTrialConfig:getNames()
	return {
		"pet_trial_stage",
		"pet_trial_team",
		"pet_trial_creeps",
		"king_load_stage",
		"king_load_creeps"
	}
end

function PetTrialConfig:handleConfig(name, content)
	if name == "king_load_stage" then
		self._stageCfg = content
	elseif name == "pet_trial_team" then
		self._teamCfg = content
	elseif name == "king_load_creeps" then
		self._creepsCfg = content
	end
end

function PetTrialConfig:getStageCfgById(id)
	return self._stageCfg[id]
end

function PetTrialConfig:getStateCfgs()
	return self._stageCfg.dataList
end

function PetTrialConfig:getTeamCfgByKeys(key1, key2)
	if self._teamCfg and self._teamCfg[key1] then
		return self._teamCfg[key1][key2]
	end

	return nil
end

function PetTrialConfig:getTeamCfgs(id)
	return self._teamCfg[id]
end

function PetTrialConfig:getCreepCfg(key1, key2)
	return self._creepsCfg[key1][key2]
end

function PetTrialConfig:getCreepCfgByStageId(stageId)
	local cfg = self:getStageCfgById(stageId)

	if cfg then
		return self._creepsCfg[cfg.creepsMasterId]
	else
		return nil
	end
end

PetTrialConfig.instance = PetTrialConfig.New()

return PetTrialConfig
