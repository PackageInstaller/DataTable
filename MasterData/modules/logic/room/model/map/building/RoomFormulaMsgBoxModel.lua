-- chunkname: @modules/logic/room/model/map/building/RoomFormulaMsgBoxModel.lua

module("modules.logic.room.model.map.building.RoomFormulaMsgBoxModel", package.seeall)

local RoomFormulaMsgBoxModel = class("RoomFormulaMsgBoxModel", ListScrollModel)

function RoomFormulaMsgBoxModel:setCostItemList(itemList)
	table.sort(itemList, function(a, b)
		if a.type ~= b.type then
			return b.type == MaterialEnum.MaterialType.Currency
		end

		local aConfig = ItemModel.instance:getItemConfig(a.type, a.id)
		local bConfig = ItemModel.instance:getItemConfig(b.type, b.id)

		if aConfig.rare ~= bConfig.rare then
			return aConfig.rare > bConfig.rare
		elseif a.id ~= b.id then
			return a.id < b.id
		end
	end)
	self:setList(itemList)
end

RoomFormulaMsgBoxModel.instance = RoomFormulaMsgBoxModel.New()

return RoomFormulaMsgBoxModel
