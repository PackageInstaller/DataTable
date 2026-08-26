-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5ResetViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5ResetViewContainer", package.seeall)

local Season123_3_5ResetViewContainer = class("Season123_3_5ResetViewContainer", BaseViewContainer)

function Season123_3_5ResetViewContainer:buildViews()
	return {
		Season123_3_5CheckCloseView.New(),
		Season123_3_5ResetView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function Season123_3_5ResetViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Season3_5ResetViewHelp)
		self._navigateButtonView:hideHelpIcon()

		return {
			self._navigateButtonView
		}
	end
end

return Season123_3_5ResetViewContainer
