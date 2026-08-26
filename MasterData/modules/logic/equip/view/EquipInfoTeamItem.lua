-- chunkname: @modules/logic/equip/view/EquipInfoTeamItem.lua

module("modules.logic.equip.view.EquipInfoTeamItem", package.seeall)

local EquipInfoTeamItem = class("EquipInfoTeamItem", ListScrollCellExtend)

function EquipInfoTeamItem:onInitView()
	self._goequip = gohelper.findChild(self.viewGO, "#go_equip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipInfoTeamItem:addEvents()
	return
end

function EquipInfoTeamItem:removeEvents()
	return
end

function EquipInfoTeamItem:_editableInitView()
	self.click = gohelper.getClick(self.viewGO)

	self.click:AddClickListener(self.onClickEquip, self)

	self._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(self._goequip, 0.85)

	EquipController.instance:registerCallback(EquipEvent.ChangeSelectedEquip, self.refreshSelect, self)
end

function EquipInfoTeamItem:onClickEquip()
	self.isSelect = not self.isSelect

	if self.isSelect then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
		EquipInfoTeamListModel.instance:setCurrentSelectEquipMo(self.equipMo)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		EquipInfoTeamListModel.instance:setCurrentSelectEquipMo(nil)
	end

	EquipController.instance:dispatchEvent(EquipEvent.ChangeSelectedEquip)
end

function EquipInfoTeamItem:onUpdateMO(equipMo)
	self.equipMo = equipMo

	self._commonEquipIcon:setSelectUIVisible(true)
	self._commonEquipIcon:hideLockIcon()
	self._commonEquipIcon:setEquipMO(self.equipMo)
	self._commonEquipIcon:setCountFontSize(33)
	self._commonEquipIcon:setLevelPos(24, -2)
	self._commonEquipIcon:setLevelFontColor("#ffffff")
	self._commonEquipIcon:checkRecommend()
	self:refreshSelect()
	self:refreshHeroIcon()

	local equipLv = self._view.viewContainer:getBalanceEquipLv()

	self._commonEquipIcon:setBalanceLv(equipLv)
end

function EquipInfoTeamItem:refreshSelect()
	self.isSelect = EquipInfoTeamListModel.instance:isSelectedEquip(self.equipMo.uid)

	self._commonEquipIcon:onSelect(self.isSelect)
end

function EquipInfoTeamItem:refreshHeroIcon()
	local heroMo = EquipInfoTeamListModel.instance:getHeroMoByEquipUid(self.equipMo.uid)

	if heroMo and self.equipMo.equipType ~= EquipEnum.ClientEquipType.TrialHero then
		local skinCo = lua_skin.configDict[heroMo.skin]

		self._commonEquipIcon:showHeroIcon(skinCo)
	else
		self._commonEquipIcon:hideHeroIcon()
	end
end

function EquipInfoTeamItem:onDestroyView()
	self.click:RemoveClickListener()
	EquipController.instance:unregisterCallback(EquipEvent.ChangeSelectedEquip, self.refreshSelect, self)
end

return EquipInfoTeamItem
