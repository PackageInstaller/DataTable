-- chunkname: @modules/logic/versionactivity2_4/act181/config/Activity181Config.lua

module("modules.logic.versionactivity2_4.act181.config.Activity181Config", package.seeall)

local Activity181Config = class("Activity181Config", BaseConfig)

function Activity181Config:reqConfigNames()
	return {
		"activity181_box",
		"activity181_boxlist"
	}
end

function Activity181Config:onInit()
	return
end

function Activity181Config:onConfigLoaded(configName, configTable)
	if configName == "activity181_box" then
		self.activity181Config = configTable
	elseif configName == "activity181_boxlist" then
		self.activity181BonusConfig = configTable

		self:initBoxListConfig()
	end
end

function Activity181Config:getBoxConfig(activityId)
	if not self.activity181Config then
		return nil
	end

	return self.activity181Config.configDict[activityId]
end

function Activity181Config:initBoxListConfig()
	self._activityBoxListDic = {}

	for _, config in ipairs(self.activity181BonusConfig.configList) do
		local configList = self._activityBoxListDic[config.activityId]

		if not configList then
			configList = {}
			self._activityBoxListDic[config.activityId] = configList
		end

		table.insert(configList, config.id)
	end
end

function Activity181Config:getBoxListConfig(activityId, boxId)
	if self.activity181BonusConfig.configDict[activityId] then
		return self.activity181BonusConfig.configDict[activityId][boxId]
	end

	return nil
end

function Activity181Config:getBoxListByActivityId(activityId)
	return self._activityBoxListDic[activityId]
end

Activity181Config.instance = Activity181Config.New()

return Activity181Config
