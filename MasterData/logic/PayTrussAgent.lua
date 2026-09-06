-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/agent/PayTrussAgent.lua

module("logic.extensions.paytruss.agent.PayTrussAgent", package.seeall)

local PayTrussAgent = class("PayTrussAgent", BaseAgent)

PayTrussAgent.PM_PayTrussGetInfoRes = "PayTrussAgent_PM_PayTrussGetInfoRes"
PayTrussAgent.PM_PayTrussNotifyPaySucRes = "PayTrussAgent_PM_PayTrussNotifyPaySucRes"

function PayTrussAgent:ctor()
	return
end

function PayTrussAgent:setExtId(extId)
	PayTrussAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PayTrussAgent:sendPM_PayTrussGetInfoReq(activityId)
	local req = PayTrussExtension_pb.PM_PayTrussGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PayTrussAgent:handlePM_PayTrussGetInfoRes(status, msg)
	if status == 0 then
		PayTrussController.instance:_handleResGetPayTrussInfo(msg)
	end
end

function PayTrussAgent:handlePM_PayTrussNotifyPaySucRes(status, msg)
	if status == 0 then
		PayTrussController.instance:_handleResPayTrussNotifyPaySuc(msg)
	end
end

PayTrussAgent.instance = PayTrussAgent.New()

return PayTrussAgent
