-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heatprogress/agent/HeatProgressAgent.lua

module("logic.extensions.heatprogress.agent.HeatProgressAgent", package.seeall)

local HeatProgressAgent = class("HeatProgressAgent", BaseAgent)

HeatProgressAgent.PM_BigCastChallengeGetInfoRes = "FunArenaAgent_PM_BigCastChallengeGetInfoRes"

function HeatProgressAgent:ctor()
	return
end

function HeatProgressAgent:setExtId(extId)
	HeatProgressAgent.super.setExtId(self, extId)
end

function HeatProgressAgent:sendPM_SummaryProgressGetInfoReq(activityId)
	local req = SummaryProgressExtension_pb.PM_SummaryProgressGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function HeatProgressAgent:handlePM_SummaryProgressGetInfoRes(status, msg)
	if status == 0 then
		HeatProgressController.instance:onHandleProgressGetInfoRes(msg)
	end
end

function HeatProgressAgent:sendPM_SummaryProgressGainPrizeReq(activityId, progressId, id)
	local req = SummaryProgressExtension_pb.PM_SummaryProgressGainPrizeReq()

	req.activityId = activityId
	req.progressId = progressId
	req.id = id

	self:sendMsg(req)
end

function HeatProgressAgent:handlePM_SummaryProgressGainPrizeRes(status, msg)
	if status == 0 then
		HeatProgressController.instance:onHandleProgressGainPrizeRes(msg)
	end
end

HeatProgressAgent.instance = HeatProgressAgent.New()

return HeatProgressAgent
