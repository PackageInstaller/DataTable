-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedisorderdragon/config/DivinedisorderdragonConfig.lua

module("logic.extensions.divinedisorderdragon.config.DivinedisorderdragonConfig", package.seeall)

local DivinedisorderdragonConfig = class("DivinedisorderdragonConfig", BaseConfig)

function DivinedisorderdragonConfig:onInit()
	return
end

function DivinedisorderdragonConfig:getNames()
	return {
		"divine_disorder_dragon_stage",
		"divine_disorder_dragon_creeps",
		"divine_disorder_dragon_monster",
		"divine_disorder_dragon_activity"
	}
end

function DivinedisorderdragonConfig:handleConfig(name, content)
	if name == "divine_disorder_dragon_stage" then
		self._divine_disorder_dragon_stage = content
	elseif name == "divine_disorder_dragon_creeps" then
		self._divine_disorder_dragon_creeps = content
	elseif name == "divine_disorder_dragon_monster" then
		self._divine_disorder_dragon_monster = content
	elseif name == "divine_disorder_dragon_activity" then
		self._divine_disorder_dragon_activity = content
	end
end

function DivinedisorderdragonConfig:getActivityCfg(activityId)
	return self._divine_disorder_dragon_activity[activityId]
end

function DivinedisorderdragonConfig:getStageCfgs(activityId)
	return self._divine_disorder_dragon_stage[activityId]
end

function DivinedisorderdragonConfig:getStageCfg(activityId, stageId)
	return self._divine_disorder_dragon_stage[activityId][stageId]
end

function DivinedisorderdragonConfig:getTeamCfg(creepsMasterId)
	return self._divine_disorder_dragon_monster[creepsMasterId]
end

function DivinedisorderdragonConfig:getCreepsCfg(creepsMasterId)
	return self._divine_disorder_dragon_creeps[creepsMasterId]
end

DivinedisorderdragonConfig.instance = DivinedisorderdragonConfig.New()

return DivinedisorderdragonConfig
