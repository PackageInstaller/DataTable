-- chunkname: @modules/logic/equip/view/EquipTeamItem.lua

module("modules.logic.equip.view.EquipTeamItem", package.seeall)

local EquipTeamItem = class("EquipTeamItem", CharacterEquipItem)

function EquipTeamItem:_editableInitView()
	self._click = gohelper.getClickWithAudio(self.viewGO)

	self._click:AddClickListener(self._onClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._setSelected, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._setSelected, self)
end

function EquipTeamItem:_onClick()
	local posIndex = EquipTeamListModel.instance:getEquipTeamPos(self._mo.uid)

	EquipController.instance:openEquipTeamShowView({
		self._mo.uid,
		posIndex == EquipTeamListModel.instance:getCurPosIndex()
	})
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	self._view:selectCell(self._index, true)
end

function EquipTeamItem:_showHeroIcon(pos, groupMO)
	self._commonEquipIcon._goinuse:SetActive(true)

	local heroUid = groupMO:getHeroByIndex(pos + 1)

	if heroUid then
		local heroMO = HeroModel.instance:getById(heroUid)

		if not heroMO then
			return
		end

		if not self._heroicon then
			self._heroicon = IconMgr.instance:getCommonHeroIcon(self._commonEquipIcon._goinuse)

			self._heroicon:isShowStar(false)
			self._heroicon:isShowBreak(false)
			self._heroicon:isShowRare(false)
			self._heroicon:setMaskVisible(false)
			self._heroicon:setLvVisible(false)
			self._heroicon:isShowCareerIcon(false)
			self._heroicon:isShowRareIcon(false)
			self._heroicon:setScale(0.27)
			self._heroicon:setAnchor(-53.7, 3)
		end

		self._heroicon:onUpdateMO(heroMO)
		gohelper.setActive(self._heroicon.go, true)
	end
end

function EquipTeamItem:onSelect(selected)
	self._commonEquipIcon:onSelect(selected)
end

function EquipTeamItem:onUpdateMO(mo)
	EquipTeamItem.super.onUpdateMO(self, mo)

	if self._heroicon then
		gohelper.setActive(self._heroicon.go, false)
	end

	self._commonEquipIcon._goinuse:SetActive(false)
	self._commonEquipIcon._gointeam:SetActive(false)
	self._commonEquipIcon:isShowEquipSkillCarrerIcon(true)
	self._commonEquipIcon:setSelectUIVisible(true)

	local groupMO = HeroGroupModel.instance:getCurGroupMO()

	if not groupMO then
		return
	end

	local equips = groupMO:getAllPosEquips()

	for pos, v in pairs(equips) do
		for _, uid in pairs(v.equipUid) do
			if uid == self._mo.uid then
				self:_showHeroIcon(pos, groupMO)

				return
			end
		end
	end
end

function EquipTeamItem:_setSelected(viewName, params)
	if viewName ~= ViewName.EquipTeamShowView then
		return
	end

	if self._mo.uid ~= params[1] then
		do return end

		local var_6_0

		if params[2] then
			var_6_0 = self._index or 1
		end
	end

	self._view:selectCell(var_6_0, true)
end

return EquipTeamItem
