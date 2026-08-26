-- chunkname: @modules/logic/store/view/PackageStoreView.lua

module("modules.logic.store.view.PackageStoreView", package.seeall)

local PackageStoreView = class("PackageStoreView", BaseView)

function PackageStoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._gostorecategoryitem = gohelper.findChild(self.viewGO, "left/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	self._scrollprop = gohelper.findChildScrollRect(self.viewGO, "#scroll_prop")
	self._gopropcontent = gohelper.findChild(self.viewGO, "#scroll_prop/viewport/content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PackageStoreView:addEvents()
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._scrollprop:AddOnValueChanged(self._onDragging, self)
	self.addClickCb(self, self.btnArrow, self._onClickBtnArrow, self)
end

function PackageStoreView:removeEvents()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._scrollprop:RemoveOnValueChanged()
	self.removeClickCb(self, self.btnArrow, self._onClickBtnArrow, self)
end

function PackageStoreView:_editableInitView()
	gohelper.setActive(self._gostorecategoryitem, false)

	self._categoryItemContainer = {}
	self._horizontalNormalizedPosition = 0
	self._scrollprop.horizontalNormalizedPosition = 0

	self._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_shangpindiban"))

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollprop.gameObject)
	self.goArrow = gohelper.findChild(self.viewGO, "#scroll_prop/arrow")
	self.btnArrow = gohelper.findChildButtonWithAudio(self.viewGO, "#scroll_prop/arrow/ani/image")
end

function PackageStoreView:_onClickBtnArrow()
	StorePackageGoodsItemListModel.instance:moveToNewGoods()
end

function PackageStoreView:_onDragBegin(param, pointerEventData)
	self:refreshNewArrow()
end

function PackageStoreView:_onDragging()
	self:refreshNewArrow()
end

function PackageStoreView:_onDragEnd(param, pointerEventData)
	self:refreshNewArrow()
end

function PackageStoreView:refreshNewArrow()
	local newIndex = StorePackageGoodsItemListModel.instance:findNewGoodsIndex()

	gohelper.setActive(self.goArrow, newIndex ~= nil)
end

function PackageStoreView:_refreshTabs(selectTabId, openUpdate, scrollToRadDot)
	local preSelectSecondTabId = self._selectSecondTabId
	local preSelectThirdTabId = self._selectThirdTabId

	self._selectSecondTabId = 0
	self._selectThirdTabId = 0

	if not StoreModel.instance:isTabOpen(selectTabId) then
		selectTabId = self.viewContainer:getSelectFirstTabId()
	end

	local _

	_, self._selectSecondTabId, self._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(selectTabId)

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
		self.viewContainer:setCurrencyByParams(nil)
	end

	if not openUpdate and preSelectSecondTabId == self._selectSecondTabId and preSelectThirdTabId == self._selectThirdTabId then
		return
	end

	self:_refreshAllSecondTabs()
	StoreController.instance:readTab(selectTabId)
	self:_onRefreshRedDot()

	self._resetScrollPos = true

	self:_refreshGoods(true, scrollToRadDot)
end

function PackageStoreView:packShowCostParam(showCost)
	local currencyTypeParams = {}
	local costInfo = string.split(showCost, "#")

	for i = #costInfo, 1, -1 do
		local costId = tonumber(costInfo[i])

		if ItemModel.instance:getItemCount(costId) > 0 and not CurrencyModel.instance:getCurrency(costId) then
			table.insert(currencyTypeParams, {
				isCurrencySprite = true,
				id = costId,
				type = MaterialEnum.MaterialType.Item
			})
		elseif CurrencyModel.instance:getCurrency(costId) then
			table.insert(currencyTypeParams, costId)
		end
	end

	return currencyTypeParams
end

function PackageStoreView:_refreshAllSecondTabs()
	local secondTabConfigs = StoreModel.instance:getSecondTabs(self._selectFirstTabId, true, true)

	if secondTabConfigs and #secondTabConfigs > 0 then
		for i = 1, #secondTabConfigs do
			self:_refreshSecondTabs(i, secondTabConfigs[i])

			local secondTabsGoods = StoreModel.instance:getPackageGoodValidList(secondTabConfigs[i].id)

			gohelper.setActive(self._categoryItemContainer[i].go, #secondTabsGoods > 0)
		end

		for i = #secondTabConfigs + 1, #self._categoryItemContainer do
			gohelper.setActive(self._categoryItemContainer[i].go, false)
		end
	else
		for i = 1, #self._categoryItemContainer do
			gohelper.setActive(self._categoryItemContainer[i].go, false)
		end
	end
end

function PackageStoreView:_refreshSecondTabs(index, secondTabConfig)
	local categoryItemTable = self._categoryItemContainer[index]

	categoryItemTable = categoryItemTable or self:initCategoryItemTable(index)
	categoryItemTable.tabId = secondTabConfig.id
	categoryItemTable.txt_itemcn1.text = secondTabConfig.name
	categoryItemTable.txt_itemcn2.text = secondTabConfig.name
	categoryItemTable.txt_itemen1.text = secondTabConfig.nameEn
	categoryItemTable.txt_itemen2.text = secondTabConfig.nameEn

	local select = self._selectSecondTabId == secondTabConfig.id

	gohelper.setActive(categoryItemTable.go_unselected, not select)
	gohelper.setActive(categoryItemTable.go_selected, select)

	local thirdTabConfigs = StoreModel.instance:getThirdTabs(secondTabConfig.id, true, true)

	gohelper.setActive(categoryItemTable.go_line, select and #thirdTabConfigs > 0)

	if select and thirdTabConfigs and #thirdTabConfigs > 0 then
		for i = 1, #thirdTabConfigs do
			self:_refreshThirdTabs(categoryItemTable, i, thirdTabConfigs[i])
			gohelper.setActive(categoryItemTable.childItemContainer[i].go, true)
		end

		for i = #thirdTabConfigs + 1, #categoryItemTable.childItemContainer do
			gohelper.setActive(categoryItemTable.childItemContainer[i].go, false)
		end
	else
		for i = 1, #categoryItemTable.childItemContainer do
			gohelper.setActive(categoryItemTable.childItemContainer[i].go, false)
		end
	end
end

function PackageStoreView:initCategoryItemTable(index)
	local categoryItemTable = self:getUserDataTb_()

	categoryItemTable.go = gohelper.cloneInPlace(self._gostorecategoryitem, "item" .. index)
	categoryItemTable.go_unselected = gohelper.findChild(categoryItemTable.go, "go_unselected")
	categoryItemTable.go_selected = gohelper.findChild(categoryItemTable.go, "go_selected")
	categoryItemTable.go_line = gohelper.findChild(categoryItemTable.go, "go_line")
	categoryItemTable.go_reddot = gohelper.findChild(categoryItemTable.go, "#go_tabreddot1")
	categoryItemTable.txt_itemcn1 = gohelper.findChildText(categoryItemTable.go, "go_unselected/txt_itemcn1")
	categoryItemTable.txt_itemen1 = gohelper.findChildText(categoryItemTable.go, "go_unselected/txt_itemen1")
	categoryItemTable.txt_itemcn2 = gohelper.findChildText(categoryItemTable.go, "go_selected/txt_itemcn2")
	categoryItemTable.txt_itemen2 = gohelper.findChildText(categoryItemTable.go, "go_selected/txt_itemen2")
	categoryItemTable.go_childcategory = gohelper.findChild(categoryItemTable.go, "go_childcategory")
	categoryItemTable.go_childItem = gohelper.findChild(categoryItemTable.go, "go_childcategory/go_childitem")
	categoryItemTable.childItemContainer = {}
	categoryItemTable.btnGO = gohelper.findChild(categoryItemTable.go, "clickArea")
	categoryItemTable.btn = gohelper.getClickWithAudio(categoryItemTable.go, AudioEnum.UI.play_ui_bank_open)
	categoryItemTable.tabId = 0

	categoryItemTable.btn:AddClickListener(self.onClickTab, {
		target = self,
		item = categoryItemTable
	})
	table.insert(self._categoryItemContainer, categoryItemTable)
	gohelper.setActive(categoryItemTable.go_childItem, false)

	return categoryItemTable
end

function PackageStoreView.onClickTab(param)
	local target = param.target
	local item = param.item

	target:clickTab(item.tabId)
end

PackageStoreView.MaxClickLimitTime = 0.2

function PackageStoreView:clickTab(jumpTab)
	local nowTime = UnityEngine.Time.realtimeSinceStartup

	if self.previousClickTime and nowTime - self.previousClickTime <= PackageStoreView.MaxClickLimitTime then
		logNormal("拦截频繁点击事件")

		return
	end

	self.previousClickTime = nowTime

	self:_refreshTabs(jumpTab)
	StoreController.instance:onSwitchTab(jumpTab)
end

function PackageStoreView:_refreshThirdTabs(categoryItemTable, index, thirdTabConfig)
	local childItemTable = categoryItemTable.childItemContainer[index]

	if not childItemTable then
		childItemTable = self:getUserDataTb_()
		childItemTable.go = gohelper.cloneInPlace(categoryItemTable.go_childItem, "item" .. index)
		childItemTable.go_unselected = gohelper.findChild(childItemTable.go, "go_unselected")
		childItemTable.go_selected = gohelper.findChild(childItemTable.go, "go_selected")
		childItemTable.go_subreddot1 = gohelper.findChild(childItemTable.go, "go_unselected/txt_itemcn1/go_subcatereddot")
		childItemTable.go_subreddot2 = gohelper.findChild(childItemTable.go, "go_selected/txt_itemcn2/go_subcatereddot")
		childItemTable.txt_itemcn1 = gohelper.findChildText(childItemTable.go, "go_unselected/txt_itemcn1")
		childItemTable.txt_itemen1 = gohelper.findChildText(childItemTable.go, "go_unselected/txt_itemen1")
		childItemTable.txt_itemcn2 = gohelper.findChildText(childItemTable.go, "go_selected/txt_itemcn2")
		childItemTable.txt_itemen2 = gohelper.findChildText(childItemTable.go, "go_selected/txt_itemen2")
		childItemTable.btnGO = gohelper.findChild(childItemTable.go, "clickArea")
		childItemTable.btn = gohelper.getClick(childItemTable.btnGO)
		childItemTable.tabId = 0

		childItemTable.btn:AddClickListener(function(childItemTable)
			local jumpTab = childItemTable.tabId

			self:_refreshTabs(jumpTab, nil, true)
			StoreController.instance:onSwitchTab(jumpTab)
		end, childItemTable)
		table.insert(categoryItemTable.childItemContainer, childItemTable)
	end

	childItemTable.tabId = thirdTabConfig.id
	childItemTable.txt_itemcn1.text = thirdTabConfig.name
	childItemTable.txt_itemcn2.text = thirdTabConfig.name
	childItemTable.txt_itemen1.text = thirdTabConfig.nameEn
	childItemTable.txt_itemen2.text = thirdTabConfig.nameEn

	local select = self._selectThirdTabId == thirdTabConfig.id

	gohelper.setActive(childItemTable.go_unselected, not select)
	gohelper.setActive(childItemTable.go_selected, select)
end

function PackageStoreView:_refreshGoods(update, scrollToRadDot)
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
		StorePackageGoodsItemListModel.instance:setMOList()
	elseif self.storeId == StoreEnum.StoreId.RecommendPackage then
		StoreModel.instance:setCurPackageStore(self.storeId)

		local goodMoList = StoreModel.instance:getRecommendPackageList(true)

		StorePackageGoodsItemListModel.instance:setMOList(nil, goodMoList)
		self:updateRecommendPackageList(scrollToRadDot)

		if update then
			self:playOpenAnim()
		end
	elseif update then
		StoreModel.instance:setCurPackageStore(self.storeId)
		StoreModel.instance:setPackageStoreRpcNum(2)
		StoreRpc.instance:sendGetStoreInfosRequest({
			self.storeId
		})
		ChargeRpc.instance:sendGetChargeInfoRequest(self.playOpenAnim, self)
	end
end

function PackageStoreView:playOpenAnim()
	self.viewContainer:playPackageStoreAnimation()
end

function PackageStoreView:_onRefreshRedDot()
	for _, v in pairs(self._categoryItemContainer) do
		if v.tabId == StoreEnum.StoreId.RecommendPackage then
			gohelper.setActive(v.go_reddot, StoreModel.instance:isTabFirstRedDotShow(v.tabId))
		else
			gohelper.setActive(v.go_reddot, StoreModel.instance:isPackageStoreTabRedDotShow(v.tabId))
		end

		for _, child in pairs(v.childItemContainer) do
			gohelper.setActive(child.go_subreddot1, StoreModel.instance:isTabSecondRedDotShow(child.tabId))
			gohelper.setActive(child.go_subreddot2, StoreModel.instance:isTabSecondRedDotShow(child.tabId))
		end
	end
end

function PackageStoreView:_beforeUpdatePackageStore()
	self._horizontalNormalizedPosition = self._scrollprop.horizontalNormalizedPosition
end

function PackageStoreView:_afterUpdatePackageStore()
	self._scrollprop.horizontalNormalizedPosition = self._horizontalNormalizedPosition
end

function PackageStoreView:onOpen()
	self._selectFirstTabId = self.viewContainer:getSelectFirstTabId()

	local jumpTabId = self.viewContainer:getJumpTabId()
	local jumpGoodsId = self.viewContainer:getJumpGoodsId()

	self:_refreshTabs(jumpTabId, true, true)
	self.addEventCb(self, StoreController.instance, StoreEvent.BeforeUpdatePackageStore, self._beforeUpdatePackageStore, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.AfterUpdatePackageStore, self._afterUpdatePackageStore, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._updateInfo, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._onRefreshRedDot, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.UpdatePackageStore, self.onUpdatePackageGoodsList, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.CurPackageListEmpty, self.onPackageGoodsListEmpty, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	transformhelper.setLocalPos(self._gopropcontent.transform, 0, 0, 0)

	if jumpGoodsId then
		StoreController.instance:openPackageStoreGoodsView(StoreModel.instance:getGoodsMO(tonumber(jumpGoodsId)))
	end
end

function PackageStoreView:_updateInfo()
	self:_refreshGoods(false)
end

function PackageStoreView:_onFinishTask(taskId)
	if StoreConfig.instance:getChargeConditionalConfig(taskId) and not self._isHasWaitRefeshGoodsTask then
		self._isHasWaitRefeshGoodsTask = true

		TaskDispatcher.runDelay(self._onRunWaitRefeshGoods, self, 0.1)
	end
end

function PackageStoreView:_onRunWaitRefeshGoods()
	self._isHasWaitRefeshGoodsTask = false

	self:_refreshGoods(true)
end

function PackageStoreView:onClose()
	self.removeEventCb(self, StoreController.instance, StoreEvent.BeforeUpdatePackageStore, self._beforeUpdatePackageStore, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.AfterUpdatePackageStore, self._afterUpdatePackageStore, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._updateInfo, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._onRefreshRedDot, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.UpdatePackageStore, self.onUpdatePackageGoodsList, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.CurPackageListEmpty, self.onPackageGoodsListEmpty, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)

	if self._isHasWaitRefeshGoodsTask then
		self._isHasWaitRefeshGoodsTask = nil

		TaskDispatcher.cancelTask(self._onRunWaitRefeshGoods, self)
	end
end

function PackageStoreView:onUpdateParam()
	self._selectFirstTabId = self.viewContainer:getSelectFirstTabId()

	local jumpTabId = self.viewContainer:getJumpTabId()
	local jumpGoodsId = self.viewContainer:getJumpGoodsId()

	self:_refreshTabs(jumpTabId)

	if jumpGoodsId then
		StoreController.instance:openPackageStoreGoodsView(StoreModel.instance:getGoodsMO(tonumber(jumpGoodsId)))
	end
end

function PackageStoreView:onDestroyView()
	if self._categoryItemContainer and #self._categoryItemContainer > 0 then
		for i = 1, #self._categoryItemContainer do
			local categotyItem = self._categoryItemContainer[i]

			categotyItem.btn:RemoveClickListener()

			if categotyItem.childItemContainer and #categotyItem.childItemContainer > 0 then
				for j = 1, #categotyItem.childItemContainer do
					categotyItem.childItemContainer[j].btn:RemoveClickListener()
				end
			end
		end
	end

	self._simagebg:UnLoadImage()
end

function PackageStoreView:onUpdatePackageGoodsList()
	self:_refreshAllSecondTabs()
	self:_onRefreshRedDot()
	self:refreshScrollViewPos(false)
end

function PackageStoreView:updateRecommendPackageList(scrollToRadDot)
	local curBuyPackageId = StoreModel.instance:getCurBuyPackageId()
	local list = StorePackageGoodsItemListModel.instance:getList()

	if (not list or #list == 0) and curBuyPackageId == nil then
		self:_refreshTabs(StoreEnum.StoreId.Package, true)

		return
	end

	self:_onRefreshRedDot()
	self:refreshScrollViewPos(scrollToRadDot)
end

function PackageStoreView:onPackageGoodsListEmpty()
	self:_refreshTabs(StoreEnum.StoreId.Package, true)
end

function PackageStoreView:refreshScrollViewPos(scrollToRadDot)
	local hasRedDot = StoreModel.instance:isPackageStoreTabRedDotShow(self._selectSecondTabId)

	if scrollToRadDot or hasRedDot then
		local list = StorePackageGoodsItemListModel.instance:getList()

		for i, mo in ipairs(list) do
			local goodsId = mo.goodsId
			local redDot = StoreModel.instance:isGoodsItemRedDotShow(goodsId)

			if redDot then
				self._scrollprop.horizontalNormalizedPosition = (i - 1) / (#list - 1)

				return
			end
		end
	end

	if self._resetScrollPos then
		self._scrollprop.horizontalNormalizedPosition = 0
		self._resetScrollPos = false
	end
end

return PackageStoreView
