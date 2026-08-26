-- chunkname: @modules/logic/versionactivity2_0/enter/helper/VersionActivity2_0EnterHelper.lua

module("modules.logic.versionactivity2_0.enter.helper.VersionActivity2_0EnterHelper", package.seeall)

local VersionActivity2_0EnterHelper = class("VersionActivity2_0EnterHelper")

function VersionActivity2_0EnterHelper.GetIsShowReplayBtn(actId)
	return (actId or nil) and ActivityConfig.instance:getActivityTabButtonState(actId)
end

function VersionActivity2_0EnterHelper.GetIsShowTabRemainTime(actId)
	if not actId then
		return false
	end

	local _, _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity2_0EnterHelper.GetIsShowAchievementBtn(actId)
	if not actId then
		return false
	end

	local _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity2_0EnterHelper.getItemTypeIdQuantity(coStr)
	if not coStr then
		return
	end

	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivity2_0EnterHelper.GetActivityPrefsKeyWithUser(key)
	local actKey = VersionActivity2_0EnterHelper.GetActivityPrefsKey(key)

	return PlayerModel.instance:getPlayerPrefsKey(actKey)
end

function VersionActivity2_0EnterHelper.GetActivityPrefsKey(key)
	return VersionActivity2_0Enum.ActivityId.EnterView .. key
end

return VersionActivity2_0EnterHelper
