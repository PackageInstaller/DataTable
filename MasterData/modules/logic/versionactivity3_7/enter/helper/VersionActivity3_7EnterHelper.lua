-- chunkname: @modules/logic/versionactivity3_7/enter/helper/VersionActivity3_7EnterHelper.lua

module("modules.logic.versionactivity3_7.enter.helper.VersionActivity3_7EnterHelper", package.seeall)

local VersionActivity3_7EnterHelper = class("VersionActivity3_7EnterHelper")

function VersionActivity3_7EnterHelper.GetIsShowReplayBtn(actId)
	return (actId or nil) and ActivityConfig.instance:getActivityTabButtonState(actId)
end

function VersionActivity3_7EnterHelper.GetIsShowTabRemainTime(actId)
	if not actId then
		return false
	end

	local _, _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity3_7EnterHelper.GetIsShowAchievementBtn(actId)
	if not actId then
		return false
	end

	local _, result = ActivityConfig.instance:getActivityTabButtonState(actId)

	return result
end

function VersionActivity3_7EnterHelper.getItemTypeIdQuantity(coStr)
	if not coStr then
		return
	end

	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivity3_7EnterHelper.GetActivityPrefsKeyWithUser(key)
	local actKey = VersionActivity3_7EnterHelper.GetActivityPrefsKey(key)

	return PlayerModel.instance:getPlayerPrefsKey(actKey)
end

function VersionActivity3_7EnterHelper.GetActivityPrefsKey(key)
	return VersionActivity3_7Enum.ActivityId.EnterView .. key
end

return VersionActivity3_7EnterHelper
