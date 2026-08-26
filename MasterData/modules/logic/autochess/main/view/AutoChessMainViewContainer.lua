-- chunkname: @modules/logic/autochess/main/view/AutoChessMainViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessMainViewContainer", package.seeall)

local AutoChessMainViewContainer = class("AutoChessMainViewContainer", BaseViewContainer)

function AutoChessMainViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AutoChessMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, 3207003)

		return {
			self.navigateView
		}
	end
end

return AutoChessMainViewContainer
