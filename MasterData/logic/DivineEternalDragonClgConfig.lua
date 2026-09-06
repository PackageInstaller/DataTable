-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineeternaldragonclg/config/DivineEternalDragonClgConfig.lua

module("logic.extensions.divineeternaldragonclg.config.DivineEternalDragonClgConfig", package.seeall)

local DivineEternalDragonClgConfig = class("DivineEternalDragonClgConfig", BaseConfig)

function DivineEternalDragonClgConfig:getNames()
	return {
		"divine_eternal_dragon_clg_stage",
		"divine_eternal_dragon_clg_monster",
		"divine_eternal_dragon_clg_activity",
		"divine_eternal_dragon_clg_creeps"
	}
end

function DivineEternalDragonClgConfig:handleConfig(name, content)
	if name == "divine_eternal_dragon_clg_stage" then
		self._divine_eternal_dragon_clg_stage = content
	elseif name == "divine_eternal_dragon_clg_monster" then
		self._divine_eternal_dragon_clg_monster = content
	elseif name == "divine_eternal_dragon_clg_activity" then
		self._divine_eternal_dragon_clg_activity = content
	elseif name == "divine_eternal_dragon_clg_creeps" then
		self._divine_eternal_dragon_clg_creeps = content
	end
end

function DivineEternalDragonClgConfig:getActivityCfg(activityId)
	return self._divine_eternal_dragon_clg_activity[activityId]
end

function DivineEternalDragonClgConfig:getStageCfgs(activityId)
	return self._divine_eternal_dragon_clg_stage[activityId]
end

function DivineEternalDragonClgConfig:getStageCfgByStageId(activityId, stageId)
	return self._divine_eternal_dragon_clg_stage[activityId][stageId]
end

function DivineEternalDragonClgConfig:getCreepCfg(creepsMasterId)
	return self._divine_eternal_dragon_clg_creeps[creepsMasterId]
end

function DivineEternalDragonClgConfig:getCreepMonsterCfg(creepsMasterId)
	return self._divine_eternal_dragon_clg_monster[creepsMasterId]
end

DivineEternalDragonClgConfig.instance = DivineEternalDragonClgConfig.New()

return DivineEternalDragonClgConfig
