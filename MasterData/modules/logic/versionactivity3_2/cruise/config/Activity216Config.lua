-- chunkname: @modules/logic/versionactivity3_2/cruise/config/Activity216Config.lua

module("modules.logic.versionactivity3_2.cruise.config.Activity216Config", package.seeall)

local Activity216Config = class("Activity216Config", BaseConfig)

function Activity216Config:ctor()
	self._taskConfig = nil
	self._onlyTaskConfig = nil
	self._onceBonusConfig = nil
	self._heroTypeConfig = nil
end

function Activity216Config:reqConfigNames()
	return {
		"activity216_task",
		"activity216_only_one_tasks",
		"activity216_once_bonus",
		"activity216_hero_circle"
	}
end

function Activity216Config:onConfigLoaded(configName, configTable)
	if configName == "activity216_task" then
		self._taskConfig = configTable
	elseif configName == "activity216_only_one_tasks" then
		self._onlyTaskConfig = configTable
	elseif configName == "activity216_once_bonus" then
		self._onceBonusConfig = configTable
	elseif configName == "activity216_hero_circle" then
		self._heroTypeConfig = configTable
	end
end

function Activity216Config:getTaskCO(taskId)
	return self._taskConfig.configDict[taskId]
end

function Activity216Config:getTaskCos()
	return self._taskConfig.configDict
end

function Activity216Config:getOnlyOneTasksCO(id)
	return self._onlyTaskConfig.configDict[id]
end

function Activity216Config:getOnlyOneTasksCos()
	return self._onlyTaskConfig.configDict
end

function Activity216Config:getOnceBonusCO(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseSelfTask

	return self._onceBonusConfig.configDict[actId]
end

function Activity216Config:getHeroRangeCos()
	return self._heroTypeConfig.configDict
end

function Activity216Config:getHeroRangeCo(id)
	return self._heroTypeConfig.configDict[id]
end

function Activity216Config:getHeros(id)
	local heroCo = self:getHeroRangeCo(id)

	if not heroCo then
		return {}
	end

	return string.splitToNumber(heroCo.heroId, "#")
end

Activity216Config.instance = Activity216Config.New()

return Activity216Config
