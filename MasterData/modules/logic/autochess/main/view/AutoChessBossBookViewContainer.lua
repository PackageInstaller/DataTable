-- chunkname: @modules/logic/autochess/main/view/AutoChessBossBookViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessBossBookViewContainer", package.seeall)

local AutoChessBossBookViewContainer = class("AutoChessBossBookViewContainer", BaseViewContainer)

function AutoChessBossBookViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessBossBookView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AutoChessBossBookViewContainer:buildTabViews(tabContainerId)
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

return AutoChessBossBookViewContainer
