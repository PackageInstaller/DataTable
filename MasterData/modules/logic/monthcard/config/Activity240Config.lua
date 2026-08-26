-- chunkname: @modules/logic/monthcard/config/Activity240Config.lua

module("modules.logic.monthcard.config.Activity240Config", package.seeall)

local Activity240Config = class("Activity240Config", BaseConfig)

function Activity240Config:ctor()
	self._act240Co = nil
	self._act240BackdateCo = nil
	self._act240TaskCo = nil
end

function Activity240Config:reqConfigNames()
	return {
		"activity240",
		"activity240_backdate",
		"activity240_task"
	}
end

function Activity240Config:onConfigLoaded(configName, configTable)
	if configName == "activity240" then
		self._act240Co = configTable
	elseif configName == "activity240_backdate" then
		self._act240BackdateCo = configTable
	elseif configName == "activity240_task" then
		self._act240TaskCo = configTable
	end
end

function Activity240Config:getActivity240Cos(actId)
	actId = actId or VersionActivity3_8Enum.ActivityId.FreeMonthCard

	return self._act240Co.configDict[actId]
end

function Activity240Config:getActivity240Co(id, actId)
	actId = actId or VersionActivity3_8Enum.ActivityId.FreeMonthCard

	return self._act240Co.configDict[actId][id]
end

function Activity240Config:getActivity240BackdateCo(actId)
	actId = actId or VersionActivity3_8Enum.ActivityId.FreeMonthCard

	return self._act240BackdateCo.configDict[actId]
end

function Activity240Config:getActivity240TaskCos(actId)
	actId = actId or VersionActivity3_8Enum.ActivityId.FreeMonthCard

	local taskCos = {}

	for _, v in pairs(self._act240TaskCo.configDict) do
		if v.activityId == actId then
			table.insert(taskCos, v)
		end
	end

	return taskCos
end

function Activity240Config:getActivity240TaskCo(id)
	return self._act240TaskCo.configDict[id]
end

Activity240Config.instance = Activity240Config.New()

return Activity240Config
