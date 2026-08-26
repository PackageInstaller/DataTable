-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotEquipInfoTeamItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEquipInfoTeamItem", package.seeall)

local V1a6_CachotEquipInfoTeamItem = class("V1a6_CachotEquipInfoTeamItem", ListScrollCellExtend)

function V1a6_CachotEquipInfoTeamItem:onInitView()
	self._goequip = gohelper.findChild(self.viewGO, "#go_equip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotEquipInfoTeamItem:addEvents()
	return
end

function V1a6_CachotEquipInfoTeamItem:removeEvents()
	return
end

function V1a6_CachotEquipInfoTeamItem:_editableInitView()
	self.click = gohelper.getClick(self.viewGO)

	self.click:AddClickListener(self.onClickEquip, self)

	self._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(self._goequip, 0.85)

	EquipController.instance:registerCallback(EquipEvent.ChangeSelectedEquip, self.refreshSelect, self)
end

function V1a6_CachotEquipInfoTeamItem:onClickEquip()
	self.isSelect = not self.isSelect

	if self.isSelect then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
		V1a6_CachotEquipInfoTeamListModel.instance:setCurrentSelectEquipMo(self.equipMo)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		V1a6_CachotEquipInfoTeamListModel.instance:setCurrentSelectEquipMo(nil)
	end

	EquipController.instance:dispatchEvent(EquipEvent.ChangeSelectedEquip)
end

function V1a6_CachotEquipInfoTeamItem:_updateBySeatLevel()
	local seatLevel = V1a6_CachotEquipInfoTeamListModel.instance:getSeatLevel()

	if not seatLevel then
		return
	end

	local level = V1a6_CachotTeamModel.instance:getEquipMaxLevel(self.equipMo, seatLevel)
	local convertLevel = self.equipMo.level ~= level

	self._commonEquipIcon._txtlevel.text = level

	local lvTxt = gohelper.findChildText(self._commonEquipIcon._txtlevel.gameObject, "lv")

	if convertLevel then
		SLFramework.UGUI.GuiHelper.SetColor(self._commonEquipIcon._txtlevel, "#bfdaff")
		SLFramework.UGUI.GuiHelper.SetColor(lvTxt, "#bfdaff")
	else
		SLFramework.UGUI.GuiHelper.SetColor(lvTxt, "#ffffff")
		SLFramework.UGUI.GuiHelper.SetColor(self._commonEquipIcon._txtlevel, "#ffffff")
	end
end

function V1a6_CachotEquipInfoTeamItem:onUpdateMO(equipMo)
	self.equipMo = equipMo

	self._commonEquipIcon:setSelectUIVisible(true)
	self._commonEquipIcon:hideLockIcon()
	self._commonEquipIcon:setEquipMO(self.equipMo)
	self._commonEquipIcon:setCountFontSize(33)
	self._commonEquipIcon:setLevelPos(24, -2)
	self._commonEquipIcon:setLevelFontColor("#ffffff")
	self:refreshSelect()
	self:refreshHeroIcon()

	local _, _, equipLv = HeroGroupBalanceHelper.getBalanceLv()

	self._commonEquipIcon:setBalanceLv(equipLv)
	self:_updateBySeatLevel()
end

function V1a6_CachotEquipInfoTeamItem:refreshSelect()
	self.isSelect = V1a6_CachotEquipInfoTeamListModel.instance:isSelectedEquip(self.equipMo.uid)

	self._commonEquipIcon:onSelect(self.isSelect)
end

function V1a6_CachotEquipInfoTeamItem:refreshHeroIcon()
	local heroMo = V1a6_CachotEquipInfoTeamListModel.instance:getHeroMoByEquipUid(self.equipMo.uid)

	if heroMo and self.equipMo.equipType ~= EquipEnum.ClientEquipType.TrialHero then
		local skinCo = lua_skin.configDict[heroMo.skin]

		self._commonEquipIcon:showHeroIcon(skinCo)
	else
		self._commonEquipIcon:hideHeroIcon()
	end
end

function V1a6_CachotEquipInfoTeamItem:onDestroyView()
	self.click:RemoveClickListener()
	EquipController.instance:unregisterCallback(EquipEvent.ChangeSelectedEquip, self.refreshSelect, self)
end

return V1a6_CachotEquipInfoTeamItem
