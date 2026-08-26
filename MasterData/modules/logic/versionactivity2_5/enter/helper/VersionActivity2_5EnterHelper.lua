-- chunkname: @modules/logic/versionactivity2_5/enter/helper/VersionActivity2_5EnterHelper.lua

module("modules.logic.versionactivity2_5.enter.helper.VersionActivity2_5EnterHelper", package.seeall)

local VersionActivity2_5EnterHelper = class("VersionActivity2_5EnterHelper")

function VersionActivity2_5EnterHelper.GetIsShowReplayBtn(actId)
	return (actId or nil) and ActivityConfig.instance:getActivityTabButtonState(actId)
end

function VersionActivity2_5EnterHelper.GetIsShowTabRemainTime(actId)
	if not actId then
		return false
	end

	local _, _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity2_5EnterHelper.GetIsShowAchievementBtn(actId)
	if not actId then
		return false
	end

	local _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity2_5EnterHelper.getItemTypeIdQuantity(coStr)
	if not coStr then
		return
	end

	local splits = GameUtil.splitString2(coStr, true)
	local attribute = splits[1]

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivity2_5EnterHelper.GetActivityPrefsKeyWithUser(key)
	local actKey = VersionActivity2_5EnterHelper.GetActivityPrefsKey(key)

	return PlayerModel.instance:getPlayerPrefsKey(actKey)
end

function VersionActivity2_5EnterHelper.GetActivityPrefsKey(key)
	return VersionActivity2_5Enum.ActivityId.EnterView .. key
end

return VersionActivity2_5EnterHelper
