-- chunkname: @modules/logic/seasonver/act166/view/information/Season166InformationMainViewContainer.lua

module("modules.logic.seasonver.act166.view.information.Season166InformationMainViewContainer", package.seeall)

local Season166InformationMainViewContainer = class("Season166InformationMainViewContainer", BaseViewContainer)

function Season166InformationMainViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166InformationMainView.New())
	table.insert(views, Season166InformationCurrencyView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Season166InformationMainViewContainer:buildTabViews(tabContainerId)
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

return Season166InformationMainViewContainer
