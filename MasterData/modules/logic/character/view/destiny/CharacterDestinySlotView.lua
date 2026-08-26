-- chunkname: @modules/logic/character/view/destiny/CharacterDestinySlotView.lua

module("modules.logic.character.view.destiny.CharacterDestinySlotView", package.seeall)

local CharacterDestinySlotView = class("CharacterDestinySlotView", BaseView)

function CharacterDestinySlotView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._goreshapefullbg = gohelper.findChild(self.viewGO, "#simage_fullbg/#go_reshapefullbg")
	self._gomain = gohelper.findChild(self.viewGO, "#go_main")
	self._scrollattr = gohelper.findChildScrollRect(self.viewGO, "#go_main/left/#scroll_attr")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_main/left/#scroll_attr/Viewport/Content/#go_attritem")
	self._goslot = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot")
	self._goslotItem = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/#go_slotItem")
	self._golock = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/#go_lock")
	self._gopreview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/middle/#go_slot/#go_lock/#btn_preview")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/#go_unlock")
	self._goempty = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_empty")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_empty/#btn_add")
	self._gostone = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone")
	self._txtstonename = gohelper.findChildText(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#txt_stonename")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#image_icon")
	self._simagestone = gohelper.findChildSingleImage(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#simage_stone")
	self._gostonebtnicon = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/icon")
	self._simagestonedec = gohelper.findChildSingleImage(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#simage_stonedec")
	self._btnstone = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#btn_stone")
	self._goconsumeitem = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/btn/#go_consumeitem")
	self._gocurrency = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/btn/#go_currency")
	self._txtcurrency = gohelper.findChildText(self.viewGO, "#go_main/middle/#go_slot/btn/#go_currency/#txt_currency")
	self._imagecurrency = gohelper.findChildImage(self.viewGO, "#go_main/middle/#go_slot/btn/#go_currency/#txt_currency/#image_currency")
	self._gounlockbtn = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/btn/#go_unlockbtn")
	self._btnunlock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/middle/#go_slot/btn/#go_unlockbtn/#btn_unlock", AudioEnum.CharacterDestinyStone.play_ui_common_click)
	self._gouplv = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/btn/#go_uplv")
	self._btnuplv = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/middle/#go_slot/btn/#go_uplv/#btn_uplv", AudioEnum.CharacterDestinyStone.play_ui_common_click)
	self._txtlv = gohelper.findChildText(self.viewGO, "#go_main/middle/#go_slot/btn/#go_uplv/#btn_uplv/#txt_lv")
	self._gouprank = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/btn/#go_uprank")
	self._btnuprank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/middle/#go_slot/btn/#go_uprank/#btn_uprank", AudioEnum.CharacterDestinyStone.play_ui_common_click)
	self._gomax = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/btn/#go_max")
	self._gocaneasycombinetip = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/btn/txt_onceCombine")
	self._scrolleffect = gohelper.findChildScrollRect(self.viewGO, "#go_main/right/#scroll_effect")
	self._gostoneeffectitem = gohelper.findChild(self.viewGO, "#go_main/right/#scroll_effect/Viewport/Content/#go_stoneeffectitem")
	self._gostoneempty = gohelper.findChild(self.viewGO, "#go_main/right/#go_stoneempty")
	self._gostonelock = gohelper.findChild(self.viewGO, "#go_main/right/#go_stonelock")
	self._goreshape = gohelper.findChild(self.viewGO, "#go_main/#go_reshape")
	self._btnreshape = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/#go_reshape/#btn_reshape")
	self._gounlockanim = gohelper.findChild(self.viewGO, "#go_unlockanim")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDestinySlotView:addEvents()
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnstone:AddClickListener(self._btnstoneOnClick, self)
	self._btnunlock:AddClickListener(self._btnunlockOnClick, self)
	self._btnuplv:AddClickListener(self._btnuplvOnClick, self)
	self._btnuprank:AddClickListener(self._btnuprankOnClick, self)
	self._gopreview:AddClickListener(self._btnpreviewOnClick, self)
	self._btnreshape:AddClickListener(self._btnreshapeOnClick, self)
end

function CharacterDestinySlotView:removeEvents()
	self._btnadd:RemoveClickListener()
	self._btnstone:RemoveClickListener()
	self._btnunlock:RemoveClickListener()
	self._btnuplv:RemoveClickListener()
	self._btnuprank:RemoveClickListener()
	self._gopreview:RemoveClickListener()
	self._btnreshape:RemoveClickListener()
end

function CharacterDestinySlotView:_btnreshapeOnClick()
	self:_showReshape(not self._isShowReshape, true)
	CharacterDestinyController.instance:dispatchEvent(CharacterDestinyEvent.onClickReshapeBtn)
end

function CharacterDestinySlotView:_btnaddOnClick()
	return
end

function CharacterDestinySlotView:_btnuplvOnClick()
	return
end

function CharacterDestinySlotView:_btnpreviewOnClick()
	self:_openCharacterDestinyStoneView()
end

CharacterDestinySlotView.UI_CLICK_BLOCK_KEY = "CharacterDestinySlotView_Click"

function CharacterDestinySlotView:_btnuprankOnClick()
	if self._heroMO.destinyStoneMo:isSlotMaxLevel() then
		return
	end

	local isEnough, toastIcon, toastName = self:isHasEnoughCurrenctLevelUp()

	if not isEnough then
		if self._canEasyCombine then
			PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, true, MaterialEnum.GetApproach.RoomProductChange)
			RoomProductionHelper.openRoomFormulaMsgBoxView(self._easyCombineTable, self._lackedItemDataList, RoomProductLineEnum.Line.Spring, nil, nil, self._onRankUpEasyCombineFinished, self)
		else
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, toastIcon, toastName)
		end

		return
	end

	self._isPlayingRankUpAnim = true

	self._anim:Play(CharacterDestinyEnum.SlotViewAnim.LevelUp, 0, 0)
	CharacterDestinyController.instance:onRankUp(self._heroMO.heroId)

	local slotItem = self._slotmats[self._heroMO.destinyStoneMo.rank + 1]

	if slotItem then
		gohelper.setActive(slotItem.golevelup, true)
	end

	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_leimi_smalluncharted_refresh)
	gohelper.setActive(self._goempty, false)
	UIBlockMgr.instance:startBlock(CharacterDestinySlotView.UI_CLICK_BLOCK_KEY)
end

function CharacterDestinySlotView:_onRankUpEasyCombineFinished(cmd, resultCode, msg)
	PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, false)

	if resultCode ~= 0 then
		return
	end

	self:_btnuprankOnClick()
end

function CharacterDestinySlotView:_btnstoneOnClick()
	self:_openCharacterDestinyStoneView()
end

function CharacterDestinySlotView:_btnunlockOnClick()
	local isEnough, toastIcon, toastName = self:isHasEnoughCurrenctLevelUp()

	if not isEnough then
		if self._canEasyCombine then
			PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, true, MaterialEnum.GetApproach.RoomProductChange)
			RoomProductionHelper.openRoomFormulaMsgBoxView(self._easyCombineTable, self._lackedItemDataList, RoomProductLineEnum.Line.Spring, nil, nil, self._onUnlockEasyCombineFinished, self)
		else
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, toastIcon, toastName)
		end

		return
	end

	self._isPlayingUnlockAnim = true

	self._anim:Play(CharacterDestinyEnum.SlotViewAnim.Unlock, 0, 0)
	CharacterDestinyController.instance:onRankUp(self._heroMO.heroId)
	gohelper.setActive(self._gotopleft, false)
	gohelper.setActive(self._goempty, false)
	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_unlock)
	UIBlockMgr.instance:startBlock(CharacterDestinySlotView.UI_CLICK_BLOCK_KEY)
end

function CharacterDestinySlotView:_onUnlockEasyCombineFinished(cmd, resultCode, msg)
	PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, false)

	if resultCode ~= 0 then
		return
	end

	self:_btnunlockOnClick()
end

local PRESS_TIME = 0.5
local NEXT_PRESS_TIME = 0.1

function CharacterDestinySlotView:_editableInitView()
	self._btnUpLvlongPress = SLFramework.UGUI.UILongPressListener.Get(self._btnuplv.gameObject)

	self._btnUpLvlongPress:SetLongPressTime({
		PRESS_TIME,
		NEXT_PRESS_TIME
	})
	self._btnUpLvlongPress:AddLongPressListener(self._upLvLongPress, self)

	self._btnuplevel = SLFramework.UGUI.UIClickListener.Get(self._btnuplv.gameObject)

	self._btnuplevel:AddClickUpListener(self._onClickLevelUpBtnUp, self)
	self._btnuplevel:AddClickDownListener(self._onClickLevelUpBtnDown, self)

	self._consumeCurrencyItems = self:getUserDataTb_()
	self._consumeCurrencyItems[1] = {
		go = self._txtcurrency.gameObject,
		txt = self._txtcurrency,
		icon = self._imagecurrency
	}
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_main/middle/#go_slot/title/txt_title")
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animEvent = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	self._reshapeAnim = self._goreshape:GetComponent(typeof(UnityEngine.Animator))
	self._effectAnim = self._scrolleffect.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self._slotmats = self:getUserDataTb_()

	for i = 1, CharacterDestinyEnum.EffectItemCount do
		local go = gohelper.findChild(self._goslot, "mesh0" .. i)
		local ms = gohelper.findChild(go, "ms"):GetComponent(typeof(UIMesh))
		local golevelup = gohelper.findChild(go, "#leveup")
		local mpc = go:GetComponent(typeof(ZProj.MaterialPropsCtrl))
		local item = {
			mpc = mpc,
			ms = ms,
			golevelup = golevelup
		}

		table.insert(self._slotmats, item)
	end

	self._gyroOffsetID = UnityEngine.Shader.PropertyToID("_GyroOffset")
	self._gyroOffset = Vector4.New(0, 0, 0)

	TaskDispatcher.runRepeat(self._tick, self, 0)

	self._goreshapeselect = gohelper.findChild(self._btnreshape.gameObject, "selected")
	self._goreshapeunselect = gohelper.findChild(self._btnreshape.gameObject, "unselect")
	self._simagestoneName = gohelper.findChildSingleImage(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#simage_reshapeTitle")
	self._imagestoneName = gohelper.findChildImage(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#simage_reshapeTitle")
	self._simagestoneName1 = gohelper.findChildSingleImage(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#simage_reshapeTitle/#glow")
	self._imagestoneName1 = gohelper.findChildImage(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#simage_reshapeTitle/#glow")
	self._goreshapeVX = gohelper.findChild(self.viewGO, "#go_main/middle/#go_slot/#go_unlock/#go_stone/#reshape")
	self._cgReshape = self._scrolleffect:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function CharacterDestinySlotView:_tick()
	local curX, curY, curZ = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

	self._gyroOffset.x, self._gyroOffset.y = (self._gyroOffset.x + curX) * 0.5, (self._gyroOffset.y + curY) * 0.5

	UnityEngine.Shader.SetGlobalVector(self._gyroOffsetID, self._gyroOffset)
end

function CharacterDestinySlotView:_upLvLongPress()
	if not self._canLongPress then
		return
	end

	local destinyStoneMo = self._heroMO.destinyStoneMo

	if destinyStoneMo:isSlotMaxLevel() then
		self:_onClickLevelUpBtnUp()

		return
	end

	local totalLevel = destinyStoneMo.level

	if self._addLevel then
		totalLevel = destinyStoneMo.level + self._addLevel

		if not self:isHasEnoughCurrenctLevelUp(true, destinyStoneMo.rank, destinyStoneMo.level + self._addLevel - 1) then
			self._addLevel = self._addLevel - 1

			self:_onClickLevelUpBtnUp()

			return
		end

		if totalLevel < self._maxRankLevel then
			self._addLevel = self._addLevel + 1

			self:_refreshLevelUpConsume(totalLevel)
		else
			self:_onClickLevelUpBtnUp()
		end
	else
		totalLevel = destinyStoneMo.level + 2
		self._addLevel = 2
	end

	self:_refreshLevelUp(destinyStoneMo.rank, totalLevel)
end

function CharacterDestinySlotView:_onClickLevelUpBtnDown()
	if self._heroMO.destinyStoneMo:isSlotMaxLevel() then
		return
	end

	if not self:isHasEnoughCurrenctLevelUp(true) then
		return
	end

	self._addLevel = 1
	self._canLongPress = true
end

function CharacterDestinySlotView:_onClickLevelUpBtnUp()
	if not self._canLongPress then
		return
	end

	self._canLongPress = nil

	local destinyStoneMo = self._heroMO.destinyStoneMo

	if destinyStoneMo:isSlotMaxLevel() then
		return
	end

	if self._addLevel then
		local totallevel = math.min(destinyStoneMo.level + self._addLevel, self._maxRankLevel)

		if destinyStoneMo.level + self._addLevel <= self._maxRankLevel then
			CharacterDestinyController.instance:onLevelUp(self._heroMO.heroId, totallevel)
			self:_refreshLevelUp(destinyStoneMo.rank, totallevel)
		else
			self:_refreshBtn(totallevel)
		end
	end

	self._addLevel = nil
end

function CharacterDestinySlotView:_refreshLevelUp(rank, level)
	self:_playAttrItemLevelUp(rank, level - 1)
	TaskDispatcher.runDelay(function()
		self:_refreshAttrPanel(rank, level)
	end, self, 0.5)
	self:_refreshBtnLevel(level)

	local maxLevel = self._heroMO.destinyStoneMo.maxLevel[rank]

	if level < maxLevel then
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_charged)
	else
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_slots_full)
	end
end

function CharacterDestinySlotView:onUpdateParam()
	return
end

function CharacterDestinySlotView:_addEvents()
	self.addEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, self._OnRankUpReply, self)
	self.addEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnLevelUpReply, self._onLevelUpReply, self)
	self.addEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, self._onUseStoneReply, self)
	self.addEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnShowStone, self._showReshapeBtn, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshCurrency, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.RefreshView, self._refreshDataCB, self)
	self._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.UnlockEnd, self._unlockEndCB, self)
	self._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.LevelUpEnd, self._rankUpEndCB, self)
	self._animEvent:AddEventListener(CharacterDestinyEnum.AnimEventName.UnlockAttrAnim, self._unlockAttrAnim, self)
end

function CharacterDestinySlotView:_removeEvents()
	self.removeEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnRankUpReply, self._OnRankUpReply, self)
	self.removeEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnLevelUpReply, self._onLevelUpReply, self)
	self.removeEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnUseStoneReply, self._onUseStoneReply, self)
	self.removeEventCb(self, CharacterDestinyController.instance, CharacterDestinyEvent.OnShowStone, self._showReshapeBtn, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshCurrency, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)

	if self._btnUpLvlongPress then
		self._btnUpLvlongPress:RemoveLongPressListener()
	end

	if self._btnuplevel then
		self._btnuplevel:RemoveClickUpListener()
		self._btnuplevel:RemoveClickDownListener()
	end

	self._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.RefreshView)
	self._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.UnlockEnd)
	self._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.LevelUpEnd)
	self._animEvent:RemoveEventListener(CharacterDestinyEnum.AnimEventName.UnlockAttrAnim)
end

function CharacterDestinySlotView:_onLevelUpReply(heroId, level)
	self:_refreshView()

	if self._heroMO.destinyStoneMo:isSlotMaxLevel() then
		AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_molu_sky_open)
	end
end

function CharacterDestinySlotView:_playItemLevelUp(attrId)
	local item = self:_getAttrItemByAtttrId(attrId)

	if item then
		item:playLevelUpAnim()
	end
end

function CharacterDestinySlotView:_playAttrItemLevelUp(rank, level, isUnlock)
	local curSlotAttrInfos, specialAttrInfos, lockAttrInfos = CharacterDestinyModel.instance:getCurSlotAttrInfos(self._heroMO.heroId, rank, level)
	local count = 0

	if curSlotAttrInfos then
		for _, info in ipairs(curSlotAttrInfos) do
			if info.nextNum then
				self:_playItemLevelUp(info.attrId)

				count = count + 1
			end
		end
	end

	if specialAttrInfos then
		for _, info in ipairs(specialAttrInfos) do
			if info.nextNum then
				self:_playItemLevelUp(info.attrId)

				count = count + 1
			end
		end
	end

	if isUnlock then
		if not lockAttrInfos[1] then
			local unlockAttrs = lockAttrInfos[rank]

			if unlockAttrs then
				for _, info in ipairs(unlockAttrs) do
					self:_playItemLevelUp(info.attrId)

					count = count + 1
				end
			end

			if count > 0 then
				AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_inking_preference_open)
			end
		end
	end
end

function CharacterDestinySlotView:_onUseStoneReply(heroId, stoneId)
	self:_refreshView()
	self:_refreshEmpty()
end

function CharacterDestinySlotView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CharacterDestinyStoneView then
		if self:_isJustOpenStone() then
			self:closeThis()
		else
			self:_playerOpenAnim()
		end
	end
end

function CharacterDestinySlotView:_isJustOpenStone()
	local isOpen = self._heroMO:isCanOpenDestinySystem()

	return not isOpen
end

function CharacterDestinySlotView:onOpen()
	self:_addEvents()

	self._heroMO = self.viewParam.heroMo
	self._isPlayingUnlockAnim = false

	local destinyStoneMo = self._heroMO.destinyStoneMo

	self._maxRankLevel = destinyStoneMo:getRankLevelCount()
	self._itemConsumeList = self._itemConsumeList or {}

	local heroType = self._heroMO:getHeroType()

	if not CharacterDestinyEnum.SlotTitle[heroType] then
		self._txttitle.text = luaLang(CharacterDestinyEnum.SlotTitle[heroType])

		if self:_isJustOpenStone() then
			self:_openCharacterDestinyStoneView(true)

			return
		end

		if self.viewParam.isBack then
			local isUnlock = self._heroMO.destinyStoneMo:isUnlockSlot()

			if isUnlock then
				if not CharacterDestinyEnum.SlotViewAnim.CloseUnlock then
					local animatorName = CharacterDestinyEnum.SlotViewAnim.CloseLock

					self._anim:Play(animatorName, 0, 1)
				end
			end
		else
			self:_playerOpenAnim()
		end

		self:_refreshView(true)
		self:_refreshAttrPanel()
		self:_refreshEmpty()
		self.viewContainer:setCurDestinySlot(destinyStoneMo)
		self:_refreshTrial()

		if self._heroMO and self._heroMO.heroId then
			self:_statEnterView(self._heroMO.heroId)
		end
	end
end

function CharacterDestinySlotView:_showReshapeBtn(stoneId)
	local destinyStoneMo = self._heroMO.destinyStoneMo
	local isShowReshape

	if not stoneId or stoneId == 0 then
		stoneId = destinyStoneMo.curUseStoneId
	end

	if stoneId and stoneId > 0 then
		local stoneMo = destinyStoneMo:getStoneMo(stoneId)

		isShowReshape = stoneMo:isReshape()
	else
		isShowReshape = destinyStoneMo:isReshapeAllStone()
	end

	gohelper.setActive(self._goreshape, isShowReshape)
	gohelper.setActive(self._goreshapeVX, isShowReshape)
	gohelper.setActive(self._goreshapefullbg, isShowReshape and self._isShowReshape)
end

function CharacterDestinySlotView:_refreshTrial()
	local isTrial = self._heroMO:isTrial()

	gohelper.setActive(self._gostonebtnicon.gameObject, not isTrial)
	gohelper.setActive(self._btnstone.gameObject, not isTrial)
end

function CharacterDestinySlotView:_playerOpenAnim()
	local isUnlock = self._heroMO.destinyStoneMo:isUnlockSlot()

	if isUnlock then
		if not CharacterDestinyEnum.SlotViewAnim.OpenUnlock then
			local animatorName = CharacterDestinyEnum.SlotViewAnim.OpenLock

			self._anim:Play(animatorName, 0, 0)
			self:_showReshapeBtn()
		end
	end
end

function CharacterDestinySlotView:_refreshView(isOpenView)
	self:_refreshBtn()
	self:_refreshSlot(isOpenView)
end

function CharacterDestinySlotView:_refreshCurrency()
	for type, consumes in pairs(self._itemConsumeList) do
		for id, quantity in pairs(consumes) do
			self._itemConsumeList[type][id] = ItemModel.instance:getItemQuantity(type, id)
		end
	end

	self:_refreshBtn()
end

function CharacterDestinySlotView:_playIdleAnim(isUnlock)
	if isUnlock then
		if not CharacterDestinyEnum.SlotViewAnim.UnlockIdle then
			local animatorName = CharacterDestinyEnum.SlotViewAnim.LockIdle

			self._anim:Play(animatorName, 0, 1)
		end
	end
end

function CharacterDestinySlotView:_OnRankUpReply()
	self._maxRankLevel = self._heroMO.destinyStoneMo:getRankLevelCount()
end

function CharacterDestinySlotView:_rankUpEndCB()
	self._isPlayingRankUpAnim = false

	local destinyStoneMo = self._heroMO.destinyStoneMo
	local rank = destinyStoneMo.rank
	local level = destinyStoneMo.maxLevel[rank - 1]

	self:_playAttrItemLevelUp(rank - 1, level)
	TaskDispatcher.runDelay(self._refreshAttrPanel, self, 0.5)
	self:_refreshBtnLevel(destinyStoneMo.level)
	gohelper.setActive(self._goempty, destinyStoneMo.curUseStoneId == 0)
	UIBlockMgr.instance:endBlock(CharacterDestinySlotView.UI_CLICK_BLOCK_KEY)
end

function CharacterDestinySlotView:_unlockEndCB()
	self._isPlayingUnlockAnim = false

	self:_playIdleAnim(true)
	gohelper.setActive(self._goempty, true)
	gohelper.setActive(self._gotopleft, true)
	CharacterDestinyController.instance:dispatchEvent(CharacterDestinyEvent.OnUnlockSlot)
end

function CharacterDestinySlotView:_refreshDataCB()
	self:_refreshView(true)
	self:_refreshAttrPanel()
end

function CharacterDestinySlotView:_unlockAttrAnim()
	self:_playAttrItemLevelUp(0, 1, true)
	UIBlockMgr.instance:endBlock(CharacterDestinySlotView.UI_CLICK_BLOCK_KEY)
end

function CharacterDestinySlotView:_refreshAttrPanel(rank, level)
	if self.isClose then
		return
	end

	local rank = rank or self._heroMO.destinyStoneMo.rank
	local level = level or self._heroMO.destinyStoneMo.level
	local curSlotAttrInfos, specialAttrInfos, lockAttrInfos = CharacterDestinyModel.instance:getCurSlotAttrInfos(self._heroMO.heroId, rank, level)

	self._attrItems = self._attrItems or self:getUserDataTb_()

	local index = 1

	if curSlotAttrInfos then
		for _, info in ipairs(curSlotAttrInfos) do
			local item = self:_getAttrItem(index)

			item:onUpdateBaseAttrMO(index, info)

			index = index + 1
		end
	end

	if specialAttrInfos then
		for i, info in ipairs(specialAttrInfos) do
			local item = self:_getAttrItem(index)

			item:onUpdateSpecailAttrMO(index, info, i == 1, #specialAttrInfos)

			index = index + 1
		end
	end

	if lockAttrInfos then
		for rank, info in pairs(lockAttrInfos) do
			local item = self:_getAttrItem(index)

			item:onUpdateLockSpecialAttrMO(index, rank, info)

			index = index + 1
		end
	end

	if self._attrItems then
		for i = 1, #self._attrItems do
			local item = self._attrItems[i]

			gohelper.setActive(item.viewGO, i < index)
		end
	end
end

function CharacterDestinySlotView:_getAttrItem(index)
	local item = self._attrItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._goattritem, "attritem_" .. index)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, CharacterDestinySlotAttrItem)
		self._attrItems[index] = item
	end

	return item
end

function CharacterDestinySlotView:_getAttrItemByAtttrId(id)
	for _, item in ipairs(self._attrItems) do
		if item.attrId == id then
			return item
		end
	end
end

function CharacterDestinySlotView:_refreshSlot(isOpenView)
	local destinyStoneMo = self._heroMO.destinyStoneMo
	local isUnlock = destinyStoneMo:isUnlockSlot()
	local stoneId = destinyStoneMo.curUseStoneId
	local isHasStone = stoneId ~= 0
	local tenpColor = Color.white

	if isHasStone then
		local name, icon, co = destinyStoneMo:getCurStoneNameAndIcon()
		local isReshapeStone = destinyStoneMo:isEquipReshape()

		gohelper.setActive(self._txtstonename.gameObject, not isReshapeStone)
		gohelper.setActive(self._simagestoneName.gameObject, isReshapeStone)
		self._simagestone:LoadImage(icon)

		local tenp = CharacterDestinyEnum.SlotTend[co.tend]
		local tendIcon = tenp.TitleIconName

		UISpriteSetMgr.instance:setUiCharacterSprite(self._imageicon, tendIcon)

		self._txtstonename.color = GameUtil.parseColor(tenp.TitleColor)

		if isReshapeStone then
			local resName = destinyStoneMo.curUseStoneId

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

	self._stoneEffectItem = self._stoneEffectItem or MonoHelper.addNoUpdateLuaComOnceToGo(self._gostoneeffectitem, CharacterDestinyStoneEffectItem)

	self._stoneEffectItem:onUpdateMo(destinyStoneMo)
	self:_showReshapeBtn(stoneId)
	self:_showReshape(false, false)

	for _, mat in ipairs(self._slotmats) do
		local mpc = mat.mpc

		if mpc.color_01 ~= tenpColor then
			mpc.color_01 = tenpColor

			mpc:SetProps()
		end
	end

	self:_setSlotLevel(isOpenView)
	gohelper.setActive(self._txttitle.gameObject, not isHasStone)
	gohelper.setActive(self._golock, not isUnlock)
	gohelper.setActive(self._gounlock, isUnlock)
	gohelper.setActive(self._gostone, isHasStone)
	gohelper.setActive(self._scrolleffect.gameObject, self._isShowReshape or isUnlock and isHasStone)
	gohelper.setActive(self._gostoneempty.gameObject, not self._isShowReshape and isUnlock and not isHasStone)
	gohelper.setActive(self._gostonelock.gameObject, not self._isShowReshape and not isUnlock)
end

function CharacterDestinySlotView:_refreshEmpty()
	local isHasStone = self._heroMO.destinyStoneMo.curUseStoneId ~= 0

	gohelper.setActive(self._goempty, not isHasStone)
end

function CharacterDestinySlotView:_setSlotLevel(isOpenView)
	local destinyStoneMo = self._heroMO.destinyStoneMo
	local rank = destinyStoneMo.rank
	local level = destinyStoneMo.level - 1

	for i = 1, destinyStoneMo.maxRank do
		local alpha = 0.65
		local progress = 1

		if i < rank then
			progress = 0
		elseif rank < i then
			progress = 1
			alpha = 0.3
		else
			local maxlevel = destinyStoneMo:getRankLevelCount() - 1

			progress = maxlevel ~= 0 and 1 - level / maxlevel or 0
		end

		local matInfo = self._slotmats[i]
		local color = matInfo.ms.color

		color.a = alpha
		matInfo.ms.color = color

		local mpc = matInfo.mpc
		local vector1 = mpc.vector_01
		local vector2 = mpc.vector_02

		if matInfo._tweenId then
			ZProj.TweenHelper.KillById(matInfo._tweenId, false)

			matInfo._tweenId = nil
		end

		local param = {
			mpc = mpc,
			vector1 = vector1,
			vector2 = vector2
		}

		if not isOpenView then
			if progress < vector2.x then
				matInfo._tweenId = ZProj.TweenHelper.DOTweenFloat(vector2.x, progress, 0.5, self._progressMat, nil, self, param)
			end
		else
			self:_progressMat(progress, param)
		end
	end
end

function CharacterDestinySlotView:_openCharacterDestinyStoneView(isJust)
	if self._isPlayingUnlockAnim then
		return
	end

	local isUnlock = self._heroMO.destinyStoneMo:isUnlockSlot()

	if isUnlock then
		if not CharacterDestinyEnum.SlotViewAnim.CloseUnlock then
			local animName = CharacterDestinyEnum.SlotViewAnim.CloseLock

			self._anim:Play(animName, 0, isJust and 1 or 0)
			CharacterDestinyController.instance:openCharacterDestinyStoneView(self._heroMO)
		end
	end
end

function CharacterDestinySlotView:_progressMat(value, param)
	local mpc = param.mpc

	mpc.vector_01 = Vector4.New(param.vector1.x, param.vector1.y, param.vector1.z, -0.5 + value)
	mpc.vector_02 = Vector4.New(value, param.vector2.y, param.vector2.z, param.vector2.w)

	mpc:SetProps()
end

function CharacterDestinySlotView:isHasEnoughCurrenctLevelUp(isShowToast, rank, level)
	local destinyStoneMo = self._heroMO.destinyStoneMo

	rank = rank or destinyStoneMo.rank
	level = level or destinyStoneMo.level

	local nextCo = CharacterDestinyConfig.instance:getNextDestinySlotCo(destinyStoneMo.heroId, rank, level)

	if not nextCo then
		return
	end

	local consumeList = GameUtil.splitString2(nextCo.consume, true)
	local itemCo, icon

	if consumeList then
		for _, consume in ipairs(consumeList) do
			local type = consume[1]
			local id = consume[2]
			local quantity = consume[3]
			local consumeTypes = self._itemConsumeList[type]

			if not consumeTypes then
				consumeTypes = {}
				self._itemConsumeList[type] = consumeTypes
			end

			consumeTypes[id] = consumeTypes[id] or ItemModel.instance:getItemQuantity(type, id)

			if quantity > self._itemConsumeList[type][id] then
				itemCo, icon = ItemModel.instance:getItemConfigAndIcon(type, id)

				break
			end
		end
	end

	if itemCo then
		if isShowToast then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, itemCo.name)
		end

		return false, icon, itemCo.name
	end

	return true
end

function CharacterDestinySlotView:_refreshBtn(level)
	local destinyStoneMo = self._heroMO.destinyStoneMo
	local isUnlock = destinyStoneMo:isUnlockSlot()
	local isMaxLv = isUnlock and destinyStoneMo:isSlotMaxLevel()
	local isCanUpRank = isUnlock and not isMaxLv and destinyStoneMo:isCanUpSlotRank()
	local isCanUpLv = isUnlock and not isMaxLv and not destinyStoneMo:isCanUpSlotRank()
	local isShowItem = not isUnlock or isCanUpRank
	local isTrial = self._heroMO:isTrial()

	gohelper.setActive(self._gounlockbtn, not isTrial and not isUnlock)
	gohelper.setActive(self._gouplv, not isTrial and isCanUpLv)
	gohelper.setActive(self._gouprank, not isTrial and isCanUpRank)
	gohelper.setActive(self._gomax, isUnlock and isMaxLv)
	gohelper.setActive(self._goconsumeitem, not isTrial and isShowItem)
	gohelper.setActive(self._gocurrency, not isTrial and isCanUpLv)

	level = level or destinyStoneMo.level
	self._canEasyCombine = false

	local nextCo = CharacterDestinyConfig.instance:getNextDestinySlotCo(destinyStoneMo.heroId, destinyStoneMo.rank, level)

	if nextCo then
		local consumeList = ItemModel.instance:getItemDataListByConfigStr(nextCo.consume)

		if isShowItem then
			self._lackedItemDataList = {}
			self._occupyItemDic = {}

			IconMgr.instance:getCommonPropItemIconList(self, self._onConsumeItemCB, consumeList, self._goconsumeitem)

			self._canEasyCombine, self._easyCombineTable = RoomProductionHelper.canEasyCombineItems(self._lackedItemDataList, self._occupyItemDic)
			self._occupyItemDic = nil
		end

		if isCanUpLv then
			self:_onRefreshConsumeCurrencyItems(consumeList)
		end
	end

	gohelper.setActive(self._gocaneasycombinetip, self._canEasyCombine)
	self:_refreshBtnLevel(destinyStoneMo.level)
end

function CharacterDestinySlotView:_onConsumeItemCB(item, data, index)
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
	item:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, self)
	item:setRecordFarmItem({
		type = type,
		id = id,
		quantity = costQuantity
	})
end

function CharacterDestinySlotView:_onRefreshConsumeCurrencyItems(consumeList)
	if consumeList then
		for i, consume in ipairs(consumeList) do
			self:_refreshConsumeCurrencyItem(i, consume)
		end
	end

	for i = 1, #self._consumeCurrencyItems do
		gohelper.setActive(self._consumeCurrencyItems[i].go, consumeList and i <= #consumeList)
	end
end

function CharacterDestinySlotView:_refreshConsumeCurrencyItem(i, consume)
	local item = self:_getConsumeCurrencyItem(i)
	local co = ItemModel.instance:getItemConfig(consume.materilType, consume.materilId)

	UISpriteSetMgr.instance:setCurrencyItemSprite(item.icon, co.icon .. "_1")

	item.consumeBtn = SLFramework.UGUI.UIClickListener.Get(item.icon.gameObject)

	item.consumeBtn:AddClickListener(function()
		MaterialTipController.instance:showMaterialInfo(consume.materilType, consume.materilId)
	end, self)

	if self._itemConsumeList[consume.materilType] then
		if not self._itemConsumeList[consume.materilType] then
			::label_55_0::

			local cur = ItemModel.instance:getItemQuantity(consume.materilType, consume.materilId)
			local lang = cur >= consume.quantity and "%s/%s" or "<color=#cd5353>%s</color>/%s"

			item.txt.text = string.format(lang, GameUtil.numberDisplay(cur), GameUtil.numberDisplay(consume.quantity))
		end
	end
end

function CharacterDestinySlotView:_refreshLevelUpConsume(level)
	local co = CharacterDestinyConfig.instance:getNextDestinySlotCo(self._heroMO.destinyStoneMo.heroId, self._heroMO.destinyStoneMo.rank, level - 1)
	local nextCo = CharacterDestinyConfig.instance:getNextDestinySlotCo(self._heroMO.destinyStoneMo.heroId, self._heroMO.destinyStoneMo.rank, level)

	if co then
		local consumeList = ItemModel.instance:getItemDataListByConfigStr(co.consume)

		if consumeList then
			for i, consume in ipairs(consumeList) do
				local type = consume.materilType
				local id = consume.materilId
				local quantity = consume.quantity

				self._itemConsumeList[type] = self._itemConsumeList[type] or {}

				local curQuantity = self._itemConsumeList[type][id]

				curQuantity = curQuantity or ItemModel.instance:getItemQuantity(type, id)
				self._itemConsumeList[type][id] = curQuantity - quantity
			end
		end
	end

	if nextCo then
		local consumeList = ItemModel.instance:getItemDataListByConfigStr(nextCo.consume)

		self:_onRefreshConsumeCurrencyItems(consumeList)
	end
end

function CharacterDestinySlotView:_getConsumeCurrencyItem(index)
	local item = self._consumeCurrencyItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._txtcurrency.gameObject)

		item = self:getUserDataTb_()
		item.go = go
		item.txt = go:GetComponent(gohelper.Type_TextMesh)
		item.icon = gohelper.findChildImage(go, "#image_currency")
		self._consumeCurrencyItems[index] = item
	end

	return item
end

function CharacterDestinySlotView:_refreshBtnLevel(level)
	if self._heroMO.destinyStoneMo:isCanUpSlotRank() then
		return
	end

	if self._heroMO.destinyStoneMo:isSlotMaxLevel() then
		return
	end

	local lang = luaLang("character_destiny_slot_level")

	level = math.min(self._maxRankLevel, level)
	self._txtlv.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, level, self._maxRankLevel)
end

function CharacterDestinySlotView:_showReshape(show, isPlayAnim)
	gohelper.setActive(self._goreshapeselect, show)
	gohelper.setActive(self._goreshapeunselect, not show)

	self._isShowReshape = show

	TaskDispatcher.cancelTask(self.showReshapeItem, self)

	if isPlayAnim then
		self._reshapeAnim:Play(CharacterDestinyEnum.SlotViewAnim.Switch, 0, 0)
		self._effectAnim:Play(CharacterDestinyEnum.SlotViewAnim.Switch, 0, 0)
		TaskDispatcher.runDelay(self.showReshapeItem, self, 0.16)
	else
		self:showReshapeItem()
	end

	local stoneCo = self._heroMO.destinyStoneMo:getEquipReshapeStoneCo()

	self._cgReshape.alpha = show and stoneCo == nil and 0.43 or 1

	CharacterDestinyModel.instance:setShowReshape(show)
end

function CharacterDestinySlotView:showReshapeItem()
	if self._stoneEffectItem then
		self._stoneEffectItem:showReshape(self._isShowReshape)
	end

	local destinyStoneMo = self._heroMO.destinyStoneMo
	local isUnlock = destinyStoneMo:isUnlockSlot()
	local stoneId = destinyStoneMo.curUseStoneId
	local isHasStone = stoneId ~= 0

	gohelper.setActive(self._scrolleffect.gameObject, self._isShowReshape or isUnlock and isHasStone)
	gohelper.setActive(self._gostoneempty.gameObject, not self._isShowReshape and isUnlock and not isHasStone)
	gohelper.setActive(self._gostonelock.gameObject, not self._isShowReshape and not isUnlock)
	gohelper.setActive(self._goreshapefullbg, self._isShowReshape)
end

function CharacterDestinySlotView:onClose()
	self.isClose = true
end

function CharacterDestinySlotView:onDestroyView()
	if self._consumeCurrencyItems then
		for _, item in ipairs(self._consumeCurrencyItems) do
			if item.consumeBtn then
				item.consumeBtn:RemoveClickListener()
			end
		end
	end

	self:_removeEvents()
	self._simagestone:UnLoadImage()
	self._simagestoneName:UnLoadImage()
	TaskDispatcher.cancelTask(self._tick, self)
	TaskDispatcher.cancelTask(self._refreshAttrPanel, self)
	TaskDispatcher.cancelTask(self.showReshapeItem, self)

	if self._slotmats then
		for _, matInfo in ipairs(self._slotmats) do
			if matInfo._tweenId then
				ZProj.TweenHelper.KillById(matInfo._tweenId, false)

				matInfo._tweenId = nil
			end
		end
	end
end

function CharacterDestinySlotView:_statEnterView(heroId)
	if self._lastStatId == heroId then
		return
	end

	self._lastStatId = heroId

	local heroCfg = HeroConfig.instance:getHeroCO(heroId)

	if heroCfg then
		local chineseViewNameStr = (StatViewNameEnum.ChineseViewName[self.viewName] or self.viewName) .. "-" .. (heroCfg.name or "")

		StatViewController.instance:trackViewName(chineseViewNameStr)
	end
end

return CharacterDestinySlotView
