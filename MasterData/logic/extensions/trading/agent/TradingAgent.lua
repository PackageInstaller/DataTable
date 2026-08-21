-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/agent/TradingAgent.lua

module("logic.extensions.trading.agent.TradingAgent", package.seeall)

local M = class("TradingAgent", BaseAgent)

function M:sendGetTradePostInfoRequest()
	local msg = HouseExtension_pb.GetTradePostInfoRequest()

	self:sendMsg(msg)
end

function M:handleGetTradePostInfoReply(status, msg)
	if status == 0 then
		local tradePost = msg.tradePost

		TradingModel.instance:updateTradePostInfo(tradePost)
	end
end

function M:sendRefreshDailyOrderRequest(orderIndex)
	local msg = HouseExtension_pb.RefreshDailyOrderRequest()

	msg.orderIndex = orderIndex

	self:sendMsg(msg)
end

function M:handleRefreshDailyOrderReply(status, msg)
	if status == 0 then
		TradingModel.instance:updateDailyOrder(msg.dailyOrder)
		TradingModel.instance:setOrderRefreshTimes(msg.orderRefreshTimes)
		GlobalDispatcher:dispatchEvent(EventType.TRADING_ORDER_LIST)
	end
end

function M:sendAcceptOrderRequest(orderType, orderIndex)
	local msg = HouseExtension_pb.AcceptOrderRequest()

	msg.orderType = orderType
	msg.orderIndex = orderIndex

	self:sendMsg(msg)
end

function M:handleAcceptOrderReply(status, msg)
	if status == 0 then
		TradingModel.instance:updateDailyOrder(msg.dailyOrder)
		TradingModel.instance:updateWeeklyOrder(msg.weeklyOrder)
		GlobalDispatcher:dispatchEvent(EventType.TRADING_ORDER_LIST)
	end
end

function M:handleGainOrderPush(status, msg)
	if status == 0 then
		TradingModel.instance:updateDailyOrder(msg.dailyOrder)
		TradingModel.instance:updateWeeklyOrder(msg.weeklyOrder)
		TradingModel.instance:updateProductivity(msg.productivity)
		GlobalDispatcher:dispatchEvent(EventType.TRADING_ORDER_LIST)
	end
end

function M:sendOrderSpeedUpRequest(count)
	local msg = HouseExtension_pb.OrderSpeedUpRequest()

	msg.count = count

	self:sendMsg(msg)
end

function M:handleOrderSpeedUpReply(status, msg)
	if status == 0 then
		TradingModel.instance:updateProductivity(msg.productivity)
		TradingModel.instance:updateDailyOrder(msg.dailyOrder)
		GlobalDispatcher:dispatchEvent(EventType.TRADING_ORDER_LIST)
		FloatWordMgr.instance:show(lang("tip_trading_lang_6"))
	end
end

function M:sendTradePostLevelUpRequest()
	local msg = HouseExtension_pb.TradePostLevelUpRequest()

	self:sendMsg(msg)
end

function M:handleTradePostLevelUpReply(status, msg)
	if status == 0 then
		local level = msg.level

		TradingModel.instance:updateTradePostLevel(level)
		ViewMgr.instance:open(ViewName.DeviceUpgradeSucceed, HouseEnum.WorkType.Trading)
	end
end

function M:sendGetGoodsPriceRequest()
	local msg = HouseExtension_pb.GetGoodsPriceRequest()

	self:sendMsg(msg)
end

function M:handleGetGoodsPriceReply(status, msg)
	if status == 0 then
		TradingModel.instance:updateGoodsList(msg.goodsList)
		TradingModel.instance:updatePriceRefreshTime(msg.priceRefreshTime)
		TradingModel.instance:updateTradeInfo(msg.intelligenceSimple, msg.intelligenceComposite)
	end
end

function M:handleGoodsPricePush(status, msg)
	if status == 0 then
		TradingModel.instance:updateGoodsList(msg.goodsList)

		if msg.priceRefreshTime then
			TradingModel.instance:updatePriceRefreshTime(msg.priceRefreshTime)
		end

		HouseMainRoomModel.instance:setBackLogNum(HouseMainEnum.BackLogTyp.tradePriceChange, 1)
	end
end

function M:handleGoodsIntelligencePush(status, msg)
	if status == 0 then
		TradingModel.instance:updateTradeInfo(msg.intelligenceSimple, msg.intelligenceComposite)
	end
end

function M:sendSaleTradeGoodsRequest(itemId, count, price)
	local msg = HouseExtension_pb.SaleTradeGoodsRequest()

	msg.itemId = itemId
	msg.count = count
	msg.price = price

	self:sendMsg(msg)
end

function M:handleSaleTradeGoodsReply(status, msg)
	if status == 0 then
		FloatWordMgr.instance:show(lang("tip_trading_lang_7"))
		GlobalDispatcher:dispatchEvent(EventType.TRADING_GOOD_LIST, TradingModel.instance:getGoodList())
	end
end

M.instance = M.New()

return M
