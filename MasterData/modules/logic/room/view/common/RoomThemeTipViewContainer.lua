-- chunkname: @modules/logic/room/view/common/RoomThemeTipViewContainer.lua

module("modules.logic.room.view.common.RoomThemeTipViewContainer", package.seeall)

local RoomThemeTipViewContainer = class("RoomThemeTipViewContainer", BaseViewContainer)

function RoomThemeTipViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomThemeTipView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "content/go_scroll/#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "content/themeitem"
	scrollParam.cellClass = RoomThemeTipItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 680
	scrollParam.cellHeight = 60
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 4
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	table.insert(views, LuaListScrollView.New(RoomThemeItemListModel.instance, scrollParam))

	return views
end

function RoomThemeTipViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return RoomThemeTipViewContainer
