-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/agent/DaysRechargeAgent.lua

module("logic.extensions.doubleeleven.agent.DaysRechargeAgent", package.seeall)

local DaysRechargeAgent = class("DaysRechargeAgent", BaseAgent)

function DaysRechargeAgent:sendPM_DaysRechargeGetInfoReq(activityId)
	local req = DaysRechargeExtension_pb.PM_DaysRechargeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DaysRechargeAgent:handlePM_DaysRechargeGetInfoRes(status, msg)
	if status == 0 then
		DoubleElevenController.instance:csSendDaysRechargeGetInfo(msg)
	end
end

function DaysRechargeAgent:sendPM_DaysRechargeGainPrizeReq(activityId, itemId)
	local req = DaysRechargeExtension_pb.PM_DaysRechargeGainPrizeReq()

	req.activityId = activityId
	req.itemId = itemId

	self:sendMsg(req)
end

function DaysRechargeAgent:handlePM_DaysRechargeGainPrizeRes(status, msg)
	if status == 0 then
		DoubleElevenController.instance:csSendDaysRechargeGainPrize(msg)
	end
end

DaysRechargeAgent.instance = DaysRechargeAgent.New()

return DaysRechargeAgent
