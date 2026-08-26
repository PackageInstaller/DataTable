-- chunkname: @modules/versionactivitybase/enterview/controller/VersionActivityEnterHelper.lua

module("modules.versionactivitybase.enterview.controller.VersionActivityEnterHelper", package.seeall)

local VersionActivityEnterHelper = class("VersionActivityEnterHelper")

function VersionActivityEnterHelper.getTabIndex(actSettingList, actId)
	if actId and actId > 0 then
		for i, v in ipairs(actSettingList) do
			if VersionActivityEnterHelper.checkIsSameAct(v, actId) then
				return i
			end
		end
	end

	return 1
end

function VersionActivityEnterHelper.checkIsSameAct(actSetting, actId)
	if actSetting.actType == VersionActivityEnterViewEnum.ActType.Single then
		return actSetting.actId == actId
	end

	for _, v in ipairs(actSetting.actId) do
		if v == actId then
			return true
		end
	end

	return false
end

function VersionActivityEnterHelper.getActId(actSetting)
	if actSetting.actType == VersionActivityEnterViewEnum.ActType.Single then
		return actSetting.actId
	end

	for _, v in ipairs(actSetting.actId) do
		local status = ActivityHelper.getActivityStatus(v)

		if status ~= ActivityEnum.ActivityStatus.Expired and status ~= ActivityEnum.ActivityStatus.NotOnLine then
			return v
		end
	end

	return actSetting.actId[1]
end

function VersionActivityEnterHelper.getActIdList(actSettingList)
	local result = {}

	if actSettingList then
		for _, actMo in ipairs(actSettingList) do
			local actId = VersionActivityEnterHelper.getActId(actMo)

			if actId then
				result[#result + 1] = actId
			end
		end
	end

	return result
end

local function _isCanRemoveActTabById(actId)
	local status = ActivityHelper.getActivityStatus(actId)

	return status == ActivityEnum.ActivityStatus.Expired or status == ActivityEnum.ActivityStatus.NotOnLine
end

function VersionActivityEnterHelper.isActTabCanRemove(actSetting)
	if not actSetting then
		return true
	end

	if actSetting.actType == VersionActivityEnterViewEnum.ActType.Single then
		if actSetting.storeId then
			if not _isCanRemoveActTabById(actSetting.actId) then
				return false
			end

			if not _isCanRemoveActTabById(actSetting.storeId) then
				return false
			end

			return true
		else
			return _isCanRemoveActTabById(actSetting.actId)
		end
	end

	for _, v in ipairs(actSetting.actId) do
		if not _isCanRemoveActTabById(v) then
			return false
		end
	end

	return true
end

function VersionActivityEnterHelper.checkCanOpen(actId)
	local result = true
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, toastParam)
		end

		result = false
	end

	return result
end

return VersionActivityEnterHelper
