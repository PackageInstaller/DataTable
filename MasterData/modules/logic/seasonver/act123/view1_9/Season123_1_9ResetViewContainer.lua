-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9ResetViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9ResetViewContainer", package.seeall)

local Season123_1_9ResetViewContainer = class("Season123_1_9ResetViewContainer", BaseViewContainer)

function Season123_1_9ResetViewContainer:buildViews()
	return {
		Season123_1_9CheckCloseView.New(),
		Season123_1_9ResetView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function Season123_1_9ResetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_9ResetViewHelp)
		self._navigateButtonView:hideHelpIcon()

		return {
			self._navigateButtonView
		}
	end
end

return Season123_1_9ResetViewContainer
