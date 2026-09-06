-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/endlessbattle/agent/InfiniteFightAgent.lua

module("logic.extensions.infinitefight.agent.InfiniteFightAgent", package.seeall)

local InfiniteFightAgent = class("InfiniteFightAgent", BaseAgent)

InfiniteFightAgent.InfiniteFightInfoRes = "InfiniteFightAgent_InfiniteFightInfoRes"
InfiniteFightAgent.SetInfiniteFightFormRes = "InfiniteFightAgent_SetInfiniteFightFormRes"
InfiniteFightAgent.GetInfiniteFightFormRes = "InfiniteFightAgent_GetInfiniteFightFormRes"
InfiniteFightAgent.InfiniteFightBuffRes = "InfiniteFightAgent_InfiniteFightBuffRes"
InfiniteFightAgent.InfiniteStartFightRes = "InfiniteFightAgent_InfiniteStartFightRes"
InfiniteFightAgent.InfiniteContinueFightRes = "InfiniteFightAgent_InfiniteContinueFightRes"
InfiniteFightAgent.NotifyInfiniteFightEndRes = "InfiniteFightAgent_NotifyInfiniteFightEndRes"
InfiniteFightAgent.InfiniteSweepRes = "InfiniteFightAgent_InfiniteSweepRes"
InfiniteFightAgent.InfiniteOneKeyFightRes = "InfiniteFightAgent_InfiniteOneKeyFightRes"

function InfiniteFightAgent:ctor()
	return
end

function InfiniteFightAgent:setExtId(extId)
	InfiniteFightAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function InfiniteFightAgent:sendInfiniteFightInfoReq(handler, handlerObj, errHandler)
	local req = InfiniteFightExtension_pb.InfiniteFightInfoReq()

	self:sendMsg(req)
	self:addEventOnce(InfiniteFightAgent.InfiniteFightInfoRes, handler, handlerObj, errHandler)
end

function InfiniteFightAgent:handleInfiniteFightInfoRes(status, msg)
	self:dispatch(InfiniteFightAgent.InfiniteFightInfoRes, status, msg)
end

function InfiniteFightAgent:sendSetInfiniteFightFormReq(simpleForm_pb, handler, handlerObj, errHandler)
	local req = InfiniteFightExtension_pb.SetInfiniteFightFormReq()

	if simpleForm_pb ~= nil then
		req.simpleForm:ParseFromString(simpleForm_pb:SerializeToString())
	end

	self:sendMsg(req)
	self:addEventOnce(InfiniteFightAgent.SetInfiniteFightFormRes, handler, handlerObj, errHandler)
end

function InfiniteFightAgent:handleSetInfiniteFightFormRes(status, msg)
	self:dispatch(InfiniteFightAgent.SetInfiniteFightFormRes, status, msg)
end

function InfiniteFightAgent:sendGetInfiniteFightFormReq(handler, handlerObj, errHandler)
	local req = InfiniteFightExtension_pb.GetInfiniteFightFormReq()

	self:sendMsg(req)
	self:addEventOnce(InfiniteFightAgent.GetInfiniteFightFormRes, handler, handlerObj, errHandler)
end

function InfiniteFightAgent:handleGetInfiniteFightFormRes(status, msg)
	self:dispatch(InfiniteFightAgent.GetInfiniteFightFormRes, status, msg)
end

function InfiniteFightAgent:sendInfiniteFightBuffReq(handler, handlerObj, errHandler)
	local req = InfiniteFightExtension_pb.InfiniteFightBuffReq()

	self:sendMsg(req)
	self:addEventOnce(InfiniteFightAgent.InfiniteFightBuffRes, handler, handlerObj, errHandler)
end

function InfiniteFightAgent:handleInfiniteFightBuffRes(status, msg)
	self:dispatch(InfiniteFightAgent.InfiniteFightBuffRes, status, msg)
end

function InfiniteFightAgent:sendInfiniteStartFightReq(buff, handler, handlerObj, errHandler)
	local req = InfiniteFightExtension_pb.InfiniteStartFightReq()

	req.buff = buff

	self:sendMsg(req)
	self:addEventOnce(InfiniteFightAgent.InfiniteStartFightRes, handler, handlerObj, errHandler)
end

function InfiniteFightAgent:handleInfiniteStartFightRes(status, msg)
	self:dispatch(InfiniteFightAgent.InfiniteStartFightRes, status, msg)
end

function InfiniteFightAgent:sendInfiniteContinueFightReq(handler, handlerObj, errHandler)
	local req = InfiniteFightExtension_pb.InfiniteContinueFightReq()

	self:sendMsg(req)
	self:addEventOnce(InfiniteFightAgent.InfiniteContinueFightRes, handler, handlerObj, errHandler)
end

function InfiniteFightAgent:handleInfiniteContinueFightRes(status, msg)
	self:dispatch(InfiniteFightAgent.InfiniteContinueFightRes, status, msg)
end

function InfiniteFightAgent:handleNotifyInfiniteFightEndRes(status, msg)
	self:dispatch(InfiniteFightAgent.NotifyInfiniteFightEndRes, status, msg)
end

function InfiniteFightAgent:sendInfiniteSweepReq(handler, handlerObj, errHandler)
	local req = InfiniteFightExtension_pb.InfiniteSweepReq()

	self:sendMsg(req)
	self:addEventOnce(InfiniteFightAgent.InfiniteSweepRes, handler, handlerObj, errHandler)
end

function InfiniteFightAgent:handleInfiniteSweepRes(status, msg)
	self:dispatch(InfiniteFightAgent.InfiniteSweepRes, status, msg)
end

function InfiniteFightAgent:sendInfiniteOneKeyFightReq(handler, handlerObj, errHandler)
	local req = InfiniteFightExtension_pb.InfiniteOneKeyFightReq()

	self:sendMsg(req)
	self:addEventOnce(InfiniteFightAgent.InfiniteOneKeyFightRes, handler, handlerObj, errHandler)
end

function InfiniteFightAgent:handleInfiniteOneKeyFightRes(status, msg)
	self:dispatch(InfiniteFightAgent.InfiniteOneKeyFightRes, status, msg)
end

InfiniteFightAgent.instance = InfiniteFightAgent.New()

return InfiniteFightAgent
