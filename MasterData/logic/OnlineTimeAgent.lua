-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/onlinetime/agent/OnlineTimeAgent.lua

module("logic.extensions.onlinetime.agent.OnlineTimeAgent", package.seeall)

local OnlineTimeAgent = class("OnlineTimeAgent", BaseAgent)

OnlineTimeAgent.OnlineTimeRes = "OnlineTimeAgent_OnlineTimeRes"
OnlineTimeAgent.OnlineTimePrizeInfoRes = "OnlineTimeAgent_OnlineTimePrizeInfoRes"
OnlineTimeAgent.OnlineTimePrizeRes = "OnlineTimeAgent_OnlineTimePrizeRes"

function OnlineTimeAgent:ctor()
	return
end

function OnlineTimeAgent:setExtId(extId)
	OnlineTimeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function OnlineTimeAgent:sendOnlineTimeReq(handler, handlerObj, errHandler)
	local req = OnlineTimeExtension_pb.OnlineTimeReq()

	self:sendMsg(req)
	self:addEventOnce(OnlineTimeAgent.OnlineTimeRes, handler, handlerObj, errHandler)
end

function OnlineTimeAgent:handleOnlineTimeRes(status, msg)
	self:dispatch(OnlineTimeAgent.OnlineTimeRes, status, msg)
end

function OnlineTimeAgent:sendOnlineTimePrizeInfoReq(handler, handlerObj, errHandler)
	local req = OnlineTimeExtension_pb.OnlineTimePrizeInfoReq()

	self:sendMsg(req)
	self:addEventOnce(OnlineTimeAgent.OnlineTimePrizeInfoRes, handler, handlerObj, errHandler)
end

function OnlineTimeAgent:handleOnlineTimePrizeInfoRes(status, msg)
	self:dispatch(OnlineTimeAgent.OnlineTimePrizeInfoRes, status, msg)
end

function OnlineTimeAgent:sendOnlineTimePrizeReq(id, prizeReq_pb, handler, handlerObj, errHandler)
	local req = OnlineTimeExtension_pb.OnlineTimePrizeReq()

	req.id = id

	req.prizeReq:ParseFromString(prizeReq_pb:SerializeToString())
	self:sendMsg(req)
	self:addEventOnce(OnlineTimeAgent.OnlineTimePrizeRes, handler, handlerObj, errHandler)
end

function OnlineTimeAgent:handleOnlineTimePrizeRes(status, msg)
	self:dispatch(OnlineTimeAgent.OnlineTimePrizeRes, status, msg)
end

OnlineTimeAgent.instance = OnlineTimeAgent.New()

return OnlineTimeAgent
