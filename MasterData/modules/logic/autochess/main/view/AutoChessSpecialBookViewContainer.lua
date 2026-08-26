-- chunkname: @modules/logic/autochess/main/view/AutoChessSpecialBookViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessSpecialBookViewContainer", package.seeall)

local AutoChessSpecialBookViewContainer = class("AutoChessSpecialBookViewContainer", BaseViewContainer)

function AutoChessSpecialBookViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessSpecialBookView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AutoChessSpecialBookViewContainer:buildTabViews(tabContainerId)
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

return AutoChessSpecialBookViewContainer
