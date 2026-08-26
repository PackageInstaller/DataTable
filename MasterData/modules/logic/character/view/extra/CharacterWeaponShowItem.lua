-- chunkname: @modules/logic/character/view/extra/CharacterWeaponShowItem.lua

module("modules.logic.character.view.extra.CharacterWeaponShowItem", package.seeall)

local CharacterWeaponShowItem = class("CharacterWeaponShowItem", LuaCompBase)

function CharacterWeaponShowItem:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "root/#go_select")
	self._imageselecticon = gohelper.findChildImage(self.viewGO, "root/#go_select/#image_icon")
	self._gounselect = gohelper.findChild(self.viewGO, "root/#go_unselect")
	self._imageunselecticon = gohelper.findChildImage(self.viewGO, "root/#go_unselect/#image_icon")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#go_unselect/#go_reddot")
	self._golock = gohelper.findChild(self.viewGO, "root/#go_lock")
	self._imagelockicon = gohelper.findChildImage(self.viewGO, "root/#go_lock/#image_icon")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterWeaponShowItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function CharacterWeaponShowItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function CharacterWeaponShowItem:_btnclickOnClick()
	if not self._heroMo:isOwnHero() then
		return
	end

	self._mo:cancelNew()
	gohelper.setActive(self._goreddot, false)
	CharacterController.instance:dispatchEvent(CharacterEvent.onClickWeapon, self._mo.type, self._mo.weaponId)
end

function CharacterWeaponShowItem:init(go)
	self.viewGO = go

	self:onInitView()

	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterWeaponShowItem:_editableInitView()
	self._txt = gohelper.findChildText(self.viewGO, "txt")
end

function CharacterWeaponShowItem:onUpdateMO(mo, heroMo)
	self._mo = mo
	self._heroMo = heroMo

	local iconPath = self._mo.co.firsticon

	if not string.nilorempty(iconPath) then
		UISpriteSetMgr.instance:setUiCharacterSprite(self._imageselecticon, iconPath)
		UISpriteSetMgr.instance:setUiCharacterSprite(self._imageunselecticon, iconPath)
		UISpriteSetMgr.instance:setUiCharacterSprite(self._imagelockicon, iconPath)
	end

	gohelper.setActive(self.viewGO, true)
	gohelper.setActive(self._goreddot, self._heroMo:isOwnHero() and mo:isNew())
	self:refreshStatus()
end

function CharacterWeaponShowItem:refreshStatus()
	local lock = self._mo:isLock()
	local equip = self._mo:isEquip()

	gohelper.setActive(self._goselect, not lock and equip)
	gohelper.setActive(self._gounselect, not lock and not equip)
	gohelper.setActive(self._golock, lock)

	if not lock and GameUtil.playerPrefsGetNumberByUserId(self:_getUnlockAnimKey(), 0) == 0 then
		self._anim:Play(CharacterExtraEnum.WeaponAnimName.Unlock, 0, 0)
		GameUtil.playerPrefsSetNumberByUserId(self:_getUnlockAnimKey(), 1)
	end
end

function CharacterWeaponShowItem:_getUnlockAnimKey()
	return (string.format("CharacterWeaponShowItem_getUnlockAnimKey_%s_%s_%s", self._mo.heroId, self._mo.type, self._mo.weaponId))
end

function CharacterWeaponShowItem:onDestroyView()
	return
end

return CharacterWeaponShowItem
