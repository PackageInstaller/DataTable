-- chunkname: @modules/logic/seasonver/act166/view2_4/Season166_2_4InformationAnalyViewContainer.lua

module("modules.logic.seasonver.act166.view2_4.Season166_2_4InformationAnalyViewContainer", package.seeall)

local Season166_2_4InformationAnalyViewContainer = class("Season166_2_4InformationAnalyViewContainer", BaseViewContainer)

function Season166_2_4InformationAnalyViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166_2_4InformationAnalyView.New())
	table.insert(views, Season166InformationCurrencyView.New())
	table.insert(views, Season166_2_4InformationAnalyRewardView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Season166_2_4InformationAnalyViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season166InformationHelp)

		return {
			self.navigateView
		}
	end
end

return Season166_2_4InformationAnalyViewContainer
