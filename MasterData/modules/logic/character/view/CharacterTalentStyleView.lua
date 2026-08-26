-- chunkname: @modules/logic/character/view/CharacterTalentStyleView.lua

module("modules.logic.character.view.CharacterTalentStyleView", package.seeall)

local CharacterTalentStyleView = class("CharacterTalentStyleView", BaseView)

function CharacterTalentStyleView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagefrontbg = gohelper.findChildSingleImage(self.viewGO, "#simage_frontbg")
	self._goinspirationItem = gohelper.findChild(self.viewGO, "#go_inspirationItem")
	self._gocubeinfo = gohelper.findChild(self.viewGO, "#go_cubeinfo")
	self._txtcompareStyleName = gohelper.findChildText(self.viewGO, "#go_cubeinfo/panel/compare/title/name/#txt_compareStyleName")
	self._txtcompareLabel = gohelper.findChildText(self.viewGO, "#go_cubeinfo/panel/compare/title/desc/go_career/#txt_compareLabel")
	self._gocurrency = gohelper.findChild(self.viewGO, "#go_cubeinfo/panel/compare/#go_currency")
	self._txtcurStyleName = gohelper.findChildText(self.viewGO, "#go_cubeinfo/panel/cur/title/name/#txt_curStyleName")
	self._txtcurLabel = gohelper.findChildText(self.viewGO, "#go_cubeinfo/panel/cur/title/desc/go_career/#txt_curLabel")
	self._gostate = gohelper.findChild(self.viewGO, "#go_cubeinfo/#go_state")
	self._btncompare = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cubeinfo/#go_state/#btn_compare")
	self._btninteam = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cubeinfo/#go_state/#btn_inteam")
	self._btnfold = gohelper.findChildButtonWithAudio(self.viewGO, "#go_cubeinfo/#go_state/#btn_fold")
	self._gorequest = gohelper.findChild(self.viewGO, "go_unlock/#go_request")
	self._gocaneasycombinetip = gohelper.findChild(self.viewGO, "go_unlock/layout/txt_onceCombine")
	self._btnunlock = gohelper.findChildButtonWithAudio(self.viewGO, "go_unlock/layout/#btn_unlock")
	self._txtunlockpercent = gohelper.findChildText(self.viewGO, "go_unlock/layout/#btn_unlock/#txt_unlockpercent")
	self._btnuse = gohelper.findChildButtonWithAudio(self.viewGO, "go_unlock/#btn_use")
	self._gousing = gohelper.findChild(self.viewGO, "go_unlock/#go_using")
	self._goreward = gohelper.findChild(self.viewGO, "go_unlock/#go_reward")
	self._scrollstyle = gohelper.findChildScrollRect(self.viewGO, "go_style/#scroll_style")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "go_style/#item_style/#btn_click")
	self._txtstyle = gohelper.findChildText(self.viewGO, "go_style/#item_style/#txt_style")
	self._goselect = gohelper.findChild(self.viewGO, "go_style/#item_style/#go_select")
	self._gouse = gohelper.findChild(self.viewGO, "go_style/#item_style/#go_use")
	self._gonew = gohelper.findChild(self.viewGO, "go_style/#item_style/#go_new")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorightbtns = gohelper.findChild(self.viewGO, "#go_rightbtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentStyleView:addEvents()
	self._btncompare:AddClickListener(self._btncompareOnClick, self)
	self._btninteam:AddClickListener(self._btninteamOnClick, self)
	self._btnfold:AddClickListener(self._btnfoldOnClick, self)
	self._btnunlock:AddClickListener(self._btnunlockOnClick, self)
	self._btnuse:AddClickListener(self._btnuseOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function CharacterTalentStyleView:removeEvents()
	self._btncompare:RemoveClickListener()
	self._btninteam:RemoveClickListener()
	self._btnfold:RemoveClickListener()
	self._btnunlock:RemoveClickListener()
	self._btnuse:RemoveClickListener()
	self._btnclick:RemoveClickListener()
end

function CharacterTalentStyleView:_btnStatOnClick()
	local params = {
		heroId = self._heroId
	}

	CharacterController.instance:openCharacterTalentStatView(params)
end

function CharacterTalentStyleView:_btnuseOnClick()
	local cubeMo = self:_getSelectCubeMo()

	TalentStyleModel.instance:UseStyle(self._heroId, cubeMo)
end

function CharacterTalentStyleView:_btncompareOnClick()
	self:_showComparePanel()
	self:_showCurCubeAttr()
end

function CharacterTalentStyleView:_btninteamOnClick()
	return
end

function CharacterTalentStyleView:_btnfoldOnClick()
	self:_hideComparePanel()
	self:_showCurCubeAttr()
end

function CharacterTalentStyleView:_btnclickOnClick()
	return
end

function CharacterTalentStyleView:_btnunlockOnClick()
	local cubeMo = self:_getSelectCubeMo()
	local list, notEnoughItemName, enough, icon = self:_isEnoughUnlock()

	if enough then
		if not cubeMo._isUnlock then
			cubeMo._isUnlock = true

			HeroRpc.instance:setUnlockTalentStyleRequest(self._heroId, cubeMo._styleId)
		end
	elseif self._canEasyCombine then
		PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, true, MaterialEnum.GetApproach.RoomProductChange)
		RoomProductionHelper.openRoomFormulaMsgBoxView(self._easyCombineTable, self._lackedItemDataList, RoomProductLineEnum.Line.Spring, nil, nil, self._onEasyCombineFinished, self)

		return
	else
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, notEnoughItemName)
	end
end

function CharacterTalentStyleView:_onEasyCombineFinished(cmd, resultCode, msg)
	PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, false)

	if resultCode ~= 0 then
		return
	end

	self:_btnunlockOnClick()
end

function CharacterTalentStyleView:_addEvents()
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onUnlockTalentStyleReply, self._onUnlockTalentStyleReply, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onUseTalentStyleReply, self._onUseTalentStyleReply, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onSelectTalentStyle, self._onSelectTalentStyle, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onHeroTalentStyleStatReply, self._onHeroTalentStyleStatReply, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.currencyChangeEvent, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.currencyChangeEvent, self)
	self._scrollstyle:AddOnValueChanged(self._onScrollValueChanged, self)

	local nav = self:_getNavigateView()

	if nav then
		nav:setOverrideStat(self._btnStatOnClick, self)
	end
end

function CharacterTalentStyleView:_removeEvents()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onUnlockTalentStyleReply, self._onUnlockTalentStyleReply, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onUseTalentStyleReply, self._onUseTalentStyleReply, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onSelectTalentStyle, self._onSelectTalentStyle, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onHeroTalentStyleStatReply, self._onHeroTalentStyleStatReply, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.currencyChangeEvent, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.currencyChangeEvent, self)
	self._animEvent:RemoveAllEventListener()
	self._scrollstyle:RemoveOnValueChanged()
end

function CharacterTalentStyleView:_editableInitView()
	local goInfo = gohelper.findChild(self.viewGO, "#go_cubeinfo/panel")

	self._attrItem = gohelper.findChild(goInfo, "attributeItem")
	self._curAttrPanel = gohelper.findChild(goInfo, "cur/panel")
	self._compareAttrPanel = gohelper.findChild(goInfo, "compare/panel")
	self._objCompareAttrPanel = gohelper.findChild(goInfo, "compare")
	self._itemCircle = gohelper.findChild(self.viewGO, "#go_inspirationItem/item/slot/dec1")
	self._txtunlock = gohelper.findChildText(self.viewGO, "go_unlock/#btn_unlock/txt")
	self._gounlock = gohelper.findChild(self.viewGO, "go_unlock")
	self._goitemUnlock = gohelper.findChild(self.viewGO, "#go_inspirationItem/item/#unlock")
	self._goitemUse = gohelper.findChild(self.viewGO, "#go_inspirationItem/item/#use")
	self._animUnlock = SLFramework.AnimatorPlayer.Get(self._gounlock)
	self._requestCanvas = self._gorequest:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._txtusing = gohelper.findChildText(self.viewGO, "go_unlock/#go_using/txt_using")
	self._txtuse = gohelper.findChildText(self.viewGO, "go_unlock/#btn_use/txt")

	self:_hideItemUnlock()
	self:_hideItemUse()
	gohelper.setActive(self._attrItem, false)
end

function CharacterTalentStyleView:onUpdateParam()
	return
end

function CharacterTalentStyleView:onOpen()
	self:_addEvents()

	self._isHideNewTag = nil
	self._attrItems = self:getUserDataTb_()

	TalentStyleModel.instance:setNewUnlockStyle()
	TalentStyleModel.instance:setNewSelectStyle()

	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._animEvent = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animEvent:AddEventListener("switch", self._refreshView, self)

	if not self.viewParam.isJustOpen then
		self._animPlayer:Play("open", nil, self)
	end

	self._heroId = self.viewParam.hero_id
	self._heroMo = HeroModel.instance:getByHeroId(self._heroId)
	self._txtusing.text = luaLang("talent_style_title_using_cn_" .. self._heroMo:getTalentTxtByHeroType())
	self._txtuse.text = luaLang("talent_style_title_use_cn_" .. self._heroMo:getTalentTxtByHeroType())

	TalentStyleModel.instance:openView(self._heroId)
	self:_initInspirationItem()

	self._selectCubeMo = TalentStyleModel.instance:getSelectCubeMo(self._heroId)

	self:_hideComparePanel()
	self:_refreshView()

	local nav = self:_getNavigateView()

	if nav then
		nav:showStatBtn(false)
	end

	HeroRpc.instance:setTalentStyleReadRequest(self._heroId)
	HeroRpc.instance:setHeroTalentStyleStatRequest(self._heroId)
end

function CharacterTalentStyleView:onClose()
	return
end

function CharacterTalentStyleView:onDestroyView()
	self:_removeEvents()
	TaskDispatcher.cancelTask(self._hideItemUse, self)
	TaskDispatcher.cancelTask(self._hideItemUnlock, self)
	TaskDispatcher.cancelTask(self._hideNewTag, self)
end

function CharacterTalentStyleView:_refreshView()
	TalentStyleListModel.instance:refreshData(self._heroId)
	self:_refreshAttribute()
	self:_refreshUnlockItem()
	self:_refreshBtn()
	self:_refreshAttrCompareBtn()
	self:_refreshInspirationItem()
end

function CharacterTalentStyleView:_onScrollValueChanged()
	if self._isHideNewTag then
		return
	end

	self._isHideNewTag = true

	TaskDispatcher.runDelay(self._hideNewTag, self, 0.2)
end

function CharacterTalentStyleView:_hideNewTag()
	TalentStyleModel.instance:hideNewState(self._heroId)
end

function CharacterTalentStyleView:_initInspirationItem()
	local mainCubeMo = TalentStyleModel.instance:getHeroMainCubeMo(self._heroId)
	local item = gohelper.findChild(self._goinspirationItem, "item")

	self._slot = gohelper.findChildImage(item, "slot")
	self._slotAnim = self._slot:GetComponent(typeof(UnityEngine.Animator))
	self._cubeIcon = gohelper.findChildImage(item, "slot/icon")
	self._cubeglow = gohelper.findChildImage(item, "slot/glow")

	local levelTxt = gohelper.findChildText(item, "level/level")
	local co = HeroResonanceConfig.instance:getCubeConfig(mainCubeMo.id)
	local temp_attr = string.split(co.icon, "_")

	self._slotSprite = "gz_" .. temp_attr[#temp_attr]
	levelTxt.text = "Lv." .. mainCubeMo.level
end

local normalAlpha = Color.white
local translucent = Color(1, 1, 1, 0.5)

function CharacterTalentStyleView:_refreshInspirationItem()
	local cubeMo = TalentStyleModel.instance:getSelectCubeMo(self._heroId)
	local cubeId = cubeMo._replaceId
	local mianCubeId = self._heroMo.talentCubeInfos.own_main_cube_id
	local co = HeroResonanceConfig.instance:getCubeConfig(cubeId)
	local _slotSpr = self._slotSprite
	local scale = 1.7

	if co then
		local icon = co.icon
		local iconmk = icon

		if mianCubeId ~= cubeId and not string.nilorempty(icon) then
			iconmk = "mk_" .. icon
			_slotSpr = self._slotSprite .. "_2"
		end

		UISpriteSetMgr.instance:setCharacterTalentSprite(self._cubeIcon, iconmk, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._cubeglow, iconmk, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._slot, _slotSpr, true)
		transformhelper.setLocalScale(self._slot.transform, scale, scale, scale)
	end

	local isUnlock = cubeMo._isUnlock
	local isUse = cubeMo._isUse

	gohelper.setActive(self._itemCircle, isUse)

	self._cubeIcon.enabled = isUse
	self._slotAnim.enabled = isUnlock

	self._slotAnim:Play("slot_loop", 0, 0)

	if isUnlock then
		self._slot.color = normalAlpha or translucent
	end

	if isUnlock then
		self._cubeglow.color = normalAlpha or translucent
	end

	gohelper.setActive(self._cubeIcon.gameObject, isUnlock)
end

function CharacterTalentStyleView:_getAttributeDataList(cubeId)
	self._cubeAttrDataList = self._cubeAttrDataList or {}

	if self._cubeAttrDataList[cubeId] then
		return self._cubeAttrDataList[cubeId]
	end

	local cubeMo = TalentStyleModel.instance:getHeroMainCubeMo(self._heroId)
	local level = cubeMo.level
	local cube_attr_config = HeroConfig.instance:getTalentCubeAttrConfig(cubeId, level)
	local attrDataList = {}

	self._heroMo:getTalentAttrGainSingle(cubeId, attrDataList, nil, nil, level)

	local temp_list = {}

	for k, v in pairs(attrDataList) do
		table.insert(temp_list, {
			key = k,
			value = v,
			is_special = cube_attr_config.calculateType == 1,
			config = cube_attr_config
		})
	end

	table.sort(temp_list, self.sortAttr)

	self._cubeAttrDataList[cubeId] = temp_list

	return temp_list
end

function CharacterTalentStyleView.sortAttr(item1, item2)
	if item1.isDelete ~= item2.isDelete then
		return item2.isDelete
	end

	return HeroConfig.instance:getIDByAttrType(item1.key) < HeroConfig.instance:getIDByAttrType(item2.key)
end

function CharacterTalentStyleView:_showComparePanel()
	local mainId = TalentStyleModel.instance:getHeroUseCubeId(self._heroId)
	local dataList = self:_getAttributeDataList(mainId)

	self:_showAttrItem(2, dataList, self._compareAttrPanel)
	gohelper.setActive(self._objCompareAttrPanel, true)

	local cubeMo = TalentStyleModel.instance:getHeroUseCubeMo(self._heroId)
	local name, tag = cubeMo:getStyleTag()

	self._txtcompareStyleName.text = name
	self._txtcompareLabel.text = tag

	self:_refreshAttrCompareBtn()
end

function CharacterTalentStyleView:_hideComparePanel()
	gohelper.setActive(self._objCompareAttrPanel, false)
	self:_refreshAttrCompareBtn()
end

function CharacterTalentStyleView:_refreshAttrCompareBtn()
	local selectId = TalentStyleModel.instance:getSelectStyleId(self._heroId)
	local useId = TalentStyleModel.instance:getHeroUseCubeStyleId(self._heroId)
	local inteam = selectId == useId
	local isShow = self._objCompareAttrPanel.gameObject.activeSelf

	if inteam and isShow then
		gohelper.setActive(self._objCompareAttrPanel, false)

		isShow = false
	end

	gohelper.setActive(self._gounlock, not isShow)
	gohelper.setActive(self._gorightbtns, not isShow)
	gohelper.setActive(self._btncompare.gameObject, not inteam and not isShow)
	gohelper.setActive(self._btninteam.gameObject, inteam)
	gohelper.setActive(self._btnfold.gameObject, isShow)
end

function CharacterTalentStyleView:_getCurAttributeDataList(curId)
	local dataList = self:_getAttributeDataList(curId)
	local mainId = TalentStyleModel.instance:getHeroUseCubeId(self._heroId)
	local showDataList = tabletool.copy(dataList)

	if mainId ~= curId and self._objCompareAttrPanel.gameObject.activeSelf then
		local mainCubeDataList = self:_getAttributeDataList(mainId)

		for _, data in ipairs(dataList) do
			local mainData = self:getMainCubeAttrDataByType(mainCubeDataList, data.key)

			if mainData then
				if data.value ~= mainData.value then
					data.changeNum = data.value - mainData.value
				end
			else
				data.isNew = true
			end
		end

		for _, mainData in ipairs(mainCubeDataList) do
			local data = self:getMainCubeAttrDataByType(dataList, mainData.key)

			if not data then
				local temp = tabletool.copy(mainData)

				temp.isDelete = true

				table.insert(showDataList, temp)
			end
		end
	else
		for _, data in ipairs(dataList) do
			data.changeNum = nil
			data.isNew = nil
			data.isDelete = nil
		end
	end

	table.sort(showDataList, self.sortAttr)

	return showDataList
end

function CharacterTalentStyleView:getMainCubeAttrDataByType(mainCubeDataList, type)
	for _, mainData in ipairs(mainCubeDataList) do
		if mainData.key == type then
			return mainData
		end
	end
end

function CharacterTalentStyleView:_getAttrItem(type, index, parentObj)
	local items = self._attrItems[type]

	if not items then
		items = self:getUserDataTb_()
		self._attrItems[type] = items
	end

	local item = self._attrItems[type][index]

	if not item then
		local go = gohelper.clone(self._attrItem, parentObj, "item_" .. index)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, CharacterTalentStyleAttrItem)
		self._attrItems[type][index] = item
	end

	return item
end

function CharacterTalentStyleView:_showAttrItem(type, dataList, parentObj)
	for i, data in ipairs(dataList) do
		local item = self:_getAttrItem(type, i, parentObj)

		item:onRefreshMo(i, data)
	end

	for i = 1, #self._attrItems[type] do
		local item = self._attrItems[type][i]

		gohelper.setActive(item.viewGO, i <= #dataList)
	end
end

function CharacterTalentStyleView:_refreshAttribute()
	local cubeMo = self:_getSelectCubeMo()

	self:_showCurCubeAttr()

	local name, tag = cubeMo:getStyleTag()

	self._txtcurStyleName.text = name
	self._txtcurLabel.text = tag
end

function CharacterTalentStyleView:_showCurCubeAttr()
	local cubeMo = self:_getSelectCubeMo()
	local selectId = cubeMo._replaceId
	local dataList = self:_getCurAttributeDataList(selectId)

	self:_showAttrItem(1, dataList, self._curAttrPanel)
end

function CharacterTalentStyleView:_refreshBtn()
	local mo = self:_getSelectCubeMo()
	local isUnlock = mo._isUnlock
	local use = isUnlock and mo._isUse

	gohelper.setActive(self._btnunlock.gameObject, not isUnlock)
	gohelper.setActive(self._btnuse.gameObject, isUnlock and not use)
	gohelper.setActive(self._gousing.gameObject, isUnlock and use)

	if not isUnlock then
		local _, _, enough, _ = self:_isEnoughUnlock()

		ZProj.UGUIHelper.SetGrayscale(self._btnunlock.gameObject, not enough and not self._canEasyCombine)

		if mo:isHotUnlock() then
			local lang = luaLang("character_talentstyle_unlockpercent")
			local percent = string.format("%.1f", mo:getUnlockPercent() * 0.01)

			self._txtunlockpercent.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, percent)
		end

		gohelper.setActive(self._txtunlockpercent.gameObject, mo:isHotUnlock())
	end

	gohelper.setActive(self._gorequest, not isUnlock)

	self._requestCanvas.alpha = isUnlock and 0 or 1
end

function CharacterTalentStyleView:_refreshUnlockItem()
	local cubeMo = self:_getSelectCubeMo()

	self._canEasyCombine = false

	if not cubeMo._isUnlock then
		local list = self:_isEnoughUnlock()

		self._lackedItemDataList = {}
		self._occupyItemDic = {}

		IconMgr.instance:getCommonPropItemIconList(self, self._onCostItemShow, list, self._gorequest)

		self._canEasyCombine, self._easyCombineTable = RoomProductionHelper.canEasyCombineItems(self._lackedItemDataList, self._occupyItemDic)
		self._occupyItemDic = nil
	end

	gohelper.setActive(self._gocaneasycombinetip, self._canEasyCombine)
end

function CharacterTalentStyleView:_isEnoughUnlock()
	local style = TalentStyleModel.instance:getSelectStyleId(self._heroId)
	local consume = HeroResonanceConfig.instance:getTalentStyleUnlockConsume(self._heroId, style)

	if consume then
		local _list = ItemModel.instance:getItemDataListByConfigStr(consume)
		local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItemsByCellData(_list)

		return _list, notEnoughItemName, enough, icon
	end

	return nil, "", true, nil
end

function CharacterTalentStyleView:_onCostItemShow(cell_component, data, index)
	transformhelper.setLocalScale(cell_component.viewGO.transform, 0.59, 0.59, 1)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)

	local type = data.materilType
	local id = data.materilId
	local costQuantity = data.quantity
	local enoughText, lackedQuantity = ItemModel.instance:getItemIsEnoughText(data)

	if lackedQuantity then
		table.insert(self._lackedItemDataList, {
			type = type,
			id = id,
			quantity = lackedQuantity
		})
	else
		self._occupyItemDic[type] = self._occupyItemDic[type] or {}
		self._occupyItemDic[type][id] = (self._occupyItemDic[type][id] or 0) + costQuantity
	end

	cell_component:setCountText(enoughText)
	cell_component:setOnBeforeClickCallback(self.onBeforeClickItem, self)
	cell_component:setRecordFarmItem({
		type = type,
		id = id,
		quantity = costQuantity
	})
end

function CharacterTalentStyleView:onBeforeClickItem(param, commonItemIcon)
	local openedViewList = JumpController.instance:getCurrentOpenedView()

	for _, openView in ipairs(openedViewList) do
		if openView.viewName == ViewName.CharacterTalentStyleView then
			openView.viewParam.isJustOpen = true

			break
		end
	end

	commonItemIcon:setRecordFarmItem({
		type = commonItemIcon._itemType,
		id = commonItemIcon._itemId,
		quantity = commonItemIcon._itemQuantity,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = openedViewList
	})
end

function CharacterTalentStyleView:_getSelectCubeMo()
	self._selectCubeMo = self._selectCubeMo or TalentStyleModel.instance:getSelectCubeMo(self._heroId)

	return self._selectCubeMo
end

function CharacterTalentStyleView:_onUnlockTalentStyleReply(msg)
	TalentStyleModel.instance:refreshUnlockList(msg.heroId)
	self:_hideComparePanel()
	self._animUnlock:Play("unlock", self._unlockAnimEnd, self)
	TalentStyleModel.instance:setNewUnlockStyle(msg.style)
	TaskDispatcher.cancelTask(self._hideItemUnlock, self)
	gohelper.setActive(self._goitemUnlock, true)
	TaskDispatcher.runDelay(self._hideItemUnlock, self, 1.2)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_resonate_unlock_02)
end

function CharacterTalentStyleView:_unlockAnimEnd()
	self:_refreshView()
end

function CharacterTalentStyleView:_hideItemUnlock()
	gohelper.setActive(self._goitemUnlock, false)
end

function CharacterTalentStyleView:_hideItemUse()
	gohelper.setActive(self._goitemUse, false)
end

function CharacterTalentStyleView:_onUseTalentStyleReply(msg)
	self:_hideComparePanel()
	self:_refreshView()
	TaskDispatcher.cancelTask(self._hideItemUse, self)
	gohelper.setActive(self._goitemUse, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_resonate_fm)
	TaskDispatcher.runDelay(self._hideItemUse, self, 0.6)
end

function CharacterTalentStyleView:_onSelectTalentStyle(msg)
	self._selectCubeMo = TalentStyleModel.instance:getSelectCubeMo(self._heroId)

	self._animPlayer:Play("switch", nil, self)
end

function CharacterTalentStyleView:currencyChangeEvent()
	self:_refreshUnlockItem()
	self:_refreshBtn()
end

function CharacterTalentStyleView:playCloseAnim()
	self._animPlayer:Play("close", self.closeThis, self)
end

function CharacterTalentStyleView:_onHeroTalentStyleStatReply(msg)
	local isHasInfo = #msg.stylePercentList > 0
	local nav = self:_getNavigateView()

	if nav then
		nav:showStatBtn(isHasInfo)
	end

	if isHasInfo then
		TalentStyleListModel.instance:refreshData(msg.heroId)
	end
end

function CharacterTalentStyleView:_getNavigateView()
	return self.viewContainer:getNavigateView()
end

return CharacterTalentStyleView
