-- chunkname: @modules/logic/towercompose/view/result/TowerComposeResultViewContainer.lua

module("modules.logic.towercompose.view.result.TowerComposeResultViewContainer", package.seeall)

local TowerComposeResultViewContainer = class("TowerComposeResultViewContainer", BaseViewContainer)

function TowerComposeResultViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeResultView.New())
	table.insert(views, TowerComposeResultHeroGroupListView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function TowerComposeResultViewContainer:buildTabViews(tabContainerId)
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

return TowerComposeResultViewContainer
