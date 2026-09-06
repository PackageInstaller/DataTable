-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonmanclg/config/DragonManClgConfig.lua

module("logic.extensions.dragonmanclg.config.DragonManClgConfig", package.seeall)

local DragonManClgConfig = class("DragonManClgConfig", BaseConfig)

function DragonManClgConfig:getNames()
	return {
		"dragon_man_clg_buff_mark",
		"dragon_man_clg_creeps",
		"dragon_man_clg_activity",
		"dragon_man_clg_monster",
		"dragon_man_clg_stage",
		"dragon_man_clg_support_pet"
	}
end

function DragonManClgConfig:handleConfig(name, content)
	if name == "dragon_man_clg_buff_mark" then
		self._dragon_man_clg_buff_mark = content
	elseif name == "dragon_man_clg_creeps" then
		self._dragon_man_clg_creeps = content
	elseif name == "dragon_man_clg_activity" then
		self._dragon_man_clg_activity = content
	elseif name == "dragon_man_clg_monster" then
		self._dragon_man_clg_monster = content
	elseif name == "dragon_man_clg_stage" then
		self._dragon_man_clg_stage = content
	elseif name == "dragon_man_clg_support_pet" then
		self._dragon_man_clg_support_pet = content
	end
end

function DragonManClgConfig:getCreepCfgs(creepsMasterId)
	return self._dragon_man_clg_creeps[creepsMasterId]
end

function DragonManClgConfig:getTeamCfg(creepsMasterId)
	return self._dragon_man_clg_monster[creepsMasterId]
end

function DragonManClgConfig:getSupportPetCfgs(planId)
	return self._dragon_man_clg_support_pet[planId]
end

function DragonManClgConfig:getActivityCfg(activityId)
	return self._dragon_man_clg_activity[activityId]
end

function DragonManClgConfig:getBuffMarkCfgs(activityId)
	return self._dragon_man_clg_buff_mark[activityId]
end

function DragonManClgConfig:getMarkCfgById(activityId, markId)
	if self._dragon_man_clg_buff_mark[activityId] then
		return self._dragon_man_clg_buff_mark[activityId][markId]
	end
end

function DragonManClgConfig:getStageCfgs(activityId)
	return self._dragon_man_clg_stage[activityId]
end

function DragonManClgConfig:getStageCfgById(activityId, stageId)
	if self._dragon_man_clg_stage[activityId] then
		return self._dragon_man_clg_stage[activityId][stageId]
	end
end

DragonManClgConfig.instance = DragonManClgConfig.New()

return DragonManClgConfig
