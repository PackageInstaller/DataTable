-- chunkname: @modules/logic/seasonver/act166/view/talent/Season166TalentViewContainer.lua

module("modules.logic.seasonver.act166.view.talent.Season166TalentViewContainer", package.seeall)

local Season166TalentViewContainer = class("Season166TalentViewContainer", BaseViewContainer)

function Season166TalentViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166TalentView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Season166TalentViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season166TalentTreeHelp)

		return {
			self.navigateView
		}
	end
end

return Season166TalentViewContainer
