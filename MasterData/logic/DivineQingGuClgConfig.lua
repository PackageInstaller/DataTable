-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineqingguclg/config/DivineQingGuClgConfig.lua

module("logic.extensions.divineqingguclg.config.DivineQingGuClgConfig", package.seeall)

local DivineQingGuClgConfig = class("DivineQingGuClgConfig", BaseConfig)

function DivineQingGuClgConfig:onInit()
	DivineQingGuClgConfig.super.onInit(self)
end

function DivineQingGuClgConfig:getNames()
	return {
		"divine_qing_gu_clg",
		"divine_qing_gu_clg_stage",
		"divine_qing_gu_clg_creeps_master",
		"divine_qing_gu_clg_creeps",
		"divine_qing_gu_clg_common"
	}
end

function DivineQingGuClgConfig:handleConfig(name, content)
	if name == "divine_qing_gu_clg" then
		self.divine_qing_gu_clg = content
	elseif name == "divine_qing_gu_clg_stage" then
		self.divine_qing_gu_clg_stage = content
	elseif name == "divine_qing_gu_clg_creeps_master" then
		self.divine_qing_gu_clg_creeps_master = content
	elseif name == "divine_qing_gu_clg_creeps" then
		self.divine_qing_gu_clg_creeps = content
	elseif name == "divine_qing_gu_clg_common" then
		self.divine_qing_gu_clg_common = content
	end
end

function DivineQingGuClgConfig:getActivityCfg(activityId)
	return self.divine_qing_gu_clg[activityId]
end

function DivineQingGuClgConfig:getStageList(activityId)
	return self.divine_qing_gu_clg_stage[activityId]
end

function DivineQingGuClgConfig:getStage(activityId, stageId)
	return self.divine_qing_gu_clg_stage[activityId] and self.divine_qing_gu_clg_stage[activityId][stageId]
end

function DivineQingGuClgConfig:getMaster(creepsMasterId)
	return self.divine_qing_gu_clg_creeps_master[creepsMasterId]
end

function DivineQingGuClgConfig:getCreeps(creepsMasterId)
	return self.divine_qing_gu_clg_creeps[creepsMasterId]
end

function DivineQingGuClgConfig:getCommonValue(key)
	return self.divine_qing_gu_clg_common[key] and self.divine_qing_gu_clg_common[key].value
end

DivineQingGuClgConfig.instance = DivineQingGuClgConfig.New()

return DivineQingGuClgConfig
