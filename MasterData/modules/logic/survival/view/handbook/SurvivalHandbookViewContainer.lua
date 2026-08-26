-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookViewContainer.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookViewContainer", package.seeall)

local SurvivalHandbookViewContainer = class("SurvivalHandbookViewContainer", BaseViewContainer)

function SurvivalHandbookViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_btns"),
		SurvivalHandbookView.New()
	}
end

function SurvivalHandbookViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateButtonView
		}
	end
end

function SurvivalHandbookViewContainer:onContainerOpenFinish()
	self.navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

return SurvivalHandbookViewContainer
