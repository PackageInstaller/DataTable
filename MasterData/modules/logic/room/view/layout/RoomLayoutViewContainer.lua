-- chunkname: @modules/logic/room/view/layout/RoomLayoutViewContainer.lua

module("modules.logic.room.view.layout.RoomLayoutViewContainer", package.seeall)

local RoomLayoutViewContainer = class("RoomLayoutViewContainer", BaseViewContainer)

function RoomLayoutViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "go_normalroot/#scroll_ItemList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = RoomLayoutItem.prefabUrl
	scrollParam.cellClass = RoomLayoutItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 2
	scrollParam.cellWidth = 690
	scrollParam.cellHeight = 400
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	self._scrollParam = scrollParam
	self._luaScrollView = LuaListScrollView.New(RoomLayoutListModel.instance, scrollParam)

	table.insert(views, self._luaScrollView)
	table.insert(views, RoomLayoutView.New())

	if not RoomController.instance:isVisitMode() then
		table.insert(views, TabViewGroup.New(1, "go_navigatebtn"))
	end

	return views
end

function RoomLayoutViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function RoomLayoutViewContainer:getCsListScroll()
	return self._luaScrollView:getCsListScroll()
end

function RoomLayoutViewContainer:getListScrollParam()
	return self._scrollParam
end

function RoomLayoutViewContainer:movetoSelect()
	local tRoomLayoutListModel = RoomLayoutListModel.instance
	local selectMO = tRoomLayoutListModel:getSelectMO()

	if selectMO == nil then
		return
	end

	local selectIndex = tRoomLayoutListModel:getIndex(selectMO)

	if selectIndex == nil then
		return
	end

	local csListView = self._luaScrollView:getCsListScroll()

	if not csListView then
		return
	end

	local cellWidth = self._scrollParam.cellWidth + self._scrollParam.cellSpaceH
	local lineCount = self._scrollParam.lineCount
	local columnIdx = Mathf.Ceil(selectIndex / lineCount)
	local width = recthelper.getWidth(csListView.transform)
	local scrollPixel = Mathf.Max(0, columnIdx - 1) * cellWidth

	csListView.HorizontalScrollPixel = Mathf.Max(0, scrollPixel)

	csListView:UpdateCells(false)
end

return RoomLayoutViewContainer
