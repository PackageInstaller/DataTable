-- chunkname: @modules/logic/room/model/common/RoomThemeItemMO.lua

module("modules.logic.room.model.common.RoomThemeItemMO", package.seeall)

local RoomThemeItemMO = pureTable("RoomThemeItemMO")

function RoomThemeItemMO:init(_id, pItemNum, pMaterialType)
	self.id = _id
	self.itemId = _id
	self.itemNum = pItemNum or 0
	self.materialType = pMaterialType
end

function RoomThemeItemMO:getItemQuantity()
	return ItemModel.instance:getItemQuantity(self.materialType, self.id) or 0
end

function RoomThemeItemMO:getItemConfig()
	return ItemModel.instance:getItemConfig(self.materialType, self.id)
end

return RoomThemeItemMO
