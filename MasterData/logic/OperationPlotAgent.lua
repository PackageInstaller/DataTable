-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/agent/OperationPlotAgent.lua

module("logic.extensions.operationplot.agent.OperationPlotAgent", package.seeall)

local OperationPlotAgent = class("OperationPlotAgent", BaseAgent)

OperationPlotAgent.PM_OperationPlotInfoRes = "OperationPlotAgent_PM_OperationPlotInfoRes"
OperationPlotAgent.PM_OperationPlotChallengeRes = "OperationPlotAgent_PM_OperationPlotChallengeRes"
OperationPlotAgent.PM_OperationPlotChallengeEndRes = "OperationPlotAgent_PM_OperationPlotChallengeEndRes"
OperationPlotAgent.PM_OperationPlotSweepsByTimesRes = "OperationPlotAgent_PM_OperationPlotSweepsByTimesRes"
OperationPlotAgent.PM_OperationPlotSweepAutoRes = "OperationPlotAgent_PM_OperationPlotSweepAutoRes"
OperationPlotAgent.PM_OperationPlotGainBuffPrizeRes = "OperationPlotAgent_PM_OperationPlotGainBuffPrizeRes"

function OperationPlotAgent:ctor()
	return
end

function OperationPlotAgent:setExtId(extId)
	OperationPlotAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function OperationPlotAgent:sendPM_OperationPlotInfoReq(handler, handlerObj, errHandler)
	local req = OperationPlotExtension_pb.PM_OperationPlotInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(OperationPlotAgent.PM_OperationPlotInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function OperationPlotAgent:handlePM_OperationPlotInfoRes(status, msg)
	self:dispatch(OperationPlotAgent.PM_OperationPlotInfoRes, status, msg)
end

function OperationPlotAgent:sendPM_OperationPlotChallengeReq(activityId, typeId, chapterId, stageId, form_pb, handler, handlerObj, errHandler)
	local req = OperationPlotExtension_pb.PM_OperationPlotChallengeReq()

	req.activityId = activityId
	req.typeId = typeId
	req.chapterId = chapterId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(OperationPlotAgent.PM_OperationPlotChallengeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function OperationPlotAgent:handlePM_OperationPlotChallengeRes(status, msg)
	self:dispatch(OperationPlotAgent.PM_OperationPlotChallengeRes, status, msg)
end

function OperationPlotAgent:handlePM_OperationPlotChallengeEndRes(status, msg)
	self:dispatch(OperationPlotAgent.PM_OperationPlotChallengeEndRes, status, msg)
end

function OperationPlotAgent:sendPM_OperationPlotSweepsByTimesReq(activityId, typeId, chapterId, stageId, times, handler, handlerObj, errHandler)
	local req = OperationPlotExtension_pb.PM_OperationPlotSweepsByTimesReq()

	req.activityId = activityId
	req.typeId = typeId
	req.chapterId = chapterId
	req.stageId = stageId
	req.times = times

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(OperationPlotAgent.PM_OperationPlotSweepsByTimesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function OperationPlotAgent:handlePM_OperationPlotSweepsByTimesRes(status, msg)
	self:dispatch(OperationPlotAgent.PM_OperationPlotSweepsByTimesRes, status, msg)
end

function OperationPlotAgent:sendPM_OperationPlotSweepAutoReq(activityId, typeId, chapterId, stageId, materialType, materialId, num, handler, handlerObj, errHandler)
	local req = OperationPlotExtension_pb.PM_OperationPlotSweepAutoReq()

	req.activityId = activityId
	req.typeId = typeId
	req.chapterId = chapterId
	req.stageId = stageId
	req.materialType = materialType
	req.materialId = materialId
	req.num = num

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(OperationPlotAgent.PM_OperationPlotSweepAutoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function OperationPlotAgent:handlePM_OperationPlotSweepAutoRes(status, msg)
	self:dispatch(OperationPlotAgent.PM_OperationPlotSweepAutoRes, status, msg)
end

function OperationPlotAgent:sendPM_OperationPlotGainBuffPrizeReq(activityId, handler, handlerObj, errHandler)
	local req = OperationPlotExtension_pb.PM_OperationPlotGainBuffPrizeReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(OperationPlotAgent.PM_OperationPlotGainBuffPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function OperationPlotAgent:handlePM_OperationPlotGainBuffPrizeRes(status, msg)
	self:dispatch(OperationPlotAgent.PM_OperationPlotGainBuffPrizeRes, status, msg)
end

OperationPlotAgent.instance = OperationPlotAgent.New()

return OperationPlotAgent
