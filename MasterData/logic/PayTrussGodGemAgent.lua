-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/agent/PayTrussGodGemAgent.lua

module("logic.extensions.paytruss.agent.PayTrussGodGemAgent", package.seeall)

local PayTrussGodGemAgent = class("PayTrussGodGemAgent", BaseAgent)

PayTrussGodGemAgent.PM_PayTrussGodGemInfoRes = "PayTrussGodGemAgent_PM_PayTrussGodGemInfoRes"
PayTrussGodGemAgent.PM_PayTrussGodGemBuyRes = "PayTrussGodGemAgent_PM_PayTrussGodGemBuyRes"

function PayTrussGodGemAgent:ctor()
	return
end

function PayTrussGodGemAgent:setExtId(extId)
	PayTrussGodGemAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PayTrussGodGemAgent:sendPM_PayTrussGodGemInfoReq(activityId)
	local req = PayTrussGodGemExtension_pb.PM_PayTrussGodGemInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PayTrussGodGemAgent:handlePM_PayTrussGodGemInfoRes(status, msg)
	if status == 0 then
		PayTrussGodGemController.instance:_handlePayTrussGodGemInfoRes(msg)
	end
end

function PayTrussGodGemAgent:sendPM_PayTrussGodGemBuyReq(activityId, buyId)
	local req = PayTrussGodGemExtension_pb.PM_PayTrussGodGemBuyReq()

	req.activityId = activityId
	req.buyId = buyId

	self:sendMsg(req)
end

function PayTrussGodGemAgent:handlePM_PayTrussGodGemBuyRes(status, msg)
	if status == 0 then
		PayTrussGodGemController.instance:_handlePayTrussGodGemBuyRes(msg)
	end
end

PayTrussGodGemAgent.instance = PayTrussGodGemAgent.New()

return PayTrussGodGemAgent
