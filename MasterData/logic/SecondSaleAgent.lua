-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/agent/SecondSaleAgent.lua

module("logic.extensions.doubleeleven.agent.SecondSaleAgent", package.seeall)

local SecondSaleAgent = class("SecondSaleAgent", BaseAgent)

function SecondSaleAgent:sendPM_SecondSaleInfoReq(activityId, planId)
	local req = SecondSaleExtension_pb.PM_SecondSaleInfoReq()

	req.activityId = activityId
	req.planId = planId

	self:sendMsg(req)
end

function SecondSaleAgent:handlePM_SecondSaleInfoRes(status, msg)
	if status == 0 then
		DoubleElevenController.instance:csSendSecondSaleInfo(msg)
	end
end

function SecondSaleAgent:sendPM_SecondSaleBuyReq(activityId, planId, itemId)
	local req = SecondSaleExtension_pb.PM_SecondSaleBuyReq()

	req.activityId = activityId
	req.planId = planId
	req.itemId = itemId

	self:sendMsg(req)
end

function SecondSaleAgent:handlePM_SecondSaleBuyRes(status, msg)
	if status == 0 then
		DoubleElevenController.instance:csSendSecondSaleBuy(msg)
	end
end

SecondSaleAgent.instance = SecondSaleAgent.New()

return SecondSaleAgent
