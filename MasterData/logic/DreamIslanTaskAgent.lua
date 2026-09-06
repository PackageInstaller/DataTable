-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/agent/DreamIslanTaskAgent.lua

module("logic.extensions.accumulategift.agent.DreamIslanTaskAgent", package.seeall)

local DreamIslanTaskAgent = class("DreamIslanTaskAgent", BaseAgent)

DreamIslanTaskAgent.PM_DreamIslanTaskGetInfoRes = "DreamIslanTaskAgent_PM_DreamIslanTaskGetInfoRes"
DreamIslanTaskAgent.PM_GainDreamIslandTaskPrizeRes = "DreamIslanTaskAgent_PM_GainDreamIslandTaskPrizeRes"
DreamIslanTaskAgent.PM_GainDreamIslanTaskScorePrizeRes = "DreamIslanTaskAgent_PM_GainDreamIslanTaskScorePrizeRes"

function DreamIslanTaskAgent:ctor()
	return
end

function DreamIslanTaskAgent:setExtId(extId)
	DreamIslanTaskAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function DreamIslanTaskAgent:sendPM_DreamIslanTaskGetInfoReq(handler, handlerObj, errHandler)
	local req = DreamIslanTaskExtension_pb.PM_DreamIslanTaskGetInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DreamIslanTaskAgent.PM_DreamIslanTaskGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DreamIslanTaskAgent:handlePM_DreamIslanTaskGetInfoRes(status, msg)
	self:dispatch(DreamIslanTaskAgent.PM_DreamIslanTaskGetInfoRes, status, msg)
end

function DreamIslanTaskAgent:sendPM_GainDreamIslandTaskPrizeReq(activityId, taskId, handler, handlerObj, errHandler)
	local req = DreamIslanTaskExtension_pb.PM_GainDreamIslandTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DreamIslanTaskAgent.PM_GainDreamIslandTaskPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DreamIslanTaskAgent:handlePM_GainDreamIslandTaskPrizeRes(status, msg)
	self:dispatch(DreamIslanTaskAgent.PM_GainDreamIslandTaskPrizeRes, status, msg)
end

function DreamIslanTaskAgent:sendPM_GainDreamIslanTaskScorePrizeReq(activityId, prizeIndex, handler, handlerObj, errHandler)
	local req = DreamIslanTaskExtension_pb.PM_GainDreamIslanTaskScorePrizeReq()

	req.activityId = activityId
	req.prizeIndex = prizeIndex

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(DreamIslanTaskAgent.PM_GainDreamIslanTaskScorePrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function DreamIslanTaskAgent:handlePM_GainDreamIslanTaskScorePrizeRes(status, msg)
	self:dispatch(DreamIslanTaskAgent.PM_GainDreamIslanTaskScorePrizeRes, status, msg)
end

DreamIslanTaskAgent.instance = DreamIslanTaskAgent.New()

return DreamIslanTaskAgent
