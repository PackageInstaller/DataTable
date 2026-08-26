-- chunkname: @modules/logic/activitywelfare/config/Activity160Config.lua

module("modules.logic.activitywelfare.config.Activity160Config", package.seeall)

local Activity160Config = class("Activity160Config", BaseConfig)

function Activity160Config:ctor()
	return
end

function Activity160Config:reqConfigNames()
	return {
		"activity160_mission"
	}
end

function Activity160Config:onConfigLoaded(configName, configTable)
	if configName == "activity160_mission" then
		self._missionConfig = configTable
	end
end

function Activity160Config:getActivityMissions(actId)
	actId = actId or ActivityEnum.Activity.NewWelfare

	return self._missionConfig.configDict[actId]
end

function Activity160Config:getMissionConfig(id, actId)
	actId = actId or ActivityEnum.Activity.NewWelfare
	id = id or 1

	return self._missionConfig.configDict[actId][id]
end

Activity160Config.instance = Activity160Config.New()

return Activity160Config
