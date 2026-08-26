-- chunkname: @modules/logic/towercompose/view/result/TowerComposeNormalResultViewContainer.lua

module("modules.logic.towercompose.view.result.TowerComposeNormalResultViewContainer", package.seeall)

local TowerComposeNormalResultViewContainer = class("TowerComposeNormalResultViewContainer", BaseViewContainer)

function TowerComposeNormalResultViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerComposeNormalResultView.New())
	table.insert(views, TowerComposeNormalResultHeroGroupListView.New())
	table.insert(views, TabViewGroup.New(1, "go_Result/#go_lefttop"))

	return views
end

function TowerComposeNormalResultViewContainer:buildTabViews(tabContainerId)
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

return TowerComposeNormalResultViewContainer
