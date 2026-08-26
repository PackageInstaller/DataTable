-- chunkname: @modules/logic/equip/view/EquipCategoryItem.lua

module("modules.logic.equip.view.EquipCategoryItem", package.seeall)

local EquipCategoryItem = class("EquipCategoryItem", ListScrollCellExtend)

function EquipCategoryItem:onInitView()
	self._gounselected = gohelper.findChild(self.viewGO, "#go_unselected")
	self._txtitemcn1 = gohelper.findChildText(self.viewGO, "#go_unselected/#txt_itemcn1")
	self._txtitemen1 = gohelper.findChildText(self.viewGO, "#go_unselected/#txt_itemen1")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._txtitemcn2 = gohelper.findChildText(self.viewGO, "#go_selected/#txt_itemcn2")
	self._txtitemen2 = gohelper.findChildText(self.viewGO, "#go_selected/#txt_itemen2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipCategoryItem:addEvents()
	return
end

function EquipCategoryItem:removeEvents()
	return
end

function EquipCategoryItem:_editableInitView()
	self._click = gohelper.getClickWithAudio(self.viewGO)
end

function EquipCategoryItem:_editableAddEvents()
	self._click:AddClickListener(self._onClick, self)
end

function EquipCategoryItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function EquipCategoryItem:_onClick()
	if self._isSelect then
		return
	end

	self._view:selectCell(self._index, true)

	EquipCategoryListModel.instance.curCategoryIndex = self._mo.resIndex

	self._view.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, self._mo.resIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_transverse_tabs_click)
end

function EquipCategoryItem:onUpdateMO(mo)
	self._mo = mo
	self._txtitemcn1.text = mo.cnName
	self._txtitemcn2.text = mo.cnName
	self._txtitemen1.text = mo.enName
	self._txtitemen2.text = mo.enName
end

function EquipCategoryItem:onSelect(isSelect)
	self._isSelect = isSelect

	self._gounselected:SetActive(not self._isSelect)
	self._goselected:SetActive(self._isSelect)
end

function EquipCategoryItem:onDestroyView()
	return
end

return EquipCategoryItem
