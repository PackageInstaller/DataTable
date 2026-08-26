-- chunkname: @modules/logic/versionactivity3_7/anniversary3/config/Anniversary3Config.lua

module("modules.logic.versionactivity3_7.anniversary3.config.Anniversary3Config", package.seeall)

local Anniversary3Config = class("Anniversary3Config", BaseConfig)

function Anniversary3Config:reqConfigNames()
	return {
		"anniversary_sign_in"
	}
end

function Anniversary3Config:onInit()
	self._signInConfig = {}
end

function Anniversary3Config:onConfigLoaded(configName, configTable)
	if configName == "anniversary_sign_in" then
		self._signInConfig = configTable
	end
end

function Anniversary3Config:getSignInCo(day, actId)
	actId = actId or VersionActivity3_7Enum.ActivityId.Anniversary3Sign

	return self._signInConfig.configDict[actId][day]
end

Anniversary3Config.instance = Anniversary3Config.New()

return Anniversary3Config
