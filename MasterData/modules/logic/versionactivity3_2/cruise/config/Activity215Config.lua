-- chunkname: @modules/logic/versionactivity3_2/cruise/config/Activity215Config.lua

module("modules.logic.versionactivity3_2.cruise.config.Activity215Config", package.seeall)

local Activity215Config = class("Activity215Config", BaseConfig)

function Activity215Config:ctor()
	self._constConfig = nil
	self._mainstageConfig = nil
	self._stageConfig = nil
	self._milestoneBonusConfig = nil
end

function Activity215Config:reqConfigNames()
	return {
		"activity215_const",
		"activity215_main_stage",
		"activity215_stage",
		"activity215_milestone_bonus"
	}
end

function Activity215Config:onConfigLoaded(configName, configTable)
	if configName == "activity215_const" then
		self._constConfig = configTable
	elseif configName == "activity215_main_stage" then
		self._mainstageConfig = configTable
	elseif configName == "activity215_stage" then
		self._stageConfig = configTable
	elseif configName == "activity215_milestone_bonus" then
		self._milestoneBonusConfig = configTable
	end
end

function Activity215Config:getConstCO(constId)
	return self._constConfig.configDict[constId]
end

function Activity215Config:getMainStageCO(stageId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	return self._mainstageConfig.configDict[actId][stageId]
end

function Activity215Config:getStageCO(stageId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	return self._stageConfig.configDict[actId][stageId]
end

function Activity215Config:getStageCos(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	return self._stageConfig.configDict[actId]
end

function Activity215Config:getMileStoneBonusCO(bonusId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	return self._milestoneBonusConfig.configDict[actId][bonusId]
end

function Activity215Config:getMileStoneBonusCos(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseGlobalTask

	return self._milestoneBonusConfig.configDict[actId]
end

Activity215Config.instance = Activity215Config.New()

return Activity215Config
