-- chunkname: @modules/versionactivitybase/fixed/enterview/helper/VersionActivityFixedEnterHelper.lua

module("modules.versionactivitybase.fixed.enterview.helper.VersionActivityFixedEnterHelper", package.seeall)

local VersionActivityFixedEnterHelper = class("VersionActivityFixedEnterHelper")

function VersionActivityFixedEnterHelper.GetIsShowReplayBtn(actId)
	return (actId or nil) and ActivityConfig.instance:getActivityTabButtonState(actId)
end

function VersionActivityFixedEnterHelper.GetIsShowTabRemainTime(actId)
	if not actId then
		return false
	end

	local _, _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivityFixedEnterHelper.GetIsShowAchievementBtn(actId)
	if not actId then
		return false
	end

	local _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivityFixedEnterHelper.getItemTypeIdQuantity(coStr)
	if not coStr then
		return
	end

	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivityFixedEnterHelper.GetActivityPrefsKeyWithUser(key)
	local actKey = VersionActivityFixedEnterHelper.GetActivityPrefsKey(key)

	return PlayerModel.instance:getPlayerPrefsKey(actKey)
end

function VersionActivityFixedEnterHelper.GetActivityPrefsKey(key)
	return VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.EnterView .. key
end

return VersionActivityFixedEnterHelper
