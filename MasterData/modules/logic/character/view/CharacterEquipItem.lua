-- chunkname: @modules/logic/character/view/CharacterEquipItem.lua

module("modules.logic.character.view.CharacterEquipItem", package.seeall)

local CharacterEquipItem = class("CharacterEquipItem", ListScrollCellExtend)

function CharacterEquipItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterEquipItem:addEvents()
	return
end

function CharacterEquipItem:removeEvents()
	return
end

function CharacterEquipItem:_editableInitView()
	self._click = gohelper.getClickWithAudio(self.viewGO)

	self._click:AddClickListener(self._onClick, self)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterEquipItem:_onClick()
	local param = {}

	param.equipMO = self._mo
	param.equipList = CharacterBackpackEquipListModel.instance:_getEquipList()

	EquipController.instance:openEquipView(param)
end

function CharacterEquipItem:_editableAddEvents()
	return
end

function CharacterEquipItem:_editableRemoveEvents()
	return
end

function CharacterEquipItem:onUpdateMO(mo)
	if not self._commonEquipIcon then
		self._commonEquipIcon = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, CommonEquipIcon)

		self._commonEquipIcon._overrideLoadIconFunc(self._commonEquipIcon, EquipHelper.getEquipIconLoadPath, self._commonEquipIcon)
	end

	self._mo = mo
	self._config = EquipConfig.instance:getEquipCo(mo.equipId)

	self._commonEquipIcon:setEquipMO(mo)
	self._commonEquipIcon:refreshLock(self._mo.isLock)
	self._commonEquipIcon:hideHeroIcon()
end

function CharacterEquipItem:onSelect(isSelect)
	return
end

function CharacterEquipItem:getAnimator()
	return self._animator
end

function CharacterEquipItem:onDestroyView()
	self._click:RemoveClickListener()
end

return CharacterEquipItem
