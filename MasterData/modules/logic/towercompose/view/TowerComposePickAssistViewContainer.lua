-- chunkname: @modules/logic/towercompose/view/TowerComposePickAssistViewContainer.lua

module("modules.logic.towercompose.view.TowerComposePickAssistViewContainer", package.seeall)

local TowerComposePickAssistViewContainer = class("TowerComposePickAssistViewContainer", BaseViewContainer)

function TowerComposePickAssistViewContainer:buildViews()
	self.viewOpenAnimTime = 0.4

	local views = {}

	self.scrollView = self:instantiateListScrollView()

	table.insert(views, TowerComposePickAssistView.New())
	table.insert(views, self.scrollView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttopbtns"))

	return views
end

function TowerComposePickAssistViewContainer:instantiateListScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_selection"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = TowerComposePickAssistItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 6
	scrollParam.cellWidth = 296
	scrollParam.cellHeight = 636

	local animationDelayTimes = {}

	for i = 1, 15 do
		animationDelayTimes[i] = math.ceil((i - 1) % 6) * 0.03 + self.viewOpenAnimTime
	end

	return LuaListScrollViewWithAnimator.New(PickAssistListModel.instance, scrollParam, animationDelayTimes)
end

function TowerComposePickAssistViewContainer:buildTabViews(tabContainerId)
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

return TowerComposePickAssistViewContainer
