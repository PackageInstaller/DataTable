-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makesnowman/agent/MakeSnowmanAgent.lua

module("logic.extensions.makesnowman.agent.MakeSnowmanAgent", package.seeall)

local MakeSnowmanAgent = class("MakeSnowmanAgent", BaseAgent)

MakeSnowmanAgent.handlePM_MakeSnowmanGetInfoRes = "MakeSnowmanAgent.handlePM_MakeSnowmanGetInfoRes"
MakeSnowmanAgent.handlePM_MakeSnowmanGainProgressPrizeRes = "MakeSnowmanAgent.handlePM_MakeSnowmanGainProgressPrizeRes"

function MakeSnowmanAgent:sendPM_MakeSnowmanGetInfoReq(activityId)
	local req = MakeSnowmanExtension_pb.PM_MakeSnowmanGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MakeSnowmanAgent:handlePM_MakeSnowmanGetInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(MakeSnowmanAgent.handlePM_MakeSnowmanGetInfoRes, status, msg)
	end
end

function MakeSnowmanAgent:sendPM_MakeSnowmanGainProgressPrizeReq(activityId, prizeId)
	local req = MakeSnowmanExtension_pb.PM_MakeSnowmanGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function MakeSnowmanAgent:handlePM_MakeSnowmanGainProgressPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(MakeSnowmanAgent.handlePM_MakeSnowmanGainProgressPrizeRes, status, msg)
	end
end

MakeSnowmanAgent.instance = MakeSnowmanAgent.New()

return MakeSnowmanAgent
