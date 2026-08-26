-- chunkname: @modules/logic/tower/view/assistboss/TowerAssistBossViewContainer.lua

module("modules.logic.tower.view.assistboss.TowerAssistBossViewContainer", package.seeall)

local TowerAssistBossViewContainer = class("TowerAssistBossViewContainer", BaseViewContainer)

function TowerAssistBossViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerAssistBossView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function TowerAssistBossViewContainer:buildTabViews(tabContainerId)
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

return TowerAssistBossViewContainer
