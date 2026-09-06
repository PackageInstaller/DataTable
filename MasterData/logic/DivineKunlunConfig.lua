-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/config/DivineKunlunConfig.lua

module("logic.extensions.divinekunlun.config.DivineKunlunConfig", package.seeall)

local DivineKunlunConfig = class("DivineKunlunConfig", BaseConfig)

function DivineKunlunConfig:getNames()
	return {
		"divine_kun_lun_clg_creeps",
		"divine_kun_lun_clg_normal_stage",
		"divine_kun_lun_clg_extreme_stage",
		"divine_kun_lun_clg_monster",
		"divine_kun_lun_clg_sys_pet",
		"divine_kun_lun_clg_normal_progress_prize",
		"divine_kun_lun_clg_activity"
	}
end

function DivineKunlunConfig:handleConfig(name, content)
	if name == "divine_kun_lun_clg_creeps" then
		self._divine_kun_lun_clg_creeps = content
	elseif name == "divine_kun_lun_clg_normal_stage" then
		self._divine_kun_lun_clg_normal_stage = content
	elseif name == "divine_kun_lun_clg_extreme_stage" then
		self._divine_kun_lun_clg_extreme_stage = content
	elseif name == "divine_kun_lun_clg_monster" then
		self._divine_kun_lun_clg_monster = content
	elseif name == "divine_kun_lun_clg_sys_pet" then
		self._divine_kun_lun_clg_sys_pet = content
	elseif name == "divine_kun_lun_clg_normal_progress_prize" then
		self._divine_kun_lun_clg_normal_progress_prize = content
	elseif name == "divine_kun_lun_clg_activity" then
		self._divine_kun_lun_clg_activity = content
	end
end

function DivineKunlunConfig:getActivityCfgById(activityId)
	return self._divine_kun_lun_clg_activity[activityId]
end

function DivineKunlunConfig:getNormalCfgListById(activityId)
	return self._divine_kun_lun_clg_normal_stage[activityId]
end

function DivineKunlunConfig:getNormalCfgById(activityId, stageId)
	if self._divine_kun_lun_clg_normal_stage[activityId] then
		return self._divine_kun_lun_clg_normal_stage[activityId][stageId]
	end
end

function DivineKunlunConfig:getProgressCfgById(activityId)
	return self._divine_kun_lun_clg_normal_progress_prize[activityId]
end

function DivineKunlunConfig:getExtremeCfgListById(activityId)
	return self._divine_kun_lun_clg_extreme_stage[activityId]
end

function DivineKunlunConfig:getExtremeCfgById(activityId, stageId)
	if self._divine_kun_lun_clg_extreme_stage[activityId] then
		return self._divine_kun_lun_clg_extreme_stage[activityId][stageId]
	end
end

function DivineKunlunConfig:getAllPet()
	return self._divine_kun_lun_clg_sys_pet.dataList
end

function DivineKunlunConfig:getSysPetById(id)
	return self._divine_kun_lun_clg_sys_pet[id]
end

function DivineKunlunConfig:getMonsterCfg(creepsMasterId)
	return self._divine_kun_lun_clg_monster[creepsMasterId]
end

function DivineKunlunConfig:getCreeps(creepsMasterId)
	return self._divine_kun_lun_clg_creeps[creepsMasterId]
end

DivineKunlunConfig.instance = DivineKunlunConfig.New()

return DivineKunlunConfig
