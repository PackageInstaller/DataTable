-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/agent/ScratchAgent.lua

module("logic.extensions.scratch.agent.ScratchAgent", package.seeall)

local ScratchAgent = class("ScratchAgent", BaseAgent)

ScratchAgent.PM_GetScratchUserInfoRes = "ScratchAgent_PM_GetScratchUserInfoRes"
ScratchAgent.PM_ScratchExchangeRes = "ScratchAgent_PM_ScratchExchangeRes"
ScratchAgent.PM_ScratchSelectBigPrizeRes = "ScratchAgent_PM_ScratchSelectBigPrizeRes"
ScratchAgent.PM_ScratchDigRes = "ScratchAgent_PM_ScratchDigRes"
ScratchAgent.PM_ScratchResetRes = "ScratchAgent_PM_ScratchResetRes"
ScratchAgent.PM_ScratchSwitchPrizeRes = "ScratchAgent_PM_ScratchSwitchPrizeRes"

function ScratchAgent:ctor()
	return
end

function ScratchAgent:setExtId(extId)
	ScratchAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ScratchAgent:sendPM_GetScratchUserInfoReq(handler, handlerObj, errHandler)
	local req = ScratchExtension_pb.PM_GetScratchUserInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScratchAgent.PM_GetScratchUserInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScratchAgent:handlePM_GetScratchUserInfoRes(status, msg)
	self:dispatch(ScratchAgent.PM_GetScratchUserInfoRes, status, msg)
end

function ScratchAgent:sendPM_ScratchExchangeReq(exchangeNum, handler, handlerObj, errHandler)
	local req = ScratchExtension_pb.PM_ScratchExchangeReq()

	req.exchangeNum = exchangeNum

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScratchAgent.PM_ScratchExchangeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScratchAgent:handlePM_ScratchExchangeRes(status, msg)
	self:dispatch(ScratchAgent.PM_ScratchExchangeRes, status, msg)
end

function ScratchAgent:sendPM_ScratchSelectBigPrizeReq(prizeId, handler, handlerObj, errHandler)
	local req = ScratchExtension_pb.PM_ScratchSelectBigPrizeReq()

	req.prizeId = prizeId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScratchAgent.PM_ScratchSelectBigPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScratchAgent:handlePM_ScratchSelectBigPrizeRes(status, msg)
	self:dispatch(ScratchAgent.PM_ScratchSelectBigPrizeRes, status, msg)
end

function ScratchAgent:sendPM_ScratchDigReq(xAxis, yAxis, handler, handlerObj, errHandler)
	local req = ScratchExtension_pb.PM_ScratchDigReq()

	req.xAxis = xAxis
	req.yAxis = yAxis

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScratchAgent.PM_ScratchDigRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScratchAgent:handlePM_ScratchDigRes(status, msg)
	self:dispatch(ScratchAgent.PM_ScratchDigRes, status, msg)
end

function ScratchAgent:sendPM_ScratchResetReq(handler, handlerObj, errHandler)
	local req = ScratchExtension_pb.PM_ScratchResetReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScratchAgent.PM_ScratchResetRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScratchAgent:handlePM_ScratchResetRes(status, msg)
	self:dispatch(ScratchAgent.PM_ScratchResetRes, status, msg)
end

function ScratchAgent:sendPM_ScratchSwitchPrizeReq(prizeId, handler, handlerObj, errHandler)
	local req = ScratchExtension_pb.PM_ScratchSwitchPrizeReq()

	req.prizeId = prizeId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(ScratchAgent.PM_ScratchSwitchPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function ScratchAgent:handlePM_ScratchSwitchPrizeRes(status, msg)
	self:dispatch(ScratchAgent.PM_ScratchSwitchPrizeRes, status, msg)
end

ScratchAgent.instance = ScratchAgent.New()

return ScratchAgent
