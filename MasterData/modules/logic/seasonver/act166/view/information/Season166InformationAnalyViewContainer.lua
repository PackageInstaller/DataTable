-- chunkname: @modules/logic/seasonver/act166/view/information/Season166InformationAnalyViewContainer.lua

module("modules.logic.seasonver.act166.view.information.Season166InformationAnalyViewContainer", package.seeall)

local Season166InformationAnalyViewContainer = class("Season166InformationAnalyViewContainer", BaseViewContainer)

function Season166InformationAnalyViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166InformationAnalyView.New())
	table.insert(views, Season166InformationCurrencyView.New())
	table.insert(views, Season166InformationAnalyRewardView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Season166InformationAnalyViewContainer:buildTabViews(tabContainerId)
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

return Season166InformationAnalyViewContainer
