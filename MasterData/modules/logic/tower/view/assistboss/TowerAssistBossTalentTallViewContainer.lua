-- chunkname: @modules/logic/tower/view/assistboss/TowerAssistBossTalentTallViewContainer.lua

module("modules.logic.tower.view.assistboss.TowerAssistBossTalentTallViewContainer", package.seeall)

local TowerAssistBossTalentTallViewContainer = class("TowerAssistBossTalentTallViewContainer", BaseViewContainer)

function TowerAssistBossTalentTallViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerAssistBossTalentTallView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function TowerAssistBossTalentTallViewContainer:buildTabViews(tabContainerId)
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

return TowerAssistBossTalentTallViewContainer
