-- chunkname: @modules/logic/versionactivity1_6/act152/config/Activity152Config.lua

module("modules.logic.versionactivity1_6.act152.config.Activity152Config", package.seeall)

local Activity152Config = class("Activity152Config", BaseConfig)

function Activity152Config:ctor()
	self._activityConfig = {}
end

function Activity152Config:reqConfigNames()
	return {
		"activity152"
	}
end

function Activity152Config:onConfigLoaded(configName, configTable)
	if configName == "activity152" then
		self._activityConfig = configTable.configDict
	end
end

function Activity152Config:getAct152Co(id)
	return self._activityConfig[ActivityEnum.Activity.NewYearEve][id]
end

function Activity152Config:getAct152Cos()
	return self._activityConfig[ActivityEnum.Activity.NewYearEve]
end

Activity152Config.instance = Activity152Config.New()

return Activity152Config
