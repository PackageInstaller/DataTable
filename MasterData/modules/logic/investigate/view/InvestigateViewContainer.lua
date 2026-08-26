-- chunkname: @modules/logic/investigate/view/InvestigateViewContainer.lua

module("modules.logic.investigate.view.InvestigateViewContainer", package.seeall)

local InvestigateViewContainer = class("InvestigateViewContainer", BaseViewContainer)

function InvestigateViewContainer:buildViews()
	return {
		InvestigateView.New(),
		TabViewGroup.New(1, "root/#go_topleft")
	}
end

function InvestigateViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self.navigateView
	}
end

return InvestigateViewContainer
