-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0ResetViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0ResetViewContainer", package.seeall)

local Season123_2_0ResetViewContainer = class("Season123_2_0ResetViewContainer", BaseViewContainer)

function Season123_2_0ResetViewContainer:buildViews()
	return {
		Season123_2_0CheckCloseView.New(),
		Season123_2_0ResetView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function Season123_2_0ResetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_0ResetViewHelp)
		self._navigateButtonView:hideHelpIcon()

		return {
			self._navigateButtonView
		}
	end
end

return Season123_2_0ResetViewContainer
