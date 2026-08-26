-- chunkname: @modules/logic/versionactivity2_2/enter/helper/VersionActivity2_2EnterHelper.lua

module("modules.logic.versionactivity2_2.enter.helper.VersionActivity2_2EnterHelper", package.seeall)

local VersionActivity2_2EnterHelper = class("VersionActivity2_2EnterHelper")

function VersionActivity2_2EnterHelper.GetIsShowReplayBtn(actId)
	return (actId or nil) and ActivityConfig.instance:getActivityTabButtonState(actId)
end

function VersionActivity2_2EnterHelper.GetIsShowTabRemainTime(actId)
	if not actId then
		return false
	end

	local _, _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity2_2EnterHelper.GetIsShowAchievementBtn(actId)
	if not actId then
		return false
	end

	local _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity2_2EnterHelper.getItemTypeIdQuantity(coStr)
	if not coStr then
		return
	end

	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivity2_2EnterHelper.GetActivityPrefsKeyWithUser(key)
	local actKey = VersionActivity2_2EnterHelper.GetActivityPrefsKey(key)

	return PlayerModel.instance:getPlayerPrefsKey(actKey)
end

function VersionActivity2_2EnterHelper.GetActivityPrefsKey(key)
	return VersionActivity2_2Enum.ActivityId.EnterView .. key
end

return VersionActivity2_2EnterHelper
