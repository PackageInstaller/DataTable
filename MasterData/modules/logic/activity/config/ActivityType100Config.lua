-- chunkname: @modules/logic/activity/config/ActivityType100Config.lua

module("modules.logic.activity.config.ActivityType100Config", package.seeall)

local ActivityType100Config = class("ActivityType100Config", BaseConfig)

function ActivityType100Config:reqConfigNames()
	return {
		"activity_const",
		"warmup_h5"
	}
end

local function _getWarmUpH5CO(activityId)
	return lua_warmup_h5.configDict[activityId]
end

function ActivityType100Config:onConfigLoaded(configName, configTable)
	return
end

function ActivityType100Config:getWarmUpH5ActIdList(fallback)
	return ActivityConfig.instance:getConstAsNumList(3, "#", fallback or {})
end

function ActivityType100Config:getWarmUpH5Link(actId)
	local CO = _getWarmUpH5CO(actId)

	if not CO then
		return
	end

	return SettingsModel.instance:extractByRegion(CO.link)
end

function ActivityType100Config:getWarmUpH5BgResUrl(actId, fallback)
	local CO = _getWarmUpH5CO(actId)

	if not CO then
		return fallback
	end

	return string.nilorempty(CO.bgResUrl) and fallback or CO.bgResUrl
end

ActivityType100Config.instance = ActivityType100Config.New()

return ActivityType100Config
