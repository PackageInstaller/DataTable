-- chunkname: @modules/logic/rouge2/map/view/choice/Rouge2_MapChoiceViewContainer.lua

module("modules.logic.rouge2.map.view.choice.Rouge2_MapChoiceViewContainer", package.seeall)

local Rouge2_MapChoiceViewContainer = class("Rouge2_MapChoiceViewContainer", BaseViewContainer)

function Rouge2_MapChoiceViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapChoiceView.New())
	table.insert(views, Rouge2_MapChoiceViewExtend.New())
	table.insert(views, Rouge2_MapCoinView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Rouge2_MapChoiceViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		false,
		false,
		false
	})

	return {
		self.navigateView
	}
end

return Rouge2_MapChoiceViewContainer
