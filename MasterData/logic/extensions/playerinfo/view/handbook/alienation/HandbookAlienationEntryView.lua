-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/alienation/HandbookAlienationEntryView.lua

module("logic.extensions.playerinfo.view.handbook.alienation.HandbookAlienationEntryView", package.seeall)

local M = class("HandbookAlienationEntryView", ViewComponent)

M.SubToggleType = {
	Protomer = 1,
	EchoItem = 2
}
M.PageTyp2GalleryTyp = {
	[M.SubToggleType.Protomer] = GameEnum.UnlockTypeEnum.Protomer,
	[M.SubToggleType.EchoItem] = GameEnum.UnlockTypeEnum.EchoItem
}

function M:ctor()
	M.super.ctor(self)
end

function M:getSubPageTyp()
	return CommEnum.HandBookSubView.Alienation
end

function M:buildUI()
	self._btnReturn = self:getBtn("3&title_view_-878360263")
	self._loopLstGroup = {}
	self._loopLstGroup[self.SubToggleType.Protomer] = {
		gameObject = self:getGo("handbook_alienation_entry_view_1214317577"),
		loopLst = LoopGridViewHelper.New(self:getGo("handbook_alienation_entry_view_1214317577"))
	}
	self._loopLstGroup[self.SubToggleType.EchoItem] = {
		gameObject = self:getGo("handbook_alienation_entry_view_559704454"),
		loopLst = LoopGridViewHelper.New(self:getGo("handbook_alienation_entry_view_559704454"))
	}

	self._loopLstGroup[self.SubToggleType.Protomer].loopLst:InitGridView(0, self._onProtomerUpdate, self)
	self._loopLstGroup[self.SubToggleType.EchoItem].loopLst:InitGridView(0, self._onEchoItemUpdate, self)

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(nil)

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("right_tab_content_-399612422"), HandbookRightTabComp)

	self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(1))
	self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(2))
end

function M:destroyUI()
	self._tabComp:destroyUI()

	self._btnReturn = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	for _, shower in pairs(self._cellItem or {}) do
		shower:destroyUI()
	end

	for _, comps in pairs(self._loopLstGroup or {}) do
		comps.loopLst:Dispose()

		comps.loopLst = nil
	end

	self._loopLstGroup = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()

	for _, shower in pairs(self._cellItem or {}) do
		shower:unbindEvents()
	end
end

function M:onEnter()
	self:setEvent(true)

	self._cellItem = {}

	self:_prepareData()
	self:_refreshTabNewMark()

	local defaultSelectTabIndex = 1

	self._toggleTabControl:selectTab(defaultSelectTabIndex)
end

function M:onExit()
	self:setEvent(false)
	goutil.setActive(self._lastLoopLstGobj, false)

	self._lastLoopLstGobj = nil

	self:setActiveIndex(nil)

	for _, shower in pairs(self._cellItem or {}) do
		shower:onExit()
		shower:unbindEvents()
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	end
end

function M:_handleHandbookUnreadInfoChange(e)
	self:_refreshTabNewMark()
end

function M:_refreshTabNewMark()
	for keyStr, valInt in pairs(self.SubToggleType) do
		local redPoint = self:_getPageUnReadCount(valInt)

		self._tabComp:setRedPointNum(valInt, redPoint)
	end
end

function M:_onClickReturn()
	self:close()
end

function M:onCellClick(cgItemCell)
	local id = cgItemCell:getId()
	local galleryTypeEnum = cgItemCell:getGalleryTypeEnum()
	local isLock = cgItemCell:getIsLock()

	print(string.format("cell click[%s] typ[%s] lock[%s]", id, galleryTypeEnum, isLock))

	if galleryTypeEnum == GameEnum.UnlockTypeEnum.Protomer then
		ContainmentFacade.instance:openPrototypeInfoView(id)
	elseif galleryTypeEnum == GameEnum.UnlockTypeEnum.EchoItem then
		local params = {
			index = isLock and HandbookEchoDetailView.SubViewType.Effect or HandbookEchoDetailView.SubViewType.Detail,
			isLock = isLock,
			echoItemId = id
		}

		ViewMgr.instance:open(ViewName.HandbookEchoDetailView, params)
	end
end

function M:getActiveIndex()
	return self._activeIndex or -1
end

function M:setActiveIndex(index)
	self._activeIndex = index
end

function M:setPage(tabIndex)
	local orgIndex = self:getActiveIndex()
	local needReresh = orgIndex ~= tabIndex

	self:setActiveIndex(tabIndex)

	if needReresh then
		if self._lastLoopLstGobj then
			goutil.setActive(self._lastLoopLstGobj, false)
		end

		local nowActiveIndex = self:getActiveIndex()
		local len = self:_getItemDataLstLen(nowActiveIndex)
		local loopLst = self:_getLoopLst(nowActiveIndex)

		self._lastLoopLstGobj = self:_getLoopLstGameObject(nowActiveIndex)

		goutil.setActive(self._lastLoopLstGobj, true)

		if len > 0 then
			loopLst:SetListItemCount(len, true)
			loopLst:RefreshAllShownItem()
		else
			loopLst:ClearCells()
		end
	end
end

function M:_prepareData()
	self._pageDataGroup = {}
	self._pageDataGroup[self.SubToggleType.Protomer] = {}
	self._pageDataGroup[self.SubToggleType.EchoItem] = {}

	local cfgLst = HandbookConfig.instance:getConfigList(ConfigName.GalleryProtomer)

	if cfgLst and #cfgLst > 0 then
		for _, cfg in ipairs(cfgLst) do
			table.insert(self._pageDataGroup[self.SubToggleType.Protomer], cfg)
		end
	end

	cfgLst = HandbookConfig.instance:getConfigList(ConfigName.GalleryEchoItem)

	if cfgLst and #cfgLst > 0 then
		for _, cfg in ipairs(cfgLst) do
			table.insert(self._pageDataGroup[self.SubToggleType.EchoItem], cfg)
		end
	end

	for key, lst in pairs(self._pageDataGroup) do
		if #lst > 0 then
			table.sort(lst, function(a, b)
				return a.sortType > b.sortType
			end)

			self._pageDataGroup[key] = lst
		end
	end
end

function M:_getPageUnReadCount(pageTyp)
	local count = 0

	for index, cfg in ipairs(self._pageDataGroup[pageTyp] or {}) do
		if GalleryModel.instance:getIsIdUnRead(self.PageTyp2GalleryTyp[pageTyp], cfg.id) then
			count = count + 1
		end
	end

	return count
end

function M:_getLoopLst(pageTyp)
	return self._loopLstGroup[pageTyp].loopLst
end

function M:_getLoopLstGameObject(pageTyp)
	return self._loopLstGroup[pageTyp].gameObject
end

function M:_getItemDataLst(pageTyp)
	return self._pageDataGroup[pageTyp] or {}
end

function M:_getItemDataLstLen(pageTyp)
	local dataLst = self._pageDataGroup[pageTyp]

	return dataLst and #dataLst or 0
end

function M:_getItemData(index)
	local curPageTyp = self:getActiveIndex()

	if self._pageDataGroup[curPageTyp] then
		return self._pageDataGroup[curPageTyp][index]
	else
		return nil
	end
end

function M:_onProtomerUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local data = self:_getItemData(curIndex)
	local loopLst = self:_getLoopLst(self.SubToggleType.Protomer)
	local item = loopLst:NewListViewItem("handbook_alienation_holding_item")
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, HandbookProtomerItemCell)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, HandbookProtomerItemCell)

		shower:buildUI()
	end

	shower:bindEvents()
	shower:onEnter()
	shower:setHandler(self)
	shower:setData(data)

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

function M:_onEchoItemUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local data = self:_getItemData(curIndex)
	local loopLst = self:_getLoopLst(self.SubToggleType.EchoItem)
	local item = loopLst:NewListViewItem("handbook_alienation_carry_item")
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, HandbookEchoItemCell)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, HandbookEchoItemCell)

		shower:buildUI()
	end

	shower:bindEvents()
	shower:onEnter()
	shower:setHandler(self)
	shower:setData(data)

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

return M
