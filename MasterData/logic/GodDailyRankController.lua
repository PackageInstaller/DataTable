-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddailyrank/controller/GodDailyRankController.lua

module("logic.extensions.goddailyrank.controller.GodDailyRankController", package.seeall)

local GodDailyRankController = class("GodDailyRankController", BaseController)

function GodDailyRankController:onInit()
	self:onReset()
end

function GodDailyRankController:onReset()
	return
end

function GodDailyRankController:getGodRankInfo(activityId)
	GodDailyRankAgent.instance:sendPM_GodDailyRankGodRankViewReq(activityId)
end

function GodDailyRankController:onGetGodRankInfo(msg)
	GodDailyRankModel.instance:onGetGodRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GODDAILYRANK_GODRANKVIEW_INFO)
end

function GodDailyRankController:getDailyRankInfo(activityId)
	GodDailyRankAgent.instance:sendPM_GodDailyRankDailyRankViewReq(activityId)
end

function GodDailyRankController:onGetDailyRankInfo(msg)
	GodDailyRankModel.instance:onGetDailyRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GODDAILYRANK_DAILYRANKVIEW_INFO)
end

function GodDailyRankController:getRankCloseTimeRangeStr(activityId)
	local config = GodDailyRankConfig.instance:getRankCfgById(activityId)

	if not config then
		return ""
	end

	return config.challengeClosedTimeRange or ""
end

function GodDailyRankController:getRankCloseTimeRange(activityId)
	local config = GodDailyRankConfig.instance:getRankCfgById(activityId)

	if not config then
		return 0, 0
	end

	if not config.challengeClosedTimeRange then
		local challengeClosedTimeRange = ""

		if challengeClosedTimeRange == "" then
			return "", ""
		end

		local timeRangeList = string.split(challengeClosedTimeRange, "-")

		return timeRangeList[1] or "", timeRangeList[2] or ""
	end
end

function GodDailyRankController:isGodRankClosed(activityId)
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId)

	if not isInTime then
		return true
	end

	local startTime, endTime = self:getRankCloseTimeRange(activityId)

	if startTime == "" or endTime == "" then
		return false
	end

	return GameUtil.checkIsInTimePeriod(startTime, endTime, true)
end

GodDailyRankController.instance = GodDailyRankController.New()

return GodDailyRankController
