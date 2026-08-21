-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activity/controller/ActivityController.lua

module("logic.extensions.activity.controller.ActivityController", package.seeall)

local M = class("ActivityController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._activityClassMap = {}

	self:_registActivityDynDataClass()
end

function M:_registActivityDynDataClass()
	self._activityClassMap[ActivityEnum.LogicType.LOTTERY] = RetrieveActivityData
	self._activityClassMap[ActivityEnum.LogicType.SIGN_IN_HISTORY] = WelfareSigninActivityData
	self._activityClassMap[ActivityEnum.LogicType.SCORE] = ActivityIntegralDropActivityData
	self._activityClassMap[ActivityEnum.LogicType.HERO_EARLY_ACCESS] = RoleExperienceData
	self._activityClassMap[ActivityEnum.LogicType.CLIP_DOLL] = ClawDollActivityData
	self._activityClassMap[ActivityEnum.LogicType.WEEKEND_SUPPLIES] = WeekendSupplyActivityData
	self._activityClassMap[ActivityEnum.LogicType.POWER_CHALLENGE] = PowerChallengeData
	self._activityClassMap[ActivityEnum.LogicType.DUNGEON_REWARD_UP] = MultipleDropActivityData
end

function M:getActivityClass(logicType, configId)
	local isWelfareActivity = WelfareConfig.instance:isActivityTab(logicType, configId)
	local baseClass = isWelfareActivity and ActivityWelfareData or ActivityData

	return self._activityClassMap[logicType] or baseClass
end

function M:refreshActivity(activities, closes)
	activities = activities or {}
	closes = closes or {}

	local typeList = {}

	for i, activity in ipairs(activities) do
		local type = ActivityModel.instance:refreshActivity(activity)

		if not table.indexof(typeList, type) then
			table.insert(typeList, type)
		end
	end

	for i, closeId in ipairs(closes) do
		ItemModel.instance:setCloseActivityNumber(closeId)

		local type = ActivityModel.instance:closeActivity(closeId)

		if type and not table.indexof(typeList, type) then
			table.insert(typeList, type)
		end
	end

	for i, type in ipairs(typeList) do
		GlobalDispatcher:dispatchEvent(EventType.ACTIVITY_REFRESH + type)
	end

	GlobalDispatcher:dispatchEvent(EventType.ACTIVITY_ALL_REFRESH)
end

function M:getActivityById(activityId)
	return ActivityModel.instance:getActivityById(activityId)
end

function M:getActivityByLogicTypeAndCode(logicType, code)
	local activityDataList = ActivityModel.instance:getActivityDataList()

	for i, activityData in ipairs(activityDataList) do
		if activityData:getType() == logicType and activityData:getIsOpen() and activityData:getConfigId() == code then
			return activityData
		end
	end

	return false
end

function M:getActivitiesByLogicType(logicType)
	local tempActivityList = {}
	local activityDataList = ActivityModel.instance:getActivityDataList()

	for i, activityData in ipairs(activityDataList) do
		if activityData:getType() == logicType and activityData:getIsOpen() then
			table.insert(tempActivityList, activityData)
		end
	end

	return tempActivityList
end

function M:hasRedDot()
	local activityRedDot = RedDotModel.instance:getDotIsActive(GameEnum.RedPointEnum.Activity)
	local activityTaskRedDot = RedDotModel.instance:getDotIsActive(GameEnum.RedPointEnum.ActivityTask)

	return activityRedDot or activityTaskRedDot or false
end

M.instance = M.New()

return M
