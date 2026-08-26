-- chunkname: @modules/logic/autochess/main/view/game/AutoChessBeginViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessBeginViewContainer", package.seeall)

local AutoChessBeginViewContainer = class("AutoChessBeginViewContainer", BaseViewContainer)

function AutoChessBeginViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessBeginView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AutoChessBeginViewContainer:buildTabViews(tabContainerId)
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

return AutoChessBeginViewContainer
