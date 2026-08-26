-- chunkname: @modules/logic/versionactivity/view/VersionActivityPushBoxGameViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityPushBoxGameViewContainer", package.seeall)

local VersionActivityPushBoxGameViewContainer = class("VersionActivityPushBoxGameViewContainer", BaseViewContainer)

function VersionActivityPushBoxGameViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_btns"),
		VersionActivityPushBoxGameView.New()
	}
end

function VersionActivityPushBoxGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.PushBox)

		return {
			self._navigateButtonView
		}
	end
end

return VersionActivityPushBoxGameViewContainer
