-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/observerbox/config/ObserverBoxConfig.lua

module("modules.logic.versionactivity3_4.laplaceforum.observerbox.config.ObserverBoxConfig", package.seeall)

local ObserverBoxConfig = class("ObserverBoxConfig", BaseConfig)

function ObserverBoxConfig:ctor()
	self._boxConfig = nil
	self._boxListConfig = nil
	self._taskConfig = nil
end

function ObserverBoxConfig:reqConfigNames()
	return {
		"activity226_box",
		"activity226_boxlist",
		"activity226_task"
	}
end

function ObserverBoxConfig:onConfigLoaded(configName, configTable)
	if configName == "activity226_box" then
		self._boxConfig = configTable
	elseif configName == "activity226_boxlist" then
		self._boxListConfig = configTable
	elseif configName == "activity226_task" then
		self._taskConfig = configTable
	end
end

function ObserverBoxConfig:getBoxCO(actId)
	local id = actId or VersionActivity3_4Enum.ActivityId.LaplaceObserverBox

	return self._boxConfig.configDict[id]
end

function ObserverBoxConfig:getBoxListCos(actId)
	local id = actId or VersionActivity3_4Enum.ActivityId.LaplaceObserverBox

	return self._boxListConfig.configDict[id]
end

function ObserverBoxConfig:getBoxListPageCos(pageId, actId)
	local id = actId or VersionActivity3_4Enum.ActivityId.LaplaceObserverBox

	return self._boxListConfig.configDict[id][pageId]
end

function ObserverBoxConfig:getBoxListPageCo(rewardId, pageId, actId)
	local id = actId or VersionActivity3_4Enum.ActivityId.LaplaceObserverBox

	return self._boxListConfig.configDict[id][pageId][rewardId]
end

function ObserverBoxConfig:getTaskCo(taskId)
	return self._taskConfig.configDict[taskId]
end

ObserverBoxConfig.instance = ObserverBoxConfig.New()

return ObserverBoxConfig
