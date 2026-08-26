-- chunkname: @modules/logic/equip/view/CharacterEquipSettingItem.lua

module("modules.logic.equip.view.CharacterEquipSettingItem", package.seeall)

local CharacterEquipSettingItem = class("CharacterEquipSettingItem", ListScrollCellExtend)

function CharacterEquipSettingItem:onInitView()
	self._goequip = gohelper.findChild(self.viewGO, "#go_equip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterEquipSettingItem:addEvents()
	return
end

function CharacterEquipSettingItem:removeEvents()
	return
end

function CharacterEquipSettingItem:_editableInitView()
	self.click = gohelper.getClick(self.viewGO)

	self.click:AddClickListener(self.onClickEquip, self)

	self._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(self._goequip, 0.85)

	EquipController.instance:registerCallback(EquipEvent.ChangeSelectedEquip, self.refreshSelect, self)
end

function CharacterEquipSettingItem:onClickEquip()
	self.isSelect = not self.isSelect

	if self.isSelect then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
		CharacterEquipSettingListModel.instance:setCurrentSelectEquipMo(self.equipMo)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		CharacterEquipSettingListModel.instance:setCurrentSelectEquipMo(nil)
	end

	EquipController.instance:dispatchEvent(EquipEvent.ChangeSelectedEquip)
end

function CharacterEquipSettingItem:onUpdateMO(equipMo)
	self.equipMo = equipMo

	self._commonEquipIcon:setSelectUIVisible(true)
	self._commonEquipIcon:hideLockIcon()
	self._commonEquipIcon:setEquipMO(self.equipMo)
	self._commonEquipIcon:isShowRefineLv(true)
	self._commonEquipIcon:setCountFontSize(33)
	self._commonEquipIcon:setLevelPos(24, -2)
	self._commonEquipIcon:setLevelFontColor("#ffffff")
	self._commonEquipIcon:checkRecommend()

	if equipMo.equipType then
		local isGray = equipMo.equipType == EquipEnum.ClientEquipType.RecommedNot

		self._commonEquipIcon:setGrayScale(isGray)
		self:refreshSelect()
	end
end

function CharacterEquipSettingItem:refreshSelect()
	self.isSelect = CharacterEquipSettingListModel.instance:isSelectedEquip(self.equipMo.uid)

	self._commonEquipIcon:onSelect(self.isSelect)
end

function CharacterEquipSettingItem:onDestroyView()
	self.click:RemoveClickListener()
	EquipController.instance:unregisterCallback(EquipEvent.ChangeSelectedEquip, self.refreshSelect, self)
end

return CharacterEquipSettingItem
