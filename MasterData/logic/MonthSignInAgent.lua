-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signindaily/agent/MonthSignInAgent.lua

module("logic.extensions.monthsignin.agent.MonthSignInAgent", package.seeall)

local MonthSignInAgent = class("MonthSignInAgent", BaseAgent)

MonthSignInAgent.PM_MonthSignInGetInfoRes = "MonthSignInAgent_PM_MonthSignInGetInfoRes"
MonthSignInAgent.PM_GainMonthSignInPrizeRes = "MonthSignInAgent_PM_GainMonthSignInPrizeRes"

function MonthSignInAgent:ctor()
	return
end

function MonthSignInAgent:setExtId(extId)
	MonthSignInAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function MonthSignInAgent:sendPM_MonthSignInGetInfoReq(handler, handlerObj, errHandler)
	local req = MonthSignInExtension_pb.PM_MonthSignInGetInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MonthSignInAgent.PM_MonthSignInGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MonthSignInAgent:handlePM_MonthSignInGetInfoRes(status, msg)
	self:dispatch(MonthSignInAgent.PM_MonthSignInGetInfoRes, status, msg)
end

function MonthSignInAgent:sendPM_GainMonthSignInPrizeReq(handler, handlerObj, errHandler)
	local req = MonthSignInExtension_pb.PM_GainMonthSignInPrizeReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(MonthSignInAgent.PM_GainMonthSignInPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function MonthSignInAgent:handlePM_GainMonthSignInPrizeRes(status, msg)
	self:dispatch(MonthSignInAgent.PM_GainMonthSignInPrizeRes, status, msg)
end

MonthSignInAgent.instance = MonthSignInAgent.New()

return MonthSignInAgent
