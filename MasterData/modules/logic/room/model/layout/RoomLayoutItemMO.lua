-- chunkname: @modules/logic/room/model/layout/RoomLayoutItemMO.lua

module("modules.logic.room.model.layout.RoomLayoutItemMO", package.seeall)

local RoomLayoutItemMO = pureTable("RoomLayoutItemMO")

function RoomLayoutItemMO:init(id, itemId, itemType, itemNum)
	self.id = id
	self.itemId = itemId
	self.itemType = itemType
	self.materialType = itemType
	self.itemNum = itemNum or 1
	self.itemIndex = 1
end

function RoomLayoutItemMO:getItemQuantity()
	return ItemModel.instance:getItemQuantity(self.materialType, self.itemId) or 0
end

function RoomLayoutItemMO:getItemConfig()
	return ItemModel.instance:getItemConfig(self.materialType, self.itemId)
end

function RoomLayoutItemMO:getNeedNum()
	if self.materialType == MaterialEnum.MaterialType.BlockPackage or self.materialType == MaterialEnum.MaterialType.SpecialBlock then
		return 1
	end

	return self.itemNum
end

function RoomLayoutItemMO:isLack()
	local needNum = self:getNeedNum()

	if self:isBuilding() then
		needNum = math.max(needNum, self.itemIndex)
	end

	return needNum > self:getItemQuantity()
end

function RoomLayoutItemMO:isBuilding()
	return self.materialType == MaterialEnum.MaterialType.Building
end

function RoomLayoutItemMO:isBlockPackage()
	return self.materialType == MaterialEnum.MaterialType.BlockPackage
end

function RoomLayoutItemMO:isSpecialBlock()
	return self.materialType == MaterialEnum.MaterialType.SpecialBlock
end

return RoomLayoutItemMO
