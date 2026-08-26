-- chunkname: @modules/logic/versionactivity1_7/lantern/config/LanternFestivalConfig.lua

module("modules.logic.versionactivity1_7.lantern.config.LanternFestivalConfig", package.seeall)

local LanternFestivalConfig = class("LanternFestivalConfig", BaseConfig)

function LanternFestivalConfig:reqConfigNames()
	return {
		"activity154",
		"activity154_options"
	}
end

function LanternFestivalConfig:onInit()
	self._actCfgDict = nil
	self._actOptions = {}
end

function LanternFestivalConfig:onConfigLoaded(configName, configTable)
	if configName == "activity154" then
		self._actCfgDict = configTable.configDict
	elseif configName == "activity154_options" then
		self._actOptions = configTable.configDict
	end
end

function LanternFestivalConfig:getAct154Co(actId, day)
	actId = actId or ActivityEnum.Activity.LanternFestival

	return self._actCfgDict[actId][day]
end

function LanternFestivalConfig:getPuzzleCo(puzzleId)
	for _, v in pairs(self._actCfgDict[ActivityEnum.Activity.LanternFestival]) do
		if v.puzzleId == puzzleId then
			return v
		end
	end

	return nil
end

function LanternFestivalConfig:getAct154Cos()
	return self._actCfgDict[ActivityEnum.Activity.LanternFestival]
end

function LanternFestivalConfig:getAct154Options(puzzleId)
	return self._actOptions[puzzleId]
end

LanternFestivalConfig.instance = LanternFestivalConfig.New()

return LanternFestivalConfig
