-- chunkname: @modules/logic/seasonver/act123/view/Season123ResetViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123ResetViewContainer", package.seeall)

local Season123ResetViewContainer = class("Season123ResetViewContainer", BaseViewContainer)

function Season123ResetViewContainer:buildViews()
	return {
		Season123CheckCloseView.New(),
		Season123ResetView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function Season123ResetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_7ResetViewHelp)

		return {
			self._navigateButtonView
		}
	end
end

return Season123ResetViewContainer
