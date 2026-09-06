-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exchange/agent/ExchangeAgent.lua

module("logic.extensions.exchange.agent.ExchangeAgent", package.seeall)

local ExchangeAgent = class("ExchangeAgent", BaseAgent)

ExchangeAgent.ExchangeTabInfoRes = "ExchangeAgent_ExchangeTabInfoRes"
ExchangeAgent.ExchangeRes = "ExchangeAgent_ExchangeRes"
ExchangeAgent.ExchangeRefreshRes = "ExchangeAgent_ExchangeRefreshRes"

function ExchangeAgent:ctor()
	return
end

function ExchangeAgent:setExtId(extId)
	ExchangeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ExchangeAgent:sendExchangeTabInfoReq(tabId, handler, handlerObj, errHandler)
	local req = ExchangeExtension_pb.ExchangeTabInfoReq()

	req.tabId = tabId

	self:sendMsg(req)
	self:addEventOnce(ExchangeAgent.ExchangeTabInfoRes, handler, handlerObj, errHandler)
end

function ExchangeAgent:handleExchangeTabInfoRes(status, msg)
	self:dispatch(ExchangeAgent.ExchangeTabInfoRes, status, msg)
end

function ExchangeAgent:sendExchangeReq(tabId, posId, commodityId, num, handler, handlerObj, errHandler)
	local req = ExchangeExtension_pb.ExchangeReq()

	req.tabId = tabId
	req.posId = posId
	req.commodityId = commodityId
	req.num = num

	self:sendMsg(req)
	self:addEventOnce(ExchangeAgent.ExchangeRes, handler, handlerObj, errHandler)
end

function ExchangeAgent:handleExchangeRes(status, msg)
	self:dispatch(ExchangeAgent.ExchangeRes, status, msg)
end

function ExchangeAgent:sendExchangeRefreshReq(tabId, handler, handlerObj, errHandler)
	local req = ExchangeExtension_pb.ExchangeRefreshReq()

	req.tabId = tabId

	self:sendMsg(req)
	self:addEventOnce(ExchangeAgent.ExchangeRefreshRes, handler, handlerObj, errHandler)
end

function ExchangeAgent:handleExchangeRefreshRes(status, msg)
	self:dispatch(ExchangeAgent.ExchangeRefreshRes, status, msg)
end

function ExchangeAgent:sendExchangeAllOpenedTabIdsReq()
	local req = ExchangeExtension_pb.ExchangeAllOpenedTabIdsReq()

	self:sendMsg(req)
end

function ExchangeAgent:handleExchangeAllOpenedTabIdsRes(status, msg)
	if status == 0 then
		local tabids = msg.tabIds

		ExchangeController.instance:handleExchangeAllOpenedTabIds(tabids)
		GlobalDispatcher:dispatch(GlobalNotify.ExchangeAllOpenedTabIdsRes)
	end
end

ExchangeAgent.instance = ExchangeAgent.New()

return ExchangeAgent
