-- chunkname: @modules/logic/activity/config/Activity106Config.lua

module("modules.logic.activity.config.Activity106Config", package.seeall)

local Activity106Config = class("Activity106Config", BaseConfig)

function Activity106Config:ctor()
	self._act106Task = nil
	self._act106Order = nil
	self._act106MiniGame = nil
end

function Activity106Config:reqConfigNames()
	return {
		"activity106_task",
		"activity106_order",
		"activity106_minigame"
	}
end

function Activity106Config:onConfigLoaded(configName, configTable)
	if configName == "activity106_task" then
		self._act106Task = configTable
	elseif configName == "activity106_order" then
		self._act106Order = configTable
	elseif configName == "activity106_minigame" then
		self._act106MiniGame = configTable
	end
end

function Activity106Config:getActivityWarmUpTaskCo(id)
	return self._act106Task.configDict[id]
end

function Activity106Config:getTaskByActId(actId)
	local list = {}

	for _, co in ipairs(self._act106Task.configList) do
		if co.activityId == actId then
			table.insert(list, co)
		end
	end

	return list
end

function Activity106Config:getActivityWarmUpAllOrderCo(actId)
	return self._act106Order.configDict[actId]
end

function Activity106Config:getActivityWarmUpOrderCo(actId, id)
	return self._act106Order.configDict[actId][id]
end

function Activity106Config:getMiniGameSettings(id)
	return self._act106MiniGame.configDict[id]
end

Activity106Config.instance = Activity106Config.New()

return Activity106Config
