-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitrank/agent/TimeLimitRankAgent.lua

module("logic.extensions.timelimitrank.agent.TimeLimitRankAgent", package.seeall)

local TimeLimitRankAgent = class("TimeLimitRankAgent", BaseAgent)

TimeLimitRankAgent.PM_TimeLimitRankGetTopInfoRes = "TimeLimitRankAgent_PM_TimeLimitRankGetTopInfoRes"
TimeLimitRankAgent.PM_TimeLimitRankGetProgressInfoRes = "TimeLimitRankAgent_PM_TimeLimitRankGetProgressInfoRes"
TimeLimitRankAgent.PM_TimeLimitRankGainProgressPrizeRes = "TimeLimitRankAgent_PM_TimeLimitRankGainProgressPrizeRes"

function TimeLimitRankAgent:ctor()
	return
end

function TimeLimitRankAgent:setExtId(extId)
	TimeLimitRankAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function TimeLimitRankAgent:sendPM_TimeLimitRankGetTopInfoReq(id, handler, handlerObj, errHandler)
	local req = TimeLimitRankExtension_pb.PM_TimeLimitRankGetTopInfoReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(TimeLimitRankAgent.PM_TimeLimitRankGetTopInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function TimeLimitRankAgent:handlePM_TimeLimitRankGetTopInfoRes(status, msg)
	self:dispatch(TimeLimitRankAgent.PM_TimeLimitRankGetTopInfoRes, status, msg)
end

function TimeLimitRankAgent:sendPM_TimeLimitRankGetProgressInfoReq(handler, handlerObj, errHandler)
	local req = TimeLimitRankExtension_pb.PM_TimeLimitRankGetProgressInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(TimeLimitRankAgent.PM_TimeLimitRankGetProgressInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function TimeLimitRankAgent:handlePM_TimeLimitRankGetProgressInfoRes(status, msg)
	self:dispatch(TimeLimitRankAgent.PM_TimeLimitRankGetProgressInfoRes, status, msg)
end

function TimeLimitRankAgent:sendPM_TimeLimitRankGainProgressPrizeReq(id, index, handler, handlerObj, errHandler)
	local req = TimeLimitRankExtension_pb.PM_TimeLimitRankGainProgressPrizeReq()

	req.id = id
	req.index = index

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(TimeLimitRankAgent.PM_TimeLimitRankGainProgressPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function TimeLimitRankAgent:handlePM_TimeLimitRankGainProgressPrizeRes(status, msg)
	self:dispatch(TimeLimitRankAgent.PM_TimeLimitRankGainProgressPrizeRes, status, msg)
end

TimeLimitRankAgent.instance = TimeLimitRankAgent.New()

return TimeLimitRankAgent
