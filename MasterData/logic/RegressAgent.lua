-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/agent/RegressAgent.lua

module("logic.extensions.playerreturn.agent.RegressAgent", package.seeall)

local RegressAgent = class("RegressAgent", BaseAgent)

RegressAgent.PM_RegressGetActInfoRes = "RegressAgent_PM_RegressGetActInfoRes"
RegressAgent.PM_RegressGetSignInInfoRes = "RegressAgent_PM_RegressGetSignInInfoRes"
RegressAgent.PM_RegressGetTaskInfoRes = "RegressAgent_PM_RegressGetTaskInfoRes"
RegressAgent.PM_RegressGetShopInfoRes = "RegressAgent_PM_RegressGetShopInfoRes"
RegressAgent.PM_RegressGainSignInPrizeRes = "RegressAgent_PM_RegressGainSignInPrizeRes"
RegressAgent.PM_RegressGainTaskPrizeRes = "RegressAgent_PM_RegressGainTaskPrizeRes"
RegressAgent.PM_RegressGainTaskScorePrizeRes = "RegressAgent_PM_RegressGainTaskScorePrizeRes"
RegressAgent.PM_RegressBuyShopItemRes = "RegressAgent_PM_RegressBuyShopItemRes"
RegressAgent.PM_RegressSetOpenRes = "RegressAgent_PM_RegressSetOpenRes"
RegressAgent.PM_NotifyRegressBuyGiftRes = "RegressAgent_PM_NotifyRegressBuyGiftRes"

function RegressAgent:ctor()
	return
end

function RegressAgent:setExtId(extId)
	RegressAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function RegressAgent:sendPM_RegressGetActInfoReq(handler, handlerObj, errHandler)
	local req = RegressExtension_pb.PM_RegressGetActInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RegressAgent.PM_RegressGetActInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function RegressAgent:handlePM_RegressGetActInfoRes(status, msg)
	self:dispatch(RegressAgent.PM_RegressGetActInfoRes, status, msg)
end

function RegressAgent:sendPM_RegressGetSignInInfoReq(handler, handlerObj, errHandler)
	local req = RegressExtension_pb.PM_RegressGetSignInInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RegressAgent.PM_RegressGetSignInInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function RegressAgent:handlePM_RegressGetSignInInfoRes(status, msg)
	self:dispatch(RegressAgent.PM_RegressGetSignInInfoRes, status, msg)
end

function RegressAgent:sendPM_RegressGetTaskInfoReq(handler, handlerObj, errHandler)
	local req = RegressExtension_pb.PM_RegressGetTaskInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RegressAgent.PM_RegressGetTaskInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function RegressAgent:handlePM_RegressGetTaskInfoRes(status, msg)
	self:dispatch(RegressAgent.PM_RegressGetTaskInfoRes, status, msg)
end

function RegressAgent:sendPM_RegressGetShopInfoReq(handler, handlerObj, errHandler)
	local req = RegressExtension_pb.PM_RegressGetShopInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RegressAgent.PM_RegressGetShopInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function RegressAgent:handlePM_RegressGetShopInfoRes(status, msg)
	self:dispatch(RegressAgent.PM_RegressGetShopInfoRes, status, msg)
end

function RegressAgent:sendPM_RegressGainSignInPrizeReq(day, handler, handlerObj, errHandler)
	local req = RegressExtension_pb.PM_RegressGainSignInPrizeReq()

	req.day = day

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RegressAgent.PM_RegressGainSignInPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function RegressAgent:handlePM_RegressGainSignInPrizeRes(status, msg)
	self:dispatch(RegressAgent.PM_RegressGainSignInPrizeRes, status, msg)
end

function RegressAgent:sendPM_RegressGainTaskPrizeReq(taskId, handler, handlerObj, errHandler)
	local req = RegressExtension_pb.PM_RegressGainTaskPrizeReq()

	req.taskId = taskId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RegressAgent.PM_RegressGainTaskPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function RegressAgent:handlePM_RegressGainTaskPrizeRes(status, msg)
	self:dispatch(RegressAgent.PM_RegressGainTaskPrizeRes, status, msg)
end

function RegressAgent:sendPM_RegressGainTaskScorePrizeReq(scoreId, handler, handlerObj, errHandler)
	local req = RegressExtension_pb.PM_RegressGainTaskScorePrizeReq()

	req.scoreId = scoreId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RegressAgent.PM_RegressGainTaskScorePrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function RegressAgent:handlePM_RegressGainTaskScorePrizeRes(status, msg)
	self:dispatch(RegressAgent.PM_RegressGainTaskScorePrizeRes, status, msg)
end

function RegressAgent:sendPM_RegressBuyShopItemReq(shopItemId, count, handler, handlerObj, errHandler)
	local req = RegressExtension_pb.PM_RegressBuyShopItemReq()

	req.shopItemId = shopItemId
	req.count = count

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RegressAgent.PM_RegressBuyShopItemRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function RegressAgent:handlePM_RegressBuyShopItemRes(status, msg)
	self:dispatch(RegressAgent.PM_RegressBuyShopItemRes, status, msg)
end

function RegressAgent:sendPM_RegressSetOpenReq(handler, handlerObj, errHandler)
	local req = RegressExtension_pb.PM_RegressSetOpenReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(RegressAgent.PM_RegressSetOpenRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function RegressAgent:handlePM_RegressSetOpenRes(status, msg)
	self:dispatch(RegressAgent.PM_RegressSetOpenRes, status, msg)
end

function RegressAgent:handlePM_NotifyRegressBuyGiftRes(status, msg)
	self:dispatch(RegressAgent.PM_NotifyRegressBuyGiftRes, status, msg)
end

function RegressAgent:sendPM_RegressGainGoldenDiamondCardReq()
	local req = RegressExtension_pb.PM_RegressGainGoldenDiamondCardReq()

	self:sendMsg(req)
end

function RegressAgent:handlePM_RegressGainGoldenDiamondCardRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.UpdataBackGoldCard, msg, false)
	end
end

function RegressAgent:sendPM_RegressGetPrivilegeInfoReq()
	local req = RegressExtension_pb.PM_RegressGetPrivilegeInfoReq()

	self:sendMsg(req)
end

function RegressAgent:handlePM_RegressGetPrivilegeInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.UpdataBackGoldCard, msg, true)
	end
end

RegressAgent.instance = RegressAgent.New()

return RegressAgent
