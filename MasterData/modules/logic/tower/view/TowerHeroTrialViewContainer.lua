-- chunkname: @modules/logic/tower/view/TowerHeroTrialViewContainer.lua

module("modules.logic.tower.view.TowerHeroTrialViewContainer", package.seeall)

local TowerHeroTrialViewContainer = class("TowerHeroTrialViewContainer", BaseViewContainer)

function TowerHeroTrialViewContainer:buildViews()
	local views = {}

	self:buildScrollViews()
	table.insert(views, self.scrollView)
	table.insert(views, TowerHeroTrialView.New())

	return views
end

function TowerHeroTrialViewContainer:buildScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_hero"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_hero/Viewport/#go_heroContent/#go_heroItem"
	scrollParam.cellClass = TowerHeroTrialItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 2
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 160
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 30
	scrollParam.startSpace = 0
	scrollParam.frameUpdateMs = 100
	self.scrollView = LuaListScrollView.New(TowerHeroTrialListModel.instance, scrollParam)
end

return TowerHeroTrialViewContainer
