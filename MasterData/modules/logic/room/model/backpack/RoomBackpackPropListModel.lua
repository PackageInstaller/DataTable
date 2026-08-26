-- chunkname: @modules/logic/room/model/backpack/RoomBackpackPropListModel.lua

module("modules.logic.room.model.backpack.RoomBackpackPropListModel", package.seeall)

local RoomBackpackPropListModel = class("RoomBackpackPropListModel", ListScrollModel)

local function _sortPropItem(aPropItem, bPropItem)
	if not aPropItem or not bPropItem then
		return false
	end

	local aId = aPropItem.id
	local bId = bPropItem.id
	local aConfig = aPropItem.config
	local bConfig = bPropItem.config
	local aRare = aConfig.rare
	local bRare = bConfig.rare

	if aRare ~= bRare then
		return aConfig.rare > bConfig.rare
	end

	return bId < aId
end

function RoomBackpackPropListModel:onInit()
	self:clear()
	self:clearData()
end

function RoomBackpackPropListModel:reInit()
	self:clearData()
end

function RoomBackpackPropListModel:clearData()
	return
end

function RoomBackpackPropListModel:setBackpackPropList()
	local list = {}
	local itemList = ItemModel.instance:getItemList() or {}

	for _, itemMO in ipairs(itemList) do
		local itemConfig = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, itemMO.id)
		local subType = itemConfig and itemConfig.subType

		if ItemEnum.RoomBackpackPropSubType[subType] then
			local propItem = self:_convert2PropItem(itemMO)

			if propItem then
				table.insert(list, propItem)
			end
		end
	end

	table.sort(list, _sortPropItem)
	self:setList(list)
end

function RoomBackpackPropListModel:_convert2PropItem(itemMO)
	local result
	local id = itemMO and itemMO.id
	local quantity = itemMO and itemMO.quantity
	local manufactureItemIdList = ManufactureConfig.instance:getManufactureItemListByItemId(id)
	local manufactureItemId = manufactureItemIdList[1]

	if manufactureItemId then
		quantity = ManufactureModel.instance:getManufactureItemCount(manufactureItemId)
	end

	local config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, id)

	return (id and quantity and quantity > 0 and config or nil) and {
		type = MaterialEnum.MaterialType.Item,
		id = id,
		quantity = quantity,
		config = config
	}
end

function RoomBackpackPropListModel:isBackpackEmpty()
	local count = self:getCount()

	return count <= 0
end

RoomBackpackPropListModel.instance = RoomBackpackPropListModel.New()

return RoomBackpackPropListModel
