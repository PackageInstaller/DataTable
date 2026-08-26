-- chunkname: @modules/logic/autochess/main/view/AutoChessCardpackViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessCardpackViewContainer", package.seeall)

local AutoChessCardpackViewContainer = class("AutoChessCardpackViewContainer", BaseViewContainer)

function AutoChessCardpackViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessCardpackView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AutoChessCardpackViewContainer:buildTabViews(tabContainerId)
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

return AutoChessCardpackViewContainer
