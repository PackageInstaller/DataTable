-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activity/model/ActivityModel.lua

module("logic.extensions.activity.model.ActivityModel", package.seeall)

local M = class("ActivityModel", BaseModel)

function M:ctor()
	self._activityDataList = nil
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._activityDataList = {}
end

function M:getActivityDataList()
	return self._activityDataList
end

function M:getActivityById(activityId)
	for i, activityData in ipairs(self._activityDataList) do
		if activityData:getId() == activityId then
			return activityData
		end
	end

	return false
end

function M:refreshActivity(activity)
	local activityId = activity.id
	local activityData = self:getActivityById(activityId)

	if activityData then
		activityData:refreshData(activity)
	else
		local activityClass = ActivityController.instance:getActivityClass(activity.logic, activity.config)

		activityData = activityClass.New(activity)

		table.insert(self._activityDataList, activityData)
	end

	activityData:setIsOpen(true)

	return activityData:getType()
end

function M:getActivityByType(activityType)
	for i, activityData in ipairs(self._activityDataList) do
		if activityData:getType() == activityType then
			return activityData
		end
	end

	return false
end

function M:closeActivity(closeId)
	local activityData = self:getActivityById(closeId)

	if activityData then
		activityData:setIsOpen(false)

		return activityData:getType()
	end

	return nil
end

function M:getActivityList(activityType, planIds)
	if not activityType or not planIds or #planIds <= 0 then
		return
	end

	local activityList = {}

	for i, activityData in ipairs(self._activityDataList) do
		if activityData:getType() == activityType then
			for i = 1, #planIds do
				local planId = planIds[i]

				if activityData:getConfigId() == planId then
					table.insert(activityList, activityData)
				end
			end
		end
	end

	return activityList
end

M.instance = M.New()

return M
