-- chunkname: @modules/logic/rouge2/map/view/choice/Rouge2_MapExploreChoiceViewContainer.lua

module("modules.logic.rouge2.map.view.choice.Rouge2_MapExploreChoiceViewContainer", package.seeall)

local Rouge2_MapExploreChoiceViewContainer = class("Rouge2_MapExploreChoiceViewContainer", BaseViewContainer)

function Rouge2_MapExploreChoiceViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapExploreChoiceView.New())
	table.insert(views, Rouge2_MapExploreChoiceViewExtend.New())
	table.insert(views, Rouge2_MapCoinView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Rouge2_MapExploreChoiceViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		false,
		false,
		false
	})

	return {
		self.navigateView
	}
end

return Rouge2_MapExploreChoiceViewContainer
