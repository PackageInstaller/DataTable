-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/sort/AirWorkShopHotRecommendView.lua

module("logic.extensions.airworkshop.view.sort.AirWorkShopHotRecommendView", package.seeall)

local M = class("AirWorkShopHotRecommendView", ViewComponent)

M.SubViewTyp = {
	Hot = 1
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self:_prepareCfg()

	local tagTypeCount = #self._cfgTypeLst

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("0&left_tab_content_-399612422"), LeftTabComp)

	while self._tabComp:getTabsCount() < tagTypeCount + 1 do
		self._tabComp:createTab()
	end

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:addToggleTab(self:getUIComponent("0&left_tab_content_-242000516", UIComponentType.SpaceXToggle))

	for i = 2, self._tabComp:getTabsCount() do
		local tabTypeLst = self._cfgTypeLst[i - 1]

		if tabTypeLst then
			self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(i))
			self._tabComp:setTabName(i, tabTypeLst[1].typeName)
		end

		self._tabComp:setTabShow(i, tabTypeLst)
	end

	self._scrollHot = self:getUIComponent("air_workshop_hot_recommend_view_86130750", UIComponentType.ScrollRect)
	self._loopListHot = LoopListHelper.New(self._scrollHot.gameObject)

	self._loopListHot:InitListView(0, self._onCellUpdateHot, self)

	self._goEmpty = self:getGo("air_workshop_hot_recommend_view_719957784")
	self._tabTypeViewPager = self:buildTypeViewPager()
	self._toggleTabControlType = ToggleTabControl.New()

	self._toggleTabControlType:setViewPager(self._tabTypeViewPager)

	self._tabTypeRoot = self:getUIComponent("air_workshop_hot_recommend_view_-888887437", UIComponentType.RectTransform)

	for i = 1, self._tabTypeRoot.childCount - 1 do
		self._toggleTabControlType:addToggleTab(self._tabTypeRoot:GetChild(i):GetComponent(UIComponentType.SpaceXToggle))
	end

	self._scrollType = self:getUIComponent("air_workshop_hot_recommend_view_-1481260327", UIComponentType.ScrollRect)
	self._loopListType = LoopListHelper.New(self._scrollType.gameObject)

	self._loopListType:InitListView(0, self._onCellUpdateType, self)
end

function M:destroyUI()
	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	self._toggleTabControlType:destroy()

	self._toggleTabControlType = nil

	self._loopListHot:Dispose()

	self._loopListHot = nil

	self._loopListType:Dispose()

	self._loopListType = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:setEvent(true)

	self._activeIndex = nil
	self._defualtTabIndex = M.SubViewTyp.Hot

	self._toggleTabControl:selectTab(self._defualtTabIndex)
	self._tabComp:setCanvasGroupShow(true)
	self._tabComp:onEnter()
	self._tabComp:playGuiAniTab(true, not self._viewPresentor:getIsBackOpen(), self._defualtTabIndex)
end

function M:onExit(reasonTyp)
	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	self:setEvent(false)

	self._hotMoLst = nil
	self._activeIndex = nil

	self._tabComp:onExit()
	self._tabComp:setCanvasInteractable(false)
	self._tabComp:playGuiAniTab(false, isNormalClose)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_HOT_MAP_REPLY, self._handleOnHotMapReply, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_HOT_MAP_BY_TAG_REPLY, self._handleOnHotMapByTagReply, self)
	else
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_HOT_MAP_REPLY, self._handleOnHotMapReply, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_HOT_MAP_BY_TAG_REPLY, self._handleOnHotMapByTagReply, self)
	end
end

function M:_handleOnHotMapReply(e, hotRankLst)
	self:refreshHotScroll(hotRankLst, true)
end

function M:_handleOnHotMapByTagReply(e, hotRankLst)
	self:refreshTypeScroll(hotRankLst, true)
end

function M:_onCellClickCheck(airMapRecordNO, mapId, airPlayType)
	if not mapId then
		printError("mapId is nil")

		return
	end

	AirWorkShopAtkAgent.instance:sendFreeStartRequest(airPlayType, mapId)
end

function M:_prepareCfg()
	local cfgLst = AirWorkShopConfig.instance:getConfigList(ConfigName.AirStudioTag)

	self._cfgTypeLst = {}

	local type
	local index = 0

	for i, cfg in ipairs(cfgLst or {}) do
		if not type or type and type ~= cfg.type then
			index = index + 1
			self._cfgTypeLst[index] = {}
			type = cfg.type
		end

		table.insert(self._cfgTypeLst[index], cfg)
	end
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	goutil.setActive(self._goEmpty, false)

	if needReflash then
		local isHot = tabIndex == M.SubViewTyp.Hot

		goutil.setActive(self._scrollHot.gameObject, isHot)
		goutil.setActive(self._scrollType.gameObject, not isHot)
		goutil.setActive(self._tabTypeRoot.gameObject, not isHot)

		if tabIndex == M.SubViewTyp.Hot then
			if not self._hotMoLst then
				self._loopListHot:ClearCells()
				AirWorkShopAtkAgent.instance:sendGetHotMapRequest()
			else
				self._scrollHot.verticalNormalizedPosition = 1
			end
		else
			self:refreshTypeTabEntry()
		end
	end

	local duration = needReflash and 0.3 or 0

	self._tabComp:MoveSelectMark(tabIndex, duration)
end

function M:refreshHotScroll(hotLst, resetPos)
	self._hotMoLst = hotLst

	local len = self._hotMoLst and #self._hotMoLst or 0

	if len > 0 then
		if resetPos then
			self._loopListHot:ClearCells()
		end

		self._loopListHot:SetListItemCount(len, resetPos)
		self._loopListHot:RefreshAllShownItem()
	else
		self._loopListHot:ClearCells()
	end

	goutil.setActive(self._goEmpty, len == 0)
end

function M:_onCellUpdateHot(curIndex)
	curIndex = curIndex + 1

	local data = self._hotMoLst[curIndex]
	local prefabName = "air_workshop_level_item"
	local item = self._loopListHot:NewListViewItem(prefabName)
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, AirWorkshopLevelItemCell)

	shower:updateData(data, AirAtkExtension_pb.AirPlayType.HOT)
	shower:setClickCheckFunc(self._onCellClickCheck, self)

	return item
end

function M:buildTypeViewPager()
	local pager = {}

	pager._activeIndex = nil

	function pager.setPage(pagerSelf, index)
		pager._activeIndex = index

		self:onPageChangeTypeScroll(pager._activeIndex, true)
	end

	function pager.getActiveIndex()
		return pager._activeIndex
	end

	function pager.setActiveIndex(index)
		pager._activeIndex = index
	end

	return pager
end

function M:refreshTypeTabEntry()
	local tabTypeLst = self._cfgTypeLst[self._activeIndex - 1]

	self._tabTypeViewPager.setActiveIndex(nil)
	self._toggleTabControlType:clear()
	self._toggleTabControlType:setViewPager(self._tabTypeViewPager)

	for i = 1, self._tabTypeRoot.childCount - 1 do
		local tr = self._tabTypeRoot:GetChild(i)
		local cfg = tabTypeLst[i]

		if cfg then
			self._toggleTabControlType:addToggleTab(tr:GetComponent(UIComponentType.SpaceXToggle))

			local txtName = goutil.findChildComponent(tr.gameObject, "normal/txtTitle", UIComponentType.Text)
			local txtName2 = goutil.findChildComponent(tr.gameObject, "select/txtTitle", UIComponentType.Text)

			txtName.text = cfg.tagName
			txtName2.text = cfg.tagName
		end

		goutil.setActive(tr.gameObject, cfg)
	end

	self._toggleTabControlType:selectTab(1)
end

function M:onPageChangeTypeScroll(tabIndex, resetPos)
	printWarn(self._activeIndex, tabIndex)

	local tabTypeLst = self._cfgTypeLst[self._activeIndex - 1]
	local cfg = tabTypeLst[tabIndex]

	self._loopListType:ClearCells()
	AirWorkShopDefAgent.instance:sendGetHotMapByTagRequest(cfg.id)
end

function M:refreshTypeScroll(hotLst, resetPos)
	self._typeMoLst = hotLst

	local len = self._typeMoLst and #self._typeMoLst or 0

	if len > 0 then
		if resetPos then
			self._loopListType:ClearCells()
		end

		self._loopListType:SetListItemCount(len, resetPos)
		self._loopListType:RefreshAllShownItem()
	else
		self._loopListType:ClearCells()
	end

	goutil.setActive(self._goEmpty, len == 0)
end

function M:_onCellUpdateType(curIndex)
	curIndex = curIndex + 1

	local data = self._typeMoLst[curIndex]
	local prefabName = "air_workshop_level_item"
	local item = self._loopListType:NewListViewItem(prefabName)
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, AirWorkshopLevelItemCell)

	shower:updateData(data, AirAtkExtension_pb.AirPlayType.HOT)
	shower:setClickCheckFunc(self._onCellClickCheck, self)

	return item
end

return M
