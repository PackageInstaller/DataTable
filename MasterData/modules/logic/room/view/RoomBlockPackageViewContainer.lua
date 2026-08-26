-- chunkname: @modules/logic/room/view/RoomBlockPackageViewContainer.lua

module("modules.logic.room.view.RoomBlockPackageViewContainer", package.seeall)

local RoomBlockPackageViewContainer = class("RoomBlockPackageViewContainer", BaseViewContainer)

function RoomBlockPackageViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomBlockPackageView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "middle/#scroll_detailed"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "middle/cloneItem/#go_detailedItem"
	scrollParam.cellClass = RoomBlockPackageDetailedItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 298
	scrollParam.cellHeight = 360
	scrollParam.cellSpaceH = 52.5
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 26

	table.insert(views, LuaListScrollView.New(RoomShowBlockPackageListModel.instance, scrollParam))

	local screenWidth = self:getUIScreenWidth()
	local scrollWidth = screenWidth - 182 - 46 - 52 - 73
	local cellWidth = 440
	local lineCount = math.floor(scrollWidth / cellWidth)
	local cellSpaceH = 0

	lineCount = math.max(lineCount, 1)

	if lineCount > 1 then
		cellSpaceH = (scrollWidth - cellWidth * lineCount + 96) / lineCount
		cellSpaceH = math.max(0, (scrollWidth - cellWidth * lineCount + 96) / lineCount)
	end

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "middle/#scroll_simple"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "middle/cloneItem/#go_simpleItem"
	scrollParam.cellClass = RoomBlockPackageSimpleItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = lineCount
	scrollParam.cellWidth = cellWidth
	scrollParam.cellHeight = 56
	scrollParam.cellSpaceH = cellSpaceH
	scrollParam.cellSpaceV = 20
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(RoomShowBlockPackageListModel.instance, scrollParam))

	return views
end

function RoomBlockPackageViewContainer:getUIScreenWidth()
	local go = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP")

	if go then
		return recthelper.getWidth(go.transform)
	end

	local scale = 1080 / UnityEngine.Screen.height

	return (math.floor(UnityEngine.Screen.width * scale + 0.5))
end

function RoomBlockPackageViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return RoomBlockPackageViewContainer
