-- chunkname: @modules/logic/autochess/main/view/AutoChessHandBookViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessHandBookViewContainer", package.seeall)

local AutoChessHandBookViewContainer = class("AutoChessHandBookViewContainer", BaseViewContainer)

function AutoChessHandBookViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessHandBookView.New())
	table.insert(views, TabViewGroup.New(1, "go_topleft"))

	return views
end

function AutoChessHandBookViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return AutoChessHandBookViewContainer
