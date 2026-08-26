-- chunkname: @modules/logic/store/view/ChargeStoreView.lua

module("modules.logic.store.view.ChargeStoreView", package.seeall)

local ChargeStoreView = class("ChargeStoreView", BaseView)

function ChargeStoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagelefticon = gohelper.findChildSingleImage(self.viewGO, "#simage_lefticon")
	self._simagerighticon = gohelper.findChildSingleImage(self.viewGO, "#simage_righticon")
	self._gostorecategoryitem = gohelper.findChild(self.viewGO, "scroll_category/viewport/categorycontent/#go_storecategoryitem")
	self._scrollprop = gohelper.findChildScrollRect(self.viewGO, "#scroll_prop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChargeStoreView:addEvents()
	return
end

function ChargeStoreView:removeEvents()
	return
end

function ChargeStoreView:_editableInitView()
	gohelper.setActive(self._gostorecategoryitem, false)

	self._categoryItemContainer = {}

	self._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("full/shangcheng_bj"))
	self._simagelefticon:LoadImage(ResUrl.getStoreBottomBgIcon("bg_leftdown2"))
	self._simagerighticon:LoadImage(ResUrl.getStoreBottomBgIcon("bg_right3"))
end

function ChargeStoreView:_refreshAllSecondTabs()
	local secondTabConfigs = StoreModel.instance:getSecondTabs(self._selectFirstTabId, true, true)

	if secondTabConfigs and #secondTabConfigs > 0 then
		for i = 1, #secondTabConfigs do
			self:_refreshSecondTabs(i, secondTabConfigs[i])
			gohelper.setActive(self._categoryItemContainer[i].go, true)
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

function ChargeStoreView:_refreshTabs(selectTabId, openUpdate, isChild)
	local preSelectSecondTabId = self._selectSecondTabId

	self._selectSecondTabId = 0

	if not StoreModel.instance:isTabOpen(selectTabId) then
		selectTabId = self.viewContainer:getSelectFirstTabId()
	end

	local _

	_, self._selectSecondTabId, _ = StoreModel.instance:jumpTabIdToSelectTabId(selectTabId)

	local secondConfig = StoreConfig.instance:getTabConfig(self._selectSecondTabId)
	local firstConfig = StoreConfig.instance:getTabConfig(self.viewContainer:getSelectFirstTabId())

	if secondConfig and not string.nilorempty(secondConfig.showCost) then
		self.viewContainer:setCurrencyType(secondConfig.showCost)
	elseif firstConfig and not string.nilorempty(firstConfig.showCost) then
		self.viewContainer:setCurrencyType(firstConfig.showCost)
	else
		self.viewContainer:setCurrencyType(nil)
	end

	if not openUpdate and preSelectSecondTabId == self._selectSecondTabId then
		return
	end

	self:_refreshAllSecondTabs()
	StoreController.instance:readTab(selectTabId)
	self:_onRefreshRedDot()

	self._resetScrollPos = true

	self:_refreshGood()
end

function ChargeStoreView:_onRefreshRedDot()
	for _, v in pairs(self._categoryItemContainer) do
		gohelper.setActive(v.go_reddot, StoreModel.instance:isTabFirstRedDotShow(v.tabId))
	end
end

function ChargeStoreView:_refreshSecondTabs(index, secondTabConfig)
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
end

function ChargeStoreView:initCategoryItemTable(index)
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

	categoryItemTable.btn:AddClickListener(function(categoryItemTable)
		local jumpTab = categoryItemTable.tabId

		self:_refreshTabs(jumpTab)
		StoreController.instance:onSwitchTab(jumpTab)
	end, categoryItemTable)
	table.insert(self._categoryItemContainer, categoryItemTable)
	gohelper.setActive(categoryItemTable.go_childItem, false)

	return categoryItemTable
end

function ChargeStoreView:_refreshGood()
	StoreModel.instance:setCurChargeStoreId(self._selectSecondTabId)

	local chargeStoreGoods = StoreModel.instance:getChargeGoods()

	StoreChargeGoodsItemListModel.instance:setMOList(chargeStoreGoods, self._selectSecondTabId)
end

function ChargeStoreView:onOpen()
	self._selectFirstTabId = self.viewContainer:getSelectFirstTabId()

	local jumpTabId = self.viewContainer:getJumpTabId()

	self:_refreshTabs(jumpTabId, true)
	self.addEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._updateInfo, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self._updateInfo, self)
end

function ChargeStoreView:_updateInfo()
	self:_refreshGood()
end

function ChargeStoreView:onClose()
	self.removeEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._updateInfo, self)
	self.removeEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self._updateInfo, self)
end

function ChargeStoreView:onUpdateParam()
	self._selectFirstTabId = self.viewContainer:getSelectFirstTabId()

	local jumpTabId = self.viewContainer:getJumpTabId()

	self:_refreshTabs(jumpTabId)
end

function ChargeStoreView:onDestroyView()
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
	self._simagelefticon:UnLoadImage()
	self._simagerighticon:UnLoadImage()
end

return ChargeStoreView
