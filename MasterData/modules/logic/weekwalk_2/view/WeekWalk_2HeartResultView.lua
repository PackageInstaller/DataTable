-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeartResultView.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeartResultView", package.seeall)

local WeekWalk_2HeartResultView = class("WeekWalk_2HeartResultView", BaseView)

function WeekWalk_2HeartResultView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagePanelBG1 = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG1")
	self._simagePanelBG2 = gohelper.findChildSingleImage(self.viewGO, "#simage_PanelBG1/#simage_PanelBG2")
	self._goPanel = gohelper.findChild(self.viewGO, "#go_Panel")
	self._goleft = gohelper.findChild(self.viewGO, "#go_Panel/#go_left")
	self._simagemaskImage = gohelper.findChildSingleImage(self.viewGO, "#go_Panel/#go_left/#simage_maskImage")
	self._goAttack = gohelper.findChild(self.viewGO, "#go_Panel/#go_Attack")
	self._txtattackNum1 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_Attack/LayoutGroup/Data1/#txt_attackNum1")
	self._txtattackNum2 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_Attack/LayoutGroup/Data2/#txt_attackNum2")
	self._txtattackNum3 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_Attack/LayoutGroup/Data3/#txt_attackNum3")
	self._goHealth = gohelper.findChild(self.viewGO, "#go_Panel/#go_Health")
	self._txthealthNum1 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_Health/LayoutGroup/Data1/#txt_healthNum1")
	self._txthealthNum2 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_Health/LayoutGroup/Data2/#txt_healthNum2")
	self._goDefence = gohelper.findChild(self.viewGO, "#go_Panel/#go_Defence")
	self._txtdefenceNum1 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_Defence/LayoutGroup/Data1/#txt_defenceNum1")
	self._txtdefenceNum2 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_Defence/LayoutGroup/Data2/#txt_defenceNum2")
	self._goRoleData = gohelper.findChild(self.viewGO, "#go_Panel/#go_RoleData")
	self._simageRoleattack = gohelper.findChildSingleImage(self.viewGO, "#go_Panel/#go_RoleData/Attack/skinnode/node/#simage_Roleattack")
	self._txtNumattack1 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_RoleData/Attack/LayoutGroup/Data1/#txt_Numattack1")
	self._txtNumattack2 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_RoleData/Attack/LayoutGroup/Data2/#txt_Numattack2")
	self._txtNumattack3 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_RoleData/Attack/LayoutGroup/Data3/#txt_Numattack3")
	self._simageRolehealth = gohelper.findChildSingleImage(self.viewGO, "#go_Panel/#go_RoleData/Health/skinnode/node/#simage_Rolehealth")
	self._txtNumhealth1 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_RoleData/Health/LayoutGroup/Data1/#txt_Numhealth1")
	self._txtNumhealth2 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_RoleData/Health/LayoutGroup/Data2/#txt_Numhealth2")
	self._simageRoledefence = gohelper.findChildSingleImage(self.viewGO, "#go_Panel/#go_RoleData/Defence/skinnode/node/#simage_Roledefence")
	self._txtNumdefence1 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_RoleData/Defence/LayoutGroup/Data1/#txt_Numdefence1")
	self._txtNumdefence2 = gohelper.findChildText(self.viewGO, "#go_Panel/#go_RoleData/Defence/LayoutGroup/Data2/#txt_Numdefence2")
	self._goCupData = gohelper.findChild(self.viewGO, "#go_Panel/#go_CupData")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Panel/#btn_click")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_skip")
	self._imageskip = gohelper.findChildImage(self.viewGO, "#btn_skip/#image_skip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2HeartResultView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
end

function WeekWalk_2HeartResultView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnskip:RemoveClickListener()
end

function WeekWalk_2HeartResultView:_btnskipOnClick()
	self._index = WeekWalk_2Enum.ResultAnimIndex.CupData

	self:_updateStatus()
end

function WeekWalk_2HeartResultView:_btnclickOnClick()
	self:_showNext()
end

function WeekWalk_2HeartResultView:_showNext()
	self._index = self._index + 1

	if self._index > #self._showHandler then
		self:closeThis()

		return
	end

	self:_updateStatus()
end

function WeekWalk_2HeartResultView:_editableInitView()
	self._animator = self.viewGO:GetComponent("Animator")
	self._index = 1
	self._showHandler = {
		[WeekWalk_2Enum.ResultAnimIndex.Attack] = self._showAttack,
		[WeekWalk_2Enum.ResultAnimIndex.Health] = self._showHealth,
		[WeekWalk_2Enum.ResultAnimIndex.Defence] = self._showDefence,
		[WeekWalk_2Enum.ResultAnimIndex.RoleData] = self._showRoleData,
		[WeekWalk_2Enum.ResultAnimIndex.CupData] = self._showCupData
	}
	self._showStatusInfo = {}
	self._animName = {
		[WeekWalk_2Enum.ResultAnimIndex.Attack] = "attack",
		[WeekWalk_2Enum.ResultAnimIndex.Health] = "health",
		[WeekWalk_2Enum.ResultAnimIndex.Defence] = "defence",
		[WeekWalk_2Enum.ResultAnimIndex.RoleData] = "roledata",
		[WeekWalk_2Enum.ResultAnimIndex.CupData] = "cupdata"
	}

	self:_initSpineNodes()
end

function WeekWalk_2HeartResultView:_initSpineNodes()
	self._gospine = gohelper.findChild(self._goleft, "spineContainer/spine")
	self._uiSpine = GuiModelAgent.Create(self._gospine, true)

	self._uiSpine:useRT()
	self._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)

	self._txtSayCn = gohelper.findChildText(self._goleft, "layout/txtSayCn")
	self._txtSayEn = gohelper.findChildText(self._goleft, "layout/txtSayEn")
	self._txtSayCn.text = ""
	self._txtSayEn.text = ""
end

function WeekWalk_2HeartResultView:_hideSpine()
	if self._uiSpine then
		self._uiSpine:stopVoice()
	end

	gohelper.setActive(self._goleft, false)
end

function WeekWalk_2HeartResultView:_showSpine(heroId)
	gohelper.setActive(self._goleft, true)

	if self._uiSpine then
		self._uiSpine:stopVoice()
	end

	local heroMo = HeroModel.instance:getByHeroId(heroId)
	local skinCO = heroMo and lua_skin.configDict[heroMo.skin]

	if not skinCO then
		return
	end

	self._heorId = heroId
	self._skinId = skinCO.id

	self._uiSpine:setImgPos(0)
	self._uiSpine:setResPath(skinCO, function()
		self._spineLoaded = true
	end, self, CharacterVoiceEnum.NormalFullScreenEffectCameraSize)

	local offsets, isNil = SkinConfig.instance:getSkinOffset(skinCO.fightSuccViewOffset)

	if isNil then
		offsets, _ = SkinConfig.instance:getSkinOffset(skinCO.characterViewOffset)
		offsets = SkinConfig.instance:getAfterRelativeOffset(504, offsets)
	end

	local scale = tonumber(offsets[3])
	local offsetX = tonumber(offsets[1])
	local offsetY = tonumber(offsets[2])

	CharacterVoiceEnum.setSpineOffset(self._uiSpine, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gospine.transform, scale, scale, scale)
end

function WeekWalk_2HeartResultView:_playSpineVoice()
	local voiceCOList = HeroModel.instance:getVoiceConfig(self._heorId, CharacterEnum.VoiceType.FightResult, nil, self._skinId)

	voiceCOList = voiceCOList or FightAudioMgr.instance:_getHeroVoiceCOs(self._heorId, CharacterEnum.VoiceType.FightResult, self._skinId)

	if voiceCOList and #voiceCOList > 0 then
		local firstVoiceCO = voiceCOList[1]

		self._uiSpine:playVoice(firstVoiceCO, nil, self._txtSayCn, self._txtSayEn)
	end
end

function WeekWalk_2HeartResultView:_updateStatus()
	gohelper.setActive(self._goAttack, true)
	gohelper.setActive(self._goHealth, true)
	gohelper.setActive(self._goDefence, true)
	gohelper.setActive(self._goRoleData, true)
	gohelper.setActive(self._goCupData, true)
	gohelper.setActive(self._btnskip, self._index ~= WeekWalk_2Enum.ResultAnimIndex.CupData)

	local handler = self._showHandler[self._index]
	local isFail = handler(self)

	self._showStatusInfo[self._index] = isFail

	if not isFail then
		if self._index ~= WeekWalk_2Enum.ResultAnimIndex.Attack then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
		end

		if self._index == WeekWalk_2Enum.ResultAnimIndex.Defence and self._showStatusInfo[WeekWalk_2Enum.ResultAnimIndex.Health] then
			self._animator:Play("go_" .. self._animName[self._index] .. "2", 0, 0)

			return
		end

		if self._index == WeekWalk_2Enum.ResultAnimIndex.CupData and self._prevIndex ~= WeekWalk_2Enum.ResultAnimIndex.RoleData then
			self._animator:Play("cupdata2", 0, 0)

			return
		end

		self._animator:Play("go_" .. self._animName[self._index], 0, 0)

		self._prevIndex = self._index
	else
		self:_showNext()
	end
end

function WeekWalk_2HeartResultView:_showAttack()
	gohelper.setActive(self._goAttack, true)

	local info = self._info.harmHero

	self._txtattackNum1.text = info.battleNum
	self._txtattackNum2.text = info.allHarm
	self._txtattackNum3.text = info.singleHighHarm

	self:_showSpine(info.heroId)
end

local delayShowTime = 0.2

function WeekWalk_2HeartResultView:_showHealth()
	gohelper.setActive(self._goHealth, true)

	local info = self._info.healHero

	if tonumber(info.allHeal) <= 0 then
		return true
	end

	self._txthealthNum1.text = info.battleNum
	self._txthealthNum2.text = info.allHeal
	self._spineHeroId = info.heroId

	TaskDispatcher.cancelTask(self._delayShowSpine, self)
	TaskDispatcher.runDelay(self._delayShowSpine, self, delayShowTime)
end

function WeekWalk_2HeartResultView:_showDefence()
	gohelper.setActive(self._goDefence, true)

	local info = self._info.hurtHero

	self._txtdefenceNum1.text = info.battleNum
	self._txtdefenceNum2.text = info.allHurt
	self._spineHeroId = info.heroId

	TaskDispatcher.cancelTask(self._delayShowSpine, self)
	TaskDispatcher.runDelay(self._delayShowSpine, self, delayShowTime)
end

function WeekWalk_2HeartResultView:_delayShowSpine()
	if self._uiSpine then
		local go = self._uiSpine:getSpineGo()

		gohelper.setActive(go, false)
	end

	self:_showSpine(self._spineHeroId)
end

function WeekWalk_2HeartResultView:_showRoleData()
	self:_hideSpine()
	gohelper.setActive(self._goRoleData, true)

	local info1 = self._info.harmHero
	local info2 = self._info.healHero
	local info3 = self._info.hurtHero

	self._txtNumattack1.text = info1.battleNum
	self._txtNumattack2.text = info1.allHarm
	self._txtNumattack3.text = info1.singleHighHarm
	self._txtNumhealth1.text = info2.battleNum
	self._txtNumhealth2.text = info2.allHeal

	if tonumber(info2.allHeal) <= 0 then
		local go = gohelper.findChild(self.viewGO, "#go_Panel/#go_RoleData/Health")

		gohelper.setActive(go, false)

		local attackGo = gohelper.findChild(self.viewGO, "#go_Panel/#go_RoleData/Attack")
		local defenceGo = gohelper.findChild(self.viewGO, "#go_Panel/#go_RoleData/Defence")
		local attackPosGo = gohelper.findChild(self.viewGO, "#go_Panel/#go_RoleData/2/Attack")
		local defencePosGo = gohelper.findChild(self.viewGO, "#go_Panel/#go_RoleData/2/Defence")

		gohelper.addChild(attackPosGo, attackGo)
		gohelper.addChild(defencePosGo, defenceGo)
		recthelper.setAnchor(attackGo.transform, 0, 0)
		recthelper.setAnchor(defenceGo.transform, 0, 0)
	end

	self._txtNumdefence1.text = info3.battleNum
	self._txtNumdefence2.text = info3.allHurt

	local heroMo1 = HeroModel.instance:getByHeroId(info1.heroId)

	if heroMo1 then
		self:_loadRoleImage(self._simageRoleattack, heroMo1.skin)
	end

	gohelper.setActive(self._simageRoleattack, heroMo1 ~= nil)

	local heroMo2 = HeroModel.instance:getByHeroId(info2.heroId)

	if heroMo2 then
		self:_loadRoleImage(self._simageRolehealth, heroMo2.skin)
	end

	gohelper.setActive(self._simageRolehealth, heroMo2 ~= nil)

	local heroMo3 = HeroModel.instance:getByHeroId(info3.heroId)

	if heroMo3 then
		self:_loadRoleImage(self._simageRoledefence, heroMo3.skin)
	end

	gohelper.setActive(self._simageRoledefence, heroMo3 ~= nil)
end

function WeekWalk_2HeartResultView:_loadRoleImage(simage, skinId)
	local function _loadedImage()
		local skinCo = SkinConfig.instance:getSkinCo(skinId)

		ZProj.UGUIHelper.SetImageSize(simage.gameObject)

		local offsetStr = skinCo.lucidescapeViewImgOffset

		if string.nilorempty(offsetStr) then
			offsetStr = skinCo.playercardViewImgOffset
		end

		if string.nilorempty(offsetStr) then
			offsetStr = skinCo.characterViewImgOffset
		end

		if not string.nilorempty(offsetStr) then
			local offsets = string.splitToNumber(offsetStr, "#")

			recthelper.setAnchor(simage.transform, tonumber(offsets[1]), tonumber(offsets[2]))
			transformhelper.setLocalScale(simage.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
		end
	end

	simage:LoadImage(ResUrl.getHeadIconImg(skinId), _loadedImage)
end

function WeekWalk_2HeartResultView:_showCupData()
	gohelper.setActive(self._goCupData, true)

	local layerInfos = self._info.layerInfos

	for i, v in pairs(layerInfos) do
		self:_showLayerInfo(v.config.layer, v)
	end
end

function WeekWalk_2HeartResultView:_showLayerInfo(layerIndex, layerInfo)
	local config = layerInfo.config

	self:_showLayerBattleInfo(layerIndex, 1, layerInfo.battleInfos[config.fightIdFront], layerInfo)
	self:_showLayerBattleInfo(layerIndex, 2, layerInfo.battleInfos[config.fightIdRear], layerInfo)
end

function WeekWalk_2HeartResultView:_showLayerBattleInfo(layerIndex, battleIndex, battleInfo, layerInfo)
	local layerRoot = gohelper.findChild(self._goCupData, tostring(layerIndex))
	local battleRoot = gohelper.findChild(layerRoot, "Level/" .. tostring(battleIndex))

	if battleIndex == 1 then
		local txtBattle = gohelper.findChildText(layerRoot, "battlename")

		txtBattle.text = layerInfo.sceneConfig.battleName
	end

	local starGo1 = gohelper.findChild(battleRoot, "badgelayout/1")
	local starGo2 = gohelper.cloneInPlace(starGo1)
	local starGo3 = gohelper.cloneInPlace(starGo1)

	self:_showBattleCup(starGo1, battleInfo.cupInfos[1])
	self:_showBattleCup(starGo2, battleInfo.cupInfos[2])
	self:_showBattleCup(starGo3, battleInfo.cupInfos[3])
end

function WeekWalk_2HeartResultView:_showBattleCup(go, cupInfo)
	if cupInfo then
		if not cupInfo.result then
			local result = 0
			local show = result > 0
			local iconGo = gohelper.findChild(go, "1")

			gohelper.setActive(iconGo, show)

			if not show then
				return
			end

			local icon = gohelper.findChildImage(go, "1")

			icon.enabled = false

			local iconEffect = self:getResInst(self.viewContainer._viewSetting.otherRes.weekwalkheart_star, icon.gameObject)

			WeekWalk_2Helper.setCupEffect(iconEffect, cupInfo)
		end
	end
end

function WeekWalk_2HeartResultView:onUpdateParam()
	return
end

function WeekWalk_2HeartResultView:onOpen()
	self._info = WeekWalk_2Model.instance:getSettleInfo()

	self:_showEndingAnim()
	self.addEventCb(self, WeekWalk_2Controller.instance, WeekWalk_2Event.OnShowSkin, self._onShowSkin, self)
end

function WeekWalk_2HeartResultView:_onShowSkin(skinId)
	self:_loadRoleImage(self._simageRoledefence, skinId)
end

function WeekWalk_2HeartResultView:_showEndingAnim()
	gohelper.setActive(self._goweekwalkending, true)
	gohelper.setActive(self._goPanel, false)
	gohelper.setActive(self._goAttack, false)
	gohelper.setActive(self._goHealth, false)
	gohelper.setActive(self._goDefence, false)
	gohelper.setActive(self._goRoleData, false)
	gohelper.setActive(self._goCupData, false)
	self:_showInfos()
end

function WeekWalk_2HeartResultView:_showInfos()
	gohelper.setActive(self._goweekwalkending, false)
	gohelper.setActive(self._goPanel, true)
	self:_updateStatus()
end

function WeekWalk_2HeartResultView:onClose()
	FightController.instance:dispatchEvent(FightEvent.OnResultViewClose)

	if self._uiSpine then
		self._uiSpine:stopVoice()
	end

	WeekWalk_2Model.instance:clearSettleInfo()
	TaskDispatcher.cancelTask(self._delayShowSpine, self)
end

function WeekWalk_2HeartResultView:onDestroyView()
	return
end

return WeekWalk_2HeartResultView
