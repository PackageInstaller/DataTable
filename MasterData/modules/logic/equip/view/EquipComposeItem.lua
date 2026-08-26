-- chunkname: @modules/logic/equip/view/EquipComposeItem.lua

module("modules.logic.equip.view.EquipComposeItem", package.seeall)

local EquipComposeItem = class("EquipComposeItem", ListScrollCellExtend)

function EquipComposeItem:onInitView()
	self._goequip = gohelper.findChild(self.viewGO, "#go_equip")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._goavaliable = gohelper.findChild(self.viewGO, "#go_avaliable")
	self._gosummon = gohelper.findChild(self.viewGO, "#go_avaliable/#go_summon")
	self._goselected = gohelper.findChild(self.viewGO, "#go_avaliable/#go_selected")
	self._gonormalblackbg = gohelper.findChild(self.viewGO, "#go_normalblackbg")
	self._goblackbg = gohelper.findChild(self.viewGO, "#go_avaliable/#go_blackbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipComposeItem:addEvents()
	return
end

function EquipComposeItem:removeEvents()
	return
end

function EquipComposeItem:_editableInitView()
	self._itemIcon = IconMgr.instance:getCommonEquipIcon(self._goequip)

	self._itemIcon:hideLockIcon()
	self._itemIcon:hideLv(true)
	gohelper.setActive(self._gonormalblackbg, true)

	self._click = gohelper.getClick(self.viewGO)

	self._click:AddClickListener(self._onClick, self)
end

function EquipComposeItem:_onClick()
	if self._num < self._needNum then
		GameFacade.showToast(ToastEnum.EquipCompose)

		return
	end

	self._mo._selected = not self._mo._selected

	self:_updateSelected()
end

function EquipComposeItem:onDestroyView()
	self._click:RemoveClickListener()
end

function EquipComposeItem:_editableAddEvents()
	return
end

function EquipComposeItem:_editableRemoveEvents()
	return
end

function EquipComposeItem:onUpdateMO(mo)
	self._mo = mo
	self._equipId = mo[3].id
	self._needNum = mo[2]

	self._itemIcon:setMOValue(MaterialEnum.MaterialType.Equip, self._equipId, 0)

	self._num = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, mo[1])
	self._txtnum.text = string.format("%s/%s", self._num, self._needNum)
	self._avalible = self._num >= self._needNum

	gohelper.setActive(self._goavaliable, self._avalible)
	gohelper.setActive(self._gonormalblackbg, not self._avalible)
	self:_updateSelected()
end

function EquipComposeItem:_updateSelected()
	if self._avalible then
		gohelper.setActive(self._gosummon, not self._mo._selected)
		gohelper.setActive(self._goblackbg, self._mo._selected)
		gohelper.setActive(self._goselected, self._mo._selected)
	end
end

function EquipComposeItem:onSelect(isSelect)
	return
end

return EquipComposeItem
