-- chunkname: @modules/logic/room/view/common/RoomThemeFilterViewContainer.lua

module("modules.logic.room.view.common.RoomThemeFilterViewContainer", package.seeall)

local RoomThemeFilterViewContainer = class("RoomThemeFilterViewContainer", BaseViewContainer)
local Cell_Width = 386
local Cell_Height = 80
local Line_Count = 3

function RoomThemeFilterViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomThemeFilterView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_content/#scroll_theme"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_content/#go_themeitem"
	scrollParam.cellClass = RoomThemeFilterItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = Line_Count
	scrollParam.cellWidth = Cell_Width
	scrollParam.cellHeight = Cell_Height
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	table.insert(views, LuaListScrollView.New(RoomThemeFilterListModel.instance, scrollParam))

	return views
end

function RoomThemeFilterViewContainer:onContainerClickModalMask()
	self:closeThis()
end

function RoomThemeFilterViewContainer:getUIScreenWidth()
	local go = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP")

	if go then
		return recthelper.getWidth(go.transform)
	end

	local scale = 1080 / UnityEngine.Screen.height

	return (math.floor(UnityEngine.Screen.width * scale + 0.5))
end

function RoomThemeFilterViewContainer:layoutContentTrs(contentTrs, isBottom)
	local halfWidth = 1220
	local halfScreen = self:getUIScreenWidth() * 0.5
	local itemCount = RoomThemeFilterListModel.instance:getCount()
	local countHeight = math.floor((itemCount + Line_Count - 1) / Line_Count) * Cell_Height + 130 + 26

	if isBottom then
		local left = 173
		local leftX = -halfScreen + left

		recthelper.setAnchorX(contentTrs, leftX)
	else
		local right = 46
		local left = 668
		local maxX = halfScreen - halfWidth - right
		local leftX = -halfScreen + left
		local x = math.min(leftX, maxX)

		recthelper.setHeight(contentTrs, math.min(countHeight, 605))
		recthelper.setAnchor(contentTrs, x, 85)
	end
end

return RoomThemeFilterViewContainer
