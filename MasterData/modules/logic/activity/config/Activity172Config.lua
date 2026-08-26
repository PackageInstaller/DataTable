-- chunkname: @modules/logic/activity/config/Activity172Config.lua

module("modules.logic.activity.config.Activity172Config", package.seeall)

local Activity172Config = class("Activity172Config", BaseConfig)

function Activity172Config:ctor()
	self._act172Task = nil
end

function Activity172Config:reqConfigNames()
	return {
		"activity172_task"
	}
end

function Activity172Config:onConfigLoaded(configName, configTable)
	if configName == "activity172_task" then
		self._act172Task = configTable
	end
end

function Activity172Config:getAct172TaskById(id)
	return self._act172Task.configDict[id]
end

Activity172Config.instance = Activity172Config.New()

return Activity172Config
