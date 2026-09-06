-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/config/DivineYuHuiConfig.lua

module("logic.extensions.divineyuhui.config.DivineYuHuiConfig", package.seeall)

local DivineYuHuiConfig = class("DivineYuHuiConfig", BaseConfig)

function DivineYuHuiConfig:getNames()
	return {
		"divine_yu_hui_clg_activity",
		"divine_yu_hui_clg_stage",
		"divine_yu_hui_clg_monster",
		"divine_yu_hui_clg_creeps"
	}
end

function DivineYuHuiConfig:handleConfig(name, content)
	if name == "divine_yu_hui_clg_activity" then
		self._divine_yu_hui_clg_activity = content
	elseif name == "divine_yu_hui_clg_stage" then
		self._divine_yu_hui_clg_stage = content
	elseif name == "divine_yu_hui_clg_monster" then
		self._divine_yu_hui_clg_monster = content
	elseif name == "divine_yu_hui_clg_creeps" then
		self._divine_yu_hui_clg_creeps = content
	end
end

function DivineYuHuiConfig:getActCfg(activityId)
	return self._divine_yu_hui_clg_activity[activityId]
end

function DivineYuHuiConfig:getStageCfg(activityId)
	return self._divine_yu_hui_clg_stage[activityId]
end

function DivineYuHuiConfig:getStageCfgByStageId(activityId, stageId)
	return self._divine_yu_hui_clg_stage[activityId] and self._divine_yu_hui_clg_stage[activityId][stageId]
end

function DivineYuHuiConfig:getStageCfg(activityId)
	return self._divine_yu_hui_clg_stage[activityId]
end

function DivineYuHuiConfig:getMasterCfg(creepsMasterId)
	return self._divine_yu_hui_clg_monster[creepsMasterId]
end

function DivineYuHuiConfig:getCreepCfg(creepsMasterId)
	return self._divine_yu_hui_clg_creeps[creepsMasterId]
end

function DivineYuHuiConfig:getCreepMasterId(activityId, stageId)
	local stageCfg = self:getStageCfgByStageId(activityId, stageId) or {}

	return stageCfg.creepsMasterId
end

DivineYuHuiConfig.instance = DivineYuHuiConfig.New()

return DivineYuHuiConfig
