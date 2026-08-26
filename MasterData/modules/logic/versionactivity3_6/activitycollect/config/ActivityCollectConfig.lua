-- chunkname: @modules/logic/versionactivity3_6/activitycollect/config/ActivityCollectConfig.lua

module("modules.logic.versionactivity3_6.activitycollect.config.ActivityCollectConfig", package.seeall)

local ActivityCollectConfig = class("ActivityCollectConfig", BaseConfig)

function ActivityCollectConfig:reqConfigNames()
	return {
		"activity_publicity"
	}
end

function ActivityCollectConfig:onInit()
	self._publicityconfig = {}
end

function ActivityCollectConfig:onConfigLoaded(configName, configTable)
	if configName == "activity_publicity" then
		self._publicityconfig = configTable
	end
end

function ActivityCollectConfig:getPublicityCfg(id, actId)
	actId = actId or ActivityCollectModel.instance:getCurActivityId()

	return self._publicityconfig.configDict[actId][id]
end

ActivityCollectConfig.instance = ActivityCollectConfig.New()

return ActivityCollectConfig
