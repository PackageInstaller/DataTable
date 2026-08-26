-- chunkname: @modules/logic/character/view/CharacterSwitchView.lua

module("modules.logic.character.view.CharacterSwitchView", package.seeall)

local CharacterSwitchView = class("CharacterSwitchView", BaseView)

function CharacterSwitchView:onInitView()
	self._btnchange = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_change")
	self._goshowing = gohelper.findChild(self.viewGO, "right/start/#go_showing")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "right/mask/#scroll_card")
	self._btntimerank = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_timerank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_rarerank")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gospinescale = gohelper.findChild(self.viewGO, "#go_spine_scale")
	self._golightspine = gohelper.findChild(self.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	self._goinfo = gohelper.findChild(self.viewGO, "left/#go_info")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "left/#go_info/#simage_signature")
	self._txttime = gohelper.findChildText(self.viewGO, "left/#go_info/#txt_time")
	self._goheroskin = gohelper.findChild(self.viewGO, "left/#go_heroskin")
	self._gobgbottom = gohelper.findChild(self.viewGO, "left/#go_heroskin/#go_bgbottom")
	self._scrollskin = gohelper.findChildScrollRect(self.viewGO, "left/#go_heroskin/#scroll_skin")
	self._goheroskinItem = gohelper.findChild(self.viewGO, "left/#go_heroskin/#scroll_skin/Viewport/Content/#go_heroskinItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSwitchView:addEvents()
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
	self._btntimerank:AddClickListener(self._btntimerankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
end

function CharacterSwitchView:removeEvents()
	self._btnchange:RemoveClickListener()
	self._btntimerank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
end

function CharacterSwitchView:_btnchangeOnClick()
	if not self._isRandom then
		self._curHeroId = self._heroId
		self._curSkinId = self._skinId
	end

	self._curRandom = self._isRandom

	CharacterSwitchListModel.instance:changeMainHero(self._curHeroId, self._curSkinId, self._isRandom)
	CharacterController.instance:dispatchEvent(CharacterEvent.MainThumbnailSignature, self._heroId)

	local limitedCO = LimitedRoleController.instance:getNeedPlayLimitedCO()

	if limitedCO and SettingsModel.instance.limitedRoleMO:isAuto() then
		LimitedRoleController.instance:play(LimitedRoleEnum.Stage.SwitchRole, limitedCO)
	end

	self:showTip()
end

function CharacterSwitchView:_btntimerankOnClick()
	if self._sortIndex ~= 1 then
		self._sortIndex = 1
	else
		self._asceTime = not self._asceTime
	end

	self._asceRare = false

	self:_refreshBtnIcon()
end

function CharacterSwitchView:_btnrarerankOnClick()
	if self._sortIndex ~= 2 then
		self._sortIndex = 2
	else
		self._asceRare = not self._asceRare
	end

	self._asceTime = false

	self:_refreshBtnIcon()
end

function CharacterSwitchView:_refreshBtnIcon()
	local tag = self._sortIndex

	if tag == 1 then
		CharacterSwitchListModel.instance:sortByTime(self._asceTime)
	else
		CharacterSwitchListModel.instance:sortByRare(self._asceRare)
	end

	gohelper.setActive(self._timeBtns[1], tag ~= 1)
	gohelper.setActive(self._timeBtns[2], tag == 1)
	gohelper.setActive(self._rareBtns[1], tag ~= 2)
	gohelper.setActive(self._rareBtns[2], tag == 2)

	local scaleTime = self._asceTime and -1 or 1
	local scaleRare = self._asceRare and -1 or 1

	transformhelper.setLocalScale(self._timeArrow[1], 1, scaleTime, 1)
	transformhelper.setLocalScale(self._timeArrow[2], 1, scaleTime, 1)
	transformhelper.setLocalScale(self._rareArrow[1], 1, scaleRare, 1)
	transformhelper.setLocalScale(self._rareArrow[2], 1, scaleRare, 1)
end

function CharacterSwitchView:_editableInitView()
	self._rootAnimator = self.viewGO:GetComponent("Animator")
	self._heroIdSet = {}
	self._showItemList = self:getUserDataTb_()
	self._cacheItemList = self:getUserDataTb_()

	self._goinfo:SetActive(false)

	self._timeBtns = self:getUserDataTb_()
	self._timeArrow = self:getUserDataTb_()
	self._rareBtns = self:getUserDataTb_()
	self._rareArrow = self:getUserDataTb_()

	for i = 1, 2 do
		self._timeBtns[i] = gohelper.findChild(self._btntimerank.gameObject, "btn" .. tostring(i))
		self._timeArrow[i] = gohelper.findChild(self._timeBtns[i], "txt/arrow").transform
		self._rareBtns[i] = gohelper.findChild(self._btnrarerank.gameObject, "btn" .. tostring(i))
		self._rareArrow[i] = gohelper.findChild(self._rareBtns[i], "txt/arrow").transform
	end

	self._sortIndex = 2
	self._asceTime = false
	self._asceRare = false
	self._golightspineParent = gohelper.findChild(self.viewGO, "#go_spine_scale/lightspine")

	gohelper.addUIClickAudio(self._btnchange.gameObject, AudioEnum.UI.Store_Good_Click)
	CharacterSwitchListModel.instance:initHeroList()
	self:_showMainHero(true)
	self:_refreshSelect()
	self:_refreshBtnIcon()
	MainHeroView.setSpineScale(self._gospinescale)
end

function CharacterSwitchView:_onScreenResize()
	MainHeroView.setSpineScale(self._gospinescale)
end

function CharacterSwitchView:_showMainHero(updateSelect)
	self._curHeroId, self._curSkinId, self._curRandom = CharacterSwitchListModel.instance:getMainHero()

	self:changeHero(self._curHeroId)

	if self._curHeroId and self._curSkinId then
		self:_switchHero(self._curHeroId, self._curSkinId, self._curRandom)

		if updateSelect then
			self:_refreshSelect()
		end
	end
end

function CharacterSwitchView:_refreshSelect()
	local heroId = not self._isRandom and self._heroId
	local mo = CharacterSwitchListModel.instance:getMoByHeroId(heroId)
	local scrollView = self.viewContainer:getCharacterScrollView()

	if mo then
		scrollView:setSelect(mo)
	end
end

function CharacterSwitchView:changeHero(id)
	CharacterSwitchListModel.instance.curHeroId = id
end

function CharacterSwitchView:_updateHero(heroId, skinId, isRandom)
	if gohelper.isNil(self._golightspine) then
		return
	end

	if isRandom then
		self:changeHero(nil)
	else
		self:changeHero(heroId)
	end

	if not isRandom then
		self:_modifySkinState(heroId, skinId)
	end

	local prevSkinId = self._skinId

	self._heroId = heroId
	self._skinId = skinId
	self._isRandom = isRandom

	self:showTip()

	local hero = HeroModel.instance:getByHeroId(self._heroId)
	local skinCo = SkinConfig.instance:getSkinCo(self._skinId or hero and hero.skin)

	if not skinCo then
		return
	end

	self._hero = hero
	self._heroSkinConfig = skinCo

	if not self._lightSpine then
		self:_getLightSpine()

		self._lightSpine = LightModelAgent.Create(self._golightspine, true)
	elseif prevSkinId ~= self._skinId or not LimitedRoleController.instance:isPlayingAction() then
		self._lightSpine:stopVoice()
	end

	self:_setOffset()
	TaskDispatcher.cancelTask(self._delayInitLightSpine, self)
	self._lightSpine:setResPath(skinCo, self._onLightSpineLoaded, self)
	self._simagesignature:UnLoadImage()
	self._simagesignature:LoadImage(ResUrl.getSignature(self._hero.config.signature))
end

function CharacterSwitchView:_setOffset()
	local offsetParam = SkinConfig.instance:getSkinOffset(self._heroSkinConfig.mainViewOffset)
	local transform = self._golightspine.transform

	recthelper.setAnchor(transform, tonumber(offsetParam[1]), tonumber(offsetParam[2]))

	local scale = tonumber(offsetParam[3])

	transformhelper.setLocalScale(transform, scale, scale, scale)
end

function CharacterSwitchView:_getLightSpine()
	if ViewMgr.instance:isOpen(ViewName.SkinOffsetAdjustView) then
		return
	end

	if not ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		return
	end

	local viewContains = ViewMgr.instance:getContainer(ViewName.MainThumbnailView)

	if not viewContains then
		return
	end

	local shareLightSpineGo = viewContains:getLightSpineGo()

	gohelper.addChildPosStay(self._golightspine.transform.parent.gameObject, shareLightSpineGo)
	gohelper.destroy(self._golightspine)

	self._golightspine = shareLightSpineGo
end

function CharacterSwitchView:showTip()
	local showCurHero = self._curHeroId == self._heroId and self._curSkinId == self._skinId and self._curRandom == self._isRandom

	if self._isRandom and self._curRandom then
		showCurHero = true
	end

	gohelper.setActive(self._btnchange.gameObject, not showCurHero)
	gohelper.setActive(self._goshowing.gameObject, showCurHero)
end

function CharacterSwitchView:_needDelay()
	return self._heroSkinConfig.id == 301601 or self._heroSkinConfig.id == 301602
end

function CharacterSwitchView:_onLightSpineLoaded()
	if not self:_needDelay() then
		self:_delayInitLightSpine()

		return
	end

	TaskDispatcher.runDelay(self._delayInitLightSpine, self, 0.1)
end

function CharacterSwitchView:_delayInitLightSpine()
	if gohelper.isNil(self.viewGO) then
		return
	end

	local renderer = self._lightSpine:getRenderer()

	WeatherController.instance:setLightModel(self._lightSpine)

	local param = {
		roleGo = self._lightSpine:getSpineGo(),
		heroId = self._heroId,
		sharedMaterial = renderer.sharedMaterial,
		skinId = self._skinId
	}

	WeatherController.instance:changeRoleGo(param)
	self._goinfo:SetActive(true)

	local timeStr = ServerTime.formatTimeInLocal(self._hero.createTime / 1000, "%Y / %m / %d")

	if not timeStr then
		return
	end

	self._txttime.text = timeStr
end

function CharacterSwitchView:onUpdateParam()
	return
end

function CharacterSwitchView:onOpen()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.SwitchHero, self._onSwitchHero, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.SwitchHeroSkin, self._switchHeroSkin, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self.addEventCb(self, MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneFinishStory, self._onSwitchSceneFinishStory, self)
end

function CharacterSwitchView:onClose()
	gohelper.setActive(self._golightspine, true)
	self:_showMainHero()
	TaskDispatcher.cancelTask(self._delayInitLightSpine, self)
end

function CharacterSwitchView:_onSwitchSceneFinishStory()
	self._switchSceneFinishStory = true
end

function CharacterSwitchView:_checkSpineAnim()
	if self._switchSceneFinishStory and self._lightSpine then
		self._lightSpine:play(StoryAnimName.B_IDLE, true)
	end

	self._switchSceneFinishStory = false
end

function CharacterSwitchView:onTabSwitchOpen()
	gohelper.setActive(self._golightspine, true)
	self._rootAnimator:Play("open", 0, 0)
	self:_checkSpineAnim()
	self:_setOffset()
end

function CharacterSwitchView:onTabSwitchClose(isClosing)
	if not isClosing then
		self._lightSpine:stopVoice()
		gohelper.setActive(self._golightspine, false)
	end
end

function CharacterSwitchView:onCloseFinish()
	local go = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP/MainThumbnailView/#go_spine_scale/lightspine")

	if gohelper.isNil(go) or gohelper.isNil(self._golightspine) then
		return
	end

	gohelper.addChildPosStay(go, self._golightspine)
	self:_checkSpineAnim()
end

function CharacterSwitchView:_switchHeroSkin(heroId, skinId)
	self:_updateHero(heroId, skinId, false)
end

function CharacterSwitchView:_onSwitchHero(param)
	self:_switchHero(param[1], param[2], param[3])
end

function CharacterSwitchView:_modifySkinState(heroId, skinId)
	if skinId ~= CharacterVoiceEnum.LuxiSkin2 then
		return
	end

	local skinState = PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, skinId, 0)

	if skinState ~= 0 then
		return
	end

	local value = CharacterVoiceEnum.LuxiState.HumanFace

	PlayerModel.instance:setPropKeyValue(PlayerEnum.SimpleProperty.SkinState, skinId, value)
	PlayerModel.instance:setPropKeyValue(PlayerEnum.SimpleProperty.SkinState, heroId, value)

	local propertyStr = PlayerModel.instance:getPropKeyValueString(PlayerEnum.SimpleProperty.SkinState)

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.SkinState, propertyStr)
end

function CharacterSwitchView:_switchHero(heroId, skinId, isRandom)
	if isRandom then
		self:_updateHero(self._curHeroId, self._curSkinId, isRandom)
	else
		self:_updateHero(heroId, skinId, isRandom)
	end

	gohelper.setActive(self._goheroskin, not isRandom)
	self:_showSkinList(heroId, skinId)

	if heroId then
		self._heroIdSet[heroId] = true

		if tabletool.len(self._heroIdSet) >= 5 then
			self._heroIdSet = {}

			GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0.5, self)
		end
	end
end

function CharacterSwitchView._sort(a, b)
	return a.skin < b.skin
end

local yOffset = {
	149.2,
	-64.3,
	-151.4
}

function CharacterSwitchView:_showSkinList(heroId, showSkinId)
	if not heroId then
		return
	end

	local heroMO = HeroModel.instance:getByHeroId(heroId)
	local skinInfoList = tabletool.copy(heroMO.skinInfoList)

	table.sort(skinInfoList, CharacterSwitchView._sort)

	local skinInfoMO = SkinInfoMO.New()

	skinInfoMO:init({
		expireSec = 0,
		skin = heroMO.config.skinId
	})
	table.insert(skinInfoList, 1, skinInfoMO)

	skinInfoList = self:removeDuplicates(skinInfoList)

	self:_hideAllItems()

	for _, skinInfo in ipairs(skinInfoList) do
		local skinId = skinInfo.skin

		self:_showSkinItem(heroId, skinId, skinId == showSkinId)
	end

	local offsetIndex = math.min(#skinInfoList, #yOffset)

	recthelper.setAnchorY(self._gobgbottom.transform, yOffset[offsetIndex])
end

function CharacterSwitchView:removeDuplicates(skinInfoList)
	local checkDict = {}
	local newArray = {}

	for _, skinInfo in ipairs(skinInfoList) do
		if not checkDict[skinInfo.skin] then
			checkDict[skinInfo.skin] = true

			table.insert(newArray, skinInfo)
		end
	end

	return newArray
end

function CharacterSwitchView:_hideAllItems()
	local count = #self._showItemList

	for i = 1, count do
		local item = self._showItemList[i]

		gohelper.setActive(item.viewGO, false)
		table.insert(self._cacheItemList, item)

		self._showItemList[i] = nil
	end
end

function CharacterSwitchView:_showSkinItem(heroId, skinId, selected)
	local item = table.remove(self._cacheItemList)

	if not item then
		local go = gohelper.cloneInPlace(self._goheroskinItem)

		item = MonoHelper.addLuaComOnceToGo(go, CharacterSwitchSkinItem)
	end

	gohelper.setAsLastSibling(item.viewGO)
	table.insert(self._showItemList, item)
	item:showSkin(heroId, skinId)
	item:setSelected(selected)
end

function CharacterSwitchView:getLightSpineGo()
	return self._golightspine, self._golightspineParent
end

function CharacterSwitchView:onDestroyView()
	self._simagesignature:UnLoadImage()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 1, self)
end

return CharacterSwitchView
