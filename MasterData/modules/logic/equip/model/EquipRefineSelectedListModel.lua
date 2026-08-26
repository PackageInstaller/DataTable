-- chunkname: @modules/logic/equip/model/EquipRefineSelectedListModel.lua

module("modules.logic.equip.model.EquipRefineSelectedListModel", package.seeall)

local EquipRefineSelectedListModel = class("EquipRefineSelectedListModel", ListScrollModel)

function EquipRefineSelectedListModel:initList()
	self:updateList()
end

function EquipRefineSelectedListModel:updateList(value)
	local list = {}

	for i = 1, EquipEnum.RefineMaxCount do
		table.insert(list, (value or nil) and (value[i] or {}))
	end

	self:setList(list)
end

function EquipRefineSelectedListModel:clearData()
	self:clear()
end

EquipRefineSelectedListModel.instance = EquipRefineSelectedListModel.New()

return EquipRefineSelectedListModel
