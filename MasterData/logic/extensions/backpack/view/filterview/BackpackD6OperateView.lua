-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/filterview/BackpackD6OperateView.lua

module("logic.extensions.backpack.view.filterview.BackpackD6OperateView", package.seeall)

local M = class("BackpackD6OperateView", ViewComponent)
local index2SortType = {
	CommEnum.MainBackpackSortType.Quality,
	CommEnum.MainBackpackSortType.Time
}
local defaultSortType = CommEnum.MainBackpackSortType.Quality
local D6ShowType = CommEnum.MainBackpackShowType.D6ShowType

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._rootGo = self:getGo("backpack_view_copy_-1457613920")
	self._btnFilter = self:getBtn("backpack_view_copy_-1983898562")
	self._d6FilterComp = Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "d6_filter_tips"), D6FilterComponent)

	self._d6FilterComp:OnBuildUI()
	self._d6FilterComp:setEvent(EventType.BACKPACK_FILTER_EVENT)

	self._btnSort = self:getBtn("backpack_view_copy_-1457936235")
	self._sortText = self:getText("backpack_view_copy_1307434746")
	self._sortItemsParent = goutil.findChild(self._btnSort.gameObject, "Template")
	self._sortUpGo = goutil.findChild(self._btnSort.gameObject, "up")
	self._sortDownGo = goutil.findChild(self._btnSort.gameObject, "down")
	self._sortItems = {}

	for i = 1, 2 do
		local sortItem = goutil.findChild(self._sortItemsParent, "Content/Item" .. i)
		local itemView = Astral.LuaComponentContainer.Add(sortItem, BackpackSortItem)
		local sortType = index2SortType[i]

		itemView:setData(BackpackItemSortData.New(sortType, false))
		itemView:setEvent(EventType.BACKPACK_SORT_ITEM_CLICK)
		itemView:setSelect(sortType == defaultSortType)
		table.insert(self._sortItems, itemView)
	end

	self._btnMask = self:getBtn("backpack_view_copy_-861743299")

	goutil.setActive(self._btnMask.gameObject, false)
end

function M:destroyUI()
	self._d6FilterComp:OnDestroy()
end

function M:onEnter()
	self:initData()
	self:initUI()
end

function M:initData()
	self._curSort = nil

	local filterCfg = MainBackpackModel.instance:getFilterCfg(D6ShowType)

	self._d6FilterComp:setData(filterCfg)
end

function M:initUI()
	goutil.setActive(self._sortItemsParent, false)
	self:_refreshSort()
end

function M:onExit()
	self._btnMask:RemoveClickListener()
	self._d6FilterComp:clear()
end

function M:bindEvents()
	self._btnFilter:AddClickListener(self._onClickFilterBtn, self)
	self._btnSort:AddClickListener(self._onClickSortBtn, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_TO_SWITCH_SHOW_TYPE, self._onSwitchShowType, self)
end

function M:unbindEvents()
	self._btnFilter:RemoveClickListener()
	self._btnSort:RemoveClickListener()
	self._btnMask:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_TO_SWITCH_SHOW_TYPE, self._onSwitchShowType, self)
end

function M:_onClickMaskBtn()
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._sortItemsParent, false)
end

function M:_onClickFilterBtn()
	if self._sortItemsParent.activeSelf then
		goutil.setActive(self._sortItemsParent, false)
		goutil.setActive(self._btnMask.gameObject, false)

		return
	end

	self._d6FilterComp:setVisible(true)
end

function M:_onClickSortBtn()
	local active = not self._sortItemsParent.activeSelf

	goutil.setActive(self._sortItemsParent, active)
	goutil.setActive(self._btnMask.gameObject, active)
end

function M:_onClickRecycleBtn()
	goutil.setActive(self._sortItemsParent, false)
	goutil.setActive(self._btnMask.gameObject, false)
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_ENTER_RECYCLE)
end

function M:_onSwitchShowType(e, showType)
	local isShow = showType == D6ShowType

	goutil.setActive(self._rootGo, isShow)

	if isShow then
		self._btnMask:RemoveClickListener()
		self._btnMask:AddClickListener(self._onClickMaskBtn, self)
	end
end

function M:_onBackpackPageDataChanged(e, changeType)
	local curShowType = MainBackpackModel.instance:getCurShowType()
	local isShowD6 = curShowType == D6ShowType and not MainBackpackModel.instance:isEmpty()

	goutil.setActive(self._rootGo, isShowD6)

	if isShowD6 and changeType == CommEnum.MainBackpackRefreshType.Sort then
		self:_refreshSort()
	end
end

function M:_refreshCapacity()
	return
end

function M:_refreshSort()
	local BackpackItemSortData = MainBackpackModel.instance:getCurSortData()

	if BackpackItemSortData then
		self._sortText.text = BackpackItemSortData:getName()

		local isUp = BackpackItemSortData.isUp

		goutil.setActive(self._sortUpGo, isUp)
		goutil.setActive(self._sortDownGo, not isUp)

		for index, item in ipairs(self._sortItems) do
			item:setSelect(index2SortType[index] == BackpackItemSortData.sortType)
		end
	else
		goutil.setActive(self._sortUpGo, false)
		goutil.setActive(self._sortDownGo, true)

		for i, itemView in ipairs(self._sortItems) do
			local sortData = itemView:getData()

			sortData.isUp = false

			itemView:setSelect(sortData.sortType == defaultSortType)
			itemView:showUp(false)
		end
	end
end

return M
