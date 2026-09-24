-- chunkname: @modules/logic/college/view/milestone/CollegeMilestoneView.lua

module("modules.logic.college.view.milestone.CollegeMilestoneView", package.seeall)

local CollegeMilestoneView = class("CollegeMilestoneView", BaseView)
local csTweenHelper = ZProj.TweenHelper
local kFastScrollSpeed = 100
local kTweenSecond = 0.3

function CollegeMilestoneView:onInitView()
	self._goList = gohelper.findChild(self.viewGO, "root/#go_List")
	self._goDetail = gohelper.findChild(self.viewGO, "root/#go_Detail")
	self._scrollTheme = gohelper.findChildScrollRect(self.viewGO, "root/#go_List/scroll_horiList")
	self._goThemeContent = gohelper.findChild(self.viewGO, "root/#go_List/scroll_horiList/Viewport/content")
	self._btnRelation = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_List/#btn_Relation")
	self._goRelationRedDot = gohelper.findChild(self.viewGO, "root/#go_List/#btn_Relation/#go_RelationRedDot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeMilestoneView:addEvents()
	self._themeDrag = UIDragListenerHelper.New()

	self._themeDrag:createByScrollRect(self._scrollViewLimitScrollCmp)
	self._themeDrag:registerCallback(self._themeDrag.EventBegin, self._onDragBeginHandler, self)
	self._scrollTheme:AddOnValueChanged(self._onScrollValueChanged, self)
	self._btnRelation:AddClickListener(self._btnRelationOnClick, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.OnSelectTheme, self._onSelectTheme, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.MilestoneUpdate, self._onMilestoneUpdate, self)
end

function CollegeMilestoneView:removeEvents()
	self._btnRelation:RemoveClickListener()
	self._scrollTheme:RemoveOnValueChanged()
	self._themeDrag:onDestroyView()
end

function CollegeMilestoneView:_btnRelationOnClick()
	CollegeStatHelper.instance:statBtnClick(CollegeStatEnum.ViewName.Milestone, CollegeStatEnum.BtnName.Relation)
	CollegeController.instance:openCollegeRelationShipBoard()
end

function CollegeMilestoneView:_editableInitView()
	RedDotController.instance:addRedDot(self._goRelationRedDot, RedDotEnum.DotNode.CollegeRelation)
	self:_initScrollView()

	self._lastSelectedIndex = 1
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
end

function CollegeMilestoneView:_initScrollView()
	self._goScrollTheme = self._scrollTheme.gameObject
	self._scrollViewLimitScrollCmp = self._goScrollTheme:GetComponent(gohelper.Type_LimitedScrollRect)
	self._goContentHLayout = self._goThemeContent:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	self._tranScrollTheme = self._goScrollTheme.transform
	self._tranThemeContent = self._goThemeContent.transform
end

function CollegeMilestoneView:_onDragBeginHandler()
	self:_killTween()
end

function CollegeMilestoneView:_onScrollValueChanged()
	self:_tweenSelectItemsInBetween()

	if self:_isScrollSlowly() then
		if self._isPlayingSlideAudio then
			self._isPlayingSlideAudio = false

			CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.SlideMilestoneViewStop)
		end
	elseif not self._isPlayingSlideAudio then
		self._isPlayingSlideAudio = true

		CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.SlideMilestoneView)
	end
end

function CollegeMilestoneView:_onClickCloseCallback()
	if self._isShowDetail then
		self._isShowDetail = false

		self._animator:Play("switch_main", 0, 0)
		gohelper.setActive(self._goList, true)
		gohelper.setActive(self._goDetail, false)
		self:_tweenSelectItemsInBetween()

		return
	end

	self:closeThis()
end

function CollegeMilestoneView:onOpen()
	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.EnterMilestoneView)
	CollegeHelper.instance:setViewVisible(self.viewName, true, {
		ViewName.CollegeMainView
	})
	self.viewContainer.navigationView:setOverrideClose(self._onClickCloseCallback, self)

	self._mileStoneBox = CollegeModel.instance:getSceneMo().milestoneBox

	self:initThemeList()
	UpdateBeat:Add(self._update, self)
end

function CollegeMilestoneView:onOpenFinish()
	self:_onScreenResize()
	self:_onSelectIndex(self._firstFocusIndex or self._lastSelectedIndex)
end

function CollegeMilestoneView:initThemeList()
	local dataList = self:_getDataList()

	self._itemList = self._itemList or self:getUserDataTb_()

	for i, mo in ipairs(dataList) do
		local item = self._itemList[i]

		if not item then
			item = self:_createThemeItem(i)

			item:setIndex(i)
			table.insert(self._itemList, item)

			if not self._firstFocusIndex and mo.unlockCount > 0 then
				self._firstFocusIndex = i
			end
		end

		item:onUpdateMO(mo)
		item:onSelect(self._lastSelectedIndex == i)
	end
end

function CollegeMilestoneView:_setScaleAdjacent(index, isAnim)
	local item = self._itemList[index]

	if not item then
		return
	end

	local left = index - 1
	local lItem = self._itemList[left]

	if lItem then
		lItem:setScale(CollegeMilestoneThemeItem.ScalerSelectedAdjacent, isAnim)

		left = left - 1

		local llItem = self._itemList[left]

		if llItem then
			llItem:setScale(CollegeMilestoneThemeItem.ScalerNormal, isAnim)
		end
	end

	local right = index + 1
	local rItem = self._itemList[right]

	if rItem then
		rItem:setScale(CollegeMilestoneThemeItem.ScalerSelectedAdjacent, isAnim)

		right = right + 1

		local rrItem = self._itemList[right]

		if rrItem then
			rrItem:setScale(CollegeMilestoneThemeItem.ScalerNormal, isAnim)
		end
	end
end

function CollegeMilestoneView:_createThemeItem(index)
	local itemClass = CollegeMilestoneThemeItem
	local go = self:getResInst(CollegeEnum.PrefabPath.MilestoneThemeItem, self._goThemeContent, index)

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass, {
		viewContainer = self.viewContainer
	})
end

function CollegeMilestoneView:_getDataList()
	self._dataList = self._dataList or self.viewContainer:getThemeList()

	return self._dataList
end

function CollegeMilestoneView:_getItemList()
	if not self._itemList then
		self:_refreshList()
	end

	return self._itemList
end

function CollegeMilestoneView:_getDataListCount()
	return #self:_getDataList()
end

function CollegeMilestoneView:_validateIndex(index)
	local count = self:_getDataListCount()

	return GameUtil.clamp(index, 1, count)
end

function CollegeMilestoneView:_contentPosX()
	return recthelper.getAnchorX(self.viewContainer:getScrollContentTranform())
end

function CollegeMilestoneView:_contentAbsPosX()
	local contentPosX = self:_contentPosX()

	return (contentPosX <= 0 or nil) and (-contentPosX or 0)
end

function CollegeMilestoneView:_getIndexFactorInbetween()
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

function CollegeMilestoneView:_tweenSelectItemsInBetween()
	local nearIndex, nearFactor, farIndex, farFactor = self:_getIndexFactorInbetween()
	local nearItem = self._itemList[nearIndex]
	local farItem = self._itemList[farIndex]

	nearItem:setScale01(nearFactor)
	farItem:setScale01(farFactor)

	for i, v in ipairs(self._itemList) do
		if i ~= nearIndex and i ~= farIndex then
			v:setScale01(0)
		end
	end
end

function CollegeMilestoneView:_killTween()
	GameUtil.onDestroyViewMember_TweenId(self, "_contentPosXTweenId")
end

function CollegeMilestoneView:_calcContentWidth()
	return self._goContentHLayout.preferredWidth
end

function CollegeMilestoneView:_getViewportW()
	return recthelper.getWidth(self._tranScrollTheme)
end

function CollegeMilestoneView:_getViewportH()
	return recthelper.getHeight(self._tranScrollTheme)
end

function CollegeMilestoneView:_getViewportWH()
	return self:_getViewportW(), self:_getViewportH()
end

function CollegeMilestoneView:_getMaxScrollX()
	local viewportW = self:_getViewportW()
	local maxContentW = self:_calcContentWidth()

	return math.max(0, maxContentW - viewportW)
end

function CollegeMilestoneView:_calcFocusIndexPosX(index)
	local posX = 0
	local maxScrollX = self:_getMaxScrollX()

	if index <= 1 then
		return posX, maxScrollX
	end

	local item = self._itemList[index]
	local startOffset = self._goContentHLayout.padding.left
	local w = self.viewContainer:getListScrollParam_cellSize()
	local halfW = w * 0.5

	posX = item:getPos() - halfW - startOffset

	return posX, maxScrollX
end

function CollegeMilestoneView:_animFocusIndex(index, callback, callbackObj)
	self:_killTween()

	local toPosX = -self:_calcFocusIndexPosX(index)

	self._contentPosXTweenId = csTweenHelper.DOAnchorPosX(self.viewContainer:getScrollContentTranform(), toPosX, kTweenSecond, callback, callbackObj, nil, EaseType.OutQuad)
end

function CollegeMilestoneView:_scrollVelocityX()
	if not self._scrollViewLimitScrollCmp then
		return nil
	end

	return self._scrollViewLimitScrollCmp.velocity.x
end

function CollegeMilestoneView:_isScrollSlowly()
	local velocity = self:_scrollVelocityX()

	if not velocity then
		return false
	end

	return math.abs(velocity) < kFastScrollSpeed
end

function CollegeMilestoneView:_update()
	if not self._themeDrag:isEndedDrag() then
		return
	end

	if self:_isScrollSlowly() then
		self._themeDrag:clear()

		local nearIndex = self:_getIndexFactorInbetween()

		self:_onSelectIndex(nearIndex)
	end
end

function CollegeMilestoneView:_onSelectIndex(index, callback, callbackObj)
	if self._lastSelectedIndex == index then
		self:_animFocusIndex(index, callback, callbackObj)

		return
	end

	if self._lastSelectedIndex then
		local lastItem = self._itemList[self._lastSelectedIndex]

		lastItem:onSelect(false)
	end

	local curItem = self._itemList[index]

	curItem:onSelect(true)
	self:_setScaleAdjacent(index, true)

	self._lastSelectedIndex = index

	self:_animFocusIndex(index, callback, callbackObj)
end

function CollegeMilestoneView:_setActiveBlock(isActive)
	gohelper.setActive(self._goblock, isActive)

	if not isActive then
		self:_setActiveOverviewTips(false)
		self:_setActiveBalanceTips(false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190316)
	end
end

function CollegeMilestoneView:_calcLeftRightOffset()
	local width = self:_getViewportW()
	local listScrollParam = self.viewContainer:getListScrollParam()
	local cellWidth = listScrollParam.cellWidth

	return Mathf.Round(width * 0.5 - cellWidth * 0.5)
end

function CollegeMilestoneView:_onScreenResize()
	local offset = self:_calcLeftRightOffset()

	self._goContentHLayout.padding.left = offset
	self._goContentHLayout.padding.right = offset

	self.viewContainer:rebuildLayout()
end

function CollegeMilestoneView:_calcSpaceOffset()
	local listScrollParam = self.viewContainer:getListScrollParam()
	local width = self:_getViewportW()
	local cellWidth = listScrollParam.cellWidth
	local startSpace = listScrollParam.startSpace
	local res = width * 0.5 - cellWidth * 0.5 - startSpace

	return math.max(0, res)
end

function CollegeMilestoneView:_onMilestoneUpdate()
	self:initThemeList()
end

function CollegeMilestoneView:_onSelectTheme(themeIndex)
	if self._lastSelectedIndex == themeIndex then
		self._isShowDetail = true

		self._animator:Play("switch_detail", 0, 0)
		gohelper.setActive(self._goList, false)
		gohelper.setActive(self._goDetail, true)
		CollegeStatHelper.instance:statBtnClick(CollegeStatEnum.ViewName.Milestone, self._dataList[themeIndex].co.title)
		CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.EnterMilestoneDetail)

		return
	end

	UIBlockHelper.instance:startBlock(self.viewName, 0.5, self.viewName)
	self:_onSelectIndex(themeIndex)
end

function CollegeMilestoneView:onClose()
	UpdateBeat:Remove(self._update, self)
	CollegeHelper.instance:setViewVisible(self.viewName, false)
	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.SlideMilestoneViewStop)
end

return CollegeMilestoneView
