-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/config/GodDarkDragonConfig.lua

module("logic.extensions.goddesscollector.config.GodDarkDragonConfig", package.seeall)

local GodDarkDragonConfig = class("GodDarkDragonConfig", BaseConfig)

function GodDarkDragonConfig:onInit()
	return
end

function GodDarkDragonConfig:getNames()
	return {
		"god_dark_dragon_activity",
		"god_dark_dragon_main_stage",
		"god_dark_dragon_buff_stage",
		"god_dark_dragon_team",
		"god_dark_dragon_creeps"
	}
end

function GodDarkDragonConfig:handleConfig(name, content)
	if name == "god_dark_dragon_activity" then
		self._god_dark_dragon_activity = content
	elseif name == "god_dark_dragon_main_stage" then
		self._god_dark_dragon_main_stage = content
	elseif name == "god_dark_dragon_buff_stage" then
		self._god_dark_dragon_buff_stage = content
	elseif name == "god_dark_dragon_team" then
		self._god_dark_dragon_team = content
	elseif name == "god_dark_dragon_creeps" then
		self._god_dark_dragon_creeps = content
	end
end

function GodDarkDragonConfig:getActivityCfg(activityId)
	return self._god_dark_dragon_activity[activityId]
end

function GodDarkDragonConfig:getMainStageCfgs(activityId)
	return self._god_dark_dragon_main_stage[activityId]
end

function GodDarkDragonConfig:getMainStageCfg(activityId, stageId)
	return self._god_dark_dragon_main_stage[activityId][stageId]
end

function GodDarkDragonConfig:getBuffStageCfgByActId(activityId)
	return self._god_dark_dragon_buff_stage[activityId]
end

function GodDarkDragonConfig:getBuffStageCfgByDay(activityId, day)
	return self._god_dark_dragon_buff_stage[activityId][day]
end

function GodDarkDragonConfig:getBuffStageCfg(activityId, day, stageId)
	return self._god_dark_dragon_buff_stage[activityId][day][stageId]
end

function GodDarkDragonConfig:getTeamCfg(creepsMasterId)
	return self._god_dark_dragon_team[creepsMasterId]
end

function GodDarkDragonConfig:getCreepsCfg(creepsMasterId)
	return self._god_dark_dragon_creeps[creepsMasterId]
end

GodDarkDragonConfig.instance = GodDarkDragonConfig.New()

return GodDarkDragonConfig
