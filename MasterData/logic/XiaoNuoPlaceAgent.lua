-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/agent/XiaoNuoPlaceAgent.lua

module("logic.extensions.xiaonuoplace.agent.XiaoNuoPlaceAgent", package.seeall)

local XiaoNuoPlaceAgent = class("XiaoNuoPlaceAgent", BaseAgent)

XiaoNuoPlaceAgent.PM_XiaoNuoPlaceInfoRes = "XiaoNuoPlaceAgent_PM_XiaoNuoPlaceInfoRes"
XiaoNuoPlaceAgent.PM_XiaoNuoPrizeRes = "XiaoNuoPlaceAgent_PM_XiaoNuoPrizeRes"
XiaoNuoPlaceAgent.PM_XiaoNuoRankRes = "XiaoNuoPlaceAgent_PM_XiaoNuoRankRes"
XiaoNuoPlaceAgent.PM_XiaoNuoBuyRes = "XiaoNuoPlaceAgent_PM_XiaoNuoBuyRes"
XiaoNuoPlaceAgent.PM_XiaoNuoComposeRes = "XiaoNuoPlaceAgent_PM_XiaoNuoComposeRes"
XiaoNuoPlaceAgent.PM_XiaoNuoMoveRes = "XiaoNuoPlaceAgent_PM_XiaoNuoMoveRes"
XiaoNuoPlaceAgent.PM_XiaoNuoDiscardRes = "XiaoNuoPlaceAgent_PM_XiaoNuoDiscardRes"
XiaoNuoPlaceAgent.PM_XiaoNuoCloseRes = "XiaoNuoPlaceAgent_PM_XiaoNuoCloseRes"
XiaoNuoPlaceAgent.PM_XiaoNuoOnPlayerReconnectRes = "XiaoNuoPlaceAgent_PM_XiaoNuoOnPlayerReconnectRes"
XiaoNuoPlaceAgent.PM_XiaoNuoOneKeyComposeRes = "XiaoNuoPlaceAgent_PM_XiaoNuoOneKeyComposeRes"
XiaoNuoPlaceAgent.PM_XiaoNuoGainActivityPrizeRes = "XiaoNuoPlaceAgent_PM_XiaoNuoGainActivityPrizeRes"

function XiaoNuoPlaceAgent:ctor()
	return
end

function XiaoNuoPlaceAgent:setExtId(extId)
	XiaoNuoPlaceAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function XiaoNuoPlaceAgent:sendPM_XiaoNuoPlaceInfoReq(handler, handlerObj, errHandler)
	local req = XiaoNuoPlaceExtension_pb.PM_XiaoNuoPlaceInfoReq()

	self:sendMsg(req)
	self:addEventOnce(XiaoNuoPlaceAgent.PM_XiaoNuoPlaceInfoRes, handler, handlerObj, errHandler)
end

function XiaoNuoPlaceAgent:handlePM_XiaoNuoPlaceInfoRes(status, msg)
	self:dispatch(XiaoNuoPlaceAgent.PM_XiaoNuoPlaceInfoRes, status, msg)
end

function XiaoNuoPlaceAgent:sendPM_XiaoNuoPrizeReq(index, handler, handlerObj, errHandler)
	local req = XiaoNuoPlaceExtension_pb.PM_XiaoNuoPrizeReq()

	req.index = index

	self:sendMsg(req)
	self:addEventOnce(XiaoNuoPlaceAgent.PM_XiaoNuoPrizeRes, handler, handlerObj, errHandler)
end

function XiaoNuoPlaceAgent:handlePM_XiaoNuoPrizeRes(status, msg)
	self:dispatch(XiaoNuoPlaceAgent.PM_XiaoNuoPrizeRes, status, msg)
end

function XiaoNuoPlaceAgent:sendPM_XiaoNuoRankReq(handler, handlerObj, errHandler)
	local req = XiaoNuoPlaceExtension_pb.PM_XiaoNuoRankReq()

	self:sendMsg(req)
	self:addEventOnce(XiaoNuoPlaceAgent.PM_XiaoNuoRankRes, handler, handlerObj, errHandler)
end

function XiaoNuoPlaceAgent:handlePM_XiaoNuoRankRes(status, msg)
	self:dispatch(XiaoNuoPlaceAgent.PM_XiaoNuoRankRes, status, msg)
end

function XiaoNuoPlaceAgent:sendPM_XiaoNuoBuyReq(level, handler, handlerObj, errHandler)
	local req = XiaoNuoPlaceExtension_pb.PM_XiaoNuoBuyReq()

	req.level = level

	self:sendMsg(req)
	self:addEventOnce(XiaoNuoPlaceAgent.PM_XiaoNuoBuyRes, handler, handlerObj, errHandler)
end

function XiaoNuoPlaceAgent:handlePM_XiaoNuoBuyRes(status, msg)
	self:dispatch(XiaoNuoPlaceAgent.PM_XiaoNuoBuyRes, status, msg)
end

function XiaoNuoPlaceAgent:sendPM_XiaoNuoComposeReq(source, target, handler, handlerObj, errHandler)
	local req = XiaoNuoPlaceExtension_pb.PM_XiaoNuoComposeReq()

	req.source = source
	req.target = target

	self:sendMsg(req)
	self:addEventOnce(XiaoNuoPlaceAgent.PM_XiaoNuoComposeRes, handler, handlerObj, errHandler)
end

function XiaoNuoPlaceAgent:handlePM_XiaoNuoComposeRes(status, msg)
	self:dispatch(XiaoNuoPlaceAgent.PM_XiaoNuoComposeRes, status, msg)
end

function XiaoNuoPlaceAgent:sendPM_XiaoNuoMoveReq(cur, target, handler, handlerObj, errHandler)
	local req = XiaoNuoPlaceExtension_pb.PM_XiaoNuoMoveReq()

	req.cur = cur
	req.target = target

	self:sendMsg(req)
	self:addEventOnce(XiaoNuoPlaceAgent.PM_XiaoNuoMoveRes, handler, handlerObj, errHandler)
end

function XiaoNuoPlaceAgent:handlePM_XiaoNuoMoveRes(status, msg)
	self:dispatch(XiaoNuoPlaceAgent.PM_XiaoNuoMoveRes, status, msg)
end

function XiaoNuoPlaceAgent:sendPM_XiaoNuoDiscardReq(position, handler, handlerObj, errHandler)
	local req = XiaoNuoPlaceExtension_pb.PM_XiaoNuoDiscardReq()

	req.position = position

	self:sendMsg(req)
	self:addEventOnce(XiaoNuoPlaceAgent.PM_XiaoNuoDiscardRes, handler, handlerObj, errHandler)
end

function XiaoNuoPlaceAgent:handlePM_XiaoNuoDiscardRes(status, msg)
	self:dispatch(XiaoNuoPlaceAgent.PM_XiaoNuoDiscardRes, status, msg)
end

function XiaoNuoPlaceAgent:sendPM_XiaoNuoCloseReq(handler, handlerObj, errHandler)
	local req = XiaoNuoPlaceExtension_pb.PM_XiaoNuoCloseReq()

	self:sendMsg(req)
	self:addEventOnce(XiaoNuoPlaceAgent.PM_XiaoNuoCloseRes, handler, handlerObj, errHandler)
end

function XiaoNuoPlaceAgent:handlePM_XiaoNuoCloseRes(status, msg)
	self:dispatch(XiaoNuoPlaceAgent.PM_XiaoNuoCloseRes, status, msg)
end

function XiaoNuoPlaceAgent:handlePM_XiaoNuoOnPlayerReconnectRes(status, msg)
	self:dispatch(XiaoNuoPlaceAgent.PM_XiaoNuoOnPlayerReconnectRes, status, msg)
end

function XiaoNuoPlaceAgent:sendPM_XiaoNuoOneKeyComposeReq(handler, handlerObj, errHandler)
	local req = XiaoNuoPlaceExtension_pb.PM_XiaoNuoOneKeyComposeReq()

	self:sendMsg(req)
	self:addEventOnce(XiaoNuoPlaceAgent.PM_XiaoNuoOneKeyComposeRes, handler, handlerObj, errHandler)
end

function XiaoNuoPlaceAgent:handlePM_XiaoNuoOneKeyComposeRes(status, msg)
	self:dispatch(XiaoNuoPlaceAgent.PM_XiaoNuoOneKeyComposeRes, status, msg)
end

function XiaoNuoPlaceAgent:sendPM_XiaoNuoGainActivityPrizeReq(index, handler, handlerObj, errHandler)
	local req = XiaoNuoPlaceExtension_pb.PM_XiaoNuoGainActivityPrizeReq()

	req.index = index

	self:sendMsg(req)
	self:addEventOnce(XiaoNuoPlaceAgent.PM_XiaoNuoGainActivityPrizeRes, handler, handlerObj, errHandler)
end

function XiaoNuoPlaceAgent:handlePM_XiaoNuoGainActivityPrizeRes(status, msg)
	self:dispatch(XiaoNuoPlaceAgent.PM_XiaoNuoGainActivityPrizeRes, status, msg)
end

XiaoNuoPlaceAgent.instance = XiaoNuoPlaceAgent.New()

return XiaoNuoPlaceAgent
