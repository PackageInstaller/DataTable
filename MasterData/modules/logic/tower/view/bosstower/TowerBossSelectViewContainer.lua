-- chunkname: @modules/logic/tower/view/bosstower/TowerBossSelectViewContainer.lua

module("modules.logic.tower.view.bosstower.TowerBossSelectViewContainer", package.seeall)

local TowerBossSelectViewContainer = class("TowerBossSelectViewContainer", BaseViewContainer)

function TowerBossSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerBossSelectView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function TowerBossSelectViewContainer:buildTabViews(tabContainerId)
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

return TowerBossSelectViewContainer
