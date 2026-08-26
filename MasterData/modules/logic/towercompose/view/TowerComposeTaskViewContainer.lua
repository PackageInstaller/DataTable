-- chunkname: @modules/logic/towercompose/view/TowerComposeTaskViewContainer.lua

module("modules.logic.towercompose.view.TowerComposeTaskViewContainer", package.seeall)

local TowerComposeTaskViewContainer = class("TowerComposeTaskViewContainer", BaseViewContainer)

function TowerComposeTaskViewContainer:buildViews()
	local views = {}

	self:buildScrollViews()
	table.insert(views, self.scrollView)
	table.insert(views, TowerComposeTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function TowerComposeTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

function TowerComposeTaskViewContainer:buildScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = TowerComposeTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1136
	scrollParam.cellHeight = 165
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.frameUpdateMs = 100

	local animationDelayTimes = {}

	for i = 1, 6 do
		animationDelayTimes[i] = (i - 1) * 0.06
	end

	self.scrollView = LuaListScrollViewWithAnimator.New(TowerComposeTaskModel.instance, scrollParam, animationDelayTimes)
end

return TowerComposeTaskViewContainer
