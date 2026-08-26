-- chunkname: @modules/logic/seasonver/act166/view2_4/Season166_2_4InformationMainViewContainer.lua

module("modules.logic.seasonver.act166.view2_4.Season166_2_4InformationMainViewContainer", package.seeall)

local Season166_2_4InformationMainViewContainer = class("Season166_2_4InformationMainViewContainer", BaseViewContainer)

function Season166_2_4InformationMainViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166_2_4InformationMainView.New())
	table.insert(views, Season166InformationCurrencyView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Season166_2_4InformationMainViewContainer:buildTabViews(tabContainerId)
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

return Season166_2_4InformationMainViewContainer
