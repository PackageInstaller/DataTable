-- chunkname: @modules/logic/towercompose/view/TowerComposeResearchViewContainer.lua

module("modules.logic.towercompose.view.TowerComposeResearchViewContainer", package.seeall)

local TowerComposeResearchViewContainer = class("TowerComposeResearchViewContainer", BaseViewContainer)

function TowerComposeResearchViewContainer:buildViews()
	local views = {}

	self:buildScrollViews()
	table.insert(views, self.scrollView)
	table.insert(views, TowerComposeResearchView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function TowerComposeResearchViewContainer:buildTabViews(tabContainerId)
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

function TowerComposeResearchViewContainer:buildScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/right/#scroll_task"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = TowerComposeResearchTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1040
	scrollParam.cellHeight = 156
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 8
	scrollParam.startSpace = 6
	scrollParam.frameUpdateMs = 100

	local animationDelayTimes = {}

	for i = 1, 5 do
		animationDelayTimes[i] = (i - 1) * 0.06
	end

	self.scrollView = LuaListScrollViewWithAnimator.New(TowerComposeTaskModel.instance, scrollParam, animationDelayTimes)
end

return TowerComposeResearchViewContainer
