-- chunkname: @modules/logic/tower/view/bosstower/TowerBossEpisodeViewContainer.lua

module("modules.logic.tower.view.bosstower.TowerBossEpisodeViewContainer", package.seeall)

local TowerBossEpisodeViewContainer = class("TowerBossEpisodeViewContainer", BaseViewContainer)

function TowerBossEpisodeViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerBossEpisodeView.New())
	table.insert(views, TowerBossEpisodeLeftView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function TowerBossEpisodeViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerBoss)

		return {
			self.navigateView
		}
	end
end

function TowerBossEpisodeViewContainer:isSp()
	return false
end

return TowerBossEpisodeViewContainer
