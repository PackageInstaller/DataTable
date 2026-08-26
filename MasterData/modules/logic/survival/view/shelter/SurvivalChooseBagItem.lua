-- chunkname: @modules/logic/survival/view/shelter/SurvivalChooseBagItem.lua

module("modules.logic.survival.view.shelter.SurvivalChooseBagItem", package.seeall)

local SurvivalChooseBagItem = class("SurvivalChooseBagItem", SurvivalBagItem)

function SurvivalChooseBagItem:getEquipId()
	return self._mo.id
end

function SurvivalChooseBagItem:updateMo(mo)
	SurvivalChooseBagItem.super.updateMo(self, mo)

	self._txtnum.text = ""

	local id = SurvivalShelterChooseEquipListModel.instance:getSelectIdByPos(1)

	gohelper.setActive(self._goCollectionSelectTips, id ~= nil and self:getEquipId() == id)
end

function SurvivalChooseBagItem:_onItemClick()
	if self._mo:isEmpty() and not self._canClickEmpty then
		return
	end

	SurvivalShelterChooseEquipListModel.instance:setSelectEquip(self:getEquipId())

	if self._callback then
		self._callback(self._callobj, self)

		return
	end
end

return SurvivalChooseBagItem
