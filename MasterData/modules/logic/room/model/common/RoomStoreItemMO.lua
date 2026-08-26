-- chunkname: @modules/logic/room/model/common/RoomStoreItemMO.lua

module("modules.logic.room.model.common.RoomStoreItemMO", package.seeall)

local RoomStoreItemMO = pureTable("RoomStoreItemMO")

function RoomStoreItemMO:init(_id, pMaterialType, pItemNum, costId, storeGoodsMO)
	self.id = _id
	self.itemId = _id
	self.itemNum = pItemNum or 0
	self.materialType = pMaterialType
	self._costId = costId
	self.belongStoreId = storeGoodsMO.belongStoreId
	self.storeGoodsMO = storeGoodsMO
	self.themeId = RoomConfig.instance:getThemeIdByItem(_id, pMaterialType)
end

function RoomStoreItemMO:getNeedNum()
	if self.materialType == MaterialEnum.MaterialType.BlockPackage or self.materialType == MaterialEnum.MaterialType.SpecialBlock then
		return 1
	end

	local cfg = self:getItemConfig()

	if cfg and cfg.numLimit and cfg.numLimit > 0 then
		return cfg.numLimit
	end

	return 9999
end

function RoomStoreItemMO:getItemQuantity()
	return ItemModel.instance:getItemQuantity(self.materialType, self.id) or 0
end

function RoomStoreItemMO:getItemConfig()
	return ItemModel.instance:getItemConfig(self.materialType, self.id)
end

function RoomStoreItemMO:getTotalPriceByCostId(costId)
	local costInfo = self:getCostById(costId)

	if not costInfo then
		logNormal(string.format("RoomStoreItemMO costId:%s itemId:%s", costId, self.id))

		return 0
	end

	local num = self:getCanBuyNum()

	return num * costInfo.price
end

function RoomStoreItemMO:getCanBuyNum()
	local needNum = self:getNeedNum()
	local quantity = self:getItemQuantity()

	if needNum <= quantity then
		return 0
	end

	return (math.min(needNum - quantity, self.itemNum))
end

function RoomStoreItemMO:addCost(costId, itemId, itemType, price)
	self._costs = self._costs or {}
	self._costs[costId] = {
		costId = costId,
		itemId = itemId,
		itemType = itemType,
		price = price
	}
end

function RoomStoreItemMO:getCostById(id)
	return self._costs and self._costs[id]
end

function RoomStoreItemMO:getStoreGoodsMO()
	return self.storeGoodsMO
end

function RoomStoreItemMO:checkShowTicket()
	if self.storeGoodsMO.belongStoreId == StoreEnum.StoreId.OldRoomStore or self.storeGoodsMO.belongStoreId == StoreEnum.StoreId.NewRoomStore then
		if self.materialType ~= MaterialEnum.MaterialType.BlockPackage and self.materialType ~= MaterialEnum.MaterialType.Building then
			return false
		end

		if not string.nilorempty(self.storeGoodsMO.config.nameEn) then
			return
		end

		if self:getItemConfig().rare <= 3 then
			if ItemModel.instance:getItemCount(StoreEnum.NormalRoomTicket) > 0 or ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
				return true
			end
		elseif self:getItemConfig().rare <= 5 and ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
			return true
		end
	end

	return false
end

function RoomStoreItemMO:getTicketId()
	if self:getItemConfig().rare <= 3 then
		if ItemModel.instance:getItemCount(StoreEnum.NormalRoomTicket) > 0 then
			return StoreEnum.NormalRoomTicket
		elseif ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
			return StoreEnum.TopRoomTicket
		end
	elseif self:getItemConfig().rare <= 5 and ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
		return StoreEnum.TopRoomTicket
	end
end

return RoomStoreItemMO
