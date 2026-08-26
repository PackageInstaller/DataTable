-- chunkname: @modules/logic/activity/view/V3a3_DoubleDanActivityViewImpl.lua

module("modules.logic.activity.view.V3a3_DoubleDanActivityViewImpl", package.seeall)

local V3a3_DoubleDanActivityViewImpl = class("V3a3_DoubleDanActivityViewImpl", BaseView)

function V3a3_DoubleDanActivityViewImpl:_sendGet101BonusRequest(cb, cbObj)
	return self.viewContainer:sendGet101BonusRequest(self:getSelectedDay(), cb, cbObj)
end

function V3a3_DoubleDanActivityViewImpl:_isType101RewardCouldGet()
	return self.viewContainer:isType101RewardCouldGet(self:getSelectedDay())
end

function V3a3_DoubleDanActivityViewImpl:_isType101RewardGet()
	return self.viewContainer:isType101RewardGet(self:getSelectedDay())
end

function V3a3_DoubleDanActivityViewImpl:_isDayOpen()
	return self.viewContainer:isDayOpen(self:getSelectedDay())
end

function V3a3_DoubleDanActivityViewImpl:ctor()
	V3a3_DoubleDanActivityViewImpl.super.ctor(self)

	self._itemTabList = {}
	self._rewardItemList = {}
end

function V3a3_DoubleDanActivityViewImpl:_btnClaimOnClick()
	self:onRewardItemClick()
end

function V3a3_DoubleDanActivityViewImpl:onRewardItemClick()
	local isClaimable = self:_isType101RewardCouldGet()

	if not isClaimable then
		return
	end

	self._sendGet101BonusRequest(self, self._onClaimCb, self)

	return true
end

function V3a3_DoubleDanActivityViewImpl:_btnGoOnClick()
	local jumpId = ActivityType101Config.instance:getDoubleDanJumpId()

	GameFacade.jump(jumpId)
end

function V3a3_DoubleDanActivityViewImpl:_btnswitchOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)

	self._isShowSpine = not self._isShowSpine

	self._animator:Play(UIAnimationName.Switch, 0, 0)
	self:_refreshTxtSwitch()
	TaskDispatcher.cancelTask(self._refreshBigVertical, self)
	TaskDispatcher.runDelay(self._refreshBigVertical, self, 0.16)
end

function V3a3_DoubleDanActivityViewImpl:_btnClaimedOnClick()
	return
end

function V3a3_DoubleDanActivityViewImpl:_btnUnopenOnClick()
	return
end

function V3a3_DoubleDanActivityViewImpl:onUpdateParam()
	self:_refresh()
	self:_refreshTxtSwitch()
	self:_refreshTimeTick()
	self:_refreshBigVertical()
	self:_refreshSkinDesc()
end

function V3a3_DoubleDanActivityViewImpl:_refreshSkinDesc()
	local skinCO = self.viewContainer:getSkinCo()
	local heroCO = self.viewContainer:getHeroCO()

	self._txtcharacterName.text = heroCO.name
	self._txtskinNameEn.text = skinCO.nameEng
	self._txtskinName.text = skinCO.name
end

function V3a3_DoubleDanActivityViewImpl:onOpen()
	self._lastItemTab = nil
	self._isShowSpine = false

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)

	self._txtLimitTime.text = ""

	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)

	if self.viewParam.parent then
		gohelper.addChild(self.viewParam.parent, self.viewGO)
	end

	local getActivityCo = self.viewContainer:getActivityCo()

	self._txtDescr.text = getActivityCo.actDesc

	self:onUpdateParam()
	self:_focusByIndex(self:getSelectedDay())
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)
end

function V3a3_DoubleDanActivityViewImpl:_onClaimCb()
	local nextClaimableDay = self.viewContainer:getFirstAvailableIndex()

	FrameTimerController.onDestroyViewMember(self, "_frameTimer")

	if self:getSelectedDay() ~= nextClaimableDay then
		self._frameTimer = FrameTimerController.instance:register(function()
			if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.RoomBlockPackageGetView) then
				FrameTimerController.onDestroyViewMember(self, "_frameTimer")
				self:_focusAndClickTabByIndex(nextClaimableDay)
			end
		end, nil, 6, 6)

		self._frameTimer:Start()
	end
end

function V3a3_DoubleDanActivityViewImpl:onClose()
	FrameTimerController.onDestroyViewMember(self, "_fTimer")
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)
end

function V3a3_DoubleDanActivityViewImpl:onDestroyView()
	FrameTimerController.onDestroyViewMember(self, "_fTimer")
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")
	TaskDispatcher.cancelTask(self._refreshBigVertical, self)
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)

	if self._bigSpine then
		self._bigSpine:onDestroy()

		self._bigSpine = nil
	end

	GameUtil.onDestroyViewMemberList(self, "_rewardItemList")
	GameUtil.onDestroyViewMemberList(self, "_itemTabList")
end

function V3a3_DoubleDanActivityViewImpl:_onRefreshNorSignActivity()
	self:_refreshTabList()
	self:_onClickTab(self._lastItemTab)
end

function V3a3_DoubleDanActivityViewImpl:_refresh()
	self:_refreshTabList()
end

function V3a3_DoubleDanActivityViewImpl:_refreshBtnState()
	local isClaimable = self:_isType101RewardCouldGet()
	local isClaimed = self:_isType101RewardGet()
	local isDayOpen = self:_isDayOpen()

	gohelper.setActive(self._btnClaimGo, isClaimable)
	gohelper.setActive(self._btnClaimedGo, isClaimed)
	gohelper.setActive(self._btnUnopenGo, not isDayOpen)
	gohelper.setActive(self._goClaim, isClaimable)
end

function V3a3_DoubleDanActivityViewImpl:_refreshTabList()
	local curSelectedDay = self:getSelectedDay()
	local maxDay = self.viewContainer:getSignMaxDay()

	for i = 1, maxDay do
		local item = self._itemTabList[i]

		if not item then
			item = self:_create_V3a3_DoubleDanActivity_radiotaskitem(i)

			table.insert(self._itemTabList, item)
		end

		item:onUpdateMO()
		item:setActive(true)
		item:setSelected(i == curSelectedDay)
	end

	for i = maxDay + 1, #self._itemTabList do
		local item = self._itemTabList[i]

		item:setActive(false)
	end

	self:onClickTab(self._itemTabList[curSelectedDay or 1] or self._itemTabList[1])
end

function V3a3_DoubleDanActivityViewImpl:getSelectedDay()
	local day

	if self._lastItemTab then
		day = self._lastItemTab:index()
	else
		day = self.viewContainer:getFirstAvailableIndex()

		if day <= 0 then
			day = self.viewContainer:getType101LoginCount()
		end
	end

	return GameUtil.clamp(day, 1, self.viewContainer:getSignMaxDay())
end

function V3a3_DoubleDanActivityViewImpl:onClickTab(item)
	if self._lastItemTab == item then
		return
	end

	if self._lastItemTab and self._lastItemTab:index() == item:index() then
		return
	end

	self:_onClickTab(item)
end

function V3a3_DoubleDanActivityViewImpl:_onClickTab(item)
	if self._lastItemTab then
		self._lastItemTab:setSelected(false)
	end

	self._lastItemTab = item

	if item then
		item:setSelected(true)
		self:_refreshRewardList(item:index())
	end
end

function V3a3_DoubleDanActivityViewImpl:_refreshRewardList(day)
	day = day or self:getSelectedDay()

	local dayBonusList = self.viewContainer:getDayBonusList(day)
	local rewardCount = #dayBonusList
	local goContainerTrans

	if rewardCount == 1 then
		goContainerTrans = self._1SlotTrans
	elseif rewardCount == 2 then
		goContainerTrans = self._2SlotTrans
	elseif rewardCount == 3 then
		goContainerTrans = self._3SlotTrans
	end

	for i, itemCO in ipairs(dayBonusList) do
		local item = self._rewardItemList[i]

		if not item then
			item = self:_create_V3a3_DoubleDanActivity_rewarditem(i)

			table.insert(self._rewardItemList, item)
		end

		local slotIndex = i - 1
		local parentTran = goContainerTrans:GetChild(slotIndex)

		if parentTran then
			item:onUpdateMO(itemCO)
			item:setActive(true)
			item:setParentAndResetPosZero(parentTran)
		else
			logError(tostring(i) .. "Slot child node out of range!")
		end
	end

	for i = rewardCount + 1, #self._rewardItemList do
		local item = self._rewardItemList[i]

		item:setActive(false)
	end

	self:_refreshBtnState()
end

function V3a3_DoubleDanActivityViewImpl:_refreshTimeTick()
	self._txtLimitTime.text = self.viewContainer:getRemainTimeStr()
end

function V3a3_DoubleDanActivityViewImpl:_refreshTxtSwitch()
	self._txtswitch.text = self._isShowSpine and luaLang("storeskinpreviewview_btnswitch") or "L2D"
end

function V3a3_DoubleDanActivityViewImpl:_create_V3a3_DoubleDanActivity_radiotaskitem(index)
	local go = gohelper.cloneInPlace(self._goradiotaskitem)
	local item = V3a3_DoubleDanActivity_radiotaskitem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a3_DoubleDanActivityViewImpl:_create_V3a3_DoubleDanActivity_rewarditem(index)
	local go = gohelper.cloneInPlace(self._goitem)
	local item = V3a3_DoubleDanActivity_rewarditem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a3_DoubleDanActivityViewImpl:_refreshBigVertical()
	local skinCo = self.viewContainer:getSkinCo()

	gohelper.setActive(self._gospinecontainer, self._isShowSpine)
	gohelper.setActive(self._simageRoleGo, not self._isShowSpine)
	self._bigSpine:setModelVisible(self._isShowSpine)
end

function V3a3_DoubleDanActivityViewImpl:_onBigSpineLoaded()
	self._bigSpine:setAllLayer(UnityLayer.SceneEffect)

	local skinCo = self.viewContainer:getSkinCo()
	local offsetStr = skinCo.skinSwitchLive2dOffset

	if string.nilorempty(offsetStr) then
		offsetStr = skinCo.characterViewOffset
	end

	local offsets = SkinConfig.instance:getSkinOffset(offsetStr)

	CharacterVoiceEnum.setSpineOffset(self._bigSpine, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gospineTran, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function V3a3_DoubleDanActivityViewImpl:_focus(index)
	local viewportWidth = recthelper.getWidth(self._viewportTrans)
	local contentWidth = recthelper.getWidth(self._contentTrans)
	local maxScroll = math.max(0, contentWidth - viewportWidth)

	if maxScroll <= 0 then
		return false
	end

	local item = self._itemTabList[index]

	if not item then
		return false
	end

	local contentRect = self._contentTrans.rect
	local contentPivot = self._contentTrans.pivot
	local targetRect = item:rect()
	local targetPivot = item:pivot()
	local targetLeftRelativeToPivot = item:posX() - targetRect.width * targetPivot.x
	local targetPosFromLeft = targetLeftRelativeToPivot + contentRect.width * contentPivot.x

	self._scrollTaskTabList.horizontalNormalizedPosition = GameUtil.saturate(targetPosFromLeft / maxScroll)

	return true
end

function V3a3_DoubleDanActivityViewImpl:_focusAndClickTabByIndex(day)
	local focusItem = self._itemTabList[day]

	if not focusItem then
		return
	end

	self:_onClickTab(focusItem)
	self:_focusByIndex(day)
end

function V3a3_DoubleDanActivityViewImpl:_focusByIndex(day)
	local isFocused = false

	FrameTimerController.onDestroyViewMember(self, "_fTimer")

	self._fTimer = FrameTimerController.instance:register(function()
		if isFocused then
			return
		end

		isFocused = self:_focus(day)
	end, self, 5, 3)

	self._fTimer:Start()
end

function V3a3_DoubleDanActivityViewImpl:_editableInitView()
	self._goitem = gohelper.findChild(self.viewGO, "Right/RawardPanel/go_Content/go_item")
	self._1Slot = gohelper.findChild(self.viewGO, "Right/RawardPanel/go_Content/1Slots")
	self._2Slot = gohelper.findChild(self.viewGO, "Right/RawardPanel/go_Content/2Slots")
	self._3Slot = gohelper.findChild(self.viewGO, "Right/RawardPanel/go_Content/3Slots")
	self._1SlotTrans = self._1Slot.transform
	self._2SlotTrans = self._2Slot.transform
	self._3SlotTrans = self._3Slot.transform

	gohelper.setActive(self._goitem, false)
	gohelper.setActive(self._goradiotaskitem, false)
	gohelper.setActive(self._btnClaimGo, false)
	gohelper.setActive(self._btnClaimedGo, false)
	gohelper.setActive(self._btnUnopenGo, false)
	gohelper.setActive(self._goClaim, false)

	self._btnClaimGo = self._btnClaim.gameObject
	self._btnClaimedGo = self._btnClaimed.gameObject
	self._btnUnopenGo = self._btnUnopen.gameObject
	self._gospineTran = self._gospine.transform
	self._simageRoleGo = self._simageRole.gameObject

	local scrollTaskTabListGo = self._scrollTaskTabList.gameObject

	self._scrollRect = scrollTaskTabListGo:GetComponent(gohelper.Type_ScrollRect)
	self._viewportTrans = gohelper.findChild(scrollTaskTabListGo, "Viewport").transform
	self._contentTrans = self._scrollRect.content
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:_editableInitView_loadSpine()
end

function V3a3_DoubleDanActivityViewImpl:_editableInitView_loadSpine()
	local skinCo = self.viewContainer:getSkinCo()

	self._bigSpine = GuiModelAgent.Create(self._gospine, true)

	self._bigSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)
	self._bigSpine:setResPath(skinCo, self._onBigSpineLoaded, self)
end

return V3a3_DoubleDanActivityViewImpl
