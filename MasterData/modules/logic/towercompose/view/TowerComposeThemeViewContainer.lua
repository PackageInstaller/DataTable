-- chunkname: @modules/logic/towercompose/view/TowerComposeThemeViewContainer.lua

module("modules.logic.towercompose.view.TowerComposeThemeViewContainer", package.seeall)

local TowerComposeThemeViewContainer = class("TowerComposeThemeViewContainer", BaseViewContainer)

function TowerComposeThemeViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeThemeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TowerComposeThemeInfoView.New())

	return views
end

function TowerComposeThemeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerComposeTheme)

		return {
			self.navigateView
		}
	end
end

return TowerComposeThemeViewContainer
