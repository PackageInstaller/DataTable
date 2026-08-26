-- chunkname: @modules/logic/room/model/trade/RoomWholesaleOrderMo.lua

module("modules.logic.room.model.trade.RoomWholesaleOrderMo", package.seeall)

local RoomWholesaleOrderMo = class("RoomWholesaleOrderMo")

function RoomWholesaleOrderMo:ctor()
	self.orderId = nil
	self.goodId = nil
	self.todaySoldCount = nil
	self.co = nil
end

function RoomWholesaleOrderMo:initMo(info)
	self.orderId = info.orderId
	self.goodId = info.goodId
	self.todaySoldCount = info.todaySoldCount
	self.co = ManufactureConfig.instance:getManufactureItemCfg(self.goodId)

	local maxCount = self:getMaxCount()

	self.soldCount = RoomTradeModel.instance:isMaxWeelyOrder() and 0 or math.min(1, maxCount)
	self.itemCo = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, self.co.itemId)
end

function RoomWholesaleOrderMo:refreshTodaySoldCount(count)
	self.todaySoldCount = count
end

function RoomWholesaleOrderMo:getGoodsName()
	return self.itemCo and self.itemCo.name
end

function RoomWholesaleOrderMo:getGoodsIcon()
	return self.itemCo and self.itemCo.icon
end

function RoomWholesaleOrderMo:getMaxCount()
	return ManufactureModel.instance:getManufactureItemCount(self.goodId, false)
end

function RoomWholesaleOrderMo:getMaxCountStr()
	local count = self:getMaxCount()

	return GameUtil.numberDisplay(count)
end

function RoomWholesaleOrderMo:getTodaySoldCount()
	return self.todaySoldCount
end

function RoomWholesaleOrderMo:getTodaySoldCountStr()
	return GameUtil.numberDisplay(self.todaySoldCount)
end

function RoomWholesaleOrderMo:getItem()
	local itemCo = ManufactureConfig.instance:getManufactureItemCfg(self.goodId)
	local type = MaterialEnum.MaterialType.Item

	if itemCo then
		local itemId = itemCo.itemId

		return type, itemId
	end
end

function RoomWholesaleOrderMo:getUnitPrice()
	local type = MaterialEnum.MaterialType.Currency
	local id = CurrencyEnum.CurrencyType.RoomTrade
	local price = self.co.wholesalePrice

	return type, id, price
end

function RoomWholesaleOrderMo:getPriceRatio()
	local noraml = self.co.orderPrice
	local price = self.co.wholesalePrice

	return -math.floor((noraml - price) / noraml * 100 + 0.5)
end

function RoomWholesaleOrderMo:getSoldCount()
	local max = self:getMaxCount()

	max = math.min(max, self.soldCount)

	return max
end

function RoomWholesaleOrderMo:getSoldCountStr()
	local count = self:getSoldCount()

	return GameUtil.numberDisplay(count)
end

function RoomWholesaleOrderMo:addSoldCount(count)
	self.soldCount = self.soldCount + (count or 1)
	self.soldCount = self:getSoldCount()
end

function RoomWholesaleOrderMo:reduceSoldCount(count)
	self.soldCount = self.soldCount - (count or 1)
	self.soldCount = math.max(0, self.soldCount)
end

function RoomWholesaleOrderMo:setSoldCount(count)
	count = count or 0

	local max = self:getMaxCount()

	self.soldCount = GameUtil.clamp(count, 0, max)
end

return RoomWholesaleOrderMo
