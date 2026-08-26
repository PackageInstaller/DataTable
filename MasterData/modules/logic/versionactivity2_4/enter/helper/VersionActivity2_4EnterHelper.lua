-- chunkname: @modules/logic/versionactivity2_4/enter/helper/VersionActivity2_4EnterHelper.lua

module("modules.logic.versionactivity2_4.enter.helper.VersionActivity2_4EnterHelper", package.seeall)

local VersionActivity2_4EnterHelper = class("VersionActivity2_4EnterHelper")

function VersionActivity2_4EnterHelper.GetIsShowReplayBtn(actId)
	return (actId or nil) and ActivityConfig.instance:getActivityTabButtonState(actId)
end

function VersionActivity2_4EnterHelper.GetIsShowTabRemainTime(actId)
	if not actId then
		return false
	end

	local _, _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity2_4EnterHelper.GetIsShowAchievementBtn(actId)
	if not actId then
		return false
	end

	local _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity2_4EnterHelper.getItemTypeIdQuantity(coStr)
	if not coStr then
		return
	end

	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivity2_4EnterHelper.GetActivityPrefsKeyWithUser(key)
	local actKey = VersionActivity2_4EnterHelper.GetActivityPrefsKey(key)

	return PlayerModel.instance:getPlayerPrefsKey(actKey)
end

function VersionActivity2_4EnterHelper.GetActivityPrefsKey(key)
	return VersionActivity2_4Enum.ActivityId.EnterView .. key
end

return VersionActivity2_4EnterHelper
