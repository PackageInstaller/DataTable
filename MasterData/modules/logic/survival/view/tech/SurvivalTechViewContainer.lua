-- chunkname: @modules/logic/survival/view/tech/SurvivalTechViewContainer.lua

module("modules.logic.survival.view.tech.SurvivalTechViewContainer", package.seeall)

local SurvivalTechViewContainer = class("SurvivalTechViewContainer", BaseViewContainer)

function SurvivalTechViewContainer:buildViews()
	return {
		SurvivalTechView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function SurvivalTechViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil)

		return {
			self.navigateButtonView
		}
	end
end

return SurvivalTechViewContainer
