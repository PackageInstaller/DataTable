-- chunkname: @modules/logic/room/controller/RoomTradeController.lua

module("modules.logic.room.controller.RoomTradeController", package.seeall)

local RoomTradeController = class("RoomTradeController", BaseController)

function RoomTradeController:finishDailyOrder(type, orderId, sellCount)
	RoomRpc.instance:sendFinishOrderRequest(type, orderId, sellCount)

	local moList = {}

	if type == RoomTradeEnum.Mode.DailyOrder then
		local orderMo = RoomTradeModel.instance:getDailyOrderById(orderId)
		local price = orderMo:getPrice()

		if not string.nilorempty(price) then
			local split = GameUtil.splitString2(price, true)

			for _, v in ipairs(split) do
				local mo = {
					materilType = v[1],
					materilId = v[2],
					quantity = orderMo:getPriceCount()
				}

				table.insert(moList, mo)
			end
		end
	else
		local orderMo = RoomTradeModel.instance:getWholesaleGoodsById(orderId)
		local type, id, price = orderMo:getUnitPrice()
		local mo = {
			materilType = type,
			materilId = id,
			quantity = price * sellCount
		}

		table.insert(moList, mo)
	end

	if LuaUtil.tableNotEmpty(moList) then
		RoomController.instance:showInteractionRewardToast(moList)
	end

	self:dispatchEvent(RoomTradeEvent.OnFlyCurrency)
end

function RoomTradeController:onFinishOrderReply(msg)
	if msg.orderType == RoomTradeEnum.Mode.DailyOrder then
		RoomTradeModel.instance:onFinishDailyOrder(msg.orderId, msg.newPurchaseOrderInfo, msg.remainRefreshCount)
	else
		RoomTradeModel.instance:onFinishWholesaleGoods(msg.orderId, msg.soldCount, msg.weeklyWholesaleRevenue)
	end

	self:dispatchEvent(RoomTradeEvent.OnFinishOrder, msg.orderType)
end

function RoomTradeController:refreshDailyOrder(orderId, guideId, stepId, callback, callbackObj)
	RoomRpc.instance:sendRefreshPurchaseOrderRequest(orderId, guideId, stepId, callback, callbackObj)
end

function RoomTradeController:onRefreshDailyOrderReply(msg)
	RoomTradeModel.instance:onRefeshDailyOrder(msg.orderInfo, msg.remainRefreshCount)
	self:dispatchEvent(RoomTradeEvent.OnRefreshDailyOrder)
end

function RoomTradeController:tracedDailyOrder(orderId, isTrace)
	RoomRpc.instance:sendChangePurchaseOrderTraceStateRequest(orderId, isTrace)
end

function RoomTradeController:onTracedDailyOrderReply(msg)
	RoomTradeModel.instance:onTracedDailyOrder(msg.orderId, msg.isTrace)
	self:dispatchEvent(RoomTradeEvent.OnTracedDailyOrder, msg.orderId)
end

function RoomTradeController:lockedDailyOrder(orderId, isLocked)
	RoomRpc.instance:sendLockOrderRequest(orderId, isLocked)
end

function RoomTradeController:onLockedDailyOrderReply(msg)
	RoomTradeModel.instance:setIsLockedOrder(msg.orderId, msg.isLocked)
	self:dispatchEvent(RoomTradeEvent.OnLockedDailyOrder, msg.orderId)
end

function RoomTradeController:openLevelUpTipView(level)
	local param = {
		level = level
	}

	ViewMgr.instance:openView(ViewName.RoomTradeLevelUpTipsView, param)
end

RoomTradeController.instance = RoomTradeController.New()

return RoomTradeController
