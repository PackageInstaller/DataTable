-- chunkname: @modules/logic/rouge/map/view/choice/RougeMapChoiceViewContainer.lua

module("modules.logic.rouge.map.view.choice.RougeMapChoiceViewContainer", package.seeall)

local RougeMapChoiceViewContainer = class("RougeMapChoiceViewContainer", BaseViewContainer)

function RougeMapChoiceViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeMapChoiceView.New())
	table.insert(views, RougeMapChoiceTipView.New())
	table.insert(views, RougeMapEntrustView.New())
	table.insert(views, RougeMapCoinView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function RougeMapChoiceViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self.navigateView
	}
end

return RougeMapChoiceViewContainer
