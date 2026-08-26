-- chunkname: @modules/logic/seasonver/act166/view/talent/Season166TalentSelectViewContainer.lua

module("modules.logic.seasonver.act166.view.talent.Season166TalentSelectViewContainer", package.seeall)

local Season166TalentSelectViewContainer = class("Season166TalentSelectViewContainer", BaseViewContainer)

function Season166TalentSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166TalentSelectView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Season166TalentSelectViewContainer:buildTabViews(tabContainerId)
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

return Season166TalentSelectViewContainer
