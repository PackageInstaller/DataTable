-- chunkname: @modules/logic/character/view/extra/CharacterWeaponEffectView.lua

module("modules.logic.character.view.extra.CharacterWeaponEffectView", package.seeall)

local CharacterWeaponEffectView = class("CharacterWeaponEffectView", BaseView)

function CharacterWeaponEffectView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._goscroll = gohelper.findChildScrollRect(self.viewGO, "root/#scroll")
	self._goitem = gohelper.findChild(self.viewGO, "root/#go_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterWeaponEffectView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3123WeaponReply, self._onChoiceHero3123WeaponReply, self)
end

function CharacterWeaponEffectView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3123WeaponReply, self._onChoiceHero3123WeaponReply, self)
end

function CharacterWeaponEffectView:_onChoiceHero3123WeaponReply(mainId, secondId)
	for _, item in ipairs(self._items) do
		item:refreshSelect()
	end
end

function CharacterWeaponEffectView:_editableInitView()
	return
end

function CharacterWeaponEffectView:onUpdateParam()
	return
end

function CharacterWeaponEffectView:onOpen()
	self.heroMo = self.viewParam
	self._items = self:getUserDataTb_()

	gohelper.setActive(self._goitem, false)

	local moList = CharacterWeaponListModel.instance:getMoList(self.heroMo)

	gohelper.CreateObjList(self, self._createItem, moList, self._goscroll.content.gameObject, self._goitem, CharacterWeaponEffectItem)
end

function CharacterWeaponEffectView:_createItem(obj, data, index)
	obj:onUpdateMO(data, self.heroMo, index)

	self._items[index] = obj
end

function CharacterWeaponEffectView:onClickModalMask()
	self:closeThis()
end

function CharacterWeaponEffectView:onClose()
	return
end

function CharacterWeaponEffectView:onDestroyView()
	return
end

return CharacterWeaponEffectView
