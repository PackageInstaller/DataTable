-- chunkname: @modules/logic/versionactivity3_3/marsha/view/MarshaGameViewContainer.lua

module("modules.logic.versionactivity3_3.marsha.view.MarshaGameViewContainer", package.seeall)

local MarshaGameViewContainer = class("MarshaGameViewContainer", BaseViewContainer)

function MarshaGameViewContainer:buildViews()
	local views = {}

	table.insert(views, MarshaGameView.New())
	table.insert(views, MarshaGameScene.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function MarshaGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, 3310003)

		return {
			self.navigateView
		}
	end
end

return MarshaGameViewContainer
