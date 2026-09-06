-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/strength/agent/StrengthAgent.lua

module("logic.extensions.strength.agent.StrengthAgent", package.seeall)

local StrengthAgent = class("StrengthAgent", BaseAgent)

StrengthAgent.PM_StrengthInfoRes = "StrengthAgent_PM_StrengthInfoRes"
StrengthAgent.PM_StrengthBuyRes = "StrengthAgent_PM_StrengthBuyRes"
StrengthAgent.PM_StrengthGetFreeRes = "StrengthAgent_PM_StrengthGetFreeRes"
StrengthAgent.PM_StrengthCompensateRes = "StrengthAgent_PM_StrengthCompensateRes"
StrengthAgent.PM_NotifyStrengthChangeRes = "StrengthAgent_PM_NotifyStrengthChangeRes"

function StrengthAgent:ctor()
	return
end

function StrengthAgent:setExtId(extId)
	StrengthAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function StrengthAgent:sendPM_StrengthInfoReq(handler, handlerObj, errHandler)
	local req = StrengthExtension_pb.PM_StrengthInfoReq()

	self:sendMsg(req)
	self:addEventOnce(StrengthAgent.PM_StrengthInfoRes, handler, handlerObj, errHandler)
end

function StrengthAgent:handlePM_StrengthInfoRes(status, msg)
	self:dispatch(StrengthAgent.PM_StrengthInfoRes, status, msg)
end

function StrengthAgent:sendPM_StrengthBuyReq(buyTimes, handler, handlerObj, errHandler)
	local req = StrengthExtension_pb.PM_StrengthBuyReq()

	req.buyTimes = buyTimes

	self:sendMsg(req)
	self:addEventOnce(StrengthAgent.PM_StrengthBuyRes, handler, handlerObj, errHandler)
end

function StrengthAgent:handlePM_StrengthBuyRes(status, msg)
	self:dispatch(StrengthAgent.PM_StrengthBuyRes, status, msg)
end

function StrengthAgent:sendPM_StrengthGetFreeReq(index, handler, handlerObj, errHandler)
	local req = StrengthExtension_pb.PM_StrengthGetFreeReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		req.index = index

		self:sendMsg(req)
		self:addEventOnce(StrengthAgent.PM_StrengthGetFreeRes, handler, handlerObj, errHandler)
	end
end

function StrengthAgent:handlePM_StrengthGetFreeRes(status, msg)
	self:dispatch(StrengthAgent.PM_StrengthGetFreeRes, status, msg)
end

function StrengthAgent:sendPM_StrengthCompensateReq(index, handler, handlerObj, errHandler)
	local req = StrengthExtension_pb.PM_StrengthCompensateReq()

	req.index = index

	self:sendMsg(req)
	self:addEventOnce(StrengthAgent.PM_StrengthCompensateRes, handler, handlerObj, errHandler)
end

function StrengthAgent:handlePM_StrengthCompensateRes(status, msg)
	self:dispatch(StrengthAgent.PM_StrengthCompensateRes, status, msg)
end

function StrengthAgent:handlePM_NotifyStrengthChangeRes(status, msg)
	self:dispatch(StrengthAgent.PM_NotifyStrengthChangeRes, status, msg)
end

StrengthAgent.instance = StrengthAgent.New()

return StrengthAgent
