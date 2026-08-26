-- chunkname: @modules/logic/seasonver/act166/view/information/Season166InformationRewardViewContainer.lua

module("modules.logic.seasonver.act166.view.information.Season166InformationRewardViewContainer", package.seeall)

local Season166InformationRewardViewContainer = class("Season166InformationRewardViewContainer", BaseViewContainer)

function Season166InformationRewardViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166InformationRewardView.New())
	table.insert(views, Season166InformationCurrencyView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Season166InformationRewardViewContainer:buildTabViews(tabContainerId)
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

return Season166InformationRewardViewContainer
