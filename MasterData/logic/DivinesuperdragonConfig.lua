-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinesuperdragon/config/DivinesuperdragonConfig.lua

module("logic.extensions.divinesuperdragon.config.DivinesuperdragonConfig", package.seeall)

local DivinesuperdragonConfig = class("DivinesuperdragonConfig", BaseConfig)

function DivinesuperdragonConfig:onInit()
	return
end

function DivinesuperdragonConfig:getNames()
	return {
		"divine_super_dragon_clg",
		"divine_super_dragon_clg_buff_stage",
		"divine_super_dragon_clg_super_stage",
		"divine_super_dragon_clg_creeps_master",
		"divine_super_dragon_clg_creeps"
	}
end

function DivinesuperdragonConfig:handleConfig(name, content)
	if name == "divine_super_dragon_clg" then
		self._divine_super_dragon_clg = content
	elseif name == "divine_super_dragon_clg_buff_stage" then
		self._divine_super_dragon_clg_buff_stage = content
	elseif name == "divine_super_dragon_clg_super_stage" then
		self._divine_super_dragon_clg_super_stage = content
	elseif name == "divine_super_dragon_clg_creeps_master" then
		self._divine_super_dragon_clg_creeps_master = content
	elseif name == "divine_super_dragon_clg_creeps" then
		self._divine_super_dragon_clg_creeps = content
	end
end

function DivinesuperdragonConfig:getActCfg(activityId)
	return self._divine_super_dragon_clg[activityId]
end

function DivinesuperdragonConfig:getSkinId(activityId)
	return self._divine_super_dragon_clg[activityId].skinId
end

function DivinesuperdragonConfig:getRuleKey(activityId, ruleKey)
	return self._divine_super_dragon_clg[activityId][ruleKey]
end

function DivinesuperdragonConfig:getBuffStageCfgs(activityId)
	return self._divine_super_dragon_clg_buff_stage[activityId]
end

function DivinesuperdragonConfig:getBuffStageCfg(activityId, stageId)
	return self._divine_super_dragon_clg_buff_stage[activityId][stageId]
end

function DivinesuperdragonConfig:getMasterCfgById(creepsMasterId)
	return self._divine_super_dragon_clg_creeps_master[creepsMasterId]
end

function DivinesuperdragonConfig:getCreepsCfgs(creepsMasterId)
	return self._divine_super_dragon_clg_creeps[creepsMasterId]
end

function DivinesuperdragonConfig:getBuffStageIdByCreepsMasterId(activityId, creepsMasterId)
	for i, v in ipairs(self._divine_super_dragon_clg_buff_stage[activityId]) do
		if v.creepsMasterId == creepsMasterId then
			return v.stageId
		end
	end

	return 0
end

function DivinesuperdragonConfig:getSuperStageCfgs(activityId)
	return self._divine_super_dragon_clg_super_stage[activityId]
end

function DivinesuperdragonConfig:getSuperStageCfg(activityId, stageId)
	return self._divine_super_dragon_clg_super_stage[activityId][stageId]
end

DivinesuperdragonConfig.instance = DivinesuperdragonConfig.New()

return DivinesuperdragonConfig
