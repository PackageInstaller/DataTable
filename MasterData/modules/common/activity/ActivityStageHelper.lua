-- chunkname: @modules/common/activity/ActivityStageHelper.lua

module("modules.common.activity.ActivityStageHelper", package.seeall)

local ActivityStageHelper = class("ActivityStageHelper")
local activityStageDict = {}
local inited = false

function ActivityStageHelper.initActivityStage()
	inited = true

	local activityStageStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey), "")

	if not string.nilorempty(activityStageStr) then
		local activityStageList = string.split(activityStageStr, ";")
		local arr

		for _, activityStage in ipairs(activityStageList) do
			if not string.nilorempty(activityStage) then
				arr = string.splitToNumber(activityStage, "#")
				activityStageDict[arr[1]] = arr
			end
		end
	end
end

function ActivityStageHelper.checkActivityStageHasChange(actIdList)
	if not inited then
		ActivityStageHelper.initActivityStage()
	end

	for _, actId in ipairs(actIdList) do
		if ActivityStageHelper.checkOneActivityStageHasChange(actId) then
			return true
		end
	end
end

function ActivityStageHelper.checkOneActivityStageHasChange(actId)
	if not inited then
		ActivityStageHelper.initActivityStage()
	end

	local status = ActivityHelper.getActivityStatus(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	local arr = activityStageDict[actId]

	if not arr then
		return true
	end

	local activityInfo = ActivityModel.instance:getActivityInfo()[actId]

	if not activityInfo then
		return false
	end

	local activityIsOpen = activityInfo:isOpen() and 1 or 0
	local stage = activityInfo:getCurrentStage()
	local isUnlock = activityInfo:isUnlock() and 1 or 0

	return arr[2] ~= activityIsOpen or arr[3] ~= stage or arr[4] ~= isUnlock
end

function ActivityStageHelper.checkOneActivityNewOpen(actId)
	if not inited then
		ActivityStageHelper.initActivityStage()
	end

	local status = ActivityHelper.getActivityStatus(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	local arr = activityStageDict[actId]

	if not arr then
		return true
	end

	local activityInfo = ActivityModel.instance:getActivityInfo()[actId]

	if not activityInfo then
		return false
	end

	local activityIsOpen = activityInfo:isOpen() and 1 or 0

	return arr[2] ~= activityIsOpen
end

function ActivityStageHelper.recordActivityStage(actIdList)
	if not inited then
		ActivityStageHelper.initActivityStage()
	end

	for _, actId in ipairs(actIdList) do
		ActivityStageHelper.recordOneActivityStage(actId)
	end
end

function ActivityStageHelper.recordOneActivityStage(actId)
	if not inited then
		ActivityStageHelper.initActivityStage()
	end

	if not ActivityStageHelper.checkOneActivityStageHasChange(actId) then
		return
	end

	local activityStageStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey), "")
	local recorded = false
	local resultList = {}
	local activityStageList = string.split(activityStageStr, ";")
	local arr, currentActStageStr

	for _, activityStage in ipairs(activityStageList) do
		if not string.nilorempty(activityStage) then
			arr = string.splitToNumber(activityStage, "#")

			if arr and arr[1] == actId then
				recorded = true
				currentActStageStr = ActivityStageHelper._buildActPlayerPrefsString(actId)

				table.insert(resultList, currentActStageStr)
			else
				table.insert(resultList, activityStage)
			end
		end
	end

	if not recorded then
		currentActStageStr = ActivityStageHelper._buildActPlayerPrefsString(actId)

		table.insert(resultList, currentActStageStr)
	end

	activityStageDict[actId] = string.splitToNumber(currentActStageStr, "#")

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey), table.concat(resultList, ";"))
	ActivityController.instance:dispatchEvent(ActivityEvent.ChangeActivityStage)
end

function ActivityStageHelper._buildActPlayerPrefsString(actId)
	local activityInfo = ActivityModel.instance:getActivityInfo()[actId]

	if not activityInfo then
		return
	end

	return string.format("%s#%s#%s#%s", actId, activityInfo:isOpen() and 1 or 0, activityInfo:getCurrentStage(), activityInfo:isUnlock() and 1 or 0)
end

function ActivityStageHelper.clear()
	activityStageDict = {}
	inited = false
end

return ActivityStageHelper
