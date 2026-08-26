-- chunkname: @modules/logic/tower/view/assistboss/TowerAssistBossDetailViewContainer.lua

module("modules.logic.tower.view.assistboss.TowerAssistBossDetailViewContainer", package.seeall)

local TowerAssistBossDetailViewContainer = class("TowerAssistBossDetailViewContainer", BaseViewContainer)

function TowerAssistBossDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerAssistBossDetailView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function TowerAssistBossDetailViewContainer:buildTabViews(tabContainerId)
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

return TowerAssistBossDetailViewContainer
