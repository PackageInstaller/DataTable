-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyEquipInfoTeamItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyEquipInfoTeamItem", package.seeall)

local OdysseyEquipInfoTeamItem = class("OdysseyEquipInfoTeamItem", EquipInfoTeamItem)

function OdysseyEquipInfoTeamItem:refreshSelect()
	self.isSelect = OdysseyEquipInfoTeamListModel.instance:isSelectedEquip(self.equipMo.uid)

	self._commonEquipIcon:onSelect(self.isSelect)
end

function OdysseyEquipInfoTeamItem:onClickEquip()
	self.isSelect = not self.isSelect

	if self.isSelect then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
		OdysseyEquipInfoTeamListModel.instance:setCurrentSelectEquipMo(self.equipMo)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		OdysseyEquipInfoTeamListModel.instance:setCurrentSelectEquipMo(nil)
	end

	EquipController.instance:dispatchEvent(EquipEvent.ChangeSelectedEquip)
end

function OdysseyEquipInfoTeamItem:refreshHeroIcon()
	local heroMo = OdysseyEquipInfoTeamListModel.instance:getHeroMoByEquipUid(self.equipMo.uid)

	if heroMo and self.equipMo.equipType ~= EquipEnum.ClientEquipType.TrialHero then
		local skinCo = lua_skin.configDict[heroMo.skin]

		self._commonEquipIcon:showHeroIcon(skinCo)
	else
		self._commonEquipIcon:hideHeroIcon()
	end
end

return OdysseyEquipInfoTeamItem
