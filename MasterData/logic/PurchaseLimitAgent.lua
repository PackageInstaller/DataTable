-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/purchaselimit/agent/PurchaseLimitAgent.lua

module("logic.extensions.purchaselimit.agent.PurchaseLimitAgent", package.seeall)

local PurchaseLimitAgent = class("PurchaseLimitAgent", BaseAgent)

function PurchaseLimitAgent:sendPM_PurchaseLimitInfoReq(activityId)
	local req = PurchaseLimitExtension_pb.PM_PurchaseLimitInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function PurchaseLimitAgent:handlePM_PurchaseLimitInfoRes(status, msg)
	if status == 0 then
		PurchaseLimitController.instance:handlePM_PurchaseLimitInfoRes(status, msg)
	end
end

function PurchaseLimitAgent:sendPM_PurchaseLimitBuyReq(activityId, itemId)
	local req = PurchaseLimitExtension_pb.PM_PurchaseLimitBuyReq()

	req.activityId = activityId
	req.itemId = itemId

	self:sendMsg(req)
end

function PurchaseLimitAgent:handlePM_PurchaseLimitBuyRes(status, msg)
	if status == 0 then
		PurchaseLimitController.instance:handlePM_PurchaseLimitBuyRes(status, msg)
	end
end

PurchaseLimitAgent.instance = PurchaseLimitAgent.New()

return PurchaseLimitAgent
