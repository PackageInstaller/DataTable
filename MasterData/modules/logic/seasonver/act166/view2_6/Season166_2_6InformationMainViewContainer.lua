-- chunkname: @modules/logic/seasonver/act166/view2_6/Season166_2_6InformationMainViewContainer.lua

module("modules.logic.seasonver.act166.view2_6.Season166_2_6InformationMainViewContainer", package.seeall)

local Season166_2_6InformationMainViewContainer = class("Season166_2_6InformationMainViewContainer", BaseViewContainer)

function Season166_2_6InformationMainViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166_2_6InformationMainView.New())
	table.insert(views, Season166InformationCurrencyView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Season166_2_6InformationMainViewContainer:buildTabViews(tabContainerId)
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

return Season166_2_6InformationMainViewContainer
