-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8ResetViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8ResetViewContainer", package.seeall)

local Season123_1_8ResetViewContainer = class("Season123_1_8ResetViewContainer", BaseViewContainer)

function Season123_1_8ResetViewContainer:buildViews()
	return {
		Season123_1_8CheckCloseView.New(),
		Season123_1_8ResetView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function Season123_1_8ResetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_8ResetViewHelp)
		self._navigateButtonView:hideHelpIcon()

		return {
			self._navigateButtonView
		}
	end
end

return Season123_1_8ResetViewContainer
