-- chunkname: @modules/logic/equip/view/EquipBreakCostItem.lua

module("modules.logic.equip.view.EquipBreakCostItem", package.seeall)

local EquipBreakCostItem = class("EquipBreakCostItem", ListScrollCellExtend)

function EquipBreakCostItem:onInitView()
	self._icon = gohelper.findChild(self.viewGO, "icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipBreakCostItem:addEvents()
	return
end

function EquipBreakCostItem:removeEvents()
	return
end

function EquipBreakCostItem:_editableInitView()
	self._item = IconMgr.instance:getCommonItemIcon(self._icon)
end

function EquipBreakCostItem:onUpdateMO(mo)
	self._mo = mo

	self._item:setMOValue(self._mo.type, self._mo.id, self._mo.quantity)

	local countTxt = self._item:getCount()
	local quantity = ItemModel.instance:getItemQuantity(self._mo.type, self._mo.id)

	countTxt.text = quantity >= self._mo.quantity and tostring(GameUtil.numberDisplay(quantity)) .. "/" .. tostring(GameUtil.numberDisplay(self._mo.quantity)) or "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(quantity)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(self._mo.quantity))
end

function EquipBreakCostItem:onSelect(isSelect)
	return
end

function EquipBreakCostItem:onDestroyView()
	return
end

return EquipBreakCostItem
