-- chunkname: @modules/logic/room/view/building/RoomFormulaViewContainer.lua

module("modules.logic.room.view.building.RoomFormulaViewContainer", package.seeall)

local RoomFormulaViewContainer = class("RoomFormulaViewContainer", BaseViewContainer)

RoomFormulaViewContainer.cellHeightSize = 150

function RoomFormulaViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomFormulaView.New())
	self:_buildFormulaItemListView(views)

	return views
end

function RoomFormulaViewContainer:_buildFormulaItemListView(views)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "view/#scroll_formula"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = RoomFormulaItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 980
	scrollParam.cellHeight = self.cellHeightSize
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	self.__scrollView = LuaListScrollView.New(RoomFormulaListModel.instance, scrollParam)

	table.insert(views, self.__scrollView)
end

function RoomFormulaViewContainer:getScrollView()
	return self.__scrollView
end

function RoomFormulaViewContainer:getCsListScroll()
	local scrollView = self:getScrollView()

	return (scrollView:getCsListScroll())
end

return RoomFormulaViewContainer
