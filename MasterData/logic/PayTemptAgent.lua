-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paytempt/agent/PayTemptAgent.lua

module("logic.extensions.paytempt.agent.PayTemptAgent", package.seeall)

local PayTemptAgent = class("PayTemptAgent", BaseAgent)

PayTemptAgent.PM_GetMyAllPayTemptInfoRes = "PayTemptAgent_PM_GetMyAllPayTemptInfoRes"
PayTemptAgent.PM_NotifyNewGiftRes = "PayTemptAgent_PM_NotifyNewGiftRes"
PayTemptAgent.PM_NotifyBuyGiftRes = "PayTemptAgent_PM_NotifyBuyGiftRes"

function PayTemptAgent:ctor()
	return
end

function PayTemptAgent:setExtId(extId)
	PayTemptAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PayTemptAgent:sendPM_GetMyAllPayTemptInfoReq(handler, handlerObj, errHandler)
	local req = PayTemptExtension_pb.PM_GetMyAllPayTemptInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PayTemptAgent.PM_GetMyAllPayTemptInfoRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function PayTemptAgent:handlePM_GetMyAllPayTemptInfoRes(status, msg)
	self:dispatch(PayTemptAgent.PM_GetMyAllPayTemptInfoRes, status, msg)
end

function PayTemptAgent:handlePM_NotifyNewGiftRes(status, msg)
	self:dispatch(PayTemptAgent.PM_NotifyNewGiftRes, status, msg)
end

function PayTemptAgent:handlePM_NotifyBuyGiftRes(status, msg)
	self:dispatch(PayTemptAgent.PM_NotifyBuyGiftRes, status, msg)
end

PayTemptAgent.instance = PayTemptAgent.New()

return PayTemptAgent
