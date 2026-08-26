-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3ResetViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3ResetViewContainer", package.seeall)

local Season123_2_3ResetViewContainer = class("Season123_2_3ResetViewContainer", BaseViewContainer)

function Season123_2_3ResetViewContainer:buildViews()
	return {
		Season123_2_3CheckCloseView.New(),
		Season123_2_3ResetView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function Season123_2_3ResetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_3ResetViewHelp)
		self._navigateButtonView:hideHelpIcon()

		return {
			self._navigateButtonView
		}
	end
end

return Season123_2_3ResetViewContainer
