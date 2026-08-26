-- chunkname: @modules/common/activity/ActivityHelper.lua

module("modules.common.activity.ActivityHelper", package.seeall)

local ActivityHelper = class("ActivityHelper")

function ActivityHelper.getActivityStatus(actId, noError)
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo then
		if not noError then
			logError(string.format("not found ActivityId : %s activity", actId))
		end

		return ActivityEnum.ActivityStatus.None
	end

	if not actInfoMo:isOpen() then
		return ActivityEnum.ActivityStatus.NotOpen
	end

	if actInfoMo:isExpired() then
		return ActivityEnum.ActivityStatus.Expired
	end

	if actInfoMo.config then
		local openId = actInfoMo.config.openId

		if openId and openId ~= 0 and not OpenModel.instance:isFunctionUnlock(openId) then
			return ActivityEnum.ActivityStatus.NotUnlock
		end

		if not actInfoMo:isOnline() then
			return ActivityEnum.ActivityStatus.NotOnLine
		end

		return ActivityEnum.ActivityStatus.Normal
	end
end

function ActivityHelper.isOpen(actId)
	return ActivityHelper.getActivityStatus(actId, true) == ActivityEnum.ActivityStatus.Normal
end

function ActivityHelper.getActivityStatusAndToast(actId, noError)
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo then
		if not noError then
			logError(string.format("not found ActivityId : %s activity", actId))
		end

		return ActivityEnum.ActivityStatus.None
	end

	if not actInfoMo:isOpen() then
		return ActivityEnum.ActivityStatus.NotOpen, ToastEnum.ActivityNotOpen
	end

	if actInfoMo:isExpired() then
		return ActivityEnum.ActivityStatus.Expired, ToastEnum.ActivityEnd
	end

	if actInfoMo.config then
		local openId = actInfoMo.config.openId

		if openId and openId ~= 0 and not OpenModel.instance:isFunctionUnlock(openId) then
			local toastId, toastParamList = OpenHelper.getToastIdAndParam(openId)

			return ActivityEnum.ActivityStatus.NotUnlock, toastId, toastParamList
		end

		if not actInfoMo:isOnline() then
			return ActivityEnum.ActivityStatus.NotOnLine, ToastEnum.ActivityEnd
		end

		return ActivityEnum.ActivityStatus.Normal
	end
end

function ActivityHelper.getActivityRemainTimeStr(activityId, useEn)
	local leftSecond = ActivityModel.instance:getRemainTimeSec(activityId)

	if leftSecond then
		if leftSecond >= 0 then
			return TimeUtil.SecondToActivityTimeFormat(leftSecond, useEn)
		else
			return luaLang("turnback_end")
		end
	end

	return ""
end

local _activityIdToVersionDict, _jumpNeedCloseViewDict

function ActivityHelper.initActivityVersion()
	if not _activityIdToVersionDict then
		_activityIdToVersionDict = {}
		_jumpNeedCloseViewDict = {}

		ActivityHelper._loadAllDefineVersionActivityEnum()
		ActivityHelper._loadVersionActivityEnum(2, 9)
		ActivityHelper._loadVersionActivityEnum(3, 10)
	end
end

function ActivityHelper._loadAllDefineVersionActivityEnum()
	local smallVersionBegin = 1

	for bigVersion = 1, math.huge do
		for smallVersion = smallVersionBegin, math.huge do
			local enum = ActivityHelper._loadVersionActivityEnum(bigVersion, smallVersion)

			if smallVersion == 0 and not enum then
				return
			elseif not enum then
				break
			end
		end

		smallVersionBegin = 0
	end
end

function ActivityHelper._loadVersionActivityEnum(bigVersion, smallVersion)
	local clsName = string.format("VersionActivity%d_%dEnum", bigVersion, smallVersion)

	if bigVersion == 1 and smallVersion == 1 then
		clsName = "VersionActivityEnum"
	end

	local enum = _G[clsName]

	if not enum then
		return
	end

	if isDebugBuild then
		logNormal("自动加载" .. clsName)
	end

	if enum.ActivityId then
		local version = string.format("%d_%d", bigVersion, smallVersion)

		for name, id in pairs(enum.ActivityId) do
			_activityIdToVersionDict[id] = _activityIdToVersionDict[id] or version
		end
	end

	if enum.JumpNeedCloseView then
		for _, viewName in pairs(enum.JumpNeedCloseView()) do
			_jumpNeedCloseViewDict[viewName] = true
		end
	end

	return enum
end

function ActivityHelper.getActivityVersion(activityId)
	ActivityHelper.initActivityVersion()

	return _activityIdToVersionDict[activityId] or ""
end

function ActivityHelper.getJumpNeedCloseViewDict()
	ActivityHelper.initActivityVersion()

	return _jumpNeedCloseViewDict
end

function ActivityHelper.activateClass(format, fromBigVersion, fromSmallVersion)
	fromBigVersion = fromBigVersion or 1
	fromSmallVersion = fromSmallVersion or 0

	for bigVersion = fromBigVersion, math.huge do
		for smallVersion = fromSmallVersion, math.huge do
			local clsName = string.format(format, bigVersion, smallVersion)
			local cls = _G[clsName]

			if smallVersion == 0 and not cls then
				return
			elseif not cls then
				break
			end

			if isDebugBuild then
				logNormal("自动加载" .. clsName)
			end
		end

		fromSmallVersion = 0
	end
end

return ActivityHelper
