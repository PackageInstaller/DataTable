-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView3_3.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView3_3", package.seeall)

local HandbookSkinSuitDetailView3_3 = class("HandbookSkinSuitDetailView3_3", HandbookSkinSuitDetailViewBase)
local dragSensitivity = 1
local slideDuration = 0.2
local authoredBaseXCache = {}

function HandbookSkinSuitDetailView3_3:onInitView()
	self._skinItemRoot = gohelper.findChild(self.viewGO, "#go_scroll/#go_storyStages")
	self._goStoryStages = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages")
	self._viewAnimator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._bgTrans = self._goStoryStages.transform
	self._skinItemGo = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages/#go_handbookskinitem")
	self._festivalItemGo = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages/LineItem")
	self._goscroll = gohelper.findChild(self.viewGO, "scroll")
	self._scroll = SLFramework.UGUI.UIDragListener.Get(self._goscroll)
	self._scrollClick = SLFramework.UGUI.UIClickListener.Get(self._goscroll)
	self._scrollRect = gohelper.findChildScrollRect(self.viewGO, "#go_scroll")
	self._goCardStages = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookSkinSuitDetailView3_3:_editableInitView()
	self._scrollValue = 0
	self._scrollRectWrap = SLFramework.UGUI.ScrollRectWrap.Get(self._goscroll)
end

function HandbookSkinSuitDetailView3_3:addEvents()
	self.addEventCb(self, HandbookController.instance, HandbookEvent.OnClickFestivalSkinCard, self._onClickCardItem, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onViewOpenedFinish, self)
	self._scroll:AddDragBeginListener(self._onScrollDragBegin, self)
	self._scroll:AddDragEndListener(self._onScrollDragEnd, self)
	self._scroll:AddDragListener(self._onScrollDragging, self)
	self._scrollClick:AddClickListener(self._onScrollClick, self)
end

function HandbookSkinSuitDetailView3_3:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onViewOpenedFinish, self)
	self._scroll:RemoveDragBeginListener()
	self._scroll:RemoveDragEndListener()
	self._scroll:RemoveDragListener()
	self._scrollClick:RemoveClickListener()
end

function HandbookSkinSuitDetailView3_3:_onScrollClick(param, eventData)
	if self._dragging then
		return
	end

	if not self._raycastResults then
		self._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
		self._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	end

	self._pointerEventData.position = UnityEngine.Input.mousePosition

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(self._pointerEventData, self._raycastResults)

	local current = self._goscroll
	local iter = self._raycastResults:GetEnumerator()

	while iter:MoveNext() do
		local raycastResult = iter.Current
		local go = raycastResult.gameObject

		if go ~= current then
			local btn = go:GetComponent(typeof(UnityEngine.UI.Button))

			if not gohelper.isNil(btn) then
				btn:OnPointerClick(self._pointerEventData)
			end
		end
	end
end

function HandbookSkinSuitDetailView3_3:_onScrollDragBegin(param, eventData)
	self.scrollDragPos = eventData.position
	self._dragging = true
end

function HandbookSkinSuitDetailView3_3:_onScrollDragging(param, eventData)
	self.scrollDragPos = self.scrollDragPos or eventData.position

	local moveOffset = eventData.position - self.scrollDragPos

	self.scrollDragPos = eventData.position

	if moveOffset.x ~= 0 and self._cardSpacing and self._cardSpacing ~= 0 then
		self._scrollValue = self._scrollValue - moveOffset.x / self._cardSpacing * dragSensitivity

		self:_applyCardLayout()
	end
end

function HandbookSkinSuitDetailView3_3:_onScrollDragEnd(param, eventData)
	self._dragging = false

	self:_slideScrollTo(self:_roundScroll())
end

function HandbookSkinSuitDetailView3_3:_bindCardSkin(nodeIdx)
	local item = self._cardItems[nodeIdx]

	item:refreshItem(self._skinIdList[nodeIdx + 1])
	item:refreshDestivalData(self._destivalDataList[nodeIdx + 1])
end

function HandbookSkinSuitDetailView3_3:_applyCardLayout()
	local M = self._showCardNum
	local half = M / 2

	for nodeIdx = 0, M - 1 do
		local vp = self._cardVP[nodeIdx]

		while vp <= self._scrollValue - half do
			vp = vp + M
		end

		while vp > self._scrollValue + half do
			vp = vp - M
		end

		self._cardVP[nodeIdx] = vp

		local x = self._centerX + (vp - self._scrollValue) * self._cardSpacing
		local tr = self._cardItemGos[nodeIdx].transform
		local lp = tr.localPosition

		transformhelper.setLocalPos(tr, x, lp.y, lp.z)
	end
end

function HandbookSkinSuitDetailView3_3:_roundScroll()
	return math.floor(self._scrollValue + 0.5)
end

function HandbookSkinSuitDetailView3_3:_slideScrollTo(targetScroll)
	UIBlockMgr.instance:startBlock(UIBlockKey.WaitItemAnimeDone)

	self._slideTargetScroll = targetScroll

	if self._scrollTweenId then
		ZProj.TweenHelper.KillById(self._scrollTweenId)
	end

	self._scrollTweenId = ZProj.TweenHelper.DOTweenFloat(self._scrollValue, targetScroll, slideDuration, self._onScrollTweenUpdate, nil, self)

	TaskDispatcher.cancelTask(self._onScrollSlideDone, self)
	TaskDispatcher.runDelay(self._onScrollSlideDone, self, slideDuration)
end

function HandbookSkinSuitDetailView3_3:_onScrollTweenUpdate(value)
	self._scrollValue = value

	self:_applyCardLayout()
end

function HandbookSkinSuitDetailView3_3:_onScrollSlideDone()
	self._scrollValue = self._slideTargetScroll or self._scrollValue

	self:_applyCardLayout()
	self:UpdateSkinItemSelectedState()
	self:_checkVisibleItemsUnlockVx()
	UIBlockMgr.instance:endBlock(UIBlockKey.WaitItemAnimeDone)
end

function HandbookSkinSuitDetailView3_3:_onClickCardItem(nodeIdx, skinId)
	if not self._cardVP[nodeIdx] then
		return
	end

	local clickedVp = self._cardVP[nodeIdx]
	local centerVp = self:_roundScroll()

	if clickedVp == centerVp then
		if skinId and skinId ~= 0 then
			local skinCfg = SkinConfig.instance:getSkinCo(skinId)

			if not skinCfg then
				return
			end

			CharacterController.instance:openCharacterSkinView({
				handbook = true,
				storyMode = true,
				heroId = skinCfg.characterId,
				skin = skinCfg.id,
				skinSuitId = self._skinSuitId
			})
		end

		return
	end

	self:_slideScrollTo(clickedVp)
end

function HandbookSkinSuitDetailView3_3:onOpen()
	logNormal(string.format("[Handbook] onOpen time: %.3f, viewName: %s", Time.realtimeSinceStartup, tostring(self.viewContainer.viewName)))

	local viewParam = self.viewParam

	self._skinSuitId = viewParam and viewParam.skinThemeGroupId
	self._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(self._skinSuitId)

	local skinIdStr = self._skinSuitCfg.skinContain
	local destivalStr = self._skinSuitCfg.festivalParams

	self._skinIdList = string.splitToNumber(skinIdStr, "|")
	self._cardCount = #self._skinIdList
	self._destivalDataList = string.split(destivalStr, "|")

	self._viewAnimator:Play(UIAnimationName.Click, 0, 1)
	self:_getPhotoRootGo(#self._skinIdList)
	self:_refreshSkinItems()

	local hasNewRedDot = HandbookController.instance:isHandbookSkinSuitNewRedDotShow(self._skinSuitId)

	if hasNewRedDot then
		self:_scrollToFirstUnlockRedDotSkin()
		HandbookController.instance:markHandbookSkinNewRedDotShow(self._skinSuitId)
	end
end

function HandbookSkinSuitDetailView3_3:_scrollToFirstUnlockRedDotSkin()
	if not self._skinItemList then
		return
	end

	local targetNodeIdx

	for i = 1, #self._skinItemList do
		local skinItem = self._skinItemList[i]

		if skinItem and skinItem._skinId and skinItem._skinId ~= 0 and HandbookController.instance:isHandbookSkinUnlockRedDotShow(skinItem._skinId) then
			targetNodeIdx = i - 1

			break
		end
	end

	if not targetNodeIdx then
		return
	end

	self:_slideScrollTo(targetNodeIdx)
end

function HandbookSkinSuitDetailView3_3:_refreshSkinItems()
	self._skinItemList = {}
	self._cardItems = {}
	self._cardItemGos = {}
	self._cardBaseX = {}
	self._cardVP = {}

	local baseXCache = authoredBaseXCache[self._skinSuitId]
	local firstInit = baseXCache == nil

	if firstInit then
		baseXCache = {}
		authoredBaseXCache[self._skinSuitId] = baseXCache
	end

	local wantM = self._cardCount
	local M = 0

	for nodeIdx = 0, wantM - 1 do
		local go = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages/#go_handbookskinitem" .. nodeIdx)

		if gohelper.isNil(go) then
			break
		end

		gohelper.setActive(go, true)

		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, HandbookSkinItem3_3, self)

		item:setData(nodeIdx, self._skinSuitId, self._scrollRectWrap)

		self._cardItems[nodeIdx] = item
		self._cardItemGos[nodeIdx] = go

		if firstInit then
			baseXCache[nodeIdx] = go.transform.localPosition.x
		end

		self._cardBaseX[nodeIdx] = baseXCache[nodeIdx]
		self._cardVP[nodeIdx] = nodeIdx

		table.insert(self._skinItemList, item)

		M = M + 1
	end

	self._showCardNum = M

	local extra = M

	while true do
		local go = gohelper.findChild(self.viewGO, "#go_scroll/Viewport/#go_storyStages/#go_handbookskinitem" .. extra)

		if gohelper.isNil(go) then
			break
		end

		gohelper.setActive(go, false)

		extra = extra + 1
	end

	self._cardSpacing = self._cardBaseX[1] - self._cardBaseX[0]
	self._centerSlot = math.floor((M - 1) / 2)
	self._centerX = self._cardBaseX[self._centerSlot]
	self._scrollValue = self._centerSlot

	for nodeIdx = 0, M - 1 do
		self:_bindCardSkin(nodeIdx)
	end

	self:_applyCardLayout()
	self:UpdateSkinItemSelectedState()
end

function HandbookSkinSuitDetailView3_3:UpdateSkinItemSelectedState()
	local centerVp = self:_roundScroll()

	for nodeIdx = 0, self._showCardNum - 1 do
		self._cardItems[nodeIdx]:refreshSelectedState(self._cardVP[nodeIdx] == centerVp)
	end
end

function HandbookSkinSuitDetailView3_3:onClose()
	TaskDispatcher.cancelTask(self._onScrollSlideDone, self)

	if self._scrollTweenId then
		ZProj.TweenHelper.KillById(self._scrollTweenId)

		self._scrollTweenId = nil
	end

	HandbookSkinSuitDetailViewBase.onClose(self)
	HandbookController.instance:dispatchEvent(HandbookEvent.OnExitToSuitGroup)
end

return HandbookSkinSuitDetailView3_3
