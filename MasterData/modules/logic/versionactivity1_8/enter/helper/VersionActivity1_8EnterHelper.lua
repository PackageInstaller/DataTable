-- chunkname: @modules/logic/versionactivity1_8/enter/helper/VersionActivity1_8EnterHelper.lua

module("modules.logic.versionactivity1_8.enter.helper.VersionActivity1_8EnterHelper", package.seeall)

local VersionActivity1_8EnterHelper = class("VersionActivity1_8EnterHelper")

function VersionActivity1_8EnterHelper.GetIsShowReplayBtn(actId)
	return (actId or nil) and ActivityConfig.instance:getActivityTabButtonState(actId)
end

function VersionActivity1_8EnterHelper.GetIsShowTabRemainTime(actId)
	if not actId then
		return false
	end

	local _, _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity1_8EnterHelper.GetIsShowAchievementBtn(actId)
	if not actId then
		return false
	end

	local _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity1_8EnterHelper.getItemTypeIdQuantity(coStr)
	if not coStr then
		return
	end

	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivity1_8EnterHelper.GetActivityPrefsKeyWithUser(key)
	local actKey = VersionActivity1_8EnterHelper.GetActivityPrefsKey(key)

	return PlayerModel.instance:getPlayerPrefsKey(actKey)
end

function VersionActivity1_8EnterHelper.GetActivityPrefsKey(key)
	return VersionActivity1_8Enum.ActivityId.EnterView .. key
end

return VersionActivity1_8EnterHelper
