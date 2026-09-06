-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timecapsule/agent/TimeCapsuleAgent.lua

module("logic.extensions.timecapsule.agent.TimeCapsuleAgent", package.seeall)

local TimeCapsuleAgent = class("TimeCapsuleAgent", BaseAgent)

TimeCapsuleAgent.PM_TCGetInfoRes = "TimeCapsuleAgent_PM_TCGetInfoRes"
TimeCapsuleAgent.PM_TCActivateNotesRes = "TimeCapsuleAgent_PM_TCActivateNotesRes"
TimeCapsuleAgent.PM_TCGainDailyPrizeRes = "TimeCapsuleAgent_PM_TCGainDailyPrizeRes"
TimeCapsuleAgent.PM_TCGainProgressPrizeRes = "TimeCapsuleAgent_PM_TCGainProgressPrizeRes"
TimeCapsuleAgent.PM_TCSearchDesireRes = "TimeCapsuleAgent_PM_TCSearchDesireRes"

function TimeCapsuleAgent:ctor()
	return
end

function TimeCapsuleAgent:setExtId(extId)
	TimeCapsuleAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function TimeCapsuleAgent:sendPM_TCGetInfoReq(handler, handlerObj, errHandler)
	local req = TimeCapsuleExtension_pb.PM_TCGetInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(TimeCapsuleAgent.PM_TCGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function TimeCapsuleAgent:handlePM_TCGetInfoRes(status, msg)
	self:dispatch(TimeCapsuleAgent.PM_TCGetInfoRes, status, msg)
end

function TimeCapsuleAgent:sendPM_TCActivateNotesReq(noteIds_i32_Ary, handler, handlerObj, errHandler)
	local req = TimeCapsuleExtension_pb.PM_TCActivateNotesReq()

	for i, v1 in ipairs(noteIds_i32_Ary) do
		req.noteIds:append(v1)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(TimeCapsuleAgent.PM_TCActivateNotesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function TimeCapsuleAgent:handlePM_TCActivateNotesRes(status, msg)
	self:dispatch(TimeCapsuleAgent.PM_TCActivateNotesRes, status, msg)
end

function TimeCapsuleAgent:sendPM_TCGainDailyPrizeReq(handler, handlerObj, errHandler)
	local req = TimeCapsuleExtension_pb.PM_TCGainDailyPrizeReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(TimeCapsuleAgent.PM_TCGainDailyPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function TimeCapsuleAgent:handlePM_TCGainDailyPrizeRes(status, msg)
	self:dispatch(TimeCapsuleAgent.PM_TCGainDailyPrizeRes, status, msg)
end

function TimeCapsuleAgent:sendPM_TCGainProgressPrizeReq(id, handler, handlerObj, errHandler)
	local req = TimeCapsuleExtension_pb.PM_TCGainProgressPrizeReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(TimeCapsuleAgent.PM_TCGainProgressPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function TimeCapsuleAgent:handlePM_TCGainProgressPrizeRes(status, msg)
	self:dispatch(TimeCapsuleAgent.PM_TCGainProgressPrizeRes, status, msg)
end

function TimeCapsuleAgent:sendPM_TCSearchDesireReq(duoDuoHao, handler, handlerObj, errHandler)
	local req = TimeCapsuleExtension_pb.PM_TCSearchDesireReq()

	req.duoDuoHao = duoDuoHao

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(TimeCapsuleAgent.PM_TCSearchDesireRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function TimeCapsuleAgent:handlePM_TCSearchDesireRes(status, msg)
	self:dispatch(TimeCapsuleAgent.PM_TCSearchDesireRes, status, msg)
end

TimeCapsuleAgent.instance = TimeCapsuleAgent.New()

return TimeCapsuleAgent
