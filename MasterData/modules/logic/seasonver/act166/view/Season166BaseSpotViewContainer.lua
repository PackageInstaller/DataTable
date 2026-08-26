-- chunkname: @modules/logic/seasonver/act166/view/Season166BaseSpotViewContainer.lua

module("modules.logic.seasonver.act166.view.Season166BaseSpotViewContainer", package.seeall)

local Season166BaseSpotViewContainer = class("Season166BaseSpotViewContainer", BaseViewContainer)

function Season166BaseSpotViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166BaseSpotView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Season166BaseSpotViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season166BaseSpotHelp)

		return {
			self.navigateView
		}
	end
end

return Season166BaseSpotViewContainer
