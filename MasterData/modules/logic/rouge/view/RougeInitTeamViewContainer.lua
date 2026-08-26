-- chunkname: @modules/logic/rouge/view/RougeInitTeamViewContainer.lua

module("modules.logic.rouge.view.RougeInitTeamViewContainer", package.seeall)

local RougeInitTeamViewContainer = class("RougeInitTeamViewContainer", BaseViewContainer)

function RougeInitTeamViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeInitTeamView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function RougeInitTeamViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setHelpId(HelpEnum.HelpId.RougeInitTeamViewHelp)

		return {
			self.navigateView
		}
	end
end

return RougeInitTeamViewContainer
