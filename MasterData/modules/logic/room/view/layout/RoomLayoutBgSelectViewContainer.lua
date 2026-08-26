-- chunkname: @modules/logic/room/view/layout/RoomLayoutBgSelectViewContainer.lua

module("modules.logic.room.view.layout.RoomLayoutBgSelectViewContainer", package.seeall)

local RoomLayoutBgSelectViewContainer = class("RoomLayoutBgSelectViewContainer", BaseViewContainer)

function RoomLayoutBgSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomLayoutBgSelectView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_content/#scroll_CoverItemList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_content/#go_coveritem"
	scrollParam.cellClass = RoomLayoutBgSelectItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 520
	scrollParam.cellHeight = 254
	scrollParam.cellSpaceH = 20
	scrollParam.cellSpaceV = 20
	scrollParam.startSpace = 20

	table.insert(views, LuaListScrollView.New(RoomLayoutBgResListModel.instance, scrollParam))

	return views
end

return RoomLayoutBgSelectViewContainer
