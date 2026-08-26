-- chunkname: @modules/logic/equip/model/EquipSelectedListModel.lua

module("modules.logic.equip.model.EquipSelectedListModel", package.seeall)

local EquipSelectedListModel = class("EquipSelectedListModel", ListScrollModel)

function EquipSelectedListModel:initList()
	self:updateList()
end

function EquipSelectedListModel:updateList(value)
	local list = {}

	for i = 1, EquipEnum.StrengthenMaxCount do
		table.insert(list, (value or nil) and (value[i] or {}))
	end

	self:setList(list)
end

function EquipSelectedListModel:clearList()
	self:clear()
end

EquipSelectedListModel.instance = EquipSelectedListModel.New()

return EquipSelectedListModel
