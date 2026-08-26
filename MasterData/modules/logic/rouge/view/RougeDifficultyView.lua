-- chunkname: @modules/logic/rouge/view/RougeDifficultyView.lua

module("modules.logic.rouge.view.RougeDifficultyView", package.seeall)

local RougeDifficultyView = class("RougeDifficultyView", BaseView)

function RougeDifficultyView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagemask2 = gohelper.findChildSingleImage(self.viewGO, "#simage_mask2")
	self._simagemask3 = gohelper.findChildSingleImage(self.viewGO, "#simage_mask3")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "Middle/#scroll_view")
	self._goContent = gohelper.findChild(self.viewGO, "Middle/#scroll_view/Viewport/#go_Content")
	self._btnleftarrow = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_leftarrow")
	self._btnrightarrow = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_rightarrow")
	self._gorougepageprogress = gohelper.findChild(self.viewGO, "#go_rougepageprogress")
	self._btnstart1 = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#btn_start1")
	self._btnstart2 = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#btn_start2")
	self._btnstart3 = gohelper.findChildButtonWithAudio(self.viewGO, "Btn/#btn_start3")
	self._goblock = gohelper.findChild(self.viewGO, "#go_block")
	self._gooverviewtips = gohelper.findChild(self.viewGO, "#go_overviewtips")
	self._godecitem = gohelper.findChild(self.viewGO, "#go_overviewtips/#scroll_overview/Viewport/Content/#txt_decitem")
	self._gobalancetips = gohelper.findChild(self.viewGO, "#go_balancetips")
	self._golevelitem = gohelper.findChild(self.viewGO, "#go_balancetips/#scroll_details/Viewport/Content/level/#go_levelitem")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeDifficultyView:addEvents()
	self._btnleftarrow:AddClickListener(self._btnleftarrowOnClick, self)
	self._btnrightarrow:AddClickListener(self._btnrightarrowOnClick, self)
	self._btnstart1:AddClickListener(self._btnstart1OnClick, self)
	self._btnstart2:AddClickListener(self._btnstart2OnClick, self)
	self._btnstart3:AddClickListener(self._btnstart3OnClick, self)
end

function RougeDifficultyView:removeEvents()
	self._btnleftarrow:RemoveClickListener()
	self._btnrightarrow:RemoveClickListener()
	self._btnstart1:RemoveClickListener()
	self._btnstart2:RemoveClickListener()
	self._btnstart3:RemoveClickListener()
end

local csTweenHelper = ZProj.TweenHelper
local kFastScrollSpeed = 100
local kTweenSecond = 0.3
local kAfterOpen1ScaleAnimSecond = 0.6
local kAfterUnlock1ScaleAnimSecond = 2

function RougeDifficultyView:_btnleftarrowOnClick()
	self:_moveByArrow(true)
end

function RougeDifficultyView:_btnrightarrowOnClick()
	self:_moveByArrow(false)
end

function RougeDifficultyView:_moveByArrow(isLeft)
	self._drag:clear()

	local lastIndex = self._lastSelectedIndex

	lastIndex = lastIndex or isLeft and 2 or 0

	if isLeft then
		if not (lastIndex - 1) then
			local selectIndex = lastIndex + 1

			self:_onSelectIndex(self:_validateIndex(selectIndex))
		end
	end
end

function RougeDifficultyView:_btnstart1OnClick()
	self:_btnStartOnClick()
end

function RougeDifficultyView:_btnstart2OnClick()
	self:_btnStartOnClick()
end

function RougeDifficultyView:_btnstart3OnClick()
	self:_btnStartOnClick()
end

local kBlockKey = "RougeDifficultyView:_btnStartOnClick"

function RougeDifficultyView:_btnStartOnClick()
	local season = RougeOutsideModel.instance:season()
	local versionList = self:_versionList()
	local difficulty = self:difficulty()
	local limiterMO

	if tabletool.indexOf(versionList, RougeDLCEnum.DLCEnum.DLC_101) then
		limiterMO = RougeDLCModel101.instance:getLimiterClientMo()
	end

	if not self._lastSelectedIndex then
		return
	end

	UIBlockHelper.instance:startBlock(kBlockKey, 1, self.viewName)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_columns_update_20190318)

	local isAnimDone = false
	local isRpcReplyed = false
	local lastItem = self._itemList[self._lastSelectedIndex]

	lastItem:setOnCloseEndCb(function()
		isAnimDone = true

		if not isRpcReplyed then
			return
		end

		UIBlockHelper.instance:endBlock(kBlockKey)
		self:_directOpenNextView()
	end)

	local from = self:_validateIndex(self._lastSelectedIndex - 2)
	local to = self:_validateIndex(self._lastSelectedIndex + 2)

	for i = from, to do
		local item = self._itemList[i]

		item:playClose()
	end

	RougeRpc.instance:sendEnterRougeSelectDifficultyRequest(season, versionList, difficulty, limiterMO, function(_, resultCode)
		if resultCode ~= 0 then
			logError("RougeDifficultyView:_btnStartOnClick resultCode=" .. tostring(resultCode))

			return
		end

		RougeOutsideModel.instance:setLastMarkSelectedDifficulty(difficulty)

		isRpcReplyed = true

		if not isAnimDone then
			return
		end

		UIBlockHelper.instance:endBlock(kBlockKey)
		self:_directOpenNextView()
	end)
end

function RougeDifficultyView:_directOpenNextView()
	if RougeModel.instance:isCanSelectRewards() then
		RougeController.instance:openRougeSelectRewardsView()
	else
		RougeController.instance:openRougeFactionView()
	end
end

function RougeDifficultyView:_editableInitView()
	self._goblockClick = gohelper.findChildClick(self._goblock, "")

	self._goblockClick:AddClickListener(self._goblockClickonClick, self)

	self._decitemTextList = self:getUserDataTb_()

	gohelper.setActive(self._godecitem, false)

	self._golevelitemList = self:getUserDataTb_()

	gohelper.setActive(self._golevelitem, false)
	self:_setActiveOverviewTips(false)
	self:_setActiveBalanceTips(false)
	self:_initScrollView()
	self:_initPageProgress()
	self:_initViewStyles()
end

function RougeDifficultyView:_goblockClickonClick()
	self:_setActiveBlock(false)
end

function RougeDifficultyView:_setActiveOverviewTips(isActive)
	gohelper.setActive(self._gooverviewtips, isActive)
end

function RougeDifficultyView:_setActiveBalanceTips(isActive)
	gohelper.setActive(self._gobalancetips, isActive)
end

function RougeDifficultyView:_initScrollView()
	self._scrollViewGo = self._scrollview.gameObject
	self._scrollViewTrans = self._scrollViewGo.transform
	self._scrollViewLimitScrollCmp = self._scrollViewGo:GetComponent(gohelper.Type_LimitedScrollRect)
	self._goContentHLayout = self._goContent:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	self._drag = UIDragListenerHelper.New()

	self._drag:createByScrollRect(self._scrollViewLimitScrollCmp)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBeginHandler, self)
	self._drag:registerCallback(self._drag.EventDragging, self._onDragging, self)
	self._scrollview:AddOnValueChanged(self._onScrollValueChanged, self)
end

function RougeDifficultyView:_initPageProgress()
	local itemClass = RougePageProgress
	local go = self.viewContainer:getResInst(RougeEnum.ResPath.rougepageprogress, self._gorougepageprogress, itemClass.__cname)

	self._pageProgress = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._pageProgress:setData()
end

function RougeDifficultyView:_initViewStyles()
	self._transBtnStartList = self:getUserDataTb_()
	self._animBtnStartList = self:getUserDataTb_()

	local i = 1
	local btnStart = self["_btnstart" .. i]

	while btnStart ~= nil do
		local go = btnStart.gameObject
		local t = go.transform

		table.insert(self._transBtnStartList, t)
		table.insert(self._animBtnStartList, go:GetComponent(gohelper.Type_Animator))
		gohelper.setActive(go, true)
		GameUtil.setActive01(t, false)

		i = i + 1
		btnStart = self["_btnstart" .. i]
	end

	self._transSimageMaskList = self:getUserDataTb_()
	self._animSimageMaskList = self:getUserDataTb_()

	for i = 1, #self._transBtnStartList do
		local simagemask = self["_simagemask" .. i]

		if simagemask then
			local go = simagemask.gameObject
			local t = go.transform

			self._transSimageMaskList[i] = t
			self._animSimageMaskList[i] = go:GetComponent(gohelper.Type_Animator)

			GameUtil.setActive01(t, false)
			gohelper.setActive(go, true)
		end
	end
end

function RougeDifficultyView:onUpdateParam()
	self:_refresh()
	self:_onSelectIndex(self:_onOpenSelectedIndex())
end

function RougeDifficultyView:onOpen()
	self._lastSelectedIndex = false
	self._uiAduioLastDragNear = nil
	self._cache_difficultyCOList = nil
	self._cache_sumDescIndexList = nil

	self:_setActiveBlock(false)

	self._dataList = RougeOutsideModel.instance:getDifficultyInfoList(self:_versionList())

	self:_refresh()
	UpdateBeat:Add(self._update, self)
	self.viewContainer:registerCallback(RougeEvent.RougeDifficultyView_OnSelectIndex, self._onSelectIndexByUser, self)
	self.viewContainer:registerCallback(RougeEvent.RougeDifficultyView_btnTipsIconOnClick, self._btnTipsIconOnClick, self)
	self.viewContainer:registerCallback(RougeEvent.RougeDifficultyView_btnBalanceOnClick, self._btnBalanceOnClick, self)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function RougeDifficultyView:onOpenFinish()
	self:_onScreenResize()
	self:_tweenOpenAnim()
end

function RougeDifficultyView:onClose()
	self:_clearTweenOpenAnimFirstItemScaleTimer()
	UpdateBeat:Remove(self._update, self)
	self._goblockClick:RemoveClickListener()
	self._scrollview:RemoveOnValueChanged()
	self.viewContainer:unregisterCallback(RougeEvent.RougeDifficultyView_OnSelectIndex, self._onSelectIndexByUser, self)
	self.viewContainer:unregisterCallback(RougeEvent.RougeDifficultyView_btnTipsIconOnClick, self._btnTipsIconOnClick, self)
	self.viewContainer:unregisterCallback(RougeEvent.RougeDifficultyView_btnBalanceOnClick, self._btnBalanceOnClick, self)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self:_killTween()
end

function RougeDifficultyView:_killTween()
	GameUtil.onDestroyViewMember_TweenId(self, "_contentPosXTweenId")
end

function RougeDifficultyView:_clearTweenOpenAnimFirstItemScaleTimer()
	TaskDispatcher.cancelTask(self._tweenOpenAnimFirstItemScale, self)
end

function RougeDifficultyView:onDestroyView()
	self:_clearTweenOpenAnimFirstItemScaleTimer()
	UpdateBeat:Remove(self._update, self)
	GameUtil.onDestroyViewMember(self, "_drag")
	GameUtil.onDestroyViewMemberList(self, "_itemList")
end

function RougeDifficultyView:_refresh()
	self:_refreshList()
end

function RougeDifficultyView:_getNewUnlockStateList()
	local res = {}

	for i, itemData in ipairs(self._dataList) do
		local difficulty = itemData.difficulty

		res[i] = RougeOutsideModel.instance:getIsNewUnlockDifficulty(difficulty)
	end

	return res
end

function RougeDifficultyView:_tweenOpenAnimFirstItemScale()
	if not self._itemList then
		return
	end

	local firstSelectedItem = self._itemList[1]

	if not firstSelectedItem then
		return
	end

	self:_setScaleAdjacent(1, true)
	firstSelectedItem:tweenScale(RougeDifficultyItem.ScalerSelected)
end

function RougeDifficultyView:_tweenOpenAnim()
	UIBlockHelper.instance:startBlock("RougeDifficultyView:_tweenOpenAnim", 1.9, self.viewName)

	local itemList = self:_getItemList()
	local newUnlockStateList = self:_getNewUnlockStateList()
	local openSelectedIndex = self:_onOpenSelectedIndex()
	local firstSelectedItem = itemList[openSelectedIndex]

	local function _animDoneCb()
		UIBlockHelper.instance:endBlock("RougeRougeDifficultyViewFactionView:_tweenOpenAnim")
		self:_onSelectIndex(openSelectedIndex)
	end

	if openSelectedIndex == 1 then
		self:_clearTweenOpenAnimFirstItemScaleTimer()
		TaskDispatcher.runDelay(self._tweenOpenAnimFirstItemScale, self, (newUnlockStateList[openSelectedIndex] or nil) and (kAfterUnlock1ScaleAnimSecond or kAfterOpen1ScaleAnimSecond))
	end

	firstSelectedItem:setOnOpenEndCb(_animDoneCb)

	if newUnlockStateList[openSelectedIndex] then
		firstSelectedItem:setOnOpenEndCb(nil)
		firstSelectedItem:setOnUnlockEndCb(_animDoneCb)
	end

	for i, item in ipairs(itemList) do
		if newUnlockStateList then
			if not newUnlockStateList[i] then
				local isNewUnlock

				if i == 1 then
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open_20190313)
				end

				if isNewUnlock ~= nil then
					local itemData = self._dataList[i]
					local difficulty = itemData.difficulty

					item:playOpen(isNewUnlock)

					if isNewUnlock then
						RougeOutsideModel.instance:setIsNewUnlockDifficulty(difficulty, false)
					end
				else
					item:playOpen()
				end
			end
		end
	end
end

function RougeDifficultyView:_versionList()
	if not self.viewParam then
		return RougeModel.instance:getVersion()
	end

	return self.viewParam.versionList or RougeModel.instance:getVersion()
end

function RougeDifficultyView:_trySelectDifficulty2TabIndex(difficulty)
	local dataList = self:_getDataList()

	if difficulty > #dataList then
		return 1
	end

	for i, v in ipairs(dataList) do
		if v.difficulty == difficulty then
			return v.isUnLocked and i or 1
		end
	end

	return 1
end

function RougeDifficultyView:_selectedDifficultyOnOpen()
	if not self.viewParam then
		return self:_trySelectDifficulty2TabIndex(RougeOutsideModel.instance:getLastMarkSelectedDifficulty(1))
	end

	return self.viewParam.selectedDifficulty or self:_trySelectDifficulty2TabIndex(RougeOutsideModel.instance:getLastMarkSelectedDifficulty(1))
end

function RougeDifficultyView:difficulty()
	return self._lastSelectedIndex or self:_onOpenSelectedIndex()
end

function RougeDifficultyView:_difficultyCOList()
	if self._cache_difficultyCOList then
		return self._cache_difficultyCOList
	end

	local cfg = RougeOutsideModel.instance:config()
	local difficultyCOList = cfg:getDifficultyCOListByVersions(self:_versionList())

	self._cache_difficultyCOList = difficultyCOList

	return difficultyCOList
end

function RougeDifficultyView:_onOpenSelectedIndex()
	if not self._lastSelectedIndex then
		local index = self:_selectedDifficultyOnOpen()

		if self._lastSelectedIndex > #self._itemList then
			return 1
		end

		return self._lastSelectedIndex
	end
end

function RougeDifficultyView:_onSelectIndexByUser(index)
	self._drag:stopMovement()
	self:_onSelectIndex(index)
end

function RougeDifficultyView:_guessIsStopedScrolling()
	if not self._drag:isStoped() then
		return false
	end

	if not self:_isScrollSlowly() then
		return false
	end

	return true
end

function RougeDifficultyView:_btnTipsIconOnClick(curDifficulty)
	if not self:_guessIsStopedScrolling() then
		return
	end

	self:_setExtendProp(curDifficulty)
	self:_setActiveOverviewTips(true)
	self:_setActiveBlock(true)
end

function RougeDifficultyView:_btnBalanceOnClick(curDifficulty)
	if not self:_guessIsStopedScrolling() then
		return
	end

	self:_setBalance(curDifficulty)
	self:_setActiveBalanceTips(true)
	self:_setActiveBlock(true)
end

function RougeDifficultyView:_onSelectIndex(index)
	if self._lastSelectedIndex == index then
		self:_animFocusIndex(index)

		return
	end

	if self._lastSelectedIndex then
		local lastItem = self._itemList[self._lastSelectedIndex]

		lastItem:setSelected(false)
	end

	local curItem = self._itemList[index]

	curItem:setSelected(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_insight_close_20190315)
	self:_setScaleAdjacent(index, true)
	self:_refreshStartBtn(self._lastSelectedIndex, index)

	self._lastSelectedIndex = index

	self:_animFocusIndex(index)
end

function RougeDifficultyView:_hideAllStartBtn()
	for _, t in ipairs(self._transBtnStartList) do
		GameUtil.setActive01(t, false)
	end
end

function RougeDifficultyView:_hideAllSimageMask()
	for _, t in ipairs(self._transSimageMaskList) do
		GameUtil.setActive01(t, false)
	end
end

local kAnimOpen = UIAnimationName.Open
local kAnimClose = UIAnimationName.Close

function RougeDifficultyView:_setSingleStyleActive(index, isActive)
	self:_setActiveStartBtn(index, isActive)
	self:_setActiveSimageMask(index, isActive)
end

function RougeDifficultyView:_setActiveStartBtn(index, isActive)
	local transBtnStart = self._transBtnStartList[index]
	local animBtnStart = self._animBtnStartList[index]

	if isActive then
		if not kAnimOpen then
			local animName = kAnimClose

			GameUtil.setActive01(transBtnStart, isActive)
			animBtnStart:Play(animName, 0, 0)
		end
	end
end

function RougeDifficultyView:_setActiveSimageMask(index, isActive)
	local transSimageMask = self._transSimageMaskList[index]

	if not transSimageMask then
		return
	end

	if isActive then
		if not kAnimOpen then
			local animName = kAnimClose
			local animSimageMask = self._animSimageMaskList[index]

			GameUtil.setActive01(transSimageMask, isActive)
			animSimageMask:Play(animName, 0, 0)
		end
	end
end

function RougeDifficultyView:_refreshStartBtn(lastDifficult, curDifficulty)
	if lastDifficult == curDifficulty then
		return
	end

	local lastIndex = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(lastDifficult)
	local curIndex = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(curDifficulty or self:difficulty())
	local dataList = self:_getDataList()
	local isCurUnLocked = dataList[curDifficulty].isUnLocked
	local isLastUnLocked

	if lastIndex == curIndex and isCurUnLocked == ((lastDifficult or nil) and dataList[lastDifficult].isUnLocked) then
		return
	end

	if not lastIndex then
		self:_hideAllStartBtn()
		self:_hideAllSimageMask()
	else
		self:_setSingleStyleActive(lastIndex, false)
	end

	if isCurUnLocked then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open_20190317)
	end

	self:_setSingleStyleActive(curIndex, isCurUnLocked)
end

function RougeDifficultyView:_refreshList()
	local dataList = self:_getDataList()

	self._itemList = self._itemList or {}

	for i, mo in ipairs(dataList) do
		local item = self._itemList[i]

		if not item then
			item = self:_create_RougeDifficultyItem()

			item:setIndex(i)
			table.insert(self._itemList, item)
		end

		item:setData(mo)
		item:playIdle()
		item:setSelected(self._lastSelectedIndex == i)
	end
end

function RougeDifficultyView:_setScaleAdjacent(index, isAnim)
	local item = self._itemList[index]

	if not item then
		return
	end

	local left = index - 1
	local lItem = self._itemList[left]

	if lItem then
		lItem:setScale(RougeDifficultyItem.ScalerSelectedAdjacent, isAnim)

		left = left - 1

		local llItem = self._itemList[left]

		if llItem then
			llItem:setScale(RougeDifficultyItem.ScalerNormal, isAnim)
		end
	end

	local right = index + 1
	local rItem = self._itemList[right]

	if rItem then
		rItem:setScale(RougeDifficultyItem.ScalerSelectedAdjacent, isAnim)

		right = right + 1

		local rrItem = self._itemList[right]

		if rrItem then
			rrItem:setScale(RougeDifficultyItem.ScalerNormal, isAnim)
		end
	end
end

function RougeDifficultyView:_create_RougeDifficultyItem()
	local itemClass = RougeDifficultyItem
	local go = self.viewContainer:getResInst(RougeEnum.ResPath.rougedifficultyitem, self.viewContainer:getScrollContentGo(), itemClass.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass, {
		baseViewContainer = self.viewContainer
	})
end

function RougeDifficultyView:_getDataList()
	self._dataList = self._dataList or RougeOutsideModel.instance:getDifficultyInfoList(self:_versionList())

	return self._dataList
end

function RougeDifficultyView:_getItemList()
	if not self._itemList then
		self:_refreshList()
	end

	return self._itemList
end

function RougeDifficultyView:_getDataListCount()
	return #self:_getDataList()
end

function RougeDifficultyView:_validateIndex(index)
	local count = self:_getDataListCount()

	return GameUtil.clamp(index, 1, count)
end

function RougeDifficultyView:_contentPosX()
	return recthelper.getAnchorX(self.viewContainer:getScrollContentTranform())
end

function RougeDifficultyView:_contentAbsPosX()
	local contentPosX = self:_contentPosX()

	return (contentPosX <= 0 or nil) and (-contentPosX or 0)
end

function RougeDifficultyView:_onScrollValueChanged()
	self:_tweenSelectItemsInBetween()
end

function RougeDifficultyView:_getIndexFactorInbetween()
	local step = self.viewContainer:getListScrollParamStep()
	local contentAbsPosX = self:_contentAbsPosX()
	local index = math.ceil(contentAbsPosX / step)
	local contentAbsPosXFromZero = contentAbsPosX % step

	contentAbsPosXFromZero = contentAbsPosXFromZero == 0 and step or contentAbsPosXFromZero

	local offset = contentAbsPosXFromZero / (step * 0.5) > 1 and 1 or 0
	local nearIndex = self:_validateIndex(index + offset)
	local farIndex = self:_validateIndex(offset == 1 and index or index + 1)
	local f = GameUtil.saturate(GameUtil.remap01(contentAbsPosXFromZero, 0, step))
	local nearFactor = offset == 1 and f or 1 - f
	local farFactor = 1 - nearFactor

	if nearIndex == farIndex then
		farFactor = 1
		nearFactor = 1
	end

	return nearIndex, nearFactor, farIndex, farFactor
end

function RougeDifficultyView:_tweenSelectItemsInBetween()
	local nearIndex, nearFactor, farIndex, farFactor = self:_getIndexFactorInbetween()
	local nearItem = self._itemList[nearIndex]
	local farItem = self._itemList[farIndex]

	nearItem:setScale01(nearFactor)
	farItem:setScale01(farFactor)
end

function RougeDifficultyView:_onDragBeginHandler()
	self:_killTween()
end

function RougeDifficultyView:_onDragging()
	self:_playAudioOnDragging()
end

function RougeDifficultyView:_playAudioOnDragging()
	local nearIndex = self:_getIndexFactorInbetween()

	if self._uiAduioLastDragNear == nil then
		self._uiAduioLastDragNear = nearIndex
	elseif self._uiAduioLastDragNear ~= nearIndex then
		self._uiAduioLastDragNear = nearIndex

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_chain_20190314)
	end
end

function RougeDifficultyView:_calcContentWidth()
	return self._goContentHLayout.preferredWidth
end

function RougeDifficultyView:_getViewportW()
	return recthelper.getWidth(self._scrollViewTrans)
end

function RougeDifficultyView:_getViewportH()
	return recthelper.getHeight(self._scrollViewTrans)
end

function RougeDifficultyView:_getViewportWH()
	return self:_getViewportW(), self:_getViewportH()
end

function RougeDifficultyView:_getMaxScrollX()
	local viewportW = self:_getViewportW()
	local maxContentW = self:_calcContentWidth()

	return math.max(0, maxContentW - viewportW)
end

function RougeDifficultyView:_calcFocusIndexPosX(index)
	local posX = 0
	local maxScrollX = self:_getMaxScrollX()

	if index <= 1 then
		return posX, maxScrollX
	end

	local item = self._itemList[index]
	local startOffset = self._goContentHLayout.padding.left
	local w = self.viewContainer:getListScrollParam_cellSize()
	local halfW = w * 0.5

	posX = item:posX() - halfW - startOffset

	return posX, maxScrollX
end

function RougeDifficultyView:_animFocusIndex(index)
	self:_killTween()

	local toPosX = -self:_calcFocusIndexPosX(index)

	self._contentPosXTweenId = csTweenHelper.DOAnchorPosX(self.viewContainer:getScrollContentTranform(), toPosX, kTweenSecond, nil, nil, nil, EaseType.OutQuad)
end

function RougeDifficultyView:_noAnimFocusIndex(index)
	local scrollContentTran = self.viewContainer:getScrollContentTranform()
	local posX = -self:_calcFocusIndexPosX(index)

	recthelper.setAnchorX(scrollContentTran, posX)
end

function RougeDifficultyView:_scrollVelocityX()
	if not self._scrollViewLimitScrollCmp then
		return nil
	end

	return self._scrollViewLimitScrollCmp.velocity.x
end

function RougeDifficultyView:_isScrollSlowly()
	local velocity = self:_scrollVelocityX()

	if not velocity then
		return false
	end

	return math.abs(velocity) < kFastScrollSpeed
end

function RougeDifficultyView:_update()
	if not self._drag:isEndedDrag() then
		return
	end

	if self:_isScrollSlowly() then
		self._drag:clear()

		local nearIndex = self:_getIndexFactorInbetween()

		self:_onSelectIndex(nearIndex)
	end
end

function RougeDifficultyView:_setActiveBlock(isActive)
	gohelper.setActive(self._goblock, isActive)

	if not isActive then
		self:_setActiveOverviewTips(false)
		self:_setActiveBalanceTips(false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190316)
	end
end

function RougeDifficultyView:_calcLeftRightOffset()
	local width = self:_getViewportW()
	local listScrollParam = self.viewContainer:getListScrollParam()
	local cellWidth = listScrollParam.cellWidth

	return Mathf.Round(width * 0.5 - cellWidth * 0.5)
end

function RougeDifficultyView:_onScreenResize()
	local offset = self:_calcLeftRightOffset()

	self._goContentHLayout.padding.left = offset
	self._goContentHLayout.padding.right = offset

	self.viewContainer:rebuildLayout()
end

function RougeDifficultyView:_calcSpaceOffset()
	local listScrollParam = self.viewContainer:getListScrollParam()
	local width = self:_getViewportW()
	local cellWidth = listScrollParam.cellWidth
	local startSpace = listScrollParam.startSpace
	local res = width * 0.5 - cellWidth * 0.5 - startSpace

	return math.max(0, res)
end

function RougeDifficultyView:_setExtendProp(curDifficulty)
	local sumDescIndexList = self:getSumDescIndexList(curDifficulty)
	local difficultyCOList = self:_difficultyCOList()
	local descCount = 0

	for _, idx in ipairs(sumDescIndexList) do
		local difficultyCO = difficultyCOList[idx]
		local descList = string.split(difficultyCO.desc, "\n")

		for _, desc in ipairs(descList) do
			if not string.nilorempty(desc) then
				descCount = descCount + 1

				local itemObj

				if descCount > #self._decitemTextList then
					itemObj = {}

					local go = gohelper.cloneInPlace(self._godecitem)

					itemObj.txt = go:GetComponent(gohelper.Type_TextMesh)
					itemObj.go = go

					table.insert(self._decitemTextList, itemObj)
					gohelper.setActive(go, true)
				else
					itemObj = self._decitemTextList[descCount]

					gohelper.setActive(self._decitemTextList[descCount].go, true)
				end

				itemObj.txt.text = desc
			end
		end
	end

	for i = descCount + 1, #self._decitemTextList do
		local itemObj = self._decitemTextList[i]

		gohelper.setActive(itemObj.go, false)
	end
end

function RougeDifficultyView:getSumDescIndexList(curDifficulty)
	self._cache_sumDescIndexList = self._cache_sumDescIndexList or {}

	if self._cache_sumDescIndexList[curDifficulty] then
		return self._cache_sumDescIndexList[curDifficulty]
	end

	local res = {}
	local difficultyCOList = self:_difficultyCOList()

	for idx, difficultyCO in ipairs(difficultyCOList) do
		if curDifficulty <= difficultyCO.difficulty then
			break
		end

		if not string.nilorempty(difficultyCO.desc) then
			table.insert(res, idx)
		end
	end

	self._cache_sumDescIndexList[curDifficulty] = res

	return res
end

local kTitleList = {
	"p_herogroupbalancetipview_txt_RoleLevel",
	"p_herogroupbalancetipview_txt_TalentLevel",
	"p_herogroupbalancetipview_txt_HeartLevel"
}
local kTextMaxCount = 3
local kRankMaxLv = 3

function RougeDifficultyView:_setBalance(curDifficulty)
	local cfg = RougeOutsideModel.instance:config()
	local difficultyCO = cfg:getDifficultyCO(curDifficulty)
	local balanceLevel = difficultyCO.balanceLevel
	local isBalance = not string.nilorempty(balanceLevel)

	if not isBalance then
		return
	end

	local balanceSp = string.splitToNumber(balanceLevel, "#")

	for i = 1, kTextMaxCount do
		local itemObj

		if i > #self._golevelitemList then
			itemObj = {}

			local go = gohelper.cloneInPlace(self._golevelitem)

			itemObj.go = go
			itemObj.txtTitle = gohelper.findChildText(go, "#txt_smalltitle")
			itemObj.txtLevel = gohelper.findChildText(go, "#txt_level")

			for j = 1, kRankMaxLv do
				local rankGO = gohelper.findChild(go, "#txt_level/rank" .. j)

				itemObj["rankGO" .. j] = rankGO

				gohelper.setActive(rankGO, false)
			end

			gohelper.setActive(go, true)
			table.insert(self._golevelitemList, itemObj)
		else
			itemObj = self._golevelitemList[i]

			gohelper.setActive(self._golevelitemList[i].go, true)
		end

		itemObj.txtTitle.text = luaLang(kTitleList[i])

		local rankLv = 0

		if i == 1 then
			local var_82_0, var_82_1 = HeroConfig.instance:getShowLevel(balanceSp[i])

			rankLv = var_82_1
			itemObj.txtLevel.text = formatLuaLang("v1a5_aizila_level", var_82_0)
		else
			itemObj.txtLevel.text = formatLuaLang("v1a5_aizila_level", balanceSp[i])
		end

		for j = 1, kRankMaxLv do
			local rankGO = itemObj["rankGO" .. j]

			gohelper.setActive(rankGO, i == 1 and j == rankLv - 1)
		end
	end
end

return RougeDifficultyView
