-- chunkname: @modules/logic/room/model/gift/RoomGiftShowBuildingMo.lua

module("modules.logic.room.model.gift.RoomGiftShowBuildingMo", package.seeall)

local RoomGiftShowBuildingMo = pureTable("RoomGiftShowBuildingMo")

function RoomGiftShowBuildingMo:init(co)
	self.id = co.id
	self.config = co
	self.rare = self.config.rare or 0
	self.subTypeIndex = 2
	self.subType = RoomBlockGiftEnum.SubType[self.subTypeIndex]
	self.itemCofig = ItemModel.instance:getItemConfig(self.subType, co.id)
	self.numLimit = self.config.numLimit
	self.isSelect = false
end

function RoomGiftShowBuildingMo:getIcon()
	if self.config then
		if self.config.canLevelUp then
			for i = 0, 3 do
				local levelCfg = RoomConfig.instance:getLevelGroupConfig(self.id, i)

				if levelCfg and not string.nilorempty(levelCfg.icon) then
					return levelCfg.icon
				end
			end
		end

		return self.config.icon
	end
end

function RoomGiftShowBuildingMo:getBuildingAreaConfig()
	return (RoomConfig.instance:getBuildingAreaConfig(self.config.areaId))
end

function RoomGiftShowBuildingMo:isCollect()
	local quantity = ItemModel.instance:getItemQuantity(self.subType, self.id)

	return quantity >= self.numLimit
end

return RoomGiftShowBuildingMo
