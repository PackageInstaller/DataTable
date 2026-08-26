-- chunkname: @modules/logic/seasonver/act166/view2_6/Season166_2_6BaseSpotViewContainer.lua

module("modules.logic.seasonver.act166.view2_6.Season166_2_6BaseSpotViewContainer", package.seeall)

local Season166_2_6BaseSpotViewContainer = class("Season166_2_6BaseSpotViewContainer", BaseViewContainer)

function Season166_2_6BaseSpotViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166BaseSpotView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, Season166WordEffectView.New())

	return views
end

function Season166_2_6BaseSpotViewContainer:buildTabViews(tabContainerId)
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

return Season166_2_6BaseSpotViewContainer
