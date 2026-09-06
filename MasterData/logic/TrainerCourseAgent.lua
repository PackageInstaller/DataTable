-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/agent/TrainerCourseAgent.lua

module("logic.extensions.sevendays.agent.TrainerCourseAgent", package.seeall)

local TrainerCourseAgent = class("TrainerCourseAgent", BaseAgent)

TrainerCourseAgent.PM_TrainerCourseGetInfoRes = "TrainerCourseAgent_PM_TrainerCourseGetInfoRes"
TrainerCourseAgent.PM_GainTrainerCoursePrizeRes = "TrainerCourseAgent_PM_GainTrainerCoursePrizeRes"
TrainerCourseAgent.PM_GainTrainerCourseScorePrizeRes = "TrainerCourseAgent_PM_GainTrainerCourseScorePrizeRes"
TrainerCourseAgent.PM_GainTrainerCourseTitlePrizeRes = "TrainerCourseAgent_PM_GainTrainerCourseTitlePrizeRes"

function TrainerCourseAgent:ctor()
	return
end

function TrainerCourseAgent:setExtId(extId)
	TrainerCourseAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function TrainerCourseAgent:sendPM_TrainerCourseGetInfoReq(handler, handlerObj, errHandler)
	local req = TrainerCourseExtension_pb.PM_TrainerCourseGetInfoReq()

	self:sendMsg(req)
	self:addEventOnce(TrainerCourseAgent.PM_TrainerCourseGetInfoRes, handler, handlerObj, errHandler)
end

function TrainerCourseAgent:handlePM_TrainerCourseGetInfoRes(status, msg)
	self:dispatch(TrainerCourseAgent.PM_TrainerCourseGetInfoRes, status, msg)
end

function TrainerCourseAgent:sendPM_GainTrainerCoursePrizeReq(taskId, handler, handlerObj, errHandler)
	local req = TrainerCourseExtension_pb.PM_GainTrainerCoursePrizeReq()

	req.taskId = taskId

	self:sendMsg(req)
	self:addEventOnce(TrainerCourseAgent.PM_GainTrainerCoursePrizeRes, handler, handlerObj, errHandler)
end

function TrainerCourseAgent:handlePM_GainTrainerCoursePrizeRes(status, msg)
	self:dispatch(TrainerCourseAgent.PM_GainTrainerCoursePrizeRes, status, msg)
end

function TrainerCourseAgent:sendPM_GainTrainerCourseScorePrizeReq(prizeIndex, handler, handlerObj, errHandler)
	local req = TrainerCourseExtension_pb.PM_GainTrainerCourseScorePrizeReq()

	req.prizeIndex = prizeIndex

	self:sendMsg(req)
	self:addEventOnce(TrainerCourseAgent.PM_GainTrainerCourseScorePrizeRes, handler, handlerObj, errHandler)
end

function TrainerCourseAgent:handlePM_GainTrainerCourseScorePrizeRes(status, msg)
	self:dispatch(TrainerCourseAgent.PM_GainTrainerCourseScorePrizeRes, status, msg)
end

function TrainerCourseAgent:sendPM_GainTrainerCourseTitlePrizeReq(handler, handlerObj, errHandler)
	local req = TrainerCourseExtension_pb.PM_GainTrainerCourseTitlePrizeReq()

	self:sendMsg(req)
	self:addEventOnce(TrainerCourseAgent.PM_GainTrainerCourseTitlePrizeRes, handler, handlerObj, errHandler)
end

function TrainerCourseAgent:handlePM_GainTrainerCourseTitlePrizeRes(status, msg)
	self:dispatch(TrainerCourseAgent.PM_GainTrainerCourseTitlePrizeRes, status, msg)
end

TrainerCourseAgent.instance = TrainerCourseAgent.New()

return TrainerCourseAgent
