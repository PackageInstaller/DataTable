-- chunkname: @modules/logic/room/view/critter/RoomCritterTrainViewContainer.lua

module("modules.logic.room.view.critter.RoomCritterTrainViewContainer", package.seeall)

local RoomCritterTrainViewContainer = class("RoomCritterTrainViewContainer", BaseViewContainer)

function RoomCritterTrainViewContainer:buildViews()
	return RoomCritterTrainViewContainer.createViewList()
end

function RoomCritterTrainViewContainer.createViewList()
	local viewDetail = RoomCritterTrainViewDetail.New()
	local viewSelect = RoomCritterTrainViewSelect.New()
	local tranView = RoomCritterTrainView.New()

	tranView.viewDetail = viewDetail
	tranView.viewSelect = viewSelect

	return {
		viewDetail,
		viewSelect,
		tranView,
		RoomCritterTrainViewAnim.New(),
		RoomCritterTrainViewContainer._createSlotScrollView(),
		RoomCritterTrainViewContainer._createHeroScrollView(),
		RoomCritterTrainViewContainer._createCritterScrollView()
	}
end

function RoomCritterTrainViewContainer._createSlotScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#go_slotSub/#scroll_slot"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = RoomTrainSlotItem.prefabPath
	scrollParam.cellClass = RoomTrainSlotItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 300
	scrollParam.cellHeight = 200
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	return (LuaListScrollView.New(RoomTrainSlotListModel.instance, scrollParam))
end

function RoomCritterTrainViewContainer._createHeroScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#go_heroSub/#scroll_hero"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = RoomTrainHeroItem.prefabPath
	scrollParam.cellClass = RoomTrainHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 540
	scrollParam.cellHeight = 184
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 8.6
	scrollParam.startSpace = 0
	scrollParam.emptyScrollParam = EmptyScrollParam.New()

	scrollParam.emptyScrollParam:setFromView("right/#go_heroSub/#go_empty")

	return (LuaListScrollView.New(RoomTrainHeroListModel.instance, scrollParam))
end

function RoomCritterTrainViewContainer._createCritterScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#go_critterSub/#scroll_critter"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = RoomCritterTrainItem.prefabPath
	scrollParam.cellClass = RoomCritterTrainItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 540
	scrollParam.cellHeight = 184
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 8.6
	scrollParam.startSpace = 14
	scrollParam.emptyScrollParam = EmptyScrollParam.New()

	scrollParam.emptyScrollParam:setFromView("right/#go_critterSub/#go_empty")

	return (LuaListScrollView.New(RoomTrainCritterListModel.instance, scrollParam))
end

return RoomCritterTrainViewContainer
