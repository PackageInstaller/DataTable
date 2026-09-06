-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckydraw/agent/LuckyDrawAgent.lua

module("logic.extensions.luckydraw.agent.LuckyDrawAgent", package.seeall)

local LuckyDrawAgent = class("LuckyDrawAgent", BaseAgent)

LuckyDrawAgent.PM_LuckyDrawGetInfoRes = "LuckyDrawAgent_PM_LuckyDrawGetInfoRes"
LuckyDrawAgent.PM_LuckyDrawRes = "LuckyDrawAgent_PM_LuckyDrawRes"
LuckyDrawAgent.PM_LuckyDrawBuyItemRes = "LuckyDrawAgent_PM_LuckyDrawBuyItemRes"

function LuckyDrawAgent:ctor()
	return
end

function LuckyDrawAgent:setExtId(extId)
	LuckyDrawAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function LuckyDrawAgent:sendPM_LuckyDrawGetInfoReq(activityId, handler, handlerObj, errHandler)
	local req = LuckyDrawExtension_pb.PM_LuckyDrawGetInfoReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LuckyDrawAgent.PM_LuckyDrawGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LuckyDrawAgent:handlePM_LuckyDrawGetInfoRes(status, msg)
	self:dispatch(LuckyDrawAgent.PM_LuckyDrawGetInfoRes, status, msg)
end

function LuckyDrawAgent:sendPM_LuckyDrawReq(activityId, inflationMoneyActivityIsOpen, useCoupon, handler, handlerObj, errHandler)
	inflationMoneyActivityIsOpen = inflationMoneyActivityIsOpen or false

	local req = LuckyDrawExtension_pb.PM_LuckyDrawReq()

	req.activityId = activityId
	req.inflationMoneyActivityIsOpen = inflationMoneyActivityIsOpen
	req.useCoupon = useCoupon

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LuckyDrawAgent.PM_LuckyDrawRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LuckyDrawAgent:handlePM_LuckyDrawRes(status, msg)
	self:dispatch(LuckyDrawAgent.PM_LuckyDrawRes, status, msg)
end

function LuckyDrawAgent:sendPM_LuckyDrawBuyItemReq(activityId, buyNum, handler, handlerObj, errHandler)
	local req = LuckyDrawExtension_pb.PM_LuckyDrawBuyItemReq()

	req.activityId = activityId
	req.buyNum = buyNum

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LuckyDrawAgent.PM_LuckyDrawBuyItemRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LuckyDrawAgent:handlePM_LuckyDrawBuyItemRes(status, msg)
	self:dispatch(LuckyDrawAgent.PM_LuckyDrawBuyItemRes, status, msg)
end

function LuckyDrawAgent:sendPM_LuckyDrawGainProcessPirzeReq(activityId, prizeId)
	local req = LuckyDrawExtension_pb.PM_LuckyDrawGainProcessPirzeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function LuckyDrawAgent:handlePM_LuckyDrawGainProcessPirzeRes(status, msg)
	if status == 0 then
		LuckyDrawModel.instance:onGainProgressPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.LuckyDrawGainProcessPirzeRes)
	end
end

function LuckyDrawAgent:sendPM_LuckyDrawRankViewReq(activityId)
	local req = LuckyDrawExtension_pb.PM_LuckyDrawRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function LuckyDrawAgent:handlePM_LuckyDrawRankViewRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.LuckyDrawRankViewRes, msg)
	end
end

LuckyDrawAgent.instance = LuckyDrawAgent.New()

return LuckyDrawAgent
