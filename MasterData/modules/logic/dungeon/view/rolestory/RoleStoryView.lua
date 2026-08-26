-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryView", package.seeall)

local RoleStoryView = class("RoleStoryView", BaseRoleStoryView)

function RoleStoryView:onInit()
	self.resPathList = {
		itemRes = "ui/viewres/dungeon/rolestory/rolestoryitem.prefab",
		mainRes = "ui/viewres/dungeon/rolestory/rolestoryview.prefab",
		itemResNew = "ui/viewres/dungeon/rolestory/rolestorynewitem.prefab",
		tankRes = RoleStoryTank.prefabPath
	}
end

function RoleStoryView:onInitView()
	self.simageFullBg = gohelper.findChildSingleImage(self.viewGO, "BG/#simage_FullBG")

	self.simageFullBg:LoadImage(ResUrl.getRoleStoryIcon("rolestory_fullbg_7"))

	self.goRewardPanel = gohelper.findChild(self.viewGO, "goRewardPanel")
	self.btnclose = gohelper.findChildButtonWithAudio(self.goRewardPanel, "btnclose")
	self.goNode = gohelper.findChild(self.goRewardPanel, "#go_node")
	self.rewardContent = gohelper.findChild(self.goRewardPanel, "#go_node/Content")
	self.rewardItems = {}
	self.currencyViewGO = gohelper.findChild(self.viewGO, "#go_topright/currencyview")
	self.currencyTxt = gohelper.findChildText(self.currencyViewGO, "#go_container/#go_currency/#btn_currency/#txt")
	self.btnCurrency = gohelper.findChildButtonWithAudio(self.currencyViewGO, "#go_container/#go_currency/#btn_currency")
	self.currencyImage = gohelper.findChildImage(self.currencyViewGO, "#go_container/#go_currency/#btn_currency/#image")
	self.currencyAnim = self.currencyViewGO:GetComponent(typeof(UnityEngine.Animator))
	self.currencyId = CurrencyEnum.CurrencyType.RoleStory

	RoleStoryListModel.instance:markUnlockOrder()

	self._gotank = gohelper.findChild(self.viewGO, "#go_tank")

	local tankGO = self:getResInst(self.resPathList.tankRes, self._gotank)

	self.roleStoryTank = RoleStoryTank.New(tankGO)
	self.goTabItem = gohelper.findChild(self.viewGO, "#scroll_chapterlist/viewport/content/#go_chapteritem")

	gohelper.setActive(self.goTabItem, false)

	self.tabList = {}

	RoleStoryListModel.instance:setSelectTabType(RoleStoryEnum.RoleStoryType.New, true)
end

function RoleStoryView:addEvents()
	self.btnclose:AddClickListener(self.onClickClose, self)
	self.btnCurrency:AddClickListener(self._btncurrencyOnClick, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.OnClickRoleStoryReward, self.showReward, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onFullViewOpenOrClose, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onFullViewOpenOrClose, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.UpdateInfo, self._onUpdateInfo, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.StoryTabChange, self.refreshList, self)
end

function RoleStoryView:removeEvents()
	self.btnclose:RemoveClickListener()
	self.btnCurrency:RemoveClickListener()
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.OnClickRoleStoryReward, self.showReward, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, self._onFullViewOpenOrClose, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onFullViewOpenOrClose, self)
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.UpdateInfo, self._onUpdateInfo, self)
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.StoryTabChange, self.refreshList, self)
end

function RoleStoryView:_onUpdateInfo()
	self:onShow()
end

function RoleStoryView:_onFullViewOpenOrClose()
	local container = ViewMgr.instance:getContainer(ViewName.DungeonView)

	if container and self._scrollView then
		if container._isVisible and self.isShow then
			self._scrollView:onOpen()
		else
			self._scrollView:onCloseFinish()
		end
	end
end

function RoleStoryView:onShow()
	self:refreshTabList()
	self:refreshList()
	self.currencyAnim:Play("currencyview_in")
	self:refreshCurrency()
	self.roleStoryTank:onOpen()
end

function RoleStoryView:onHide()
	if self._scrollView then
		self._scrollView:onCloseFinish()
	end

	self:onClickClose()
	self.currencyAnim:Play("currencyview_out")
end

function RoleStoryView:refreshList()
	if self._scrollView then
		self._scrollView:removeEventsInternal()
		self._scrollView:onDestroyViewInternal()
		self._scrollView:__onDispose()
	end

	self._scrollView = nil

	self:buildScroll()
	self._scrollView:onOpen()
	RoleStoryListModel.instance:refreshList()
end

function RoleStoryView:buildScroll()
	if self._scrollView then
		return
	end

	local tabType = RoleStoryListModel.instance:getSelectTabType()
	local isNew = tabType == RoleStoryEnum.RoleStoryType.New
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "RoleChapterList/#Scroll_RoleChapter"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes

	if isNew then
		scrollParam.prefabUrl = self.resPathList.itemResNew or self.resPathList.itemRes
	end

	if isNew then
		scrollParam.cellClass = RoleStoryNewItem or RoleStoryItem
	end

	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 474
	scrollParam.cellHeight = 760
	scrollParam.cellSpaceH = 156
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 145
	scrollParam.endSpace = 100
	scrollParam.sortMode = ScrollEnum.ScrollSortUp
	self._scrollView = LuaListScrollView.New(RoleStoryListModel.instance, scrollParam)
	self._scrollView.isFirst = true

	function self._scrollView.onUpdateFinish(view)
		view.isFirst = false
	end

	self._scrollView:__onInit()

	self._scrollView.viewGO = self.viewGO
	self._scrollView.viewName = self.viewName
	self._scrollView.viewContainer = self

	self._scrollView:onInitViewInternal()
	self._scrollView:addEventsInternal()
end

function RoleStoryView:onClickClose()
	gohelper.setActive(self.goRewardPanel, false)
end

function RoleStoryView:showReward(mo, x, y, z)
	if not mo then
		self:onClickClose()

		return
	end

	transformhelper.setPos(self.goNode.transform, x, y, z)
	gohelper.setActive(self.goRewardPanel, true)

	local rewards = mo.rewards

	for i = 1, math.max(#rewards, #self.rewardItems) do
		local item = self.rewardItems[i]
		local data = rewards[i]

		if not item then
			item = IconMgr.instance:getCommonItemIcon(self.rewardContent)
			self.rewardItems[i] = item

			transformhelper.setLocalScale(item.tr, 0.5, 0.5, 1)
		end

		if data then
			gohelper.setActive(item.go, true)
			item:setMOValue(data[1], data[2], data[3])
			item:setCountFontSize(42)
		else
			gohelper.setActive(item.go, false)
		end
	end
end

function RoleStoryView:_onCurrencyChange(changeIds)
	local id = self.currencyId

	if not id or not changeIds[id] then
		return
	end

	self:refreshCurrency()
end

function RoleStoryView:refreshCurrency()
	local currencyID = self.currencyId
	local currencyMO = CurrencyModel.instance:getCurrency(currencyID)
	local currencyCO = CurrencyConfig.instance:getCurrencyCo(currencyID)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self.currencyTxt.text = string.format("%s/%s", GameUtil.numberDisplay(quantity), GameUtil.numberDisplay(currencyCO.maxLimit))

			local currencyname = currencyCO.icon

			UISpriteSetMgr.instance:setCurrencyItemSprite(self.currencyImage, currencyname .. "_1")
		end
	end
end

function RoleStoryView:_btncurrencyOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, self.currencyId, false)
end

function RoleStoryView:refreshTabList()
	for _, v in pairs(RoleStoryEnum.RoleStoryType) do
		local tab = self:getTabItem(v)

		self:refreshTabItem(tab)
	end
end

function RoleStoryView:getTabItem(tabType)
	local item = self.tabList[tabType]

	if not item then
		item = self:getUserDataTb_()
		item.tabType = tabType
		item.go = gohelper.cloneInPlace(self.goTabItem, tostring(tabType))
		item.goSelected = gohelper.findChild(item.go, "beselected")
		item.txtSelectedName = gohelper.findChildTextMesh(item.goSelected, "chapternamecn")
		item.goUnSelect = gohelper.findChild(item.go, "unselected")
		item.txtUnSelectName = gohelper.findChildTextMesh(item.goUnSelect, "chapternamecn")
		item.btnClick = gohelper.findChildButtonWithAudio(item.go, "btnclick")

		item.btnClick:AddClickListener(self.onClickTabItem, self, item)

		self.tabList[tabType] = item

		local str = luaLang(string.format("rolestoryview_tabname_%s", tabType))

		item.txtSelectedName.text = str
		item.txtUnSelectName.text = str
	end

	return item
end

function RoleStoryView:refreshTabItem(tab)
	gohelper.setActive(tab.go, true)

	local selectTabType = RoleStoryListModel.instance:getSelectTabType()
	local tabType = tab.tabType
	local isSelect = selectTabType == tabType

	gohelper.setActive(tab.goSelected, isSelect)
	gohelper.setActive(tab.goUnSelect, not isSelect)
end

function RoleStoryView:onClickTabItem(tab)
	local tabType = tab.tabType

	if not RoleStoryListModel.instance:setSelectTabType(tabType) then
		return
	end

	self:refreshTabList()
end

function RoleStoryView:onDestroyView()
	if self.simageFullBg then
		self.simageFullBg:UnLoadImage()

		self.simageFullBg = nil
	end

	if self._scrollView then
		self._scrollView:removeEventsInternal()
		self._scrollView:onDestroyViewInternal()
		self._scrollView:__onDispose()
	end

	self._scrollView = nil

	if self.rewardItems then
		for k, v in pairs(self.rewardItems) do
			v:onDestroy()
		end

		self.rewardItems = nil
	end

	if self.roleStoryTank then
		self.roleStoryTank:onDestroy()

		self.roleStoryTank = nil
	end

	if self.tabList then
		for k, v in pairs(self.tabList) do
			v.btnClick:RemoveClickListener()
		end

		self.tabList = nil
	end
end

return RoleStoryView
