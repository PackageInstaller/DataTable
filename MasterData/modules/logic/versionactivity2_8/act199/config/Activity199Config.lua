-- chunkname: @modules/logic/versionactivity2_8/act199/config/Activity199Config.lua

module("modules.logic.versionactivity2_8.act199.config.Activity199Config", package.seeall)

local Activity199Config = class("Activity199Config", BaseConfig)

function Activity199Config:reqConfigNames()
	return {
		"activity199"
	}
end

function Activity199Config:onInit()
	return
end

function Activity199Config:onConfigLoaded(configName, configTable)
	if configName == "activity199" then
		self._summonNewPickConfig = configTable
	end
end

function Activity199Config:getSummonConfigById(activityId)
	return self._summonNewPickConfig.configDict[activityId]
end

Activity199Config.instance = Activity199Config.New()

return Activity199Config
