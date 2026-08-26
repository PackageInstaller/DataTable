-- chunkname: @modules/logic/character/view/extra/CharacterDefaultExtraView.lua

module("modules.logic.character.view.extra.CharacterDefaultExtraView", package.seeall)

local CharacterDefaultExtraView = class("CharacterDefaultExtraView", BaseView)
local defalutPrefValue = 0
local savePrefValue = 1

function CharacterDefaultExtraView:onInitView()
	self._goskillLayout = gohelper.findChild(self.viewGO, "anim/layout/#go_skillLayout")
	self._goweapon = gohelper.findChild(self._goskillLayout, "#go_weapon")
	self._goweaponmain = gohelper.findChild(self._goweapon, "main")
	self._imageweaponmainicon = gohelper.findChildImage(self._goweapon, "main/#image_icon")
	self._goweaponmainadd = gohelper.findChild(self._goweapon, "main/#go_add")
	self._goweaponmainreddot = gohelper.findChild(self._goweapon, "main/#go_reddot")
	self._goweaponsecond = gohelper.findChild(self._goweapon, "second")
	self._imageweaponsecondicon = gohelper.findChildImage(self._goweapon, "second/#image_icon")
	self._goweaponsecondadd = gohelper.findChild(self._goweapon, "second/#go_add")
	self._goweaponsecondreddot = gohelper.findChild(self._goweapon, "second/#go_reddot")
	self._btnweapon = gohelper.findChildButtonWithAudio(self._goweapon, "#btn_weapon")
	self._goskilltalent = gohelper.findChild(self._goskillLayout, "#go_skilltalent")
	self._goskilltalentlock = gohelper.findChild(self._goskillLayout, "#go_skilltalent/lock")
	self._goskilltalentunlight = gohelper.findChild(self._goskillLayout, "#go_skilltalent/unlight")
	self._goskilltalentunlightreddot = gohelper.findChild(self._goskilltalent, "unlight/#go_reddot")
	self._goskilltalentlightedreddot = gohelper.findChild(self._goskilltalent, "lighted/#go_reddot")
	self._goskilltalentlighted = gohelper.findChild(self._goskillLayout, "#go_skilltalent/lighted")
	self._btnskilltalent = gohelper.findChildButtonWithAudio(self._goskilltalent, "#btn_skilltalent")
	self._goskill = gohelper.findChild(self._goskilltalent, "#go_skillLayout/#go_skill")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDefaultExtraView:addEvents()
	self._btnweapon:AddClickListener(self._btnweaponOnClick, self)
	self._btnskilltalent:AddClickListener(self._btnskilltalentOnClick, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._onSuccessHeroRankUp, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3123WeaponReply, self._refreshWeapon, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, self._refresSkilltalent, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onResetHero3124TalentTreeReply, self._refresSkilltalent, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, self._refresSkilltalent, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, self._refresSkilltalent, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, self._refresSkilltalent, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.OnSwitchSpine, self._onSwitchSpine, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self)
end

function CharacterDefaultExtraView:removeEvents()
	self._btnweapon:RemoveClickListener()
	self._btnskilltalent:RemoveClickListener()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._onSuccessHeroRankUp, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3123WeaponReply, self._refreshWeapon, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, self._refresSkilltalent, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onResetHero3124TalentTreeReply, self._refresSkilltalent, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, self._refresSkilltalent, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, self._refresSkilltalent, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, self._refresSkilltalent, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.OnSwitchSpine, self._onSwitchSpine, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self)
end

function CharacterDefaultExtraView:_btnweaponOnClick()
	if not self.weaponMo then
		return
	end

	if not self.weaponMo:isUnlockSystem() then
		local rank = self.weaponMo:getUnlockSystemRank()

		GameFacade.showToast(ToastEnum.CharacterRankUnlock, GameUtil.getNum2Chinese(rank - 1))

		return
	end

	CharacterController.instance:openCharacterWeaponView(self.heroMo)
	self.weaponMo:checkReddot()
	self:_refreshWeaponReddot()
end

function CharacterDefaultExtraView:_btnskilltalentOnClick()
	if not self.skillTalentMo then
		return
	end

	if not self.skillTalentMo:isUnlockSystem() then
		local rank = self.skillTalentMo:getUnlockSystemRank()

		GameFacade.showToast(ToastEnum.CharacterRankUnlock, GameUtil.getNum2Chinese(rank - 1))

		return
	end

	CharacterController.instance:openCharacterSkillTalentView(self.heroMo)
end

function CharacterDefaultExtraView:_editableInitView()
	local mainWeaponAnim = self._goweaponmain:GetComponent(typeof(UnityEngine.Animator))
	local secondWeaponAnim = self._goweaponsecond:GetComponent(typeof(UnityEngine.Animator))

	self._weaponComps = {
		[CharacterExtraEnum.WeaponType.First] = {
			Root = self._goweaponmain,
			Icon = self._imageweaponmainicon,
			Add = self._goweaponmainadd,
			Reddot = self._goweaponmainreddot,
			Anim = mainWeaponAnim
		},
		[CharacterExtraEnum.WeaponType.Second] = {
			Root = self._goweaponsecond,
			Icon = self._imageweaponsecondicon,
			Add = self._goweaponsecondadd,
			Reddot = self._goweaponsecondreddot,
			Anim = secondWeaponAnim
		}
	}
	self._skilltalentitems = self:getUserDataTb_()

	for i = 1, 3 do
		local go = gohelper.findChild(self._goskilltalent, "lighted/" .. i)

		if go then
			local item = self:getUserDataTb_()

			item.go = go
			item.iconList = self:getUserDataTb_()
			item.numList = self:getUserDataTb_()

			if i > 1 then
				for j = 1, i do
					item.iconList[j] = gohelper.findChildImage(go, "#image_icon" .. j)
					item.numList[j] = gohelper.findChildText(go, "#txt_num" .. j)
				end
			else
				item.iconList[1] = gohelper.findChildImage(go, "#image_icon")
				item.numList[1] = gohelper.findChildText(go, "#txt_num")
			end

			self._skilltalentitems[i] = item
		end
	end
end

function CharacterDefaultExtraView:_onSuccessHeroRankUp()
	self:_refreshView()
end

function CharacterDefaultExtraView:_onSwitchSpine(heroMo)
	self:_refreshMo(heroMo)
end

function CharacterDefaultExtraView:_onCloseFullView(viewName)
	if viewName == ViewName.CharacterRankUpResultView then
		self:_checkPlayUnlockWeaponAnim()
	elseif viewName == ViewName.CharacterWeaponView then
		self:_checkPlaySwitchWeaponAnim(true)
	end
end

function CharacterDefaultExtraView:onOpen()
	self:_refreshMo(self.viewParam)
end

function CharacterDefaultExtraView:_refreshMo(heroMo)
	self.heroMo = heroMo
	self.heroExtraMo = self.heroMo.extraMo
	self.weaponMo = self.heroExtraMo and self.heroExtraMo:getWeaponMo()

	local var_11_0 = self.heroExtraMo

	if self.heroExtraMo then
		if self.heroMo.trialCo then
			var_11_0 = OdysseyTalentModel.instance:getTrialCassandraTreeInfo() or self.heroExtraMo:getSkillTalentMo()
		end
	end

	self.skillTalentMo = var_11_0

	self:_refreshEntrance()
	self:_refreshView()
	self:_checkPlayUnlockWeaponAnim()
	self:_checkPlaySwitchWeaponAnim(false)
end

function CharacterDefaultExtraView:_refreshView()
	if self.weaponMo then
		self:_refreshWeapon()
	end

	if self.skillTalentMo then
		self:_refresSkilltalent()
	else
		gohelper.setActive(self._goskilltalentlightedreddot, false)
		gohelper.setActive(self._goskilltalentunlightreddot, false)
	end

	self:_refreshWeaponReddot()
end

function CharacterDefaultExtraView:_refreshWeaponReddot()
	for type, comp in ipairs(self._weaponComps) do
		local reddot = comp.Reddot

		if self.weaponMo then
			local isShow = self.weaponMo:isShowWeaponReddot(type)

			gohelper.setActive(reddot, self.weaponMo)
		end
	end
end

function CharacterDefaultExtraView:_refreshEntrance()
	if self.heroExtraMo then
		local hasTalentSkill = self.heroExtraMo:hasTalentSkill()

		if self.heroExtraMo then
			local hasWeapon = self.heroExtraMo:hasWeapon()

			gohelper.setActive(self._goweapon, hasWeapon)
			gohelper.setActive(self._goskilltalent, self.heroExtraMo)
		end
	end
end

function CharacterDefaultExtraView:_refreshWeapon()
	if self.weaponMo then
		for weaponType, comp in ipairs(self._weaponComps) do
			local isUnlock = self.weaponMo:isUnlockWeapon(weaponType)

			if isUnlock then
				local euipId = self.weaponMo:getCurEquipWeapon(weaponType)
				local isEquip = euipId and euipId ~= 0

				if isEquip then
					local mo = self.weaponMo:getWeaponMoByTypeId(weaponType, euipId)

					if weaponType == CharacterExtraEnum.WeaponType.First then
						if not mo.co.firsticon then
							local iconPath = mo.co.secondicon

							if not string.nilorempty(iconPath) then
								UISpriteSetMgr.instance:setUiCharacterSprite(comp.Icon, iconPath)
							end
						end
					end
				end

				gohelper.setActive(comp.Icon.gameObject, isEquip)
				gohelper.setActive(comp.Add, not isEquip)
			end

			gohelper.setActive(comp.Root, isUnlock)
		end
	end
end

function CharacterDefaultExtraView:_checkPlayUnlockWeaponAnim()
	if self.weaponMo then
		for weaponType, comp in ipairs(self._weaponComps) do
			local isUnlock = self.weaponMo:isUnlockWeapon(weaponType)

			if isUnlock then
				local key = self:_getPlayUnlockWeaponAnimKey(weaponType)
				local prefs = GameUtil.playerPrefsGetNumberByUserId(key, defalutPrefValue)

				if prefs == defalutPrefValue then
					comp.Anim:Play(CharacterExtraEnum.WeaponAnimName.Unlock, 0, 0)
					GameUtil.playerPrefsSetNumberByUserId(self:_getPlayUnlockWeaponAnimKey(weaponType), savePrefValue)
					AudioMgr.instance:trigger(AudioEnum2_9.Character.ui_role_aijiao_jiesuo2)
				end
			end
		end
	end
end

function CharacterDefaultExtraView:_checkPlaySwitchWeaponAnim(isPalyAnim)
	if self.weaponMo then
		self._showWeaponId = self._showWeaponId or {}

		for weaponType, comp in ipairs(self._weaponComps) do
			local isUnlock = self.weaponMo:isUnlockWeapon(weaponType)

			if isUnlock then
				local equipId = self.weaponMo:getCurEquipWeapon(weaponType)

				if not self._showWeaponId[weaponType] then
					if self._showWeaponId[weaponType] ~= equipId then
						self._showWeaponId[weaponType] = equipId

						if isPalyAnim then
							comp.Anim:Play(CharacterExtraEnum.WeaponAnimName.Switch, 0, 0)
						end
					end
				end
			end
		end
	end
end

function CharacterDefaultExtraView:_getPlayUnlockWeaponAnimKey(weaponType)
	return (string.format("CharacterDefaultExtraView_PlayWeaponAnimKey_%s_%s", self.heroMo.heroId, weaponType))
end

function CharacterDefaultExtraView:_refresSkilltalent()
	local isUnlock = self.skillTalentMo:isUnlockSystem()

	gohelper.setActive(self._goskilltalentlightedreddot, self.skillTalentMo:showReddot())
	gohelper.setActive(self._goskilltalentunlightreddot, self.skillTalentMo:showReddot())

	if isUnlock then
		local isNotLight = self.skillTalentMo:isNotLight()

		if not isNotLight then
			local extra = self.skillTalentMo:getSubExtra()
			local info = {}
			local treecount = 0

			for i, list in pairs(extra) do
				local v = {
					sub = i,
					count = tabletool.len(list)
				}

				table.insert(info, v)

				treecount = treecount + 1
			end

			table.sort(info, function(a, b)
				return a.count > b.count
			end)

			local stItem = self._skilltalentitems[treecount]

			if stItem then
				for j = 1, treecount do
					local txtNum = stItem.numList[j]

					txtNum.text = info[j].count

					local imageicon = stItem.iconList[j]
					local icon = self.skillTalentMo:getWhiteSubIconPath(info[j].sub)

					UISpriteSetMgr.instance:setUiCharacterSprite(imageicon, icon)
				end
			end

			for i, item in ipairs(self._skilltalentitems) do
				gohelper.setActive(item.go, treecount == i)
			end
		end

		gohelper.setActive(self._goskilltalentlock, false)
		gohelper.setActive(self._goskilltalentunlight, isNotLight)
		gohelper.setActive(self._goskilltalentlighted, not isNotLight)
	else
		gohelper.setActive(self._goskilltalentlock, true)
		gohelper.setActive(self._goskilltalentunlight, false)
		gohelper.setActive(self._goskilltalentlighted, false)
	end
end

return CharacterDefaultExtraView
