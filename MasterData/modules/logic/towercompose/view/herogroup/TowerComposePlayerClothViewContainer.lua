-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposePlayerClothViewContainer.lua

module("modules.logic.towercompose.view.herogroup.TowerComposePlayerClothViewContainer", package.seeall)

local TowerComposePlayerClothViewContainer = class("TowerComposePlayerClothViewContainer", PlayerClothViewContainer)

function TowerComposePlayerClothViewContainer:buildViews()
	local listParam = ListScrollParam.New()

	listParam.scrollGOPath = "#scroll_skills"
	listParam.prefabType = ScrollEnum.ScrollPrefabFromView
	listParam.prefabUrl = "#scroll_skills/Viewport/#go_skillitem"
	listParam.cellClass = TowerComposePlayerClothItem
	listParam.scrollDir = ScrollEnum.ScrollDirV
	listParam.lineCount = 1
	listParam.cellWidth = 300
	listParam.cellHeight = 155
	listParam.cellSpaceH = 0
	listParam.cellSpaceV = -4.34
	listParam.startSpace = 0
	self._clothListView = LuaListScrollView.New(PlayerClothListViewModel.instance, listParam)

	return {
		TowerComposePlayerClothView.New(),
		self._clothListView,
		TabViewGroup.New(1, "#go_btns")
	}
end

return TowerComposePlayerClothViewContainer
