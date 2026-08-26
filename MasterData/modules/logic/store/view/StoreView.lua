-- chunkname: @modules/logic/store/view/StoreView.lua

module("modules.logic.store.view.StoreView", package.seeall)

local StoreView = class("StoreView", BaseView)

function StoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_store/bg/#simage_bg")
	self._simagelefticon = gohelper.findChildSingleImage(self.viewGO, "#go_store/bg/#simage_lefticon")
	self._simagerighticon = gohelper.findChildSingleImage(self.viewGO, "#go_store/bg/#simage_righticon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreView:addEvents()
	return
end

function StoreView:removeEvents()
	return
end

function StoreView:_editableInitView()
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._gobigTypeItem = gohelper.findChild(self.viewGO, "scroll_bigType/viewport/content/#go_bigTypeItem")
	self._gobigTypeItem1 = gohelper.findChild(self.viewGO, "scroll_bigType/viewport/content/#go_bigTypeItem1")
	self._bigTypeItemContent = gohelper.findChild(self.viewGO, "scroll_bigType/viewport/content").transform

	self._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("full/shangcheng_bj"))
	self._simagelefticon:LoadImage(ResUrl.getStoreBottomBgIcon("bg_leftdown2"))
	self._simagerighticon:LoadImage(ResUrl.getStoreBottomBgIcon("bg_right3"))

	self._scrollbigType = gohelper.findChildScrollRect(self.viewGO, "scroll_bigType")
	self._tabsContainer = {}

	local num = #StoreModel.instance:getFirstTabs(true, true)

	for i = 1, num do
		local tabTable = self:getUserDataTb_()

		tabTable.go = gohelper.cloneInPlace(self._gobigTypeItem, "bigTypeItem" .. i)
		tabTable.reddot = gohelper.findChild(tabTable.go, "go_tabreddot")
		tabTable.reddotNormalType = gohelper.findChild(tabTable.go, "go_tabreddot/type1")
		tabTable.reddotActType = gohelper.findChild(tabTable.go, "go_tabreddot/type9")
		tabTable.goselected = gohelper.findChild(tabTable.go, "go_selected")
		tabTable.iconselected = gohelper.findChildImage(tabTable.goselected, "itemicon2")
		tabTable.gounselected = gohelper.findChild(tabTable.go, "go_unselected")
		tabTable.iconunselected = gohelper.findChildImage(tabTable.gounselected, "itemicon1")
		tabTable.txtnamecn1 = gohelper.findChildText(tabTable.go, "go_selected/txt_itemcn2")
		tabTable.txtnameen1 = gohelper.findChildText(tabTable.go, "go_selected/txt_itemen2")
		tabTable.txtnamecn2 = gohelper.findChildText(tabTable.go, "go_unselected/txt_itemcn1")
		tabTable.txtnameen2 = gohelper.findChildText(tabTable.go, "go_unselected/txt_itemen1")
		tabTable.clickArea = gohelper.findChild(tabTable.go, "clickArea")
		tabTable.godeadline = gohelper.findChild(tabTable.go, "go_deadline")
		tabTable.godeadlineEffect = gohelper.findChild(tabTable.godeadline, "#effect")
		tabTable.txttime = gohelper.findChildText(tabTable.godeadline, "#txt_time")
		tabTable.txtformat = gohelper.findChildText(tabTable.godeadline, "#txt_time/#txt_format")
		tabTable.imagetimebg = gohelper.findChildImage(tabTable.godeadline, "timebg")
		tabTable.imagetimeicon = gohelper.findChildImage(tabTable.godeadline, "#txt_time/timeicon")
		tabTable.btn = gohelper.getClickWithAudio(tabTable.clickArea, AudioEnum.UI.play_ui_plot_common)

		tabTable.btn:AddClickListener(function(tabTable)
			local jumpTab = tabTable.tabId

			self:_refreshTabs(jumpTab)
			StoreController.instance:onSwitchTab(jumpTab)
		end, tabTable)
		table.insert(self._tabsContainer, tabTable)
	end

	local tabTable = self:getUserDataTb_()

	tabTable.go = self._gobigTypeItem1
	tabTable.reddot = gohelper.findChild(tabTable.go, "go_tabreddot")
	tabTable.goselected = gohelper.findChild(tabTable.go, "go_selected")
	tabTable.iconselected = gohelper.findChildImage(tabTable.goselected, "itemicon2")
	tabTable.gounselected = gohelper.findChild(tabTable.go, "go_unselected")
	tabTable.iconunselected = gohelper.findChildImage(tabTable.gounselected, "itemicon1")
	tabTable.txtnamecn1 = gohelper.findChildText(tabTable.go, "go_selected/txt_itemcn2")
	tabTable.txtnameen1 = gohelper.findChildText(tabTable.go, "go_selected/txt_itemen2")
	tabTable.txtnamecn2 = gohelper.findChildText(tabTable.go, "go_unselected/txt_itemcn1")
	tabTable.txtnameen2 = gohelper.findChildText(tabTable.go, "go_unselected/txt_itemen1")
	tabTable.clickArea = gohelper.findChild(tabTable.go, "clickArea")
	tabTable.btn = gohelper.getClickWithAudio(tabTable.clickArea, AudioEnum.UI.play_ui_plot_common)

	tabTable.btn:AddClickListener(function(tabTable)
		local jumpTab = tabTable.tabId

		self:_refreshTabs(jumpTab)
		StoreController.instance:onSwitchTab(jumpTab)
	end, tabTable)

	self._tabTableSP1 = tabTable

	gohelper.setActive(self._gobigTypeItem, false)
	gohelper.setActive(self._gobigTypeItem1, false)
end

function StoreView:_refreshTabs(selectTabId, jumpGoodsId)
	StoreController.instance:readTab(selectTabId)

	local tabConfigs

	if StoreModel.instance:isTabOpen(selectTabId) == false then
		jumpGoodsId = nil
		tabConfigs = StoreModel.instance:getFirstTabs(true, true)
		selectTabId = tabConfigs[1].id
	end

	local isFirstTimeEnter = self._selectFirstTabId == nil
	local preSelectFirstTabId = self._selectFirstTabId

	self._selectFirstTabId = StoreEnum.DefaultTabId
	self._selectFirstTabId = StoreModel.instance:jumpTabIdToSelectTabId(selectTabId)

	self.viewContainer:selectTabView(selectTabId, self._selectFirstTabId, jumpGoodsId, preSelectFirstTabId == self._selectFirstTabId)

	tabConfigs = tabConfigs or StoreModel.instance:getFirstTabs(true, true)

	local newTotalTabCount = math.min(#tabConfigs, #self._tabsContainer)

	if preSelectFirstTabId == self._selectFirstTabId and self._totalTabCount == newTotalTabCount then
		return
	end

	self._totalTabCount = newTotalTabCount

	if tabConfigs and #tabConfigs > 0 then
		self._needCountdown = false

		for i = 1, math.min(#tabConfigs, #self._tabsContainer) do
			local tabConfig = tabConfigs[i]
			local tabTable = self._tabsContainer[i]

			if tabConfig.id == StoreEnum.DefaultTabId then
				tabTable = self._tabTableSP1

				local sibling = gohelper.getSibling(self._tabsContainer[i].go)

				gohelper.setSibling(tabTable.go, sibling)
				gohelper.setActive(self._tabsContainer[i].go, false)
			end

			tabTable.tabId = tabConfig.id

			local select = tabConfig.id == self._selectFirstTabId

			tabTable.txtnamecn1.text = tabConfig.name
			tabTable.txtnamecn2.text = tabConfig.name
			tabTable.txtnameen1.text = tabConfig.nameEn
			tabTable.txtnameen2.text = tabConfig.nameEn

			UISpriteSetMgr.instance:setStoreGoodsSprite(tabTable.iconselected, tabTable.tabId)
			UISpriteSetMgr.instance:setStoreGoodsSprite(tabTable.iconunselected, tabTable.tabId)
			gohelper.setActive(tabTable.goselected, select)
			gohelper.setActive(tabTable.gounselected, not select)
			gohelper.setActive(tabTable.go, true)
			self:refreshTimeDeadline(tabConfig, tabTable)

			if select then
				self:_handleTabSet(i, isFirstTimeEnter)
			end
		end

		self:checkCountdownStatus()

		for i = #tabConfigs + 1, #self._tabsContainer do
			gohelper.setActive(self._tabsContainer[i].go, false)
		end
	else
		for i = 1, #self._tabsContainer do
			gohelper.setActive(self._tabsContainer[i].go, false)
		end
	end
end

function StoreView:refreshTimeDeadline(tabConfig, tabItem)
	if not tabItem.godeadline or gohelper.isNil(tabItem.godeadline) or tabConfig == nil then
		return
	end

	local deadlineHasDay = false
	local needShowReddot = StoreModel.instance:isTabMainRedDotShow(tabConfig.id)
	local needCountDown = false

	if tabConfig.id == StoreEnum.StoreId.SummonExchange then
		if tabConfig.id ~= self._selectFirstTabId and not needShowReddot then
			local deadlineTimeSec = StoreHelper.getRemainExpireTimeDeep(tabConfig)

			if deadlineTimeSec and deadlineTimeSec > 0 and deadlineTimeSec <= TimeUtil.OneDaySecond * 7 then
				gohelper.setActive(tabItem.godeadline, true)
				gohelper.setActive(tabItem.txttime.gameObject, true)

				tabItem.txttime.text, tabItem.txtformat.text, deadlineHasDay = TimeUtil.secondToRoughTime(math.floor(deadlineTimeSec), true)

				UISpriteSetMgr.instance:setCommonSprite(tabItem.imagetimebg, deadlineHasDay and "daojishi_01" or "daojishi_02")
				UISpriteSetMgr.instance:setCommonSprite(tabItem.imagetimeicon, deadlineHasDay and "daojishiicon_01" or "daojishiicon_02")
				SLFramework.UGUI.GuiHelper.SetColor(tabItem.txttime, deadlineHasDay and "#98D687" or "#E99B56")
				SLFramework.UGUI.GuiHelper.SetColor(tabItem.txtformat, deadlineHasDay and "#98D687" or "#E99B56")
				gohelper.setActive(tabItem.godeadlineEffect, not deadlineHasDay)

				needCountDown = true
			end
		end
	elseif tabConfig.id == StoreEnum.StoreId.DecorateStore then
		if tabConfig.id ~= self._selectFirstTabId and not needShowReddot then
			local deadlineTimeSec = StoreHelper.getRemainExpireTimeDeepByStoreId(tabConfig.id)

			if deadlineTimeSec and deadlineTimeSec > 0 and deadlineTimeSec < TimeUtil.OneWeekSecond then
				gohelper.setActive(tabItem.godeadline, true)
				gohelper.setActive(tabItem.txttime.gameObject, true)

				tabItem.txttime.text, tabItem.txtformat.text, deadlineHasDay = TimeUtil.secondToRoughTime(math.floor(deadlineTimeSec), true)

				UISpriteSetMgr.instance:setCommonSprite(tabItem.imagetimebg, deadlineHasDay and "daojishi_01" or "daojishi_02")
				UISpriteSetMgr.instance:setCommonSprite(tabItem.imagetimeicon, deadlineHasDay and "daojishiicon_01" or "daojishiicon_02")
				SLFramework.UGUI.GuiHelper.SetColor(tabItem.txttime, deadlineHasDay and "#98D687" or "#E99B56")
				SLFramework.UGUI.GuiHelper.SetColor(tabItem.txtformat, deadlineHasDay and "#98D687" or "#E99B56")
				gohelper.setActive(tabItem.godeadlineEffect, not deadlineHasDay)

				needCountDown = true
			end
		end
	elseif StoreEnum.StoreId.Skin == tabConfig.storeId then
		local deadlineTimeSec = 0

		if not needShowReddot then
			deadlineTimeSec = StoreHelper.getRemainExpireTimeByStoreId(tabConfig.storeId)

			if deadlineTimeSec > TimeUtil.OneWeekSecond then
				deadlineTimeSec = 0
			end
		end

		if deadlineTimeSec > 0 then
			gohelper.setActive(tabItem.godeadline, true)
			gohelper.setActive(tabItem.txttime.gameObject, true)

			tabItem.txttime.text, tabItem.txtformat.text, deadlineHasDay = TimeUtil.secondToRoughTime(math.floor(deadlineTimeSec), true)

			UISpriteSetMgr.instance:setCommonSprite(tabItem.imagetimebg, deadlineHasDay and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(tabItem.imagetimeicon, deadlineHasDay and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(tabItem.txttime, deadlineHasDay and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(tabItem.txtformat, deadlineHasDay and "#98D687" or "#E99B56")
			gohelper.setActive(tabItem.godeadlineEffect, not deadlineHasDay)

			needCountDown = true
		else
			gohelper.setActive(tabItem.godeadline, false)
			gohelper.setActive(tabItem.txttime.gameObject, false)
		end
	else
		gohelper.setActive(tabItem.godeadline, false)
		gohelper.setActive(tabItem.txttime.gameObject, false)
	end

	self._needCountdown = needCountDown
end

function StoreView:onOpen()
	if self.viewParam then
		if not self.viewParam.jumpTab then
			local jumpTab = self:_getDefaultTabId()

			if not StoreModel.instance:isTabOpen(jumpTab) then
				jumpTab = self:_getDefaultTabId()
			end

			self:_refreshTabs(jumpTab, self.viewParam.jumpGoodsId)
			self:_onRefreshRedDot()
			TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._OnDailyRefresh, self)
			self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._onRefreshRedDot, self)
			self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._onStoreInfoChanged, self)
			self.addEventCb(self, StoreController.instance, StoreEvent.UpdatePackageStore, self._onRefreshRedDot, self)
			self.addEventCb(self, SignInController.instance, SignInEvent.OnReceiveSupplementMonthCardReply, self.refreshMainTabRedDot, self)
			self.addEventCb(self, StoreController.instance, StoreEvent.PlayShowStoreAnim, self._onPlayStoreInAnim, self)
			self.addEventCb(self, StoreController.instance, StoreEvent.PlayHideStoreAnim, self._onPlayStoreOutAnim, self)
			StoreController.instance:onSwitchTab(jumpTab)
			self.addEventCb(self, self.viewContainer, StoreEvent.SkinGoodsItemChanged, self._onSkinGoodsItemSibling, self)
		end
	end
end

function StoreView:_onPlayStoreInAnim()
	self._viewAnim:Play("storeview_show", 0, 0)
end

function StoreView:_onPlayStoreOutAnim()
	self._viewAnim:Play("storeview_hide", 0, 0)
end

function StoreView:_onSkinGoodsItemSibling()
	if not self._isHasSkinGoodsItemSibling then
		self._isHasSkinGoodsItemSibling = true

		TaskDispatcher.runDelay(self._onRunSkinGoodsItemSibling, self, 0.1)
	end
end

function StoreView:_onRunSkinGoodsItemSibling()
	self._isHasSkinGoodsItemSibling = false

	if self.viewContainer then
		self.viewContainer:sortSkinStoreSiblingIndex()
	end
end

function StoreView:_onRefreshRedDot()
	self._needCountdown = false

	for _, v in pairs(self._tabsContainer) do
		local isShow, isActRedDot = StoreModel.instance:isTabMainRedDotShow(v.tabId)

		gohelper.setActive(v.reddot, isShow)
		gohelper.setActive(v.reddotNormalType, not isActRedDot)
		gohelper.setActive(v.reddotActType, isActRedDot)
		self:refreshTimeDeadline(StoreConfig.instance:getTabConfig(v.tabId), v)
	end

	self:checkCountdownStatus()
	self:refreshMainTabRedDot()
end

function StoreView:refreshMainTabRedDot()
	local showRedDot = StoreModel.instance:isTabMainRedDotShow(self._tabTableSP1.tabId) or SignInModel.instance:getCanSupplementMonthCardDays() > 0

	gohelper.setActive(self._tabTableSP1.reddot, showRedDot)
end

function StoreView:_OnDailyRefresh()
	ChargeRpc.instance:sendGetChargeInfoRequest()
	StoreRpc.instance:sendGetStoreInfosRequest(nil, self._handleDailyRefreshReceive, self)
end

function StoreView:_onStoreInfoChanged()
	self:_onRefreshRedDot()

	local newGoods = DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.NewDecorateStore)
	local hasNo = #newGoods <= 0

	if self._hasDecorateGoods and hasNo then
		self:closeThis()
	end

	self._hasDecorateGoods = not hasNo
end

function StoreView:_handleDailyRefreshReceive()
	self:_refreshTabs(self._selectFirstTabId)
	self:_onRefreshRedDot()
end

function StoreView:checkCountdownStatus()
	if self._needCountdown and not self._countdownRepeat then
		TaskDispatcher.runRepeat(self.refreshCountdown, self, 1)

		self._countdownRepeat = true
	elseif not self._needCountdown and self._countdownRepeat then
		TaskDispatcher.cancelTask(self.refreshCountdown, self)

		self._countdownRepeat = false
	end
end

function StoreView:refreshCountdown()
	if not self._tabsContainer then
		return
	end

	for _, v in pairs(self._tabsContainer) do
		if v.tabId then
			self:refreshTimeDeadline(StoreConfig.instance:getTabConfig(v.tabId), v)
		end
	end
end

function StoreView:onClose()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._OnDailyRefresh, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._onRefreshRedDot, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._onStoreInfoChanged, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.UpdatePackageStore, self._onRefreshRedDot, self)
	self.removeEventCb(self, SignInController.instance, SignInEvent.OnReceiveSupplementMonthCardReply, self.refreshMainTabRedDot, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.PlayShowStoreAnim, self._onPlayStoreInAnim, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.PlayHideStoreAnim, self._onPlayStoreOutAnim, self)
	StoreController.instance:statExitStore()

	self._needCountdown = false

	self:checkCountdownStatus()
	self:killTween()
	TaskDispatcher.cancelTask(self._onRunSkinGoodsItemSibling, self)
end

function StoreView:onUpdateParam()
	if self.viewParam then
		if not self.viewParam.jumpTab then
			local jumpTab = self:_getDefaultTabId()

			if not StoreModel.instance:isTabOpen(jumpTab) then
				jumpTab = self:_getDefaultTabId()
			end

			self:_refreshTabs(jumpTab, self.viewParam.jumpGoodsId)
		end
	end
end

function StoreView:_getDefaultTabId()
	local tabConfigList = StoreModel.instance:getFirstTabs(true, true)
	local tabId = StoreHelper.getDefaultSelectFirstStoreTab(tabConfigList)

	logNormal("商店默认页签选择 tabId: " .. tostring(tabId))

	return tabId
end

function StoreView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagelefticon:UnLoadImage()
	self._simagerighticon:UnLoadImage()

	if self._tabsContainer and #self._tabsContainer > 0 then
		for i = 1, #self._tabsContainer do
			self._tabsContainer[i].btn:RemoveClickListener()
		end
	end

	self._tabTableSP1.btn:RemoveClickListener()
end

StoreView.TweenTime = 0.1
StoreView.OffY = 19
StoreView.ItemH = 120
StoreView.ItemSpace = -6.5
StoreView.ListH = 764.5

function StoreView:_handleTabSet(uiIndex, isFirstTimeEnter)
	local anchorY = recthelper.getAnchorY(self._bigTypeItemContent)
	local itemY = StoreView.OffY + (StoreView.ItemH + StoreView.ItemSpace) * (uiIndex - 1)

	if anchorY > itemY - StoreView.OffY or itemY + StoreView.ItemH > anchorY + StoreView.ListH then
		local newAnchorY = itemY - StoreView.OffY

		if anchorY < newAnchorY then
			newAnchorY = itemY - StoreView.ListH + StoreView.ItemH - StoreView.OffY
		end

		if isFirstTimeEnter then
			recthelper.setAnchorY(self._bigTypeItemContent, newAnchorY)
		else
			self:killTween()

			self._tweenIdCategory = ZProj.TweenHelper.DOTweenFloat(anchorY, newAnchorY, StoreView.TweenTime, self.onTweenCategory, self.onTweenFinishCategory, self)
		end
	end
end

function StoreView:onTweenCategory(value)
	if not gohelper.isNil(self._scrollbigType) then
		recthelper.setAnchorY(self._bigTypeItemContent, value)
	end
end

function StoreView:onTweenFinishCategory()
	self:killTween()
end

function StoreView:killTween()
	if self._tweenIdCategory then
		ZProj.TweenHelper.KillById(self._tweenIdCategory)

		self._tweenIdCategory = nil
	end
end

return StoreView
