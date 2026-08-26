-- chunkname: @modules/logic/room/view/debug/RoomDebugViewContainer.lua

module("modules.logic.room.view.debug.RoomDebugViewContainer", package.seeall)

local RoomDebugViewContainer = class("RoomDebugViewContainer", BaseViewContainer)

function RoomDebugViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomViewDebugPlace.New())
	table.insert(views, RoomViewDebugPackage.New())
	table.insert(views, RoomViewDebugBuilding.New())
	table.insert(views, RoomDebugView.New())
	table.insert(views, RoomViewDebugCamera.New())
	self:_buildDebugPlaceListView(views)
	self:_buildDebugPackageListView(views)
	self:_buildDebugBuildingListView(views)

	return views
end

function RoomDebugViewContainer:_buildDebugPlaceListView(views)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "go_normalroot/go_debugplace/scroll_debugplace"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[6]
	scrollParam.cellClass = RoomDebugPlaceItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 300
	scrollParam.cellHeight = 234
	scrollParam.cellSpaceH = 10
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(RoomDebugPlaceListModel.instance, scrollParam))
end

function RoomDebugViewContainer:_buildDebugPackageListView(views)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "go_normalroot/go_debugpackage/scroll_debugpackage"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[7]
	scrollParam.cellClass = RoomDebugPackageItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 300
	scrollParam.cellHeight = 234
	scrollParam.cellSpaceH = 10
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(RoomDebugPackageListModel.instance, scrollParam))
end

function RoomDebugViewContainer:_buildDebugBuildingListView(views)
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "go_normalroot/go_debugbuilding/scroll_debugbuilding"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = RoomDebugBuildingItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 300
	scrollParam.cellHeight = 234
	scrollParam.cellSpaceH = 10
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(RoomDebugBuildingListModel.instance, scrollParam))
end

return RoomDebugViewContainer
