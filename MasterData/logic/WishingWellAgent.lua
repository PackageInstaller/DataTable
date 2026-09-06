-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/agent/WishingWellAgent.lua

module("logic.extensions.sevendays.agent.WishingWellAgent", package.seeall)

local WishingWellAgent = class("WishingWellAgent", BaseAgent)

WishingWellAgent.WishingWellInfoRes = "WishingWellAgent_WishingWellInfoRes"
WishingWellAgent.WishingWellDrawRes = "WishingWellAgent_WishingWellDrawRes"
WishingWellAgent.WishingWellShopBuyRes = "WishingWellAgent_WishingWellShopBuyRes"
WishingWellAgent.WishingWellBroadcastRes = "WishingWellAgent_WishingWellBroadcastRes"
WishingWellAgent.NotifyWishingWellShopBuySucRes = "WishingWellAgent_NotifyWishingWellShopBuySucRes"

function WishingWellAgent:ctor()
	return
end

function WishingWellAgent:setExtId(extId)
	WishingWellAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function WishingWellAgent:sendWishingWellInfoReq(handler, handlerObj, errHandler)
	local req = WishingWellExtension_pb.WishingWellInfoReq()

	self:sendMsg(req)
	self:addEventOnce(WishingWellAgent.WishingWellInfoRes, handler, handlerObj, errHandler)
end

function WishingWellAgent:handleWishingWellInfoRes(status, msg)
	self:dispatch(WishingWellAgent.WishingWellInfoRes, status, msg)
end

function WishingWellAgent:sendWishingWellDrawReq(times, handler, handlerObj, errHandler)
	local req = WishingWellExtension_pb.WishingWellDrawReq()

	req.times = times

	self:sendMsg(req)
	self:addEventOnce(WishingWellAgent.WishingWellDrawRes, handler, handlerObj, errHandler)
end

function WishingWellAgent:handleWishingWellDrawRes(status, msg)
	self:dispatch(WishingWellAgent.WishingWellDrawRes, status, msg)
end

function WishingWellAgent:sendWishingWellShopBuyReq(itemId, handler, handlerObj, errHandler)
	local req = WishingWellExtension_pb.WishingWellShopBuyReq()

	req.itemId = itemId

	self:sendMsg(req)
	self:addEventOnce(WishingWellAgent.WishingWellShopBuyRes, handler, handlerObj, errHandler)
end

function WishingWellAgent:handleWishingWellShopBuyRes(status, msg)
	self:dispatch(WishingWellAgent.WishingWellShopBuyRes, status, msg)
end

function WishingWellAgent:sendWishingWellBroadcastReq(handler, handlerObj, errHandler)
	local req = WishingWellExtension_pb.WishingWellBroadcastReq()

	self:sendMsg(req)
	self:addEventOnce(WishingWellAgent.WishingWellBroadcastRes, handler, handlerObj, errHandler)
end

function WishingWellAgent:handleWishingWellBroadcastRes(status, msg)
	self:dispatch(WishingWellAgent.WishingWellBroadcastRes, status, msg)
end

function WishingWellAgent:handleNotifyWishingWellShopBuySucRes(status, msg)
	self:dispatch(WishingWellAgent.NotifyWishingWellShopBuySucRes, status, msg)
end

WishingWellAgent.instance = WishingWellAgent.New()

return WishingWellAgent
