-- chunkname: @modules/logic/character/view/destiny/CharacterDestinyStoneView.lua

module("modules.logic.character.view.destiny.CharacterDestinyStoneView", package.seeall)

local CharacterDestinyStoneView = class("CharacterDestinyStoneView", BaseView)

function CharacterDestinyStoneView:onInitView()
	self._godrag = gohelper.findChild(self.viewGO, "#go_drag")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#image_icon")
	self._txtstonename = gohelper.findChildText(self.viewGO, "root/#txt_stonename")
	self._gostone = gohelper.findChild(self.viewGO, "root/#go_stone")
	self._goprestone = gohelper.findChild(self.viewGO, "root/#go_prestone")
	self._btnprestone = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_prestone/#btn_prestone")
	self._gonextstone = gohelper.findChild(self.viewGO, "root/#go_nextstone")
	self._btnnextstone = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_nextstone/#btn_nextstone")
	self._gounlock = gohelper.findChild(self.viewGO, "root/btn/#go_unlock")
	self._gounlockitem = gohelper.findChild(self.viewGO, "root/btn/#go_unlock/#go_unlockitem")
	self._gocaneasycombinetip = gohelper.findChild(self.viewGO, "root/btn/#go_unlock/txt_onceCombine")
	self._btnunlock = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#go_unlock/#btn_unlock")
	self._goselect = gohelper.findChild(self.viewGO, "root/btn/#go_select")
	self._btnselect = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#go_select/#btn_select")
	self._gounselect = gohelper.findChild(self.viewGO, "root/btn/#go_unselect")
	self._btnunselect = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#go_unselect/#btn_unselect")
	self._goexchange = gohelper.findChild(self.viewGO, "root/btn/#go_exchange")
	self._btnexchange = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#go_exchange/#btn_exchange")
	self._gounlocktips = gohelper.findChild(self.viewGO, "root/btn/#go_unlocktips")
	self._gounlocktips2 = gohelper.findChild(self.viewGO, "root/btn/#go_unlocktips_2")
	self._txtunlocktips2 = gohelper.findChildText(self.viewGO, "root/btn/#go_unlocktips_2/TipsBG/#txt_tips")
	self._goreshapeeffect = gohelper.findChild(self.viewGO, "root/#go_reshape/#go_reshapeeffect")
	self._goreshapeItem = gohelper.findChild(self.viewGO, "root/#go_reshape/#go_reshapeeffect/#scroll_reshape")
	self._gopoint = gohelper.findChild(self.viewGO, "root/point/#go_point")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDestinyStoneView:addEvents()
	self._btnprestone:AddClickListener(self._btnprestoneOnClick, self)
	self._btnnextstone:AddClickListener(self._btnnextstoneOnClick, self)
	self._btnunlock:AddClickListener(self._btnunlockOnClick, self)
	self._btnselect:AddClickListener(self._btnselectOnClick, self)
	self._btnunselect:AddClickListener(self._btnunselectOnClick, self)
	self._btnexchange:AddClickListener(self._btnexchangeOnClick, self)
end

function CharacterDestinyStoneView:removeEvents()
	self._btnprestone:RemoveClickListener()
	self._btnnextstone:RemoveClickListener()
	self._btnunlock:RemoveClickListener()
	self._btnselect:RemoveClickListener()
	self._btnunselect:RemoveClickListener()
	self._btnexchange:RemoveClickListener()
end

function CharacterDestinyStoneView:_btnreshapeOnClick()
	self:_showReshape(not self._isShowReshape, true)
end

function CharacterDestinyStoneView:_btnprestoneOnClick()
	if self._openUnlockStoneView then
		return
	end

	self._animRoot:Play(CharacterDestinyEnum.StoneViewAnim.SwitchRight, 0, 0)
	TaskDispatcher.runDelay(self._cutPreStoneCB, self, 0.16)
end

function CharacterDestinyStoneView:_btnnextstoneOnClick()
	if self._openUnlockStoneView then
		return
	end

	self._animRoot:Play(CharacterDestinyEnum.StoneViewAnim.SwitchLeft, 0, 0)
	TaskDispatcher.runDelay(self._cutNextStoneCB, self, 0.16)
end

function CharacterDestinyStoneView:_btnunselectOnClick()
	CharacterDestinyController.instance:onUseStone(self._heroMO.heroId, 0)
end

function CharacterDestinyStoneView:_btnunlockOnClick()
	if not self._curStoneMo then
		return
	end

	if self._curStoneMo.conusmeCo then
		local consumeList = ItemModel.instance:getItemDataListByConfigStr(self._curStoneMo.conusmeCo.consume)
		local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItemsByCellData(consumeList)

		if not enough then
			if self._canEasyCombine then
				PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, true, MaterialEnum.GetApproach.RoomProductChange)
				RoomProductionHelper.openRoomFormulaMsgBoxView(self._easyCombineTable, self._lackedItemDataList, RoomProductLineEnum.Line.Spring, nil, nil, self._onUnlockEasyCombineFinished, self)
			else
				GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, notEnoughItemName)
			end

			return
		end
	end

	local stoneMo = self._facetMos[self._selectStoneIndex]

	if stoneMo then
		self:openUnlockStoneView(stoneMo.stoneId)
	end
end

function CharacterDestinyStoneView:_onUnlockEasyCombineFinished(cmd, resultCode, msg)
	PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, false)

	if resultCode ~= 0 then
		return
	end

	self:_btnunlockOnClick()
end

function CharacterDestinyStoneView:_btnselectOnClick()
	local stoneMo = self._facetMos[self._selectStoneIndex]

	if stoneMo then
		CharacterDestinyController.instance:onUseStone(self._heroMO.heroId, stoneMo.stoneId)
	end
end

function CharacterDestinyStoneView:_btnexchangeOnClick()
	local stoneMo = self._facetMos[self._selectStoneIndex]

	if stoneMo then
		CharacterDestinyController.instance:onUseStone(self._heroMO.heroId, stoneMo.stoneId)
	end
end

function CharacterDestinyStoneView:_editableInitView()
	self._simagestone = gohelper.findChildSingleImage(self.viewGO, "root/#go_stone/#simage_stone")
	self._simagepre = gohelper.findChildSingleImage(self.viewGO, "root/#go_prestone/#btn_prestone")
	self._simagenext = gohelper.findChildSingleImage(self.viewGO, "root/#go_nextstone/#btn_nextstone")
	self._gounlockstone = gohelper.findChild(self.viewGO, "unlockstone")
	self._root = gohelper.findChild(self.viewGO, "root")
	self._goeffect = gohelper.findChild(self.viewGO, "root/effectItem")
	self._imgstone = gohelper.findChildImage(self.viewGO, "root/#go_stone/#simage_stone")
	self._goEquip = gohelper.findChild(self.viewGO, "root/#go_stone/#equip")
	self._animRoot = self._root:GetComponent(typeof(UnityEngine.Animator))
	self._animPlayerRoot = ZProj.ProjAnimatorPlayer.Get(self._root)
	self._animPlayerUnlockStone = ZProj.ProjAnimatorPlayer.Get(self._gounlockstone)
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godrag.gameObject)
	self._goreshapeVX = gohelper.findChild(self.viewGO, "root/#go_stone/#reshape")
	self._simagereshape = gohelper.findChildSingleImage(self.viewGO, "root/#go_stone/#reshape/#simage_stone")
	self._simagestoneName = gohelper.findChildSingleImage(self.viewGO, "root/#simage_reshapeTitle")
	self._simagestoneName1 = gohelper.findChildSingleImage(self.viewGO, "root/#simage_reshapeTitle/#glow")
	self._imagestoneName = gohelper.findChildImage(self.viewGO, "root/#simage_reshapeTitle")
	self._imagestoneName1 = gohelper.findChildImage(self.viewGO, "root/#simage_reshapeTitle/#glow")

	self:_initReshapeItem()
end

function CharacterDestinyStoneView:onUpdateParam()
	return
end

function CharacterDestinyStoneView:_addEvents()
	self.addEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnUnlockStoneReply, self._onUnlockStoneReply, self)
	self.addEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, self._onUseStoneReply, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshConsume, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshConsume, self)
	self.addEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.onClickReshapeBtn, self._btnreshapeOnClick, self)

	if self._drag then
		self._drag:AddDragBeginListener(self._dragBeginEventCb, self)
		self._drag:AddDragListener(self._dragEventCb, self)
		self._drag:AddDragEndListener(self._dragEndEventCb, self)
	end
end

function CharacterDestinyStoneView:_removeEvents()
	self.removeEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnUnlockStoneReply, self._onUnlockStoneReply, self)
	self.removeEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, self._onUseStoneReply, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshConsume, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshConsume, self)
	self.removeEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.onClickReshapeBtn, self._btnreshapeOnClick, self)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end
end

function CharacterDestinyStoneView:_refreshView()
	self:_refreshStoneItem(self._selectStoneIndex)
	self:_refreshBtn()
end

function CharacterDestinyStoneView:_onUnlockStoneReply(heroId, stoneId)
	if self._curStoneMo then
		self._curStoneMo:refresUnlock(true)
	end

	self:_refreshView()
	gohelper.setActive(self._root, true)
	gohelper.setActive(self._gounlockstone, false)

	self._openUnlockStoneView = false
end

function CharacterDestinyStoneView:_onUseStoneReply(heroId, stoneId)
	self._heroMO.destinyStoneMo:refreshUseStone()

	self._curUseStoneId = self._heroMO.destinyStoneMo.curUseStoneId

	self:_refreshBtn()
	gohelper.setActive(self._goEquip, self._curStoneMo.isUse)
end

function CharacterDestinyStoneView:onOpen()
	self:_addEvents()

	self._effectItems = self:getUserDataTb_()
	self._effectitemPrefab = gohelper.findChild(self._goeffect, "#scroll_effect")

	for i = 1, CharacterDestinyEnum.EffectItemCount do
		local item = self:_getEffectItem(i)

		gohelper.setActive(item.root, true)
	end

	self._heroMO = self.viewParam.heroMo
	self._curUseStoneId = self._heroMO.destinyStoneMo.curUseStoneId

	local facetMos = self._heroMO.destinyStoneMo.stoneMoList

	self._facetMos = {}

	if facetMos then
		local curUseStoneIndex = 1

		for _, mo in pairs(facetMos) do
			table.insert(self._facetMos, mo)
		end

		table.sort(self._facetMos, self._sortStone)

		if self._curUseStoneId and self._curUseStoneId ~= 0 then
			for i, mo in ipairs(self._facetMos) do
				if mo.stoneId == self._curUseStoneId then
					curUseStoneIndex = i
				end
			end
		end

		self:_refreshStoneItem(curUseStoneIndex)
		self:_refreshBtn()
	end

	gohelper.setActive(self._root, true)
	gohelper.setActive(self._gounlockstone, false)

	self._openUnlockStoneView = false

	local isUnlock, tips = self:_isUnlockDestiny()

	if not isUnlock then
		self._txtunlocktips2.text = tips
	end

	gohelper.setActive(self._gounlocktips2, not isUnlock)
end

function CharacterDestinyStoneView:_isUnlockDestiny()
	local isOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DestinyStone)

	if not isOpen then
		local desc = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.DestinyStone)

		if desc == 0 then
			local openEpisodeId = lua_open.configDict[OpenEnum.UnlockFunc.DestinyStone].episodeId

			if not DungeonModel.instance:hasPassLevel(openEpisodeId) then
				local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(openEpisodeId)
				local tostCo = ToastConfig.instance:getToastCO(ToastEnum.DungeonMapLevel)

				desc = GameUtil.getSubPlaceholderLuaLangOneParam(tostCo.tips, episodeDisplay)
			end
		end

		return false, desc
	end

	local openLevel = self._heroMO:getUnlockDestinyLevel()

	if openLevel > self._heroMO.level then
		local showLevel, rank = HeroConfig.instance:getShowLevel(openLevel)
		local tostCo = ToastConfig.instance:getToastCO(ToastEnum.CharacterDestinyUnlockLevel)

		return false, GameUtil.getSubPlaceholderLuaLangTwoParam(tostCo.tips, GameUtil.getNum2Chinese(rank - 1), showLevel)
	end

	return true
end

function CharacterDestinyStoneView:_getEffectItem(index)
	local item = self._effectItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.findChild(self._goeffect, index)

		item.go = go
		item.root = gohelper.clone(self._effectitemPrefab, go)
		item.lockicon = gohelper.findChildImage(item.root, "Viewport/Content/#go_decItem/#txt_dec/#go_lockicon")
		item.unlockicon = gohelper.findChildImage(item.root, "Viewport/Content/#go_decItem/#txt_dec/#go_unlockicon")
		item.txt = gohelper.findChildText(item.root, "Viewport/Content/#go_decItem/#txt_dec")
		item.gounlock = gohelper.findChild(item.root, "Viewport/Content/#go_decItem/#unlock")
		item.canvasgroup = item.root:GetComponent(typeof(UnityEngine.CanvasGroup))
		self._effectItems[index] = item
	end

	return item
end

function CharacterDestinyStoneView._sortStone(x, y)
	local xConsumeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(x.stoneId)
	local yConsumeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(y.stoneId)

	if xConsumeCo.facetsSort ~= yConsumeCo.facetsSort then
		return xConsumeCo.facetsSort < yConsumeCo.facetsSort
	end

	return x.stoneId > y.stoneId
end

function CharacterDestinyStoneView:_refreshStoneItem(curIndex)
	if not curIndex or curIndex == 0 then
		curIndex = 1
	end

	self._selectStoneIndex = curIndex

	local max = #self._facetMos

	self._curStoneMo = self._facetMos[curIndex]

	local isReshapeStone = self._curStoneMo:isReshape()

	if self._curStoneMo then
		self._levelCos = self._curStoneMo:getFacetCo()

		local conusmeCo = self._curStoneMo.conusmeCo

		if self._levelCos then
			for i, item in ipairs(self._effectItems) do
				local co = self._levelCos[i]

				item.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(item.txt.gameObject, SkillDescComp)

				item.skillDesc:updateInfo(item.txt, co.desc, self._heroMO.heroId)
				item.skillDesc:setTipParam(0, Vector2(300, 100))

				if self._curStoneMo.isUnlock then
					local isUnlock = i <= self._heroMO.destinyStoneMo.rank
					local color = item.txt.color

					color.a = isUnlock and 1 or 0.43
					item.txt.color = color

					if isUnlock then
						local color = item.unlockicon.color

						color.a = isUnlock and 1 or 0.43
						item.unlockicon.color = color
					else
						local color = item.lockicon.color

						color.a = isUnlock and 1 or 0.43
						item.lockicon.color = color
					end

					gohelper.setActive(item.lockicon.gameObject, not isUnlock)
					gohelper.setActive(item.unlockicon.gameObject, isUnlock)
				end
			end
		end

		gohelper.setActive(self._goEquip, self._curStoneMo.isUse)
		gohelper.setActive(self._txtstonename.gameObject, not isReshapeStone)
		gohelper.setActive(self._simagestoneName.gameObject, isReshapeStone)
		gohelper.setActive(self._simagestoneName1.gameObject, isReshapeStone)
		gohelper.setActive(self._goreshapeVX, isReshapeStone)

		if conusmeCo then
			local name, icon = self._curStoneMo:getNameAndIcon()

			self._simagestone:LoadImage(icon)
			self._simagereshape:LoadImage(icon)

			local tenp = CharacterDestinyEnum.SlotTend[conusmeCo.tend]
			local tendIcon = tenp.TitleIconName

			UISpriteSetMgr.instance:setUiCharacterSprite(self._imageicon, tendIcon)

			if isReshapeStone then
				local resName = self._curStoneMo.stoneId

				self._simagestoneName:LoadImage(ResUrl.getTxtDestinyIcon(resName), function()
					self._imagestoneName:SetNativeSize()
				end)
				self._simagestoneName1:LoadImage(ResUrl.getTxtDestinyIcon(resName), function()
					self._imagestoneName1:SetNativeSize()
				end)
			else
				self._txtstonename.text = name
				self._txtstonename.color = GameUtil.parseColor(tenp.TitleColor)
			end
		end

		local isUnlock = self._curStoneMo.isUnlock

		if isUnlock then
			if not Color.white then
				self._imgstone.color = Color(0.5, 0.5, 0.5, 1)

				self:_checkPlayAttrUnlockAnim(self._curStoneMo.stoneId)

				local isReshape = CharacterDestinyModel.instance:getIsShowReshape()

				self:_showReshape(isReshape and isReshapeStone, false)
				self:_refreshReshape()
				CharacterDestinyController.instance:dispatchEvent(CharacterDestinyEvent.OnShowStone, self._curStoneMo.stoneId)
			end
		end
	end

	self._pointItems = self._pointItems or self:getUserDataTb_()

	if max > 1 then
		for i = 1, max do
			local item = self:_getPointItem(i)

			gohelper.setActive(item.select, curIndex == i)
			gohelper.setActive(item.go, true)
		end
	else
		for _, item in ipairs(self._pointItems) do
			gohelper.setActive(item.go, false)
		end
	end

	self:_refreshConsume()
	self:_refreshPreAndNextStoneItem(curIndex)
end

function CharacterDestinyStoneView:_refreshConsume()
	if not self._curStoneMo then
		gohelper.setActive(self._gocaneasycombinetip, false)

		return
	end

	self._canEasyCombine = false
	self._lackedItemDataList = {}
	self._occupyItemDic = {}

	local conusmeCo = self._curStoneMo.conusmeCo

	if not self._curStoneMo.isUnlock then
		local consumeList = ItemModel.instance:getItemDataListByConfigStr(conusmeCo.consume)

		IconMgr.instance:getCommonPropItemIconList(self, self._onCostItemShow, consumeList, self._gounlockitem)

		self._canEasyCombine, self._easyCombineTable = RoomProductionHelper.canEasyCombineItems(self._lackedItemDataList, self._occupyItemDic)
		self._occupyItemDic = nil
	end

	gohelper.setActive(self._gocaneasycombinetip, self._canEasyCombine)
end

function CharacterDestinyStoneView:_checkPlayAttrUnlockAnim(stoneId)
	if self._effectItems then
		for rank, item in ipairs(self._effectItems) do
			local isCanPlay = self._heroMO.destinyStoneMo:isCanPlayAttrUnlockAnim(stoneId, rank)

			gohelper.setActive(item.gounlock, isCanPlay)
		end
	end
end

function CharacterDestinyStoneView:_refreshPreAndNextStoneItem(curIndex)
	if curIndex > 1 then
		local preMo = self._facetMos[curIndex - 1]

		if preMo and preMo.conusmeCo then
			local _, icon = preMo:getNameAndIcon()

			self._simagepre:LoadImage(icon)
		end
	end

	if curIndex < #self._facetMos then
		local nextMo = self._facetMos[curIndex + 1]

		if nextMo and nextMo.conusmeCo then
			local _, icon = nextMo:getNameAndIcon()

			self._simagenext:LoadImage(icon)
		end
	end

	gohelper.setActive(self._goprestone, curIndex > 1)
	gohelper.setActive(self._gonextstone, curIndex < #self._facetMos)
end

function CharacterDestinyStoneView:_onCostItemShow(item, data, index)
	transformhelper.setLocalScale(item.viewGO.transform, 0.6, 0.6, 1)
	item:onUpdateMO(data)
	item:setConsume(true)
	item:showStackableNum2()
	item:isShowEffect(true)
	item:setAutoPlay(true)
	item:setCountFontSize(48)

	local txt = item:getItemIcon():getCount()
	local maxWidth = 170
	local contentSizeFitter = txt.gameObject:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))

	txt.enableAutoSizing = true
	contentSizeFitter.enabled = false
	txt.fontSizeMax = 48
	txt.fontSizeMin = 30
	txt.transform.anchorMax = Vector2(0.5, 0.5)
	txt.transform.anchorMin = Vector2(0.5, 0.5)
	txt.transform.pivot = Vector2(0.5, 0.5)
	txt.alignment = TMPro.TextAlignmentOptions.Center

	recthelper.setWidth(txt.transform, maxWidth)
	recthelper.setHeight(txt.transform, 70)
	item:SetCountLocalY(-50)

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

	item:setCountText(enoughText)
	item:setOnBeforeClickCallback(self.onBeforeClickItem, self)
end

function CharacterDestinyStoneView:onBeforeClickItem(param, commonItemIcon)
	local openedViewList = JumpController.instance:getCurrentOpenedView(self.viewName)

	for _, openView in ipairs(openedViewList) do
		if openView.viewName == ViewName.CharacterDestinySlotView then
			openView.viewParam.isBack = true

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

function CharacterDestinyStoneView:_refreshBtn()
	if not self._curStoneMo then
		return
	end

	local isUnlockSlot = self._heroMO.destinyStoneMo:isUnlockSlot()
	local isUnlock = self._curStoneMo.isUnlock
	local isUse = self._curStoneMo.isUse
	local isUseStone = self._curUseStoneId ~= 0

	gohelper.setActive(self._gounlock.gameObject, isUnlockSlot and not isUnlock)
	gohelper.setActive(self._goselect.gameObject, isUnlockSlot and isUnlock and not isUse and not isUseStone)
	gohelper.setActive(self._gounselect.gameObject, isUnlockSlot and isUnlock and isUse)
	gohelper.setActive(self._goexchange.gameObject, isUnlockSlot and isUnlock and not isUse and isUseStone)
end

function CharacterDestinyStoneView:_getPointItem(index)
	local item = self._pointItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gopoint, index)

		item.go = go
		item.normal = gohelper.findChild(go, "normal")
		item.select = gohelper.findChild(go, "select")
		self._pointItems[index] = item
	end

	return item
end

function CharacterDestinyStoneView:openUnlockStoneView(stoneId)
	if not self._unlockStoneView then
		self._unlockStoneView = MonoHelper.addNoUpdateLuaComOnceToGo(self._gounlockstone, CharacterDestinyUnlockStoneComp)

		self._unlockStoneView:setStoneView(self)
	end

	self._unlockStoneView:onUpdateMo(self._heroMO.heroId, stoneId)
	gohelper.setActive(self._gounlockstone, true)
	self.playRootOpenCloseAnim(self, false, self._hideRoot, self)
	self.playUnlockstoneOpenCloseAnim(self, true, nil, self)
	self.viewContainer:setOpenUnlockStoneView(true)

	self._openUnlockStoneView = true
end

function CharacterDestinyStoneView:closeUnlockStoneView()
	gohelper.setActive(self._root, true)
	self.playRootOpenCloseAnim(self, true, nil, self)
	self.playUnlockstoneOpenCloseAnim(self, false, self._hideUnlockstone, self)
	self.viewContainer:setOpenUnlockStoneView(false)

	self._openUnlockStoneView = false
end

function CharacterDestinyStoneView:_cutPreStoneCB()
	self:_refreshStoneItem(self._selectStoneIndex - 1)
	self:_refreshBtn()
end

function CharacterDestinyStoneView:_cutNextStoneCB()
	self:_refreshStoneItem(self._selectStoneIndex + 1)
	self:_refreshBtn()
end

function CharacterDestinyStoneView:_dragBeginEventCb(data, pointerEventData)
	self._dragPos = pointerEventData.position
end

function CharacterDestinyStoneView:_dragEventCb(data, pointerEventData)
	return
end

function CharacterDestinyStoneView:_dragEndEventCb(data, pointerEventData)
	if self._openUnlockStoneView then
		return
	end

	if #self._facetMos < 2 then
		self._dragPos = nil

		return
	end

	if self._dragPos then
		TaskDispatcher.cancelTask(self._cutPreStoneCB, self)
		TaskDispatcher.cancelTask(self._cutNextStoneCB, self)

		if self._dragPos.x < pointerEventData.position.x and self._selectStoneIndex > 1 then
			self._animRoot:Play(CharacterDestinyEnum.StoneViewAnim.SwitchRight, 0, 0)
			TaskDispatcher.runDelay(self._cutPreStoneCB, self, 0.16)
		elseif self._dragPos.x > pointerEventData.position.x and self._selectStoneIndex < #self._facetMos then
			self._animRoot:Play(CharacterDestinyEnum.StoneViewAnim.SwitchLeft, 0, 0)
			TaskDispatcher.runDelay(self._cutNextStoneCB, self, 0.16)
		end
	end
end

function CharacterDestinyStoneView:onUnlockStone()
	self.viewContainer:setOpenUnlockStoneView(false)
	self:_refreshBtn()
end

function CharacterDestinyStoneView:playRootOpenCloseAnim(isOpen, callback, callbackObj)
	if isOpen then
		if not CharacterDestinyEnum.StoneViewAnim.Open then
			local animName = CharacterDestinyEnum.StoneViewAnim.Close

			self:playRootAnim(animName, callback, callbackObj)
		end
	end
end

function CharacterDestinyStoneView:playUnlockstoneOpenCloseAnim(isOpen, callback, callbackObj)
	if isOpen then
		if not CharacterDestinyEnum.StoneViewAnim.Open then
			local animName = CharacterDestinyEnum.StoneViewAnim.Close

			self:playUnlockstoneAnim(animName, callback, callbackObj)
		end
	end
end

function CharacterDestinyStoneView:playRootAnim(name, callback, callbackObj)
	self._animPlayerRoot:Play(name, callback, callbackObj)
end

function CharacterDestinyStoneView:playUnlockstoneAnim(name, callback, callbackObj)
	self._animPlayerUnlockStone:Play(name, callback, callbackObj)
end

function CharacterDestinyStoneView:_hideRoot()
	gohelper.setActive(self._root, false)
end

function CharacterDestinyStoneView:_hideUnlockstone()
	gohelper.setActive(self._gounlockstone, false)

	self._openUnlockStoneView = false
end

function CharacterDestinyStoneView:_showReshape(show, isPlayAnim)
	self._isShowReshape = show

	TaskDispatcher.cancelTask(self._showReshapeEffect, self)

	if isPlayAnim then
		if show then
			if not CharacterDestinyEnum.StoneViewAnim.Switch_reshape then
				local animName = CharacterDestinyEnum.StoneViewAnim.Switch_normal

				self._animRoot:Play(animName, 0, 0)
				TaskDispatcher.runDelay(self._showReshapeEffect, self, 0.16)
			end
		end
	else
		self:_showReshapeEffect()
	end

	local isEquipReshapeAttr = self._heroMO.destinyStoneMo:getEquipReshapeStoneCo(self._curStoneMo) ~= nil
	local isShowTip = show and not isEquipReshapeAttr

	gohelper.setActive(self._gounlocktips, isShowTip)
end

function CharacterDestinyStoneView:_showReshapeEffect()
	gohelper.setActive(self._goeffect, not self._isShowReshape)
	gohelper.setActive(self._goreshapeeffect, self._isShowReshape)
end

function CharacterDestinyStoneView:_refreshReshape()
	local descList = self._curStoneMo:getReshapeDesc()
	local count = 0
	local isEquipReshapeAttr = self._heroMO.destinyStoneMo:getEquipReshapeStoneCo(self._curStoneMo) ~= nil

	if descList then
		count = #descList

		for i = 1, #descList do
			local item = self._reshapeItems[i]
			local lang = luaLang("character_destinystone_reshape_lv")

			item.titleTxt.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, i)
			item.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(item.descTxt.gameObject, SkillDescComp)

			item.skillDesc:updateInfo(item.descTxt, descList[i], self._heroMO.heroId)
			item.skillDesc:setTipParam(0, Vector2(300, 100))

			item.cg.alpha = isEquipReshapeAttr and 1 or 0.43
		end
	end

	for i = 1, #self._reshapeItems do
		gohelper.setActive(self._reshapeItems[i].go, i <= count)
	end
end

function CharacterDestinyStoneView:_initReshapeItem()
	gohelper.setActive(self._goreshapeItem, false)

	self._reshapeItems = self:getUserDataTb_()

	for index = 1, 5 do
		local item = self._reshapeItems[index]

		if not item then
			item = self:getUserDataTb_()

			local root = gohelper.findChild(self._goreshapeeffect, index)
			local go = gohelper.clone(self._goreshapeItem, root, "item" .. index)

			item.go = root
			item.descTxt = gohelper.findChildText(go, "Viewport/Content/#go_reshapeItem")
			item.titleTxt = gohelper.findChildText(go, "Viewport/Content/#go_reshapeItem/title")
			item.cg = root:GetComponent(typeof(UnityEngine.CanvasGroup))
			self._reshapeItems[index] = item

			gohelper.setActive(go, true)
		end
	end
end

function CharacterDestinyStoneView:onClose()
	return
end

function CharacterDestinyStoneView:onDestroyView()
	self:_removeEvents()
	self._simagestone:UnLoadImage()
	self._simagepre:UnLoadImage()
	self._simagenext:UnLoadImage()
	self._simagereshape:UnLoadImage()
	self._simagestoneName:UnLoadImage()
	self._simagestoneName1:UnLoadImage()
	TaskDispatcher.cancelTask(self._cutPreStoneCB, self)
	TaskDispatcher.cancelTask(self._cutNextStoneCB, self)
	TaskDispatcher.cancelTask(self._showReshapeEffect, self)
end

return CharacterDestinyStoneView
