-- chunkname: @modules/logic/autochess/main/view/AutoChessBadgeViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessBadgeViewContainer", package.seeall)

local AutoChessBadgeViewContainer = class("AutoChessBadgeViewContainer", BaseViewContainer)

function AutoChessBadgeViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessBadgeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AutoChessBadgeViewContainer:buildTabViews(tabContainerId)
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

return AutoChessBadgeViewContainer
