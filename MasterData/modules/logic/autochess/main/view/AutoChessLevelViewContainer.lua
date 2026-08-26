-- chunkname: @modules/logic/autochess/main/view/AutoChessLevelViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessLevelViewContainer", package.seeall)

local AutoChessLevelViewContainer = class("AutoChessLevelViewContainer", BaseViewContainer)

function AutoChessLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AutoChessLevelViewContainer:buildTabViews(tabContainerId)
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

return AutoChessLevelViewContainer
