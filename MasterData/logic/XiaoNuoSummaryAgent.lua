-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/agent/XiaoNuoSummaryAgent.lua

module("logic.extensions.xiaonuosummary.agent.XiaoNuoSummaryAgent", package.seeall)

local XiaoNuoSummaryAgent = class("XiaoNuoSummaryAgent", BaseAgent)

function XiaoNuoSummaryAgent:ctor()
	return
end

function XiaoNuoSummaryAgent:setExtId(extId)
	XiaoNuoSummaryAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function XiaoNuoSummaryAgent:sendPM_XiaoNuoSummaryGetInfoReq(activityId)
	local req = XiaoNuoSummaryExtension_pb.PM_XiaoNuoSummaryGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiaoNuoSummaryAgent:handlePM_XiaoNuoSummaryGetInfoRes(status, msg)
	if status == 0 then
		ActivitySummaryController.instance:onGetSignInfo(msg)
	end
end

function XiaoNuoSummaryAgent:sendPM_XiaoNuoSummaryGainPrizeReq(activityId)
	local req = XiaoNuoSummaryExtension_pb.PM_XiaoNuoSummaryGainPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiaoNuoSummaryAgent:handlePM_XiaoNuoSummaryGainPrizeRes(status, msg)
	if status == 0 then
		ActivitySummaryController.instance:onGetSignInPrize(msg)
	end
end

function XiaoNuoSummaryAgent:sendPM_XiaoNuoSummaryLikeReq(activityId, tab, id)
	local req = XiaoNuoSummaryExtension_pb.PM_XiaoNuoSummaryLikeReq()

	req.activityId = activityId
	req.tab = tab
	req.id = id

	self:sendMsg(req)
end

function XiaoNuoSummaryAgent:handlePM_XiaoNuoSummaryLikeRes(status, msg)
	if status == 0 then
		ActivitySummaryController.instance:onLike(msg)
	end
end

function XiaoNuoSummaryAgent:handlePM_XiaoNuoBuyEndRes(status, msg)
	if status == 0 then
		ActivitySummaryController.instance:onBuyTime(msg)
	end
end

function XiaoNuoSummaryAgent:sendPM_XiaoNuoSummaryGainWeekPrizeReq(activityId)
	local req = XiaoNuoSummaryExtension_pb.PM_XiaoNuoSummaryGainWeekPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiaoNuoSummaryAgent:handlePM_XiaoNuoSummaryGainWeekPrizeRes(status, msg)
	if status == 0 then
		ActivitySummaryController.instance:onGetWeeklyPrize(msg)
	end
end

function XiaoNuoSummaryAgent:sendPM_XiaoNuoSummaryBuyDaysReq(activityId)
	local req = XiaoNuoSummaryExtension_pb.PM_XiaoNuoSummaryBuyDaysReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiaoNuoSummaryAgent:handlePM_XiaoNuoSummaryBuyDaysRes(status, msg)
	if status == 0 then
		ActivitySummaryController.instance:onBuyTime(msg)
	end
end

function XiaoNuoSummaryAgent:sendPM_XiaoNuoSummaryGainDailyPrizeReq(activityId)
	local req = XiaoNuoSummaryExtension_pb.PM_XiaoNuoSummaryGainDailyPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XiaoNuoSummaryAgent:handlePM_XiaoNuoSummaryGainDailyPrizeRes(status, msg)
	if status == 0 then
		ActivitySummaryController.instance:onGainDailySignInPrize(msg)
	end
end

XiaoNuoSummaryAgent.instance = XiaoNuoSummaryAgent.New()

return XiaoNuoSummaryAgent
