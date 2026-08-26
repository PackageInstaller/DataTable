-- chunkname: @modules/logic/room/view/gift/RoomBlockGiftChoiceViewContainer.lua

module("modules.logic.room.view.gift.RoomBlockGiftChoiceViewContainer", package.seeall)

local RoomBlockGiftChoiceViewContainer = class("RoomBlockGiftChoiceViewContainer", BaseViewContainer)

function RoomBlockGiftChoiceViewContainer:buildViews()
	local views = {}
	local blockScrollParam = ListScrollParam.New()

	blockScrollParam.scrollGOPath = "#scroll_block"
	blockScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	blockScrollParam.prefabUrl = "#go_blockItem"
	blockScrollParam.cellClass = RoomBlockGiftPackageItem
	blockScrollParam.scrollDir = ScrollEnum.ScrollDirV
	blockScrollParam.lineCount = 5

	local blockSubTypeInfo = RoomBlockGiftEnum.SubTypeInfo[MaterialEnum.MaterialType.BlockPackage]

	blockScrollParam.cellWidth = blockSubTypeInfo.CellSize[1]
	blockScrollParam.cellHeight = blockSubTypeInfo.CellSize[2]
	blockScrollParam.cellSpaceH = blockSubTypeInfo.CellSpacing[1]
	blockScrollParam.cellSpaceV = blockSubTypeInfo.CellSpacing[2]

	table.insert(views, LuaListScrollView.New(RoomBlockGiftListModel.instance, blockScrollParam))

	local buildingScrollParam = ListScrollParam.New()

	buildingScrollParam.scrollGOPath = "#scroll_building"
	buildingScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	buildingScrollParam.prefabUrl = "#go_buildingItem"
	buildingScrollParam.cellClass = RoomBlockGiftBuildingItem
	buildingScrollParam.scrollDir = ScrollEnum.ScrollDirV
	buildingScrollParam.startSpace = 20
	buildingScrollParam.lineCount = 4

	local buildingSubTypeInfo = RoomBlockGiftEnum.SubTypeInfo[MaterialEnum.MaterialType.Building]

	buildingScrollParam.cellWidth = buildingSubTypeInfo.CellSize[1]
	buildingScrollParam.cellHeight = buildingSubTypeInfo.CellSize[2]
	buildingScrollParam.cellSpaceH = buildingSubTypeInfo.CellSpacing[1]
	buildingScrollParam.cellSpaceV = buildingSubTypeInfo.CellSpacing[2]

	table.insert(views, LuaListScrollView.New(RoomBuildingGiftListModel.instance, buildingScrollParam))
	table.insert(views, RoomBlockGiftChoiceView.New())

	return views
end

return RoomBlockGiftChoiceViewContainer
