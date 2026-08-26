-- chunkname: @modules/logic/versionactivity2_8/enter/helper/VersionActivity2_8EnterHelper.lua

module("modules.logic.versionactivity2_8.enter.helper.VersionActivity2_8EnterHelper", package.seeall)

local VersionActivity2_8EnterHelper = class("VersionActivity2_8EnterHelper")

function VersionActivity2_8EnterHelper.GetIsShowReplayBtn(actId)
	return (actId or nil) and ActivityConfig.instance:getActivityTabButtonState(actId)
end

function VersionActivity2_8EnterHelper.GetIsShowTabRemainTime(actId)
	if not actId then
		return false
	end

	local _, _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity2_8EnterHelper.GetIsShowAchievementBtn(actId)
	if not actId then
		return false
	end

	local _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity2_8EnterHelper.getItemTypeIdQuantity(coStr)
	if not coStr then
		return
	end

	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivity2_8EnterHelper.GetActivityPrefsKeyWithUser(key)
	local actKey = VersionActivity2_8EnterHelper.GetActivityPrefsKey(key)

	return PlayerModel.instance:getPlayerPrefsKey(actKey)
end

function VersionActivity2_8EnterHelper.GetActivityPrefsKey(key)
	return VersionActivity2_8Enum.ActivityId.EnterView .. key
end

return VersionActivity2_8EnterHelper
