-- chunkname: @modules/logic/autochess/main/view/v4a0/AutoChessLeaderSelectViewContainer.lua

module("modules.logic.autochess.main.view.v4a0.AutoChessLeaderSelectViewContainer", package.seeall)

local AutoChessLeaderSelectViewContainer = class("AutoChessLeaderSelectViewContainer", BaseViewContainer)

function AutoChessLeaderSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessLeaderSelectView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AutoChessLeaderSelectViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return AutoChessLeaderSelectViewContainer
