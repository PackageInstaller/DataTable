-- chunkname: @modules/logic/room/view/layout/RoomLayoutItemTipsContainer.lua

module("modules.logic.room.view.layout.RoomLayoutItemTipsContainer", package.seeall)

local RoomLayoutItemTipsContainer = class("RoomLayoutItemTipsContainer", BaseViewContainer)

function RoomLayoutItemTipsContainer:buildViews()
	local views = {}

	table.insert(views, RoomLayoutItemTips.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_content/#scroll_ItemList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_content/#go_normalitem"
	scrollParam.cellClass = RoomLayoutItemTipsItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 550
	scrollParam.cellHeight = 52
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(RoomLayoutItemListModel.instance, scrollParam))

	return views
end

function RoomLayoutItemTipsContainer:getTipsHeight()
	local count = RoomLayoutItemListModel.instance:getCount()
	local minShowCount = 0
	local maxShowCount = 12.5
	local lineHeight = 52
	local top = 88
	local bottom = 20

	if count > 0 then
		count = count + 0.5
	end

	count = math.max(minShowCount, count)
	count = math.min(maxShowCount, count)

	return count * lineHeight + top + bottom
end

return RoomLayoutItemTipsContainer
