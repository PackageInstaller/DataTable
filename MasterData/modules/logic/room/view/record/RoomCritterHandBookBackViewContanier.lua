-- chunkname: @modules/logic/room/view/record/RoomCritterHandBookBackViewContanier.lua

module("modules.logic.room.view.record.RoomCritterHandBookBackViewContanier", package.seeall)

local RoomCritterHandBookBackViewContanier = class("RoomCritterHandBookBackViewContanier", BaseViewContainer)

function RoomCritterHandBookBackViewContanier:buildViews()
	local handbookbackScrollParam = ListScrollParam.New()

	handbookbackScrollParam.scrollGOPath = "bg/#scroll_view/"
	handbookbackScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	handbookbackScrollParam.prefabUrl = "bg/#scroll_view/Viewport/Content/item"
	handbookbackScrollParam.cellClass = RoomCritterHandBookBackItem
	handbookbackScrollParam.scrollDir = ScrollEnum.ScrollDirV
	handbookbackScrollParam.cellWidth = 230
	handbookbackScrollParam.cellHeight = 220
	handbookbackScrollParam.cellSpaceV = 0
	handbookbackScrollParam.cellSpaceH = 20
	handbookbackScrollParam.startSpace = 20
	handbookbackScrollParam.cellSpaceH = 0
	handbookbackScrollParam.lineCount = 4
	self._handbookbackView = RoomCritterHandBookBackView.New()
	self._handbookbackScrollView = LuaListScrollView.New(RoomHandBookBackListModel.instance, handbookbackScrollParam)

	local views = {}

	table.insert(views, self._handbookbackView)
	table.insert(views, self._handbookbackScrollView)

	return views
end

function RoomCritterHandBookBackViewContanier:getScrollView()
	return self._handbookbackScrollView
end

return RoomCritterHandBookBackViewContanier
