-- chunkname: @modules/logic/survival/view/map/SurvivalMapTeamViewContainer.lua

module("modules.logic.survival.view.map.SurvivalMapTeamViewContainer", package.seeall)

local SurvivalMapTeamViewContainer = class("SurvivalMapTeamViewContainer", BaseViewContainer)

function SurvivalMapTeamViewContainer:buildViews()
	return {
		SurvivalMapTeamView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function SurvivalMapTeamViewContainer:buildTabViews(tabContainerId)
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

return SurvivalMapTeamViewContainer
