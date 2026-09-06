-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timeserverpetgain/agent/TimeServerPetGainAgent.lua

module("logic.extensions.timeserverpetgain.agent.TimeServerPetGainAgent", package.seeall)

local TimeServerPetGainAgent = class("TimeServerPetGainAgent", BaseAgent)

function TimeServerPetGainAgent:sendPM_TimeServerPetGainGetInfoReq(activityId)
	local req = TimeServerPetGainExtension_pb.PM_TimeServerPetGainGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TimeServerPetGainAgent:handlePM_TimeServerPetGainGetInfoRes(status, msg)
	if status == 0 then
		TimeServerPetGainModel.instance:TimeServerPetGainGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.TimeServerPetGainGetInfoRes)
	end
end

function TimeServerPetGainAgent:sendPM_TimeServerPetGainGetProgressPrizeReq(activityId, id)
	local req = TimeServerPetGainExtension_pb.PM_TimeServerPetGainGetProgressPrizeReq()

	req.activityId = activityId
	req.id = id

	self:sendMsg(req)
end

function TimeServerPetGainAgent:handlePM_TimeServerPetGainGetProgressPrizeRes(status, msg)
	if status == 0 then
		TimeServerPetGainModel.instance:TimeServerPetGainGetProgressPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.TimeServerPetGainGetProgressPrizeRes)
	end
end

TimeServerPetGainAgent.instance = TimeServerPetGainAgent.New()

return TimeServerPetGainAgent
