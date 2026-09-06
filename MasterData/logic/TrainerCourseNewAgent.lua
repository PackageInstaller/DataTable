-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/agent/TrainerCourseNewAgent.lua

module("logic.extensions.trainercoursenew.agent.TrainerCourseNewAgent", package.seeall)

local TrainerCourseNewAgent = class("TrainerCourseNewAgent", BaseAgent)

TrainerCourseNewAgent.PM_TrainerCourseGetInfoRes = "TrainerCourseNewAgent_PM_TrainerCourseGetInfoRes"
TrainerCourseNewAgent.PM_GainTrainerCoursePrizeRes = "TrainerCourseNewAgent_PM_GainTrainerCoursePrizeRes"
TrainerCourseNewAgent.PM_GainTrainerCourseScorePrizeRes = "TrainerCourseNewAgent_PM_GainTrainerCourseScorePrizeRes"

function TrainerCourseNewAgent:sendPM_TrainerCourseNewGetInfoReq(activityId)
	local req = TrainerCourseNewExtension_pb.PM_TrainerCourseNewGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TrainerCourseNewAgent:handlePM_TrainerCourseNewGetInfoRes(status, msg)
	self:dispatch(TrainerCourseNewAgent.PM_TrainerCourseGetInfoRes, status, msg)
end

function TrainerCourseNewAgent:sendPM_GainTrainerCourseNewPrizeReq(activityId, taskId)
	local req = TrainerCourseNewExtension_pb.PM_GainTrainerCourseNewPrizeReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function TrainerCourseNewAgent:handlePM_GainTrainerCourseNewPrizeRes(status, msg)
	self:dispatch(TrainerCourseNewAgent.PM_GainTrainerCoursePrizeRes, status, msg)
end

function TrainerCourseNewAgent:sendPM_GainTrainerCourseScoreNewPrizeReq(activityId, prizeIndex)
	local req = TrainerCourseNewExtension_pb.PM_GainTrainerCourseScoreNewPrizeReq()

	req.activityId = activityId
	req.prizeIndex = prizeIndex

	self:sendMsg(req)
end

function TrainerCourseNewAgent:handlePM_GainTrainerCourseScoreNewPrizeRes(status, msg)
	self:dispatch(TrainerCourseNewAgent.PM_GainTrainerCoursePrizeRes, status, msg)
end

TrainerCourseNewAgent.instance = TrainerCourseNewAgent.New()

return TrainerCourseNewAgent
