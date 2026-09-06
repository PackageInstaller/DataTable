-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/agent/SevenDayTaskAgent.lua

module("logic.extensions.sevendays.agent.SevenDayTaskAgent", package.seeall)

local SevenDayTaskAgent = class("SevenDayTaskAgent", BaseAgent)

SevenDayTaskAgent.PM_SevenDayTaskGetInfoRes = "SevenDayTaskAgent_PM_SevenDayTaskGetInfoRes"
SevenDayTaskAgent.PM_GainSevenDayTaskPrizeRes = "SevenDayTaskAgent_PM_GainSevenDayTaskPrizeRes"
SevenDayTaskAgent.PM_GainSevenDayTaskScorePrizeRes = "SevenDayTaskAgent_PM_GainSevenDayTaskScorePrizeRes"

function SevenDayTaskAgent:ctor()
	return
end

function SevenDayTaskAgent:setExtId(extId)
	SevenDayTaskAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function SevenDayTaskAgent:sendPM_SevenDayTaskGetInfoReq(handler, handlerObj, errHandler)
	local req = SevenDayTaskExtension_pb.PM_SevenDayTaskGetInfoReq()

	self:sendMsg(req)
	self:addEventOnce(SevenDayTaskAgent.PM_SevenDayTaskGetInfoRes, handler, handlerObj, errHandler)
end

function SevenDayTaskAgent:handlePM_SevenDayTaskGetInfoRes(status, msg)
	self:dispatch(SevenDayTaskAgent.PM_SevenDayTaskGetInfoRes, status, msg)
end

function SevenDayTaskAgent:sendPM_GainSevenDayTaskPrizeReq(taskId, handler, handlerObj, errHandler)
	local req = SevenDayTaskExtension_pb.PM_GainSevenDayTaskPrizeReq()

	req.taskId = taskId

	self:sendMsg(req)
	self:addEventOnce(SevenDayTaskAgent.PM_GainSevenDayTaskPrizeRes, handler, handlerObj, errHandler)
end

function SevenDayTaskAgent:handlePM_GainSevenDayTaskPrizeRes(status, msg)
	self:dispatch(SevenDayTaskAgent.PM_GainSevenDayTaskPrizeRes, status, msg)
end

function SevenDayTaskAgent:sendPM_GainSevenDayTaskScorePrizeReq(prizeIndex, handler, handlerObj, errHandler)
	local req = SevenDayTaskExtension_pb.PM_GainSevenDayTaskScorePrizeReq()

	req.prizeIndex = prizeIndex

	self:sendMsg(req)
	self:addEventOnce(SevenDayTaskAgent.PM_GainSevenDayTaskScorePrizeRes, handler, handlerObj, errHandler)
end

function SevenDayTaskAgent:handlePM_GainSevenDayTaskScorePrizeRes(status, msg)
	self:dispatch(SevenDayTaskAgent.PM_GainSevenDayTaskScorePrizeRes, status, msg)
end

SevenDayTaskAgent.instance = SevenDayTaskAgent.New()

return SevenDayTaskAgent
