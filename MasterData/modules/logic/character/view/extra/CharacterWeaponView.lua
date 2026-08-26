-- chunkname: @modules/logic/character/view/extra/CharacterWeaponView.lua

module("modules.logic.character.view.extra.CharacterWeaponView", package.seeall)

local CharacterWeaponView = class("CharacterWeaponView", BaseView)
local defalutPrefValue = 0
local savePrefValue = 1

function CharacterWeaponView:onInitView()
	self._scrollmain = gohelper.findChildScrollRect(self.viewGO, "main/#scroll_main")
	self._gomain = gohelper.findChild(self.viewGO, "main/#go_main")
	self._imagemainweapon = gohelper.findChildImage(self.viewGO, "main/#go_main/equiped/#image_weapon")
	self._txtmainname = gohelper.findChildText(self.viewGO, "main/#go_main/equiped/#txt_name")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "main/#go_main/#btn_click")
	self._scrollsecond = gohelper.findChildScrollRect(self.viewGO, "second/#scroll_second")
	self._gosecond = gohelper.findChild(self.viewGO, "second/#go_second")
	self._imagesecondweapon = gohelper.findChildImage(self.viewGO, "second/#go_second/equiped/#image_weapon")
	self._txtsecondname = gohelper.findChildText(self.viewGO, "second/#go_second/equiped/#txt_name")
	self._btnsecondclick = gohelper.findChildButtonWithAudio(self.viewGO, "second/#go_second/#btn_click")
	self._goeffect = gohelper.findChild(self.viewGO, "#go_effect")
	self._goeffectTitle = gohelper.findChild(self.viewGO, "#go_effect/#go_effectTitle")
	self._btneffect = gohelper.findChildButtonWithAudio(self.viewGO, "#go_effect/#btn_effect")
	self._scrolleffect = gohelper.findChildScrollRect(self.viewGO, "#go_effect/#scroll_effect")
	self._txtfirsteffect = gohelper.findChildText(self.viewGO, "#go_effect/#scroll_effect/Viewport/Content/#txt_firsteffect")
	self._txtsecondeffect = gohelper.findChildText(self.viewGO, "#go_effect/#scroll_effect/Viewport/Content/#txt_secondeffect")
	self._goempty = gohelper.findChild(self.viewGO, "#go_effect/#scroll_effect/Viewport/Content/#go_empty")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterWeaponView:addEvents()
	self._btneffect:AddClickListener(self._btneffectOnClick, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._onSuccessHeroRankUp, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3123WeaponReply, self._onChoiceHero3123WeaponReply, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onClickWeapon, self._onClickWeapon, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function CharacterWeaponView:removeEvents()
	self._btneffect:RemoveClickListener()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._onSuccessHeroRankUp, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3123WeaponReply, self._onChoiceHero3123WeaponReply, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onClickWeapon, self._onClickWeapon, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function CharacterWeaponView:_btneffectOnClick()
	CharacterController.instance:openCharacterWeaponEffectView(self.heroMo)
end

function CharacterWeaponView:_onSuccessHeroRankUp()
	self:_refreshWeaponStatus()
	self:_refreshWeaponUnlock()
end

function CharacterWeaponView:_onChoiceHero3123WeaponReply()
	self:_refreshWeaponStatus()

	if not ViewMgr.instance:isOpen(ViewName.CharacterWeaponEffectView) then
		self:_playSwitchAnim()
	end
end

function CharacterWeaponView:_onCloseView(viewName)
	if viewName == ViewName.CharacterWeaponEffectView then
		self:_playSwitchAnim()
	end
end

function CharacterWeaponView:_onClickWeapon(type, id)
	local mo = self.weaponMo:getWeaponMoByTypeId(type, id)

	if mo then
		if mo:isLock() then
			if type == CharacterExtraEnum.WeaponType.Second and not self.weaponMo:isUnlockWeapon(type) then
				local rank = self.weaponMo:getUnlockWeaponRank(type)

				GameFacade.showToast(ToastEnum.CharacterSecondWeaponRankUnlock, GameUtil.getNum2Chinese(rank - 1))
			end

			return
		elseif mo:isNormal() then
			self.weaponMo:setChoiceHero3123WeaponRequest(type, id)
		end
	end

	self:_refreshWeaponStatus()
end

function CharacterWeaponView:_editableInitView()
	local contentmain = gohelper.findChild(self.viewGO, "main/#scroll_main/Viewport/Content")
	local contentsecond = gohelper.findChild(self.viewGO, "second/#scroll_second/Viewport/Content")
	local itemmain = gohelper.findChild(self.viewGO, "main/#scroll_main/Viewport/Content/go_item")
	local itemsecond = gohelper.findChild(self.viewGO, "second/#scroll_second/Viewport/Content/go_item")
	local equipRootmain = gohelper.findChild(self.viewGO, "main/#go_main/equiped")
	local equipRootsecond = gohelper.findChild(self.viewGO, "second/#go_second/equiped")
	local unequipRootmain = gohelper.findChild(self.viewGO, "main/#go_main/unequip")
	local unequipRootsecond = gohelper.findChild(self.viewGO, "second/#go_second/unequip")

	self._curShowWeapon = {}

	local mainWeaponAnim = self._gomain:GetComponent(typeof(UnityEngine.Animator))
	local secondWeaponAnim = self._gosecond:GetComponent(typeof(UnityEngine.Animator))
	local mainEffect = gohelper.findChild(self._txtfirsteffect.gameObject, "#switch")
	local secondEffect = gohelper.findChild(self._txtsecondeffect.gameObject, "#switch")
	local locksecond = gohelper.findChild(self.viewGO, "second/#go_second/locked")

	self._weaponItems = self:getUserDataTb_()
	self._weaponTypeComp = {
		[CharacterExtraEnum.WeaponType.First] = {
			content = contentmain,
			prefabItem = itemmain,
			equipRoot = equipRootmain,
			unequipRoot = unequipRootmain,
			anim = mainWeaponAnim,
			effect = mainEffect,
			nameTxt = self._txtmainname,
			iconImage = self._imagemainweapon
		},
		[CharacterExtraEnum.WeaponType.Second] = {
			content = contentsecond,
			prefabItem = itemsecond,
			equipRoot = equipRootsecond,
			unequipRoot = unequipRootsecond,
			lock = locksecond,
			anim = secondWeaponAnim,
			effect = secondEffect,
			nameTxt = self._txtsecondname,
			iconImage = self._imagesecondweapon
		}
	}

	gohelper.setActive(itemmain, false)
	gohelper.setActive(itemsecond, false)

	self._txtsecondweaponLock = gohelper.findChildText(self.viewGO, "second/#go_second/locked/txt_locked")
	self._effectAnim = self._goeffect:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterWeaponView:onUpdateParam()
	self:_refreshWeaponStatus()
end

function CharacterWeaponView:onOpen()
	self.heroMo = self.viewParam

	local extraMo = self.heroMo.extraMo

	self.weaponMo = extraMo:getWeaponMo()

	self:_refreshWeapon()
	self:_refreshEquip()
	self:_refreshWeaponUnlock()

	local unlockSecondWeaponRank = self.weaponMo:getUnlockWeaponRank(CharacterExtraEnum.WeaponType.Second)
	local lang = luaLang("characterweaponview_unlock_rank")
	local rankStr = GameUtil.getNum2Chinese(unlockSecondWeaponRank - 1)

	self._txtsecondweaponLock.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, rankStr)
end

function CharacterWeaponView:_refreshWeaponUnlock()
	for weaponType, comp in ipairs(self._weaponTypeComp) do
		local isUnlock = self.weaponMo:isUnlockWeapon(weaponType)

		if isUnlock then
			local key = self:_getPlayUnlockWeaponAnimKey(weaponType)

			if GameUtil.playerPrefsGetNumberByUserId(key, defalutPrefValue) == defalutPrefValue then
				comp.anim:Play(CharacterExtraEnum.WeaponAnimName.Unlock, 0, 0)
				GameUtil.playerPrefsSetNumberByUserId(key, savePrefValue)
				AudioMgr.instance:trigger(AudioEnum2_9.Character.ui_role_aijiao_jiesuo)
			end
		else
			gohelper.setActive(comp.equipRoot.gameObject, false)
			gohelper.setActive(comp.unequipRoot.gameObject, false)
		end

		if comp.lock then
			gohelper.setActive(comp.lock.gameObject, not isUnlock)
		end
	end
end

function CharacterWeaponView:_getPlayUnlockWeaponAnimKey(weaponType)
	return (string.format("CharacterWeaponView_PlayWeaponAnimKey_%s_%s", self.heroMo.heroId, weaponType))
end

function CharacterWeaponView:_refreshWeaponStatus()
	for _, items in pairs(self._weaponItems) do
		for _, item in pairs(items) do
			item:refreshStatus()
		end
	end
end

function CharacterWeaponView:_refreshEquip()
	local exSkillLevel = self.heroMo.exSkillLevel

	for _, type in pairs(CharacterExtraEnum.WeaponType) do
		local equipId = self.weaponMo:getCurEquipWeapon(type)
		local typeComp = self._weaponTypeComp[type]
		local isEquip = equipId and equipId ~= 0

		if isEquip then
			local mo = self.weaponMo:getWeaponMoByTypeId(type, equipId)

			if mo then
				typeComp.nameTxt.text = mo.co.name

				local iconPath = mo.co.secondicon

				if not string.nilorempty(iconPath) then
					UISpriteSetMgr.instance:setUiCharacterSprite(typeComp.iconImage, iconPath)
				end
			end

			gohelper.setActive(typeComp.equipRoot, true)
			gohelper.setActive(typeComp.unequipRoot, false)
		else
			gohelper.setActive(typeComp.equipRoot, false)

			local isUnlock = self.weaponMo:isUnlockWeapon(type)

			gohelper.setActive(typeComp.unequipRoot, isUnlock)
		end

		local curShowWeapon = self._curShowWeapon[type]

		curShowWeapon = curShowWeapon or {}
		curShowWeapon.id = equipId
		self._curShowWeapon[type] = curShowWeapon
	end

	local curShowFirstWeapon = self._curShowWeapon[CharacterExtraEnum.WeaponType.First]

	if curShowFirstWeapon then
		if not curShowFirstWeapon.id then
			local mainId = 0

			if mainId == 0 then
				gohelper.setActive(self._txtfirsteffect.gameObject, false)
				gohelper.setActive(self._txtsecondeffect.gameObject, false)
				gohelper.setActive(self._goempty.gameObject, true)

				return
			end

			local curShowSecondWeapon = self._curShowWeapon[CharacterExtraEnum.WeaponType.Second]

			if curShowSecondWeapon then
				if not curShowSecondWeapon.id then
					local secondId = 0
					local co = CharacterExtraConfig.instance:getEzioWeaponGroupCos(mainId, secondId, exSkillLevel)

					curShowFirstWeapon.desc = co.firstDesc
					self._firstSkillDesc = self._firstSkillDesc or MonoHelper.addNoUpdateLuaComOnceToGo(self._txtfirsteffect.gameObject, SkillDescComp)

					self._firstSkillDesc:updateInfo(self._txtfirsteffect, co.firstDesc, self.heroMo.heroId)
					self._firstSkillDesc:setTipParam(nil, Vector2(250, -100))
					self._firstSkillDesc:setBuffTipPivot(CommonBuffTipEnum.Pivot.Down)
					gohelper.setActive(self._txtfirsteffect.gameObject, true)
					gohelper.setActive(self._goempty.gameObject, false)

					if secondId == 0 then
						gohelper.setActive(self._txtsecondeffect.gameObject, false)

						return
					end

					curShowSecondWeapon.desc = co.secondDesc
					self._secondSkillDesc = self._secondSkillDesc or MonoHelper.addNoUpdateLuaComOnceToGo(self._txtsecondeffect.gameObject, SkillDescComp)

					self._secondSkillDesc:updateInfo(self._txtsecondeffect, co.secondDesc, self.heroMo.heroId)
					self._secondSkillDesc:setTipParam(nil, Vector2(250, -100))
					self._secondSkillDesc:setBuffTipPivot(CommonBuffTipEnum.Pivot.Down)
					gohelper.setActive(self._txtsecondeffect.gameObject, true)
				end
			end
		end
	end
end

function CharacterWeaponView:_checkDescHeight(co)
	local firstHeight = SLFramework.UGUI.GuiHelper.GetPreferredHeight(self._txtfirsteffect, co.firstDesc)
	local secondHeight = SLFramework.UGUI.GuiHelper.GetPreferredHeight(self._txtsecondeffect, co.secondDesc)
	local totalHeight = firstHeight + secondHeight + 20
	local scrollMaxHeight = 246
	local scrollMinHeight = 168
	local height = GameUtil.clamp(totalHeight, scrollMinHeight, scrollMaxHeight)

	recthelper.setHeight(self._scrolleffect.transform, height)
end

function CharacterWeaponView:_refreshWeapon()
	for _, type in pairs(CharacterExtraEnum.WeaponType) do
		local moList = self.weaponMo:getWeaponMosByType(type)

		for i, mo in ipairs(moList) do
			local item = self:_getWeaponItem(type, i)

			item:onUpdateMO(mo, self.heroMo)
		end
	end
end

function CharacterWeaponView:_getWeaponItem(type, index)
	self._weaponItems[type] = self._weaponItems[type] or self:getUserDataTb_()

	local item = self._weaponItems[type][index]

	if not item then
		local weaponTypeComp = self._weaponTypeComp[type]
		local parent = weaponTypeComp.content
		local prefabItem = weaponTypeComp.prefabItem
		local go = gohelper.clone(prefabItem, parent)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, CharacterWeaponShowItem)
		self._weaponItems[type][index] = item
	end

	return item
end

function CharacterWeaponView:_playSwitchAnim()
	TaskDispatcher.cancelTask(self._refreshEquip, self)

	local isPlaySwitchAnim = false
	local groupCo = self.weaponMo:getWeaponGroupCo()

	for weaponType, comp in ipairs(self._weaponTypeComp) do
		local weaponId = self.weaponMo:getCurEquipWeapon(weaponType)
		local curShowWeapon = self._curShowWeapon[weaponType]

		if curShowWeapon.id ~= weaponId then
			comp.anim:Play(CharacterExtraEnum.WeaponAnimName.Switch, 0, 0)
			AudioMgr.instance:trigger(AudioEnum2_9.Character.ui_role_aijiao_wuqi)
		end

		if weaponType == CharacterExtraEnum.WeaponType.First then
			if not groupCo.firstDesc then
				local desc = groupCo.secondDesc

				if curShowWeapon.desc ~= desc then
					gohelper.setActive(comp.effect, true)

					isPlaySwitchAnim = true
				else
					gohelper.setActive(comp.effect, false)
				end
			end
		end
	end

	if isPlaySwitchAnim then
		self._effectAnim:Play(CharacterExtraEnum.WeaponAnimName.Switch, 0, 0)
	end

	TaskDispatcher.runDelay(self._refreshEquip, self, 0.16)
end

function CharacterWeaponView:onClose()
	TaskDispatcher.cancelTask(self._refreshEquip, self)
end

function CharacterWeaponView:onDestroyView()
	return
end

return CharacterWeaponView
