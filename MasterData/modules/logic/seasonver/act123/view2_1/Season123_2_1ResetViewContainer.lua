-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1ResetViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1ResetViewContainer", package.seeall)

local Season123_2_1ResetViewContainer = class("Season123_2_1ResetViewContainer", BaseViewContainer)

function Season123_2_1ResetViewContainer:buildViews()
	return {
		Season123_2_1CheckCloseView.New(),
		Season123_2_1ResetView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function Season123_2_1ResetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_1ResetViewHelp)
		self._navigateButtonView:hideHelpIcon()

		return {
			self._navigateButtonView
		}
	end
end

return Season123_2_1ResetViewContainer
