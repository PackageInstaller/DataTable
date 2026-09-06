-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegoddragonclg/config/DivineGodDragonClgConfig.lua

module("logic.extensions.divinegoddragonclg.config.DivineGodDragonClgConfig", package.seeall)

local DivineGodDragonClgConfig = class("DivineGodDragonClgConfig", BaseConfig)

function DivineGodDragonClgConfig:onInit()
	DivineGodDragonClgConfig.super.onInit(self)
end

function DivineGodDragonClgConfig:getNames()
	return {
		"divine_god_dragon_activity",
		"divine_god_dragon_stage",
		"divine_god_dragon_buff",
		"divine_god_dragon_progress",
		"divine_god_dragon_team",
		"divine_god_dragon_creeps",
		"divine_god_dragon_support"
	}
end

function DivineGodDragonClgConfig:handleConfig(name, content)
	if name == "divine_god_dragon_activity" then
		self._divine_god_dragon_activity = content
	elseif name == "divine_god_dragon_stage" then
		self._divine_god_dragon_stage = content
	elseif name == "divine_god_dragon_buff" then
		self._divine_god_dragon_buff = content
	elseif name == "divine_god_dragon_progress" then
		self._divine_god_dragon_progress = content
	elseif name == "divine_god_dragon_team" then
		self._divine_god_dragon_team = content
	elseif name == "divine_god_dragon_creeps" then
		self._divine_god_dragon_creeps = content
	elseif name == "divine_god_dragon_support" then
		self._divine_god_dragon_support = content
	end
end

function DivineGodDragonClgConfig:getActivityCfg(activityId)
	return self._divine_god_dragon_activity[activityId]
end

function DivineGodDragonClgConfig:getStageCfgs(activityId)
	return self._divine_god_dragon_stage[activityId]
end

function DivineGodDragonClgConfig:getStageCfg(activityId, stageId)
	return self._divine_god_dragon_stage[activityId][stageId]
end

function DivineGodDragonClgConfig:getBuffCfg(activityId, day)
	return self._divine_god_dragon_buff[activityId][day]
end

function DivineGodDragonClgConfig:getBuffCfgs(activityId)
	return self._divine_god_dragon_buff[activityId]
end

function DivineGodDragonClgConfig:getRewardProgressListCfgs(activityId)
	return self._divine_god_dragon_progress[activityId]
end

function DivineGodDragonClgConfig:getTeamCfg(creepsMasterId)
	return self._divine_god_dragon_team[creepsMasterId]
end

function DivineGodDragonClgConfig:getCreepsCfg(creepsMasterId)
	return self._divine_god_dragon_creeps[creepsMasterId]
end

function DivineGodDragonClgConfig:getSupportCfg(creepsId)
	return self._divine_god_dragon_support[creepsId]
end

function DivineGodDragonClgConfig:getRewardProgressListCfg(activityId, prizeId)
	return self._divine_god_dragon_progress[activityId][prizeId]
end

DivineGodDragonClgConfig.instance = DivineGodDragonClgConfig.New()

return DivineGodDragonClgConfig
