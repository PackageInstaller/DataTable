-- chunkname: @modules/logic/character/view/extra/CharacterWeaponEffectItem.lua

module("modules.logic.character.view.extra.CharacterWeaponEffectItem", package.seeall)

local CharacterWeaponEffectItem = class("CharacterWeaponEffectItem", ListScrollCellExtend)

function CharacterWeaponEffectItem:onInitView()
	self._imagemainicon = gohelper.findChildImage(self.viewGO, "main/#image_icon")
	self._imagesecondicon = gohelper.findChildImage(self.viewGO, "second/#image_icon")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._txteffect = gohelper.findChildText(self.viewGO, "#txt_effect")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterWeaponEffectItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function CharacterWeaponEffectItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btntxt:RemoveClickListener()
end

function CharacterWeaponEffectItem:_btnclickOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if not self.heroMo:isOwnHero() then
		return
	end

	if not self.weaponMo then
		return
	end

	local isConfirm = self.weaponMo:isConfirmWeaponGroup(self._mo.firstId, self._mo.secondId)

	if isConfirm then
		return
	end

	self.weaponMo:confirmWeaponGroup(self._mo.firstId, self._mo.secondId)
end

function CharacterWeaponEffectItem:_editableInitView()
	self._btntxt = SLFramework.UGUI.UIClickListener.Get(self._txteffect.gameObject)

	self._btntxt:AddClickListener(self._btnclickOnClick, self)

	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterWeaponEffectItem:onUpdateMO(mo, heroMo, index)
	self._skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(self._txteffect.gameObject, SkillDescComp)
	self.heroMo = heroMo
	self.weaponMo = self.heroMo.extraMo:getWeaponMo()
	self._mo = mo

	self._skillDesc:updateInfo(self._txteffect, mo:getSecondDesc(), self.heroMo.heroId)
	gohelper.setActive(self.viewGO, true)
	self:refreshSelect()
	gohelper.setActive(self.viewGO, false)
	TaskDispatcher.runDelay(self._playOpenAnim, self, 0.06 * (index - 1))

	local weapon1, weapon2 = self._mo.firstId, self._mo.secondId
	local weaponMo1 = self.weaponMo:getWeaponMoByTypeId(CharacterExtraEnum.WeaponType.First, weapon1)
	local weaponMo2 = self.weaponMo:getWeaponMoByTypeId(CharacterExtraEnum.WeaponType.Second, weapon2)
	local iconPath1 = weaponMo1.co.firsticon

	if not string.nilorempty(iconPath1) then
		UISpriteSetMgr.instance:setUiCharacterSprite(self._imagemainicon, iconPath1)
	end

	local iconPath2 = weaponMo2.co.secondicon

	if not string.nilorempty(iconPath2) then
		UISpriteSetMgr.instance:setUiCharacterSprite(self._imagesecondicon, iconPath2)
	end
end

function CharacterWeaponEffectItem:_playOpenAnim()
	gohelper.setActive(self.viewGO, true)
	self._anim:Play(UIAnimationName.Open, 0, 0)
end

function CharacterWeaponEffectItem:refreshSelect()
	local isConfirm = self.weaponMo:isConfirmWeaponGroup(self._mo.firstId, self._mo.secondId)

	self:onSelect(isConfirm)
end

function CharacterWeaponEffectItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function CharacterWeaponEffectItem:onDestroyView()
	TaskDispatcher.cancelTask(self._playOpenAnim, self)
end

return CharacterWeaponEffectItem
