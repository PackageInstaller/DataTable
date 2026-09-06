-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemiruikeclg/config/DivineMiRuiKeClgConfig.lua

module("logic.extensions.divinemiruikeclg.config.DivineMiRuiKeClgConfig", package.seeall)

local DivineMiRuiKeClgConfig = class("DivineMiRuiKeClgConfig", BaseConfig)

function DivineMiRuiKeClgConfig:onInit()
	DivineMiRuiKeClgConfig.super.onInit(self)
end

function DivineMiRuiKeClgConfig:getNames()
	return {
		"divine_mi_rui_ke_clg",
		"divine_mi_rui_ke_clg_phase",
		"divine_mi_rui_ke_clg_stage",
		"divine_mi_rui_ke_clg_buff",
		"divine_mi_rui_ke_clg_support_pet",
		"divine_mi_rui_ke_clg_creeps_master",
		"divine_mi_rui_ke_clg_creeps",
		"divine_mi_rui_ke_clg_common"
	}
end

function DivineMiRuiKeClgConfig:handleConfig(name, content)
	if name == "divine_mi_rui_ke_clg" then
		self.divine_mi_rui_ke_clg = content
	elseif name == "divine_mi_rui_ke_clg_phase" then
		self.divine_mi_rui_ke_clg_phase = content
	elseif name == "divine_mi_rui_ke_clg_stage" then
		self.divine_mi_rui_ke_clg_stage = content
	elseif name == "divine_mi_rui_ke_clg_buff" then
		self.divine_mi_rui_ke_clg_buff = content
	elseif name == "divine_mi_rui_ke_clg_support_pet" then
		self.divine_mi_rui_ke_clg_support_pet = content
	elseif name == "divine_mi_rui_ke_clg_creeps_master" then
		self.divine_mi_rui_ke_clg_creeps_master = content
	elseif name == "divine_mi_rui_ke_clg_creeps" then
		self.divine_mi_rui_ke_clg_creeps = content
	elseif name == "divine_mi_rui_ke_clg_common" then
		self.divine_mi_rui_ke_clg_common = content
	end
end

function DivineMiRuiKeClgConfig:getActivityCfg(activityId)
	return self.divine_mi_rui_ke_clg[activityId]
end

function DivineMiRuiKeClgConfig:getPhaseCfgList(activityId)
	return self.divine_mi_rui_ke_clg_phase[activityId] or {}
end

function DivineMiRuiKeClgConfig:getPhaseCfg(activityId, phaseId)
	return self.divine_mi_rui_ke_clg_phase[activityId] and self.divine_mi_rui_ke_clg_phase[activityId][phaseId]
end

function DivineMiRuiKeClgConfig:getStageCfgList(activityId, phaseId)
	return self.divine_mi_rui_ke_clg_stage[activityId] and self.divine_mi_rui_ke_clg_stage[activityId][phaseId]
end

function DivineMiRuiKeClgConfig:getStageCfg(activityId, phaseId, stageId)
	return self.divine_mi_rui_ke_clg_stage[activityId] and self.divine_mi_rui_ke_clg_stage[activityId][phaseId] and self.divine_mi_rui_ke_clg_stage[activityId][phaseId][stageId]
end

function DivineMiRuiKeClgConfig:getBuffList(activityId)
	local list = {}

	for i, v in ipairs(self.divine_mi_rui_ke_clg_buff.dataList) do
		if v.activityId == activityId then
			table.insert(list, v)
		end
	end

	return list
end

function DivineMiRuiKeClgConfig:getSupportPets(activityId)
	return self.divine_mi_rui_ke_clg_support_pet[activityId] or {}
end

function DivineMiRuiKeClgConfig:getSupportPet(activityId, creepsId)
	return self.divine_mi_rui_ke_clg_support_pet[activityId] and self.divine_mi_rui_ke_clg_support_pet[activityId][creepsId]
end

function DivineMiRuiKeClgConfig:getMonsterCfg(creepsMasterId)
	return self.divine_mi_rui_ke_clg_creeps_master[creepsMasterId]
end

function DivineMiRuiKeClgConfig:getCreeps(creepsMasterId)
	return self.divine_mi_rui_ke_clg_creeps[creepsMasterId]
end

function DivineMiRuiKeClgConfig:getCommonValue(key)
	return self.divine_mi_rui_ke_clg_common and self.divine_mi_rui_ke_clg_common[key].value
end

DivineMiRuiKeClgConfig.instance = DivineMiRuiKeClgConfig.New()

return DivineMiRuiKeClgConfig
