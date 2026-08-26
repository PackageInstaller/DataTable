-- chunkname: @modules/logic/turnback/view/TurnbackPickEquipViewContainer.lua

module("modules.logic.turnback.view.TurnbackPickEquipViewContainer", package.seeall)

local TurnbackPickEquipViewContainer = class("TurnbackPickEquipViewContainer", BaseViewContainer)

function TurnbackPickEquipViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/#scroll_equiplist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "root/#scroll_equiplist/viewport/content/#go_item"
	scrollParam.cellClass = TurnbackPickEquipListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 560
	scrollParam.cellHeight = 300
	scrollParam.cellSpaceH = 50
	scrollParam.cellSpaceV = 30
	scrollParam.startSpace = 10

	table.insert(views, LuaListScrollView.New(TurnbackPickEquipListModel.instance, scrollParam))
	table.insert(views, TurnbackPickEquipView.New())

	return views
end

return TurnbackPickEquipViewContainer
