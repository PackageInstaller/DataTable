-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shop/agent/ShopAgent.lua

module("logic.extensions.shop.agent.ShopAgent", package.seeall)

local ShopAgent = class("ShopAgent", BaseAgent)

ShopAgent.GetLimitSellLeftCountsRes = "ShopAgent_GetLimitSellLeftCountsRes"
ShopAgent.BuyShopItemRes = "ShopAgent_BuyShopItemRes"

function ShopAgent:ctor()
	return
end

function ShopAgent:setExtId(extId)
	ShopAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ShopAgent:sendGetLimitSellLeftCountsReq(handler, handlerObj, errHandler)
	local req = ShopExtension_pb.GetLimitSellLeftCountsReq()

	self:sendMsg(req)
	self:addEventOnce(ShopAgent.GetLimitSellLeftCountsRes, handler, handlerObj, errHandler)
end

function ShopAgent:handleGetLimitSellLeftCountsRes(status, msg)
	self:dispatch(ShopAgent.GetLimitSellLeftCountsRes, status, msg)
end

function ShopAgent:sendBuyShopItemReq(id, count, expectPrice, handler, handlerObj, errHandler)
	local req = ShopExtension_pb.BuyShopItemReq()

	req.id = id
	req.count = count
	req.expectPrice = expectPrice

	self:sendMsg(req)
	self:addEventOnce(ShopAgent.BuyShopItemRes, handler, handlerObj, errHandler)
end

function ShopAgent:handleBuyShopItemRes(status, msg)
	self:dispatch(ShopAgent.BuyShopItemRes, status, msg)
end

ShopAgent.instance = ShopAgent.New()

return ShopAgent
