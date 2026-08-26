-- chunkname: @modules/logic/seasonver/act166/view2_6/Season166_2_6TalentSelectViewContainer.lua

module("modules.logic.seasonver.act166.view2_6.Season166_2_6TalentSelectViewContainer", package.seeall)

local Season166_2_6TalentSelectViewContainer = class("Season166_2_6TalentSelectViewContainer", BaseViewContainer)

function Season166_2_6TalentSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166_2_6TalentSelectView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Season166_2_6TalentSelectViewContainer:buildTabViews(tabContainerId)
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

return Season166_2_6TalentSelectViewContainer
