-- chunkname: @modules/logic/versionactivity3_3/enter/helper/VersionActivity3_3EnterHelper.lua

module("modules.logic.versionactivity3_3.enter.helper.VersionActivity3_3EnterHelper", package.seeall)

local VersionActivity3_3EnterHelper = class("VersionActivity3_3EnterHelper")

function VersionActivity3_3EnterHelper.GetIsShowReplayBtn(actId)
	return (actId or nil) and ActivityConfig.instance:getActivityTabButtonState(actId)
end

function VersionActivity3_3EnterHelper.GetIsShowTabRemainTime(actId)
	if not actId then
		return false
	end

	local _, _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity3_3EnterHelper.GetIsShowAchievementBtn(actId)
	if not actId then
		return false
	end

	local _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity3_3EnterHelper.getItemTypeIdQuantity(coStr)
	if not coStr then
		return
	end

	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivity3_3EnterHelper.GetActivityPrefsKeyWithUser(key)
	local actKey = VersionActivity3_3EnterHelper.GetActivityPrefsKey(key)

	return PlayerModel.instance:getPlayerPrefsKey(actKey)
end

function VersionActivity3_3EnterHelper.GetActivityPrefsKey(key)
	return VersionActivity3_3Enum.ActivityId.EnterView .. key
end

return VersionActivity3_3EnterHelper
