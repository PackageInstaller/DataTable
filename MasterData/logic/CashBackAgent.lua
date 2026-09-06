-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cashback/agent/CashBackAgent.lua

module("logic.extensions.cashback.agent.CashBackAgent", package.seeall)

local CashBackAgent = class("CashBackAgent", BaseAgent)

function CashBackAgent:sendPM_CashBackInfoReq(activityId)
	local req = CashBackExtension_pb.PM_CashBackInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CashBackAgent:handlePM_CashBackInfoRes(status, msg)
	if status == 0 then
		CashBackController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.CashBackError, status)
	end
end

function CashBackAgent:sendPM_CashBackGainPrizeReq(activityId, prizeId)
	local req = CashBackExtension_pb.PM_CashBackGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function CashBackAgent:handlePM_CashBackGainPrizeRes(status, msg)
	if status == 0 then
		CashBackController.instance:handleGainPrize(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.CashBackError, status)
	end
end

CashBackAgent.instance = CashBackAgent.New()

return CashBackAgent
