-- chunkname: @modules/logic/room/view/debug/RoomDebugThemeFilterViewContainer.lua

module("modules.logic.room.view.debug.RoomDebugThemeFilterViewContainer", package.seeall)

local RoomDebugThemeFilterViewContainer = class("RoomDebugThemeFilterViewContainer", BaseViewContainer)

function RoomDebugThemeFilterViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomDebugThemeFilterView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_content/#scroll_theme"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_content/#go_themeitem"
	scrollParam.cellClass = RoomDebugThemeFilterItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 386
	scrollParam.cellHeight = 80
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	table.insert(views, LuaListScrollView.New(RoomDebugThemeFilterListModel.instance, scrollParam))

	return views
end

function RoomDebugThemeFilterViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return RoomDebugThemeFilterViewContainer
