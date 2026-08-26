-- chunkname: @modules/logic/tower/view/assistboss/TowerAssistBossTalentViewContainer.lua

module("modules.logic.tower.view.assistboss.TowerAssistBossTalentViewContainer", package.seeall)

local TowerAssistBossTalentViewContainer = class("TowerAssistBossTalentViewContainer", BaseViewContainer)

function TowerAssistBossTalentViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerAssistBossTalentView.New())
	table.insert(views, TowerAssistBossTalentTreeView.New())
	table.insert(views, TowerAssistBossTalentPlanModifyView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function TowerAssistBossTalentViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerTalent)

		return {
			self.navigateView
		}
	end
end

return TowerAssistBossTalentViewContainer
