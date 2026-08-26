-- chunkname: @modules/logic/room/model/trade/RoomProductionMo.lua

module("modules.logic.room.model.trade.RoomProductionMo", package.seeall)

local RoomProductionMo = class("RoomProductionMo")

function RoomProductionMo:ctor()
	self.productionId = nil
	self.quantity = nil
end

function RoomProductionMo:initMo(info)
	self.productionId = info.productionId
	self.quantity = info.quantity or 0
	self.co = ManufactureConfig.instance:getManufactureItemCfg(self.productionId)
end

function RoomProductionMo:getCurQuantity()
	return ManufactureModel.instance:getManufactureItemCount(self.productionId, false)
end

function RoomProductionMo:isEnoughCount()
	local cur = self:getCurQuantity() or 0

	return cur >= self.quantity, cur
end

function RoomProductionMo:getQuantityStr()
	local color = "#a63838"
	local langStr = luaLang("room_trade_progress")
	local isEnough, cur = self:isEnoughCount()

	if isEnough then
		color = "#220F04"
	else
		local failedProduce = not self:isPlacedProduceBuilding() or self:checkProduceBuildingLevel()

		if failedProduce then
			color = "#6F6F6F"
			langStr = luaLang("room_trade_progress_wrong")
		end
	end

	return GameUtil.getSubPlaceholderLuaLangThreeParam(langStr, color, GameUtil.numberDisplay(cur), GameUtil.numberDisplay(self.quantity))
end

function RoomProductionMo:isPlacedProduceBuilding()
	return (ManufactureController.instance:checkPlaceProduceBuilding(self.productionId))
end

function RoomProductionMo:checkProduceBuildingLevel()
	local needUpgrade, buildingUid = ManufactureController.instance:checkProduceBuildingLevel(self.productionId)

	return needUpgrade, buildingUid
end

function RoomProductionMo:getItem()
	local type = MaterialEnum.MaterialType.Item

	if self.co then
		local itemId = self.co.itemId

		return type, itemId
	end
end

function RoomProductionMo:getOrderPrice()
	return self:getOneOrderPrice() * self.quantity
end

function RoomProductionMo:getOneOrderPrice()
	local rate = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.OrderPriceMul) or 1

	return (self.co or nil) and (self.co.orderPrice * rate or 0)
end

return RoomProductionMo
