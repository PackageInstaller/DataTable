-- chunkname: @modules/logic/store/view/RecommendStoreView.lua

module("modules.logic.store.view.RecommendStoreView", package.seeall)

local RecommendStoreView = class("RecommendStoreView", BaseView)

RecommendStoreView.AutoToNextTime = 4

function RecommendStoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagerecommend = gohelper.findChildSingleImage(self.viewGO, "subViewContainer/#simage_recommend")
	self._gomonthcard = gohelper.findChild(self.viewGO, "subViewContainer/#go_monthcard")
	self._gostorecategoryitem = gohelper.findChild(self.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	self._categorycontentTrans = gohelper.findChild(self.viewGO, "top/scroll_category/viewport/categorycontent").transform
	self._categoryscroll = gohelper.findChild(self.viewGO, "top/scroll_category")
	self._categoryscrollTrs = self._categoryscroll.transform
	self._categoryscrollRect = gohelper.findChildScrollRect(self.viewGO, "top/scroll_category")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RecommendStoreView:addEvents()
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnbubbleLeft:AddClickListener(self._btnbubbleLeftOnClick, self)
	self._btnbubbleRight:AddClickListener(self._btnbubbleRightOnClick, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StopRecommendViewAuto, self._stopAutoChange, self)
end

function RecommendStoreView:removeEvents()
	self._btnright:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnbubbleLeft:RemoveClickListener()
	self._btnbubbleRight:RemoveClickListener()
end

function RecommendStoreView:_onClickRecommend()
	if self._selectThirdTabId ~= 0 then
		if not self._selectThirdTabId then
			local tabId = self._selectSecondTabId

			if tabId ~= 0 then
				local co = StoreConfig.instance:getStoreRecommendConfig(tabId)

				if string.nilorempty(co.systemJumpCode) == false then
					StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
						[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
						[StatEnum.EventProperties.RecommendPageId] = co.id,
						[StatEnum.EventProperties.RecommendPageName] = co.name,
						[StatEnum.EventProperties.RecommendPageRank] = self:getIndexByTabId(tabId)
					})
					GameFacade.jumpByAdditionParam(co.systemJumpCode)
				end
			end
		end
	end
end

function RecommendStoreView:_editableInitView()
	self._tabIdRedDotFlagDict = {}

	gohelper.setActive(self._gostorecategoryitem, false)
	self._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_shangpindiban"))

	self._click = gohelper.getClick(self._simagerecommend.gameObject)

	gohelper.addUIClickAudio(self._simagerecommend.gameObject, AudioEnum.UI.play_ui_common_pause)

	self._categoryItemContainer = {}
	self._tabView = StoreTabViewGroup.New(4, "subViewContainer/#go_monthcard")
	self._tabView.viewGO = self.viewGO
	self._tabView.viewContainer = self.viewContainer
	self._tabView.viewName = self.viewName

	self._tabView:onInitView()

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._ignoreClick = false
	self._gosubViewContainer = gohelper.findChild(self.viewGO, "subViewContainer")
	self._btnleft = gohelper.findChildButton(self.viewGO, "subViewContainer/#btn_left")
	self._btnright = gohelper.findChildButton(self.viewGO, "subViewContainer/#btn_right")
	self._gobubbleLeft = gohelper.findChild(self.viewGO, "top/go_bubbleLeft")
	self._gobubbleRight = gohelper.findChild(self.viewGO, "top/go_bubbleRight")
	self._btnbubbleLeft = gohelper.findChildButtonWithAudio(self.viewGO, "top/go_bubbleLeft/btn_click")
	self._btnbubbleRight = gohelper.findChildButtonWithAudio(self.viewGO, "top/go_bubbleRight/btn_click")
	self._sliderGo = gohelper.findChild(self.viewGO, "#go_slider/selectitem")

	gohelper.setActive(self._sliderGo, false)
	gohelper.setActive(self._gobubbleLeft, false)
	gohelper.setActive(self._gobubbleRight, false)

	self._bubbleTbLeft = self:_createBubbleTb(self._gobubbleLeft, self._btnbubbleLeft)
	self._bubbleTbRight = self:_createBubbleTb(self._gobubbleRight, self._btnbubbleRight)
	self.animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function RecommendStoreView:_onDragBegin(param, pointerEventData)
	self._startPos = pointerEventData.position.x
	self._ignoreClick = false
end

function RecommendStoreView:_onDrag(param, pointerEventData)
	local curPos = pointerEventData.position.x
	local offPos = Mathf.Abs(self._startPos - curPos)

	self._ignoreClick = offPos > 300
end

function RecommendStoreView:_onDragEnd(param, pointerEventData)
	local curPos = pointerEventData.position.x
	local offPos = curPos - self._startPos
	local offPosAbs = Mathf.Abs(offPos)

	self._ignoreClick = offPosAbs > 300

	TaskDispatcher.runDelay(self._resetIgnoreClick, self, 0.1)

	if self._ignoreClick then
		local offIndex = offPos > 0 and -1 or 1

		self:_toNextTab(offIndex)
	end
end

function RecommendStoreView:_btnbubbleLeftOnClick()
	if self._leftRedDotTabId then
		StoreController.instance:enterRecommendStore(self._leftRedDotTabId)
		self:_switchTab(self._leftRedDotTabId)
		self:_moveToTabId(self._leftRedDotTabId)
	end
end

function RecommendStoreView:_btnbubbleRightOnClick()
	if self._rightRedDotTabId then
		StoreController.instance:enterRecommendStore(self._rightRedDotTabId)
		self:_switchTab(self._rightRedDotTabId)
		self:_moveToTabId(self._rightRedDotTabId)
	end
end

function RecommendStoreView:_onCategoryscrollValueChanged(value)
	self:_onRefreshBubbleRedDot()
end

function RecommendStoreView:_btnrightOnClick()
	self:_toNextTab(1)
end

function RecommendStoreView:_btnleftOnClick()
	self:_toNextTab(-1)
end

function RecommendStoreView:_toNextTab(offIndex)
	offIndex = offIndex or 1

	local newIndex = self._nowIndex + offIndex

	if newIndex <= 0 then
		newIndex = #self._categoryItemContainer
	elseif newIndex > #self._categoryItemContainer then
		newIndex = 1
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local categoryItemTable = self._categoryItemContainer[newIndex]
	local jumpTab = categoryItemTable.tabId

	self:_switchTab(jumpTab)
end

function RecommendStoreView:_switchTab(jumpTab)
	if self._selectSecondTabId ~= jumpTab and self._jumpTab == nil then
		self._jumpTab = jumpTab

		if self._selectThirdTabId ~= 0 then
			if not self._selectThirdTabId then
				local tabId = self._selectSecondTabId
				local co = StoreConfig.instance:getStoreRecommendConfig(tabId)

				if co.prefab > 0 then
					local curView = self._tabView._tabViews[co.prefab]

					if curView.switchClose then
						curView:switchClose(self._onSwitchCloseAnimDone, self)
					else
						self:_onSwitchCloseAnimDone()
					end
				else
					self.animatorPlayer:Play(UIAnimationName.Close, self._onSwitchCloseAnimDone, self)
				end

				TaskDispatcher.runDelay(self._onSwitchCloseAnimDone, self, 2)

				self._selectSecondTabId = jumpTab

				self:_refreshTabsItem()
			end
		end
	end
end

function RecommendStoreView:_onSwitchCloseAnimDone()
	TaskDispatcher.cancelTask(self._onSwitchCloseAnimDone, self)
	self:_refreshTabs(self._jumpTab)
	self:refreshRightPage()
	StoreController.instance:onSwitchTab(self._jumpTab)

	self._jumpTab = nil
end

function RecommendStoreView:_resetIgnoreClick()
	self._ignoreClick = false
end

function RecommendStoreView:onOpen()
	local monthCardInfo = StoreModel.instance:getMonthCardInfo()

	self._hasMonthCard = false

	if monthCardInfo ~= nil then
		local remainDay = monthCardInfo:getRemainDay()

		self._hasMonthCard = remainDay ~= StoreEnum.MonthCardStatus.NotPurchase
	end

	self._tabView:onOpen()
	self.addEventCb(self, StoreController.instance, StoreEvent.UpdatePackageStore, self._refreshTabsItem, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._refreshTabsItem, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.ChangeActivityStage, self._onRefreshRedDot, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.SetVisibleInternal, self._onSetVisibleInternal, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.SetAutoToNextPage, self._onSetAutoToNextPage, self)
	self._click:AddClickListener(self._onClickRecommend, self)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gosubViewContainer)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._categoryscrollRect:AddOnValueChanged(self._onCategoryscrollValueChanged, self)

	self._selectFirstTabId = self.viewContainer:getSelectFirstTabId()

	local jumpTabId = self.viewContainer:getJumpTabId()

	self:refreshUI(jumpTabId, true)
end

function RecommendStoreView:refreshUI(jumpTabId, openUpdate)
	self:_refreshTabs(jumpTabId, openUpdate)
end

function RecommendStoreView:_refreshTabs(selectTabId, openUpdate)
	TaskDispatcher.cancelTask(self._toNextTab, self)
	TaskDispatcher.runDelay(self._toNextTab, self, RecommendStoreView.AutoToNextTime)

	local preSelectSecondTabId = self._selectSecondTabId
	local preSelectThirdTabId = self._selectThirdTabId

	self._selectSecondTabId = selectTabId
	self._selectThirdTabId = 0

	local thirdConfig = StoreConfig.instance:getTabConfig(self._selectThirdTabId)
	local secondConfig = StoreConfig.instance:getTabConfig(self._selectSecondTabId)
	local firstConfig = StoreConfig.instance:getTabConfig(self.viewContainer:getSelectFirstTabId())

	if thirdConfig and not string.nilorempty(thirdConfig.showCost) then
		self.viewContainer:setCurrencyType(thirdConfig.showCost)
	elseif secondConfig and not string.nilorempty(secondConfig.showCost) then
		self.viewContainer:setCurrencyType(secondConfig.showCost)
	elseif firstConfig and not string.nilorempty(firstConfig.showCost) then
		self.viewContainer:setCurrencyType(firstConfig.showCost)
	else
		self.viewContainer:setCurrencyType(nil)
	end

	if not openUpdate and preSelectSecondTabId == self._selectSecondTabId and preSelectThirdTabId == self._selectThirdTabId then
		return
	end

	local storeIds = self:_refreshTabsItem()

	if #storeIds > 0 then
		StoreRpc.instance:sendGetStoreInfosRequest(storeIds)
	end

	self:refreshRightPage()
end

function RecommendStoreView:_refreshTabsItem()
	local showSecondTabConfigs, storeIds = StoreHelper.getRecommendStoreSecondTabConfig()

	self._showSecondTabConfigs = showSecondTabConfigs

	self:sortPage(showSecondTabConfigs)

	local findSecondTabId = false

	for _, co in ipairs(showSecondTabConfigs) do
		if co.id == self._selectSecondTabId then
			findSecondTabId = true

			break
		end
	end

	if not findSecondTabId then
		self._selectSecondTabId = showSecondTabConfigs[1].id
	end

	self._tabIdList = {}

	for i = 1, #showSecondTabConfigs do
		local tabCfg = showSecondTabConfigs[i]

		table.insert(self._tabIdList, tabCfg.id)
		self:_refreshSecondTabs(i, tabCfg)
		gohelper.setActive(self._categoryItemContainer[i].go, true)
		gohelper.setActive(self._categoryItemContainer[i].sliderGo, true)
	end

	gohelper.setActive(self._categoryItemContainer[#showSecondTabConfigs].go_line, false)

	for i = #showSecondTabConfigs + 1, #self._categoryItemContainer do
		self._categoryItemContainer[i].btn:RemoveClickListener()
		gohelper.destroy(self._categoryItemContainer[i].go)

		self._categoryItemContainer[i] = nil
	end

	local tarMaxX = -300 * (self._nowIndex - 5) - 50
	local tarMinX = -300 * (self._nowIndex - 1)
	local nowX = recthelper.getAnchorX(self._categorycontentTrans)

	if nowX < tarMinX then
		recthelper.setAnchorX(self._categorycontentTrans, tarMinX)
	elseif tarMaxX < nowX then
		recthelper.setAnchorX(self._categorycontentTrans, tarMaxX)
	end

	self:_onRefreshRedDot()

	return storeIds
end

function RecommendStoreView:_tabSortFunction(xConfig, yConfig)
	local xArr = string.splitToNumber(xConfig.adjustOrder, "#")
	local yArr = string.splitToNumber(yConfig.adjustOrder, "#")
	local xOrder = xConfig.order

	if self:_checkSortType(xArr) then
		xOrder = xArr[1]
	end

	return xOrder < ((self:_checkSortType(yArr) or nil) and yArr[1])
end

function RecommendStoreView:sortPage(tempConfigs)
	self:_cacheConfigGroupData(tempConfigs)
	table.sort(tempConfigs, function(a, b)
		return self:_tabSortGroupFunction(a, b)
	end)

	self._cacheConfigGroupDic = {}
	self._cacheConfigOrderDic = {}
end

function RecommendStoreView:_cacheConfigGroupData(list)
	self._cacheConfigGroupDic = {}
	self._cacheConfigOrderDic = {}

	if not list or #list <= 0 then
		return
	end

	for _, co in ipairs(list) do
		local group, order = StoreHelper.getRecommendStoreGroupAndOrder(co, true)

		self._cacheConfigGroupDic[co.id] = group
		self._cacheConfigOrderDic[co.id] = order
	end
end

function RecommendStoreView:_tabSortGroupFunction(xConfig, yConfig)
	local groupX = self._cacheConfigGroupDic[xConfig.id]
	local groupY = self._cacheConfigGroupDic[yConfig.id]

	if groupX == groupY then
		local orderX = self._cacheConfigOrderDic[xConfig.id]
		local orderY = self._cacheConfigOrderDic[yConfig.id]

		return orderX < orderY
	end

	return groupX < groupY
end

function RecommendStoreView:_trySwitchToMonthCard(config)
	if config.id == StoreEnum.RecommendSubStoreId.MonthCardId then
		return true
	end
end

function RecommendStoreView:_checkSortType(infos)
	local type = infos[2]

	if type == StoreEnum.AdjustOrderType.MonthCard and self._hasMonthCard then
		return true
	end
end

function RecommendStoreView:_refreshSecondTabs(index, secondTabConfig)
	local categoryItemTable = self._categoryItemContainer[index]

	categoryItemTable = categoryItemTable or self:initCategoryItemTable(index)
	categoryItemTable.tabConfig = secondTabConfig
	categoryItemTable.tabId = secondTabConfig.id
	categoryItemTable.txt_itemcn1.text = secondTabConfig.name
	categoryItemTable.txt_itemcn2.text = secondTabConfig.name
	categoryItemTable.txt_itemen1.text = secondTabConfig.nameEn
	categoryItemTable.txt_itemen2.text = secondTabConfig.nameEn

	local select = self._selectSecondTabId == secondTabConfig.id

	gohelper.setActive(self._categoryItemContainer[index].go_line, true)

	if select then
		self._nowIndex = index

		if self._categoryItemContainer[index - 1] then
			gohelper.setActive(self._categoryItemContainer[index - 1].go_line, false)
		end
	end

	gohelper.setActive(categoryItemTable.go_timelimit, not string.nilorempty(secondTabConfig.openTime) and not string.nilorempty(secondTabConfig.endTime))
	gohelper.setActive(categoryItemTable.go_unselected, not select)
	gohelper.setActive(categoryItemTable.go_sliderUnselected, not select)
	gohelper.setActive(categoryItemTable.go_selected, select)
	gohelper.setActive(categoryItemTable.go_sliderSelected, select)
end

function RecommendStoreView:initCategoryItemTable(index)
	local categoryItemTable = self:getUserDataTb_()

	categoryItemTable.go = gohelper.cloneInPlace(self._gostorecategoryitem, "item" .. index)
	categoryItemTable.go_unselected = gohelper.findChild(categoryItemTable.go, "go_unselected")
	categoryItemTable.go_selected = gohelper.findChild(categoryItemTable.go, "go_selected")
	categoryItemTable.go_timelimit = gohelper.findChild(categoryItemTable.go, "go_timellimit")
	categoryItemTable.go_reddot = gohelper.findChild(categoryItemTable.go, "#go_tabreddot1")
	categoryItemTable.go_reddotType1 = gohelper.findChild(categoryItemTable.go, "#go_tabreddot1/type1")
	categoryItemTable.go_reddotType5 = gohelper.findChild(categoryItemTable.go, "#go_tabreddot1/type5")
	categoryItemTable.txt_itemcn1 = gohelper.findChildText(categoryItemTable.go, "go_unselected/txt_itemcn1")
	categoryItemTable.txt_itemen1 = gohelper.findChildText(categoryItemTable.go, "go_unselected/txt_itemen1")
	categoryItemTable.txt_itemcn2 = gohelper.findChildText(categoryItemTable.go, "go_selected/txt_itemcn2")
	categoryItemTable.txt_itemen2 = gohelper.findChildText(categoryItemTable.go, "go_selected/txt_itemen2")
	categoryItemTable.go_childcategory = gohelper.findChild(categoryItemTable.go, "go_childcategory")
	categoryItemTable.go_childItem = gohelper.findChild(categoryItemTable.go, "go_childcategory/go_childitem")
	categoryItemTable.go_line = gohelper.findChild(categoryItemTable.go, "#go_line")
	categoryItemTable.btn = gohelper.getClickWithAudio(categoryItemTable.go, AudioEnum.UI.Play_UI_Universal_Click)
	categoryItemTable.tabId = 0
	categoryItemTable.sliderGo = gohelper.cloneInPlace(self._sliderGo, "item" .. index)
	categoryItemTable.go_sliderSelected = gohelper.findChild(categoryItemTable.sliderGo, "#go_lightstar")
	categoryItemTable.go_sliderUnselected = gohelper.findChild(categoryItemTable.sliderGo, "#go_nomalstar")

	categoryItemTable.btn:AddClickListener(function(categoryItemTable)
		local jumpTab = categoryItemTable.tabId

		StoreController.instance:enterRecommendStore(jumpTab)
		self:_switchTab(jumpTab)
	end, categoryItemTable)
	table.insert(self._categoryItemContainer, categoryItemTable)

	categoryItemTable.go_reddotTrs = categoryItemTable.go_reddot.transform
	categoryItemTable.goTrs = categoryItemTable.go.transform

	gohelper.setActive(categoryItemTable.go_childItem, false)

	return categoryItemTable
end

function RecommendStoreView:_createBubbleTb(go, btn)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb.animator = go:GetComponent(gohelper.Type_Animator)
	tb.btn = btn

	return tb
end

function RecommendStoreView:_setBubbleTbActive(tb, isActive)
	local isShow = isActive == true

	if tb.isShow ~= isShow then
		tb.isShow = isShow

		gohelper.setActive(tb.btn, isShow)

		tb.keepTime = Time.time + 0.3

		if isShow then
			gohelper.setActive(tb.go, isShow)
		end

		tb.animator:Play(isShow and "open" or "close")
	elseif tb.keepTime and tb.keepTime < Time.time then
		tb.keepTime = nil

		gohelper.setActive(tb.go, tb.isShow)
	end
end

function RecommendStoreView:_onRefreshRedDot()
	for _, v in pairs(self._categoryItemContainer) do
		local hasRed = false

		if StoreModel.instance:isTabFirstRedDotShow(v.tabId) then
			hasRed = true

			gohelper.setActive(v.go_reddot, true)
			gohelper.setActive(v.go_reddotType1, true)
			gohelper.setActive(v.go_reddotType5, false)
		elseif StoreController.instance:isNeedShowRedDotNewTag(v.tabConfig) and not StoreController.instance:isEnteredRecommendStore(v.tabConfig.id) then
			hasRed = true

			gohelper.setActive(v.go_reddot, true)
			gohelper.setActive(v.go_reddotType1, false)
			gohelper.setActive(v.go_reddotType5, true)
		else
			gohelper.setActive(v.go_reddot, false)
		end

		self._tabIdRedDotFlagDict[v.tabId] = hasRed
	end

	self:_onRefreshBubbleRedDot()
end

function RecommendStoreView:_onRefreshBubbleRedDot()
	if not self._isHasWaitRunLRRedDotTask then
		self._isHasWaitRunLRRedDotTask = true

		TaskDispatcher.runDelay(self._onRunLRRedDotTask, self, 0.1)
	end
end

function RecommendStoreView:_onRunLRRedDotTask()
	self._isHasWaitRunLRRedDotTask = false
	self._leftRedDotTabId = nil
	self._rightRedDotTabId = nil

	if not self._categoryscrollTrsLeftX or not self._categoryscrollTrsRightX then
		local width = recthelper.getWidth(self._categoryscrollTrs)
		local pivotX = self._categoryscrollTrs.pivot.x
		local leftPos = self._categoryscrollTrs:TransformPoint(Vector3(-width * pivotX, 0, 0))
		local rightPos = self._categoryscrollTrs:TransformPoint(Vector3(width * (1 - pivotX), 0, 0))

		self._categoryscrollTrsLeftX = leftPos.x
		self._categoryscrollTrsRightX = rightPos.x
	end

	for _, item in ipairs(self._categoryItemContainer) do
		if item and self._tabIdRedDotFlagDict[item.tabId] and not gohelper.isNil(item.go_reddotTrs) then
			local pos = item.go_reddotTrs.position
			local posX = pos.x

			if posX < self._categoryscrollTrsLeftX then
				self._leftRedDotTabId = item.tabId
			elseif not self._rightRedDotTabId and posX > self._categoryscrollTrsRightX then
				self._rightRedDotTabId = item.tabId
			end
		end

		if self._leftRedDotTabId and self._rightRedDotTabId then
			break
		end
	end

	self:_setBubbleTbActive(self._bubbleTbLeft, self._leftRedDotTabId ~= nil)
	self:_setBubbleTbActive(self._bubbleTbRight, self._rightRedDotTabId ~= nil)
end

function RecommendStoreView:_moveToTabId(tabId)
	local index = self:getIndexByTabId(tabId)
	local item = self._categoryItemContainer[index]

	if not item or gohelper.isNil(item.goTrs) then
		return
	end

	local contentWidth = recthelper.getWidth(self._categorycontentTrans)
	local scrollWith = recthelper.getWidth(self._categoryscrollTrs)
	local lizedWithd = contentWidth - scrollWith

	if lizedWithd <= 0 then
		return
	end

	local itemWidth = recthelper.getWidth(item.goTrs)
	local itemPosX = recthelper.getAnchorX(item.goTrs)
	local pivotX = item.goTrs.pivot.x
	local itemLPosX = itemPosX - itemWidth * pivotX

	self._categoryscrollRect.horizontalNormalizedPosition = itemLPosX / lizedWithd
end

function RecommendStoreView:refreshRightPage()
	if self._selectThirdTabId ~= 0 then
		if not self._selectThirdTabId then
			local tabId = self._selectSecondTabId
			local co = StoreConfig.instance:getStoreRecommendConfig(tabId)

			if co.prefab > 0 then
				gohelper.setActive(self._gomonthcard, true)
				gohelper.setActive(self._simagerecommend.gameObject, false)

				if self._tabView then
					local tabId = self._tabView:getCurTabId()
					local curView = self._tabView._tabViews[tabId]

					if curView then
						curView:stopAnimator()
					end
				end

				self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 4, co.prefab)
			else
				gohelper.setActive(self._gomonthcard, false)
				gohelper.setActive(self._simagerecommend.gameObject, true)
				self._simagerecommend:LoadImage(ResUrl.getStoreRecommend(co.res))

				self._animator.enabled = true

				self._animator:Play(UIAnimationName.Open, 0, 0)
				self._animator:Update(0)
			end
		end
	end
end

function RecommendStoreView:onClose()
	self.removeEventCb(self, StoreController.instance, StoreEvent.UpdatePackageStore, self._refreshTabsItem, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._refreshTabsItem, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.SetVisibleInternal, self._onSetVisibleInternal, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.SetAutoToNextPage, self._onSetAutoToNextPage, self)

	local tabId = self._tabView:getCurTabId()
	local curView = self._tabView._tabViews[tabId]

	if curView then
		curView:stopAnimator()
	end

	self._tabView:onClose()
	self._click:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._drag:RemoveDragListener()
	self._categoryscrollRect:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(self._toNextTab, self)

	self._ignoreClick = false

	self.animatorPlayer:Stop()

	self._jumpTab = nil
	self._isHasWaitRunLRRedDotTask = false

	TaskDispatcher.cancelTask(self._onSwitchCloseAnimDone, self)
	TaskDispatcher.cancelTask(self._resetIgnoreClick, self)
	TaskDispatcher.cancelTask(self._onRunLRRedDotTask, self, 0.1)
end

function RecommendStoreView:_onSetVisibleInternal(v)
	if v then
		TaskDispatcher.cancelTask(self._toNextTab, self)
		TaskDispatcher.runDelay(self._toNextTab, self, RecommendStoreView.AutoToNextTime)
	else
		TaskDispatcher.cancelTask(self._toNextTab, self)
	end
end

function RecommendStoreView:_onSetAutoToNextPage(auto)
	if auto then
		TaskDispatcher.cancelTask(self._toNextTab, self)
		TaskDispatcher.runDelay(self._toNextTab, self, RecommendStoreView.AutoToNextTime)
	else
		TaskDispatcher.cancelTask(self._toNextTab, self)
	end
end

function RecommendStoreView:onUpdateParam()
	self._selectFirstTabId = self.viewContainer:getSelectFirstTabId()

	local jumpTabId = self.viewContainer:getJumpTabId()

	self:refreshUI(jumpTabId)
end

function RecommendStoreView:onDestroyView()
	if self._categoryItemContainer and #self._categoryItemContainer > 0 then
		for i = 1, #self._categoryItemContainer do
			local categotyItem = self._categoryItemContainer[i]

			categotyItem.btn:RemoveClickListener()
		end
	end

	self._simagebg:UnLoadImage()
	self._simagerecommend:UnLoadImage()
	self._tabView:removeEvents()
	self._tabView:onDestroyView()
	TaskDispatcher.cancelTask(self._toNextTab, self)
	TaskDispatcher.cancelTask(self._onSwitchCloseAnimDone, self)
	TaskDispatcher.cancelTask(self._resetIgnoreClick, self)
end

function RecommendStoreView:_stopAutoChange()
	TaskDispatcher.cancelTask(self._toNextTab, self)
end

function RecommendStoreView:_playAutoChange()
	TaskDispatcher.cancelTask(self._toNextTab, self)
end

function RecommendStoreView:getIndexByTabId(tabId)
	return tabletool.indexOf(self._tabIdList, tabId) or 1
end

return RecommendStoreView
