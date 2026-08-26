-- chunkname: @modules/logic/versionactivity3_7/anniversary3/config/Activity233Config.lua

module("modules.logic.versionactivity3_7.anniversary3.config.Activity233Config", package.seeall)

local Activity233Config = class("Activity233Config", BaseConfig)

function Activity233Config:ctor()
	self._bpConfig = {}
	self._bonusConfig = {}
	self._taskConfig = {}
end

function Activity233Config:reqConfigNames()
	return {
		"activity233_bp",
		"activity233_lv_bonus",
		"activity233_task"
	}
end

function Activity233Config:onConfigLoaded(configName, configTable)
	if configName == "activity233_bp" then
		self._bpConfig = configTable
	elseif configName == "activity233_lv_bonus" then
		self._bonusConfig = configTable
	elseif configName == "activity233_task" then
		self._taskConfig = configTable
	end
end

function Activity233Config:getBpCo(bpId)
	return self._bpConfig.configDict[bpId]
end

function Activity233Config:getLevelScore(bpId)
	local co = self:getBpCo(bpId)

	if not co then
		return 1000
	end

	return co.expLevelUp
end

function Activity233Config:getBonusCos(bpId)
	bpId = bpId or 1

	return self._bonusConfig.configDict[bpId]
end

function Activity233Config:getBonusCo(lv, bpId)
	bpId = bpId or 1

	return self._bonusConfig.configDict[bpId][lv]
end

function Activity233Config:getTaskCo(taskId)
	return self._taskConfig.configDict[taskId]
end

Activity233Config.instance = Activity233Config.New()

return Activity233Config
