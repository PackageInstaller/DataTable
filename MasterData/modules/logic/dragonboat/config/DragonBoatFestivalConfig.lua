-- chunkname: @modules/logic/dragonboat/config/DragonBoatFestivalConfig.lua

module("modules.logic.dragonboat.config.DragonBoatFestivalConfig", package.seeall)

local DragonBoatFestivalConfig = class("DragonBoatFestivalConfig", BaseConfig)

function DragonBoatFestivalConfig:reqConfigNames()
	return {
		"activity101_dragonboat"
	}
end

function DragonBoatFestivalConfig:onInit()
	self._dragonConfig = nil
end

function DragonBoatFestivalConfig:onConfigLoaded(configName, configTable)
	if configName == "activity101_dragonboat" then
		self._dragonConfig = configTable
	end
end

function DragonBoatFestivalConfig:getDragonBoatCos()
	local actId = ActivityEnum.Activity.DragonBoatFestival

	return self._dragonConfig.configDict[actId]
end

function DragonBoatFestivalConfig:getDragonBoatCo(day)
	local actId = ActivityEnum.Activity.DragonBoatFestival

	return self._dragonConfig.configDict[actId][day]
end

DragonBoatFestivalConfig.instance = DragonBoatFestivalConfig.New()

return DragonBoatFestivalConfig
