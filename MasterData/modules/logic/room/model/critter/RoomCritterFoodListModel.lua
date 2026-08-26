-- chunkname: @modules/logic/room/model/critter/RoomCritterFoodListModel.lua

module("modules.logic.room.model.critter.RoomCritterFoodListModel", package.seeall)

local RoomCritterFoodListModel = class("RoomCritterFoodListModel", ListScrollModel)

local function _sortFoodItem(aFood, bFood)
	local aItemId = aFood and aFood.id
	local bItemId = bFood and bFood.id

	if not aItemId or not bItemId then
		return false
	end

	local aIsFavorite = aFood.isFavorite
	local bIsFavorite = bFood.isFavorite

	if aIsFavorite ~= bIsFavorite then
		return aIsFavorite
	end

	local aQuantity = ItemModel.instance:getItemCount(aItemId)
	local bQuantity = ItemModel.instance:getItemCount(bItemId)

	if aQuantity ~= bQuantity then
		return bQuantity < aQuantity
	end

	local aCfg = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, aItemId)
	local bCfg = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, bItemId)

	if aCfg.rare ~= bCfg.rare then
		return aCfg.rare > bCfg.rare
	end

	return aItemId < bItemId
end

function RoomCritterFoodListModel:onInit()
	self:clear()
	self:clearData()
end

function RoomCritterFoodListModel:reInit()
	self:clearData()
end

function RoomCritterFoodListModel:clearData()
	return
end

function RoomCritterFoodListModel:setCritterFoodList(critterId)
	local foodItemList = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.CritterFood)
	local list = {}

	for i, cfg in ipairs(foodItemList) do
		local itemId = cfg.id
		local isFavorite = CritterConfig.instance:isFavoriteFood(critterId, itemId)

		list[i] = {
			id = itemId,
			isFavorite = isFavorite
		}
	end

	table.sort(list, _sortFoodItem)
	self:setList(list)
end

RoomCritterFoodListModel.instance = RoomCritterFoodListModel.New()

return RoomCritterFoodListModel
