-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pay/agent/PayAgent.lua

module("logic.extensions.pay.agent.PayAgent", package.seeall)

local PayAgent = class("PayAgent", BaseAgent)

PayAgent.GenOrderNoRes = "PayAgent_GenOrderNoRes"
PayAgent.NotifyPayResultRes = "PayAgent_NotifyPayResultRes"

function PayAgent:ctor()
	return
end

function PayAgent:setExtId(extId)
	PayAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PayAgent:sendGenOrderNoReq(goodsId, subGoodsType, subGoodsId, extParams, callBackStr, handler, handlerObj, errHandler)
	local req = PayExtension_pb.GenOrderNoReq()

	req.goodsId = goodsId
	req.subGoodsType = subGoodsType
	req.subGoodsId = subGoodsId

	if extParams ~= nil then
		req.extParams = extParams
	end

	req.callBackStr = callBackStr

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(PayAgent.GenOrderNoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function PayAgent:handleGenOrderNoRes(status, msg)
	self:dispatch(PayAgent.GenOrderNoRes, status, msg)
end

function PayAgent:handleNotifyPayResultRes(status, msg)
	self:dispatch(PayAgent.NotifyPayResultRes, status, msg)
end

PayAgent.instance = PayAgent.New()

return PayAgent
