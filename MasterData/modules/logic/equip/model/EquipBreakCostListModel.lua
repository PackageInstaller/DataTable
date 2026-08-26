-- chunkname: @modules/logic/equip/model/EquipBreakCostListModel.lua

module("modules.logic.equip.model.EquipBreakCostListModel", package.seeall)

local EquipBreakCostListModel = class("EquipBreakCostListModel", ListScrollModel)

function EquipBreakCostListModel:initList(items)
	self:setList(items)
end

function EquipBreakCostListModel:clearList()
	self:clear()
end

EquipBreakCostListModel.instance = EquipBreakCostListModel.New()

return EquipBreakCostListModel
