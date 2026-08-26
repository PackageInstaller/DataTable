-- chunkname: @modules/logic/rouge/map/view/piecechoice/RougeMapPieceChoiceViewContainer.lua

module("modules.logic.rouge.map.view.piecechoice.RougeMapPieceChoiceViewContainer", package.seeall)

local RougeMapPieceChoiceViewContainer = class("RougeMapPieceChoiceViewContainer", BaseViewContainer)

function RougeMapPieceChoiceViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeMapPieceChoiceView.New())
	table.insert(views, RougeMapCoinView.New())
	table.insert(views, RougeMapEntrustView.New())
	table.insert(views, RougeMapChoiceTipView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function RougeMapPieceChoiceViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self.navigateView
	}
end

function RougeMapPieceChoiceViewContainer:setOverrideClose(func, funcObj)
	self.navigateView:setOverrideClose(func, funcObj)
end

return RougeMapPieceChoiceViewContainer
