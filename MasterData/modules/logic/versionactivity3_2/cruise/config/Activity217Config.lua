-- chunkname: @modules/logic/versionactivity3_2/cruise/config/Activity217Config.lua

module("modules.logic.versionactivity3_2.cruise.config.Activity217Config", package.seeall)

local Activity217Config = class("Activity217Config", BaseConfig)

function Activity217Config:ctor()
	self._controlConfig = nil
	self._bonusConfig = nil
	self._actIdList = {}
end

function Activity217Config:reqConfigNames()
	return {
		"activity217_control",
		"activity217_bonus",
		"activity220_sub_type"
	}
end

function Activity217Config:onConfigLoaded(configName, configTable)
	if configName == "activity217_control" then
		self._controlConfig = configTable

		self:_initActIdList()
	elseif configName == "activity217_bonus" then
		self._bonusConfig = configTable
	end
end

function Activity217Config:getControlCO(controlId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

	return self._controlConfig.configDict[actId][controlId]
end

function Activity217Config:getControlCos(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

	return self._controlConfig.configDict[actId]
end

function Activity217Config:getBonusCO(episodeId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

	return self._bonusConfig.configDict[actId][episodeId]
end

function Activity217Config:getSubTypeCO(actId)
	actId = actId or ActivityEnum.Activity.V3a6_DoubleDrop

	return lua_activity220_sub_type.configDict[actId]
end

function Activity217Config:_initActIdList()
	for index, co in ipairs(self._controlConfig.configList) do
		if not tabletool.indexOf(self._actIdList, co.activityId) then
			table.insert(self._actIdList, co.activityId)
		end
	end
end

function Activity217Config:getActIdList()
	return self._actIdList
end

Activity217Config.instance = Activity217Config.New()

return Activity217Config
