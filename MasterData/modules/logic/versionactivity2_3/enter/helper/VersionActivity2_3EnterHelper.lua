-- chunkname: @modules/logic/versionactivity2_3/enter/helper/VersionActivity2_3EnterHelper.lua

module("modules.logic.versionactivity2_3.enter.helper.VersionActivity2_3EnterHelper", package.seeall)

local VersionActivity2_3EnterHelper = class("VersionActivity2_3EnterHelper")

function VersionActivity2_3EnterHelper.GetIsShowReplayBtn(actId)
	return (actId or nil) and ActivityConfig.instance:getActivityTabButtonState(actId)
end

function VersionActivity2_3EnterHelper.GetIsShowTabRemainTime(actId)
	if not actId then
		return false
	end

	local _, _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity2_3EnterHelper.GetIsShowAchievementBtn(actId)
	if not actId then
		return false
	end

	local _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity2_3EnterHelper.getItemTypeIdQuantity(coStr)
	if not coStr then
		return
	end

	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivity2_3EnterHelper.GetActivityPrefsKeyWithUser(key)
	local actKey = VersionActivity2_3EnterHelper.GetActivityPrefsKey(key)

	return PlayerModel.instance:getPlayerPrefsKey(actKey)
end

function VersionActivity2_3EnterHelper.GetActivityPrefsKey(key)
	return VersionActivity2_3Enum.ActivityId.EnterView .. key
end

return VersionActivity2_3EnterHelper
