-- chunkname: @modules/logic/tower/view/bosstower/TowerBossSpEpisodeViewContainer.lua

module("modules.logic.tower.view.bosstower.TowerBossSpEpisodeViewContainer", package.seeall)

local TowerBossSpEpisodeViewContainer = class("TowerBossSpEpisodeViewContainer", BaseViewContainer)

function TowerBossSpEpisodeViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerBossSpEpisodeView.New())
	table.insert(views, TowerBossEpisodeLeftView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function TowerBossSpEpisodeViewContainer:buildTabViews(tabContainerId)
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

function TowerBossSpEpisodeViewContainer:isSp()
	return true
end

return TowerBossSpEpisodeViewContainer
