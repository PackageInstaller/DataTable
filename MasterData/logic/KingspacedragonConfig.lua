-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingspacedragon/config/KingspacedragonConfig.lua

module("logic.extensions.kingspacedragon.config.KingspacedragonConfig", package.seeall)

local KingspacedragonConfig = class("KingspacedragonConfig", BaseConfig)

function KingspacedragonConfig:onInit()
	return
end

function KingspacedragonConfig:getNames()
	return {
		"king_space_dragon_clg_activity",
		"king_space_dragon_clg_stage",
		"king_space_dragon_clg_creeps_master",
		"king_space_dragon_clg_creeps"
	}
end

function KingspacedragonConfig:handleConfig(name, content)
	if name == "king_space_dragon_clg_activity" then
		self._king_space_dragon_clg_activity = content
	elseif name == "king_space_dragon_clg_stage" then
		self._king_space_dragon_clg_stage = content
	elseif name == "king_space_dragon_clg_creeps_master" then
		self._king_space_dragon_clg_creeps_master = content
	elseif name == "king_space_dragon_clg_creeps" then
		self._king_space_dragon_clg_creeps = content
	end
end

function KingspacedragonConfig:getActCfg(activityId)
	return self._king_space_dragon_clg_activity[activityId]
end

function KingspacedragonConfig:getStageCfgs(activityId)
	return self._king_space_dragon_clg_stage[activityId]
end

function KingspacedragonConfig:getStageCfg(activityId, stageId)
	return self._king_space_dragon_clg_stage[activityId][stageId]
end

function KingspacedragonConfig:getCreepsCfgs(creepsMasterId)
	return self._king_space_dragon_clg_creeps[creepsMasterId]
end

function KingspacedragonConfig:getMasterCfg(creepsMasterId)
	return self._king_space_dragon_clg_creeps_master[creepsMasterId]
end

function KingspacedragonConfig:getSkinId(activityId)
	return self._king_space_dragon_clg_activity[activityId].skinId
end

function KingspacedragonConfig:getRuleKey(activityId, ruleKey)
	return self._king_space_dragon_clg_activity[activityId][ruleKey]
end

KingspacedragonConfig.instance = KingspacedragonConfig.New()

return KingspacedragonConfig
