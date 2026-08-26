-- chunkname: @modules/logic/rouge2/map/view/piecechoice/Rouge2_MapPieceChoiceViewContainer.lua

module("modules.logic.rouge2.map.view.piecechoice.Rouge2_MapPieceChoiceViewContainer", package.seeall)

local Rouge2_MapPieceChoiceViewContainer = class("Rouge2_MapPieceChoiceViewContainer", BaseViewContainer)

function Rouge2_MapPieceChoiceViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapPieceChoiceView.New())
	table.insert(views, Rouge2_MapPieceChoiceViewExtend.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Rouge2_MapPieceChoiceViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		false,
		false,
		false
	})

	self.setOverrideClose(self, self.exitCurView, self)

	return {
		self.navigateView
	}
end

function Rouge2_MapPieceChoiceViewContainer:setOverrideClose(func, funcObj)
	self.navigateView:setOverrideClose(func, funcObj)
end

function Rouge2_MapPieceChoiceViewContainer:exitCurView()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onExitPieceChoiceEvent)
end

return Rouge2_MapPieceChoiceViewContainer
