-- chunkname: @modules/logic/store/view/NormalStoreView.lua

module("modules.logic.store.view.NormalStoreView", package.seeall)

local NormalStoreView = class("NormalStoreView", BaseView)

function NormalStoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrollprop = gohelper.findChildScrollRect(self.viewGO, "#scroll_prop")
	self._golock = gohelper.findChild(self.viewGO, "#scroll_prop/#go_lock")
	self._simagelockbg = gohelper.findChildSingleImage(self.viewGO, "#scroll_prop/#go_lock/#simage_lockbg")
	self._gostorecategoryitem = gohelper.findChild(self.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	self._goline = gohelper.findChild(self.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_line")
	self._gotabreddot1 = gohelper.findChild(self.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_tabreddot1")
	self._golimit = gohelper.findChild(self.viewGO, "#go_limit")
	self._txtrefreshTime = gohelper.findChildText(self.viewGO, "#txt_refreshTime")
	self._gosortbtn = gohelper.findChild(self.viewGO, "top/#go_sortbtn")
	self._gounsort = gohelper.findChild(self.viewGO, "top/#go_sortbtn/#go_unsort")
	self._gosort = gohelper.findChild(self.viewGO, "top/#go_sortbtn/#go_sort")
	self._btntip = gohelper.findChildButtonWithAudio(self.viewGO, "top/#go_sortbtn/txt_sort/btn_tip")
	self._gotip = gohelper.findChild(self.viewGO, "top/#go_sortbtn/txt_sort/btn_tip/#go_tip")
	self._btntipclose = gohelper.findChildButtonWithAudio(self.viewGO, "top/#go_sortbtn/txt_sort/btn_tip/#go_tip/#btn_tipclose")
	self._btnsort = gohelper.findChildButtonWithAudio(self.viewGO, "top/#go_sortbtn/btn_sort")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NormalStoreView:addEvents()
	self._btntip:AddClickListener(self._btntipOnClick, self)
	self._btntipclose:AddClickListener(self._btntipcloseOnClick, self)
	self._btnsort:AddClickListener(self._btsortOnClick, self)
end

function NormalStoreView:removeEvents()
	self._btntip:RemoveClickListener()
	self._btntipclose:RemoveClickListener()
	self._btnsort:RemoveClickListener()
end

function NormalStoreView:_btntipOnClick()
	gohelper.setActive(self._gotip, true)
end

function NormalStoreView:_btntipcloseOnClick()
	gohelper.setActive(self._gotip, false)
end

function NormalStoreView:_btsortOnClick()
	local isSortEquip = StoreNormalGoodsItemListModel.instance:setSortEquip()

	gohelper.setActive(self._gounsort, not isSortEquip)
	gohelper.setActive(self._gosort, isSortEquip)
end

function NormalStoreView:_editableInitView()
	self._txtrefreshTime = gohelper.findChildText(self.viewGO, "#txt_refreshTime")

	gohelper.setActive(self._txtrefreshTime.gameObject, false)
	gohelper.setActive(self._gostorecategoryitem, false)

	self._lockClick = gohelper.getClickWithAudio(self._golock)
	self._isLock = false
	self._categoryItemContainer = {}

	self._simagelockbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_weijiesuodiban"))
end

function NormalStoreView:_refreshTabs(selectTabId, openUpdate)
	if selectTabId ~= StoreEnum.StoreId.HighSummon then
		StoreController.instance:readTab(selectTabId)
	end

	local preSelectSecondTabId = self._selectSecondTabId
	local preSelectThirdTabId = self._selectThirdTabId

	self._selectSecondTabId = 0
	self._selectThirdTabId = 0

	if not StoreModel.instance:isTabOpen(selectTabId) then
		selectTabId = self.viewContainer:getSelectFirstTabId()
	end

	local _

	_, self._selectSecondTabId, self._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(selectTabId)

	local isLimit = self._selectSecondTabId == StoreEnum.StoreId.LimitStore

	if isLimit then
		self:refreshCurrency()
	else
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
	end

	if not openUpdate and preSelectSecondTabId == self._selectSecondTabId and preSelectThirdTabId == self._selectThirdTabId then
		return
	end

	local secondTabConfigs = StoreModel.instance:getSecondTabs(self._selectFirstTabId, true, true)

	if secondTabConfigs and #secondTabConfigs > 0 then
		for i = 1, #secondTabConfigs do
			self:_refreshSecondTabs(i, secondTabConfigs[i])
			gohelper.setActive(self._categoryItemContainer[i].go, true)
		end

		gohelper.setActive(self._categoryItemContainer[#secondTabConfigs].go_line, false)

		for i = #secondTabConfigs + 1, #self._categoryItemContainer do
			gohelper.setActive(self._categoryItemContainer[i].go, false)
		end

		gohelper.setActive(self._lineGo, true)
	else
		for i = 1, #self._categoryItemContainer do
			gohelper.setActive(self._categoryItemContainer[i].go, false)
		end

		gohelper.setActive(self._lineGo, false)
	end

	self:_onRefreshRedDot()
	self:_refreshTabDeadLine()
	self:_refreshGoods(true)

	if self._selectThirdTabId > 0 then
		self._isLock = StoreModel.instance:isStoreTabLock(self._selectThirdTabId)

		if self._isLock then
			local co = StoreConfig.instance:getStoreConfig(self._selectThirdTabId)

			self._txtLockText.text = string.format(luaLang("lock_store_text"), StoreConfig.instance:getTabConfig(co.needClearStore).name)
		end

		gohelper.setActive(self._golock, self._isLock)
	else
		gohelper.setActive(self._golock, false)
	end

	self._scrollprop.verticalNormalizedPosition = 1

	gohelper.setActive(self._golimit, isLimit)
	gohelper.setActive(self._scrollprop.gameObject, not isLimit)

	local isEquipStore = self.storeId == StoreEnum.StoreId.SummonEquipExchange

	if isEquipStore then
		local isSortEquip = StoreNormalGoodsItemListModel.instance:initSortEquip()

		gohelper.setActive(self._gounsort, not isSortEquip)
		gohelper.setActive(self._gosort, isSortEquip)
	end

	gohelper.setActive(self._gosortbtn, isEquipStore)
end

function NormalStoreView:refreshCurrency()
	local thirdConfig = StoreConfig.instance:getTabConfig(self._selectThirdTabId)
	local secondConfig = StoreConfig.instance:getTabConfig(self._selectSecondTabId)
	local firstConfig = StoreConfig.instance:getTabConfig(self.viewContainer:getSelectFirstTabId())

	if thirdConfig and not string.nilorempty(thirdConfig.showCost) then
		self.viewContainer:setCurrencyByParams(self:packShowCostParam(thirdConfig.showCost))
	elseif secondConfig and not string.nilorempty(secondConfig.showCost) then
		self.viewContainer:setCurrencyByParams(self:packShowCostParam(secondConfig.showCost))
	elseif firstConfig and not string.nilorempty(firstConfig.showCost) then
		self.viewContainer:setCurrencyByParams(self:packShowCostParam(firstConfig.showCost))
	else
		self.viewContainer:setCurrencyType(nil)
	end
end

function NormalStoreView:packShowCostParam(showCost)
	local currencyTypeParams = {}
	local costInfo = string.split(showCost, "#")

	for i = #costInfo, 1, -1 do
		local costId = costInfo[i]
		local config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, costId)

		if config then
			table.insert(currencyTypeParams, {
				isCurrencySprite = true,
				id = tonumber(costId),
				icon = config.icon,
				type = MaterialEnum.MaterialType.Item
			})
		end
	end

	return currencyTypeParams
end

function NormalStoreView:_refreshSecondTabs(index, secondTabConfig)
	local categoryItemTable = self._categoryItemContainer[index]

	categoryItemTable = categoryItemTable or self:initCategoryItemTable(index)
	categoryItemTable.tabId = secondTabConfig.id
	categoryItemTable.txt_itemcn1.text = secondTabConfig.name
	categoryItemTable.txt_itemcn2.text = secondTabConfig.name
	categoryItemTable.txt_itemen1.text = secondTabConfig.nameEn
	categoryItemTable.txt_itemen2.text = secondTabConfig.nameEn

	local select = self._selectSecondTabId == secondTabConfig.id

	gohelper.setActive(self._categoryItemContainer[index].go_line, true)

	if select and self._categoryItemContainer[index - 1] then
		gohelper.setActive(self._categoryItemContainer[index - 1].go_line, false)
	end

	gohelper.setActive(categoryItemTable.go_unselected, not select)
	gohelper.setActive(categoryItemTable.go_selected, select)
end

function NormalStoreView:initCategoryItemTable(index)
	local categoryItemTable = self:getUserDataTb_()

	categoryItemTable.go = gohelper.cloneInPlace(self._gostorecategoryitem, "item" .. index)
	categoryItemTable.go_unselected = gohelper.findChild(categoryItemTable.go, "go_unselected")
	categoryItemTable.go_selected = gohelper.findChild(categoryItemTable.go, "go_selected")
	categoryItemTable.go_reddot = gohelper.findChild(categoryItemTable.go, "#go_tabreddot1")
	categoryItemTable.go_reddotNormalType = gohelper.findChild(categoryItemTable.go, "#go_tabreddot1/type1")
	categoryItemTable.go_reddotActType = gohelper.findChild(categoryItemTable.go, "#go_tabreddot1/type9")
	categoryItemTable.txt_itemcn1 = gohelper.findChildText(categoryItemTable.go, "go_unselected/txt_itemcn1")
	categoryItemTable.txt_itemen1 = gohelper.findChildText(categoryItemTable.go, "go_unselected/txt_itemen1")
	categoryItemTable.txt_itemcn2 = gohelper.findChildText(categoryItemTable.go, "go_selected/txt_itemcn2")
	categoryItemTable.txt_itemen2 = gohelper.findChildText(categoryItemTable.go, "go_selected/txt_itemen2")
	categoryItemTable.go_line = gohelper.findChild(categoryItemTable.go, "#go_line")
	categoryItemTable.go_deadline = gohelper.findChild(categoryItemTable.go, "go_deadline")
	categoryItemTable.imagetimebg = gohelper.findChildImage(categoryItemTable.go, "go_deadline/timebg")
	categoryItemTable.godeadlineEffect = gohelper.findChild(categoryItemTable.go, "go_deadline/#effect")
	categoryItemTable.imagetimeicon = gohelper.findChildImage(categoryItemTable.go, "go_deadline/#txt_time/timeicon")
	categoryItemTable.txttime = gohelper.findChildText(categoryItemTable.go, "go_deadline/#txt_time")
	categoryItemTable.txtformat = gohelper.findChildText(categoryItemTable.go, "go_deadline/#txt_time/#txt_format")
	categoryItemTable.btn = gohelper.getClickWithAudio(categoryItemTable.go, AudioEnum.UI.play_ui_bank_open)
	categoryItemTable.tabId = 0

	categoryItemTable.btn:AddClickListener(function(categoryItemTable)
		local jumpTab = categoryItemTable.tabId

		self:_refreshTabs(jumpTab)

		self.viewContainer.notPlayAnimation = true

		StoreController.instance:onSwitchTab(jumpTab)
	end, categoryItemTable)
	table.insert(self._categoryItemContainer, categoryItemTable)
	gohelper.setActive(categoryItemTable.go_childItem, false)

	return categoryItemTable
end

function NormalStoreView:_refreshGoods(update)
	self.storeId = 0

	local thirdConfig = StoreConfig.instance:getTabConfig(self._selectThirdTabId)

	if thirdConfig then
		self.storeId = thirdConfig.storeId or 0
	end

	if self.storeId == 0 then
		local secondConfig = StoreConfig.instance:getTabConfig(self._selectSecondTabId)

		if secondConfig then
			self.storeId = secondConfig.storeId or 0
		end
	end

	if self.storeId == 0 then
		StoreNormalGoodsItemListModel.instance:setMOList()
	else
		local storeMO = StoreModel.instance:getStoreMO(self.storeId)

		if storeMO then
			local storeGoodsMOList = storeMO:getGoodsList(true)

			StoreNormalGoodsItemListModel.instance:setMOList(storeGoodsMOList, self.storeId)
		else
			StoreNormalGoodsItemListModel.instance:setMOList(nil, self.storeId)
		end

		if update then
			StoreRpc.instance:sendGetStoreInfosRequest({
				self.storeId
			})
			self.viewContainer:playNormalStoreAnimation()
			self.viewContainer:playSummonStoreAnimation()
		end
	end
end

function NormalStoreView:onOpen()
	self._selectFirstTabId = self.viewContainer:getSelectFirstTabId()

	local jumpTabId = self.viewContainer:getJumpTabId()

	self:_refreshTabs(jumpTabId, true)
	self.addEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._updateInfo, self)
	self.addEventCb(self, FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, self._updateInfo, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._onRefreshRedDot, self)
	self._lockClick:AddClickListener(self._onLockClick, self)
	self:checkCountdownStatus()
end

function NormalStoreView:_onLockClick()
	if self._isLock then
		local currentStoreName = StoreConfig.instance:getTabConfig(self.storeId).name

		GameFacade.showToast(ToastEnum.NormalStoreIsLock, currentStoreName)
	end
end

function NormalStoreView:_updateInfo()
	self:_refreshGoods(false)
end

function NormalStoreView:onClose()
	self.removeEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._updateInfo, self)
	self.removeEventCb(self, FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, self._updateInfo, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._onRefreshRedDot, self)
	self._lockClick:RemoveClickListener()
	self:closeTaskCountdown()
end

function NormalStoreView:_onRefreshRedDot()
	for _, v in pairs(self._categoryItemContainer) do
		local isShow, isActRedDot = StoreModel.instance:isTabFirstRedDotShow(v.tabId)

		gohelper.setActive(v.go_reddot, isShow)
		gohelper.setActive(v.go_reddotNormalType, not isActRedDot)
		gohelper.setActive(v.go_reddotActType, isActRedDot)
	end
end

function NormalStoreView:checkCountdownStatus()
	if self._needCountdown then
		TaskDispatcher.cancelTask(self._refreshTabDeadLine, self)
		TaskDispatcher.runRepeat(self._refreshTabDeadLine, self, 1)
	end
end

function NormalStoreView:closeTaskCountdown()
	if self._needCountdown then
		TaskDispatcher.cancelTask(self._refreshTabDeadLine, self)
	end
end

function NormalStoreView:_refreshTabDeadLine()
	for _, tabItem in pairs(self._categoryItemContainer) do
		if tabItem ~= nil or tabItem.tabId ~= nil then
			local config = StoreConfig.instance:getTabConfig(tabItem.tabId)
			local deadlineTimeSec = StoreHelper.getRemainExpireTime(config)

			if deadlineTimeSec > 0 then
				local deadlineHasDay = false

				tabItem.txttime.text, tabItem.txtformat.text, deadlineHasDay = TimeUtil.secondToRoughTime(math.floor(deadlineTimeSec), true)

				if self._refreshTabDeadlineHasDay == nil then
					self._refreshTabDeadlineHasDay = {}
				end

				if self._refreshTabDeadlineHasDay[tabItem.tabId] == nil or self._refreshTabDeadlineHasDay[tabItem.tabId] ~= deadlineHasDay then
					UISpriteSetMgr.instance:setCommonSprite(tabItem.imagetimebg, deadlineHasDay and "daojishi_01" or "daojishi_02")
					UISpriteSetMgr.instance:setCommonSprite(tabItem.imagetimeicon, deadlineHasDay and "daojishiicon_01" or "daojishiicon_02")
					SLFramework.UGUI.GuiHelper.SetColor(tabItem.txttime, deadlineHasDay and "#98D687" or "#E99B56")
					SLFramework.UGUI.GuiHelper.SetColor(tabItem.txtformat, deadlineHasDay and "#98D687" or "#E99B56")
					gohelper.setActive(tabItem.godeadlineEffect, not deadlineHasDay)

					self._refreshTabDeadlineHasDay[tabItem.tabId] = deadlineHasDay
				end

				self._needCountdown = true
			end

			gohelper.setActive(tabItem.go_deadline, deadlineTimeSec > 0)
			gohelper.setActive(tabItem.txttime.gameObject, deadlineTimeSec > 0)
		end
	end
end

function NormalStoreView:onUpdateParam()
	self._selectFirstTabId = self.viewContainer:getSelectFirstTabId()

	local jumpTabId = self.viewContainer:getJumpTabId()

	self:_refreshTabs(jumpTabId)
end

function NormalStoreView:onDestroyView()
	if self._categoryItemContainer and #self._categoryItemContainer > 0 then
		for i = 1, #self._categoryItemContainer do
			local categotyItem = self._categoryItemContainer[i]

			categotyItem.btn:RemoveClickListener()
		end
	end

	self._simagelockbg:UnLoadImage()
end

return NormalStoreView
