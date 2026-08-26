-- chunkname: @modules/logic/seasonver/act166/view/Season166TrainViewContainer.lua

module("modules.logic.seasonver.act166.view.Season166TrainViewContainer", package.seeall)

local Season166TrainViewContainer = class("Season166TrainViewContainer", BaseViewContainer)

function Season166TrainViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166TrainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Season166TrainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season166TrainHelp)

		return {
			self.navigateView
		}
	end
end

function Season166TrainViewContainer:setOverrideCloseClick(overrideCloseFunc, overrideCloseObj)
	self.navigateView:setOverrideClose(overrideCloseFunc, overrideCloseObj)
end

return Season166TrainViewContainer
