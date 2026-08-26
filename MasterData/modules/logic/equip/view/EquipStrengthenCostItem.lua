-- chunkname: @modules/logic/equip/view/EquipStrengthenCostItem.lua

module("modules.logic.equip.view.EquipStrengthenCostItem", package.seeall)

local EquipStrengthenCostItem = class("EquipStrengthenCostItem", BaseChildView)

function EquipStrengthenCostItem:onInitView()
	self._goitem = gohelper.findChild(self.viewGO, "#go_item")
	self._goblank = gohelper.findChild(self.viewGO, "#go_blank")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipStrengthenCostItem:addEvents()
	return
end

function EquipStrengthenCostItem:removeEvents()
	return
end

function EquipStrengthenCostItem:_editableInitView()
	self._click = gohelper.getClickWithAudio(self.viewGO)

	self._click:AddClickListener(self._onClick, self)
end

function EquipStrengthenCostItem:_onClick()
	EquipController.instance:openEquipChooseView()
end

function EquipStrengthenCostItem:onUpdateParam()
	if not self.viewParam then
		self._goblank:SetActive(true)
		self._goitem:SetActive(false)

		return
	end

	self._goblank:SetActive(false)
	self._goitem:SetActive(true)

	self._itemIcon = self._itemIcon or IconMgr.instance:getCommonEquipIcon(self._goitem)

	self._itemIcon:setEquipMO(self.viewParam)
	self._itemIcon:showLevel()
end

function EquipStrengthenCostItem:onOpen()
	return
end

function EquipStrengthenCostItem:onClose()
	return
end

function EquipStrengthenCostItem:onDestroyView()
	self._click:RemoveClickListener()
end

return EquipStrengthenCostItem
