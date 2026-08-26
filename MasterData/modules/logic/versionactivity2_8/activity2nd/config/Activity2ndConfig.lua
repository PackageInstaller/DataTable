-- chunkname: @modules/logic/versionactivity2_8/activity2nd/config/Activity2ndConfig.lua

module("modules.logic.versionactivity2_8.activity2nd.config.Activity2ndConfig", package.seeall)

local Activity2ndConfig = class("Activity2ndConfig", BaseConfig)

function Activity2ndConfig:reqConfigNames()
	return {
		"activity196",
		"activity200",
		"activity196_const"
	}
end

function Activity2ndConfig:onInit()
	self._strDict = {}
	self._strList = {}
	self._act200config = {}
	self._act196const = {}
end

function Activity2ndConfig:onConfigLoaded(configName, configTable)
	if configName == "activity196" then
		for _, strCo in ipairs(configTable.configList) do
			self._strDict[strCo.code] = strCo.id
		end

		self._strList = configTable.configList
	elseif configName == "activity200" then
		self._act200config = configTable
	elseif configName == "activity196_const" then
		self._act196const = configTable
	end
end

function Activity2ndConfig:getIdByStr(str)
	return self._strDict[str]
end

function Activity2ndConfig:getStrList()
	return self._strList
end

function Activity2ndConfig:getAct200ConfigList()
	return self._act200config.configList
end

function Activity2ndConfig:getAct200ConfigById(id)
	return self._act200config.configList[id]
end

function Activity2ndConfig:getAct196ConstById(actId)
	return self._act196const.configDict[actId]
end

Activity2ndConfig.instance = Activity2ndConfig.New()

return Activity2ndConfig
