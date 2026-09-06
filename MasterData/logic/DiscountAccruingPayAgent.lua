-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/discountaccruingpay/agent/DiscountAccruingPayAgent.lua

module("logic.extensions.discountaccruingpay.agent.DiscountAccruingPayAgent", package.seeall)

local DiscountAccruingPayAgent = class("DiscountAccruingPayAgent", BaseAgent)

DiscountAccruingPayAgent.GetPayInfoRes = "DiscountAccruingPayAgent_GetPayInfoRes"
DiscountAccruingPayAgent.GainExGiftRes = "DiscountAccruingPayAgent_GainExGiftRes"
DiscountAccruingPayAgent.PM_NotifyBuyGiftRes = "DiscountAccruingPayAgent_PM_NotifyBuyGiftRes"

function DiscountAccruingPayAgent:ctor()
	return
end

function DiscountAccruingPayAgent:setExtId(extId)
	DiscountAccruingPayAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function DiscountAccruingPayAgent:sendGetPayInfoReq(activityId, handler, handlerObj, errHandler)
	local req = DiscountAccruingPayExtension_pb.GetPayInfoReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DiscountAccruingPayAgent.GetPayInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DiscountAccruingPayAgent:handleGetPayInfoRes(status, msg)
	self:dispatch(DiscountAccruingPayAgent.GetPayInfoRes, status, msg)
end

function DiscountAccruingPayAgent:sendGainExGiftReq(activityId, handler, handlerObj, errHandler)
	local req = DiscountAccruingPayExtension_pb.GainExGiftReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DiscountAccruingPayAgent.GainExGiftRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DiscountAccruingPayAgent:handleGainExGiftRes(status, msg)
	self:dispatch(DiscountAccruingPayAgent.GainExGiftRes, status, msg)
end

function DiscountAccruingPayAgent:handlePM_NotifyBuyGiftRes(status, msg)
	self:dispatch(DiscountAccruingPayAgent.PM_NotifyBuyGiftRes, status, msg)
end

DiscountAccruingPayAgent.instance = DiscountAccruingPayAgent.New()

return DiscountAccruingPayAgent
