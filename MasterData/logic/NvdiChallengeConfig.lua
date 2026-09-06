-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/config/NvdiChallengeConfig.lua

module("logic.extensions.nvdi.config.NvdiChallengeConfig", package.seeall)

local NvdiChallengeConfig = class("NvdiChallengeConfig", BaseConfig)

function NvdiChallengeConfig:getNames()
	return {
		"empress_clg_activity",
		"empress_clg_activity_common",
		"empress_extreme_clg_stage",
		"empress_extreme_clg_buff",
		"empress_normal_clg_stage_group",
		"empress_clg_support_pet",
		"empress_normal_clg_progress",
		"empress_clg_creeps_master",
		"empress_clg_creeps"
	}
end

function NvdiChallengeConfig:handleConfig(name, content)
	if name == "empress_clg_activity" then
		self._empress_clg_activity = content
	elseif name == "empress_clg_activity_common" then
		self._empress_clg_activity_common = content
	elseif name == "empress_extreme_clg_stage" then
		self._empress_extreme_clg_stage = content
	elseif name == "empress_extreme_clg_buff" then
		self._empress_extreme_clg_buff = content
	elseif name == "empress_normal_clg_stage_group" then
		self._empress_normal_clg_stage_group = content
	elseif name == "empress_clg_support_pet" then
		self._empress_clg_support_pet = content
	elseif name == "empress_normal_clg_progress" then
		self._empress_normal_clg_progress = content
	elseif name == "empress_clg_creeps_master" then
		self._empress_clg_creeps_master = content
	elseif name == "empress_clg_creeps" then
		self._empress_clg_creeps = content
	end
end

function NvdiChallengeConfig:getCommonCfgById(key)
	if self._empress_clg_activity_common[key] then
		return self._empress_clg_activity_common[key].value
	end

	return ""
end

function NvdiChallengeConfig:getActivityCfgById(id)
	return self._empress_clg_activity[id]
end

function NvdiChallengeConfig:getStageCfgList(id)
	return self._empress_extreme_clg_stage[id]
end

function NvdiChallengeConfig:getStageCfgById(id, stageId)
	if self._empress_extreme_clg_stage[id] then
		return self._empress_extreme_clg_stage[id][stageId]
	end
end

function NvdiChallengeConfig:getBuffCfgList(id)
	return self._empress_extreme_clg_buff[id]
end

function NvdiChallengeConfig:getBuffCfgById(id, buffId)
	if self._empress_extreme_clg_buff[id] then
		return self._empress_extreme_clg_buff[id][buffId]
	end
end

function NvdiChallengeConfig:getGroupCfgList(id, groupId)
	if self._empress_normal_clg_stage_group[id] then
		return self._empress_normal_clg_stage_group[id][groupId]
	end
end

function NvdiChallengeConfig:getGroupCfgById(id, groupId, dataBitId)
	local cfg = self:getGroupCfgList(id, groupId)

	if cfg then
		return cfg[dataBitId]
	end

	return nil
end

function NvdiChallengeConfig:getSupportPetCfgById(id)
	return self._empress_clg_support_pet[id]
end

function NvdiChallengeConfig:getProgressCfgById(id)
	return self._empress_normal_clg_progress[id]
end

function NvdiChallengeConfig:getMonsterCfgById(id)
	return self._empress_clg_creeps_master[id]
end

function NvdiChallengeConfig:getCreepsCfgById(id)
	return self._empress_clg_creeps[id]
end

NvdiChallengeConfig.instance = NvdiChallengeConfig.New()

return NvdiChallengeConfig
