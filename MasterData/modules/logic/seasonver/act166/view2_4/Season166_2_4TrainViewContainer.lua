-- chunkname: @modules/logic/seasonver/act166/view2_4/Season166_2_4TrainViewContainer.lua

module("modules.logic.seasonver.act166.view2_4.Season166_2_4TrainViewContainer", package.seeall)

local Season166_2_4TrainViewContainer = class("Season166_2_4TrainViewContainer", BaseViewContainer)

function Season166_2_4TrainViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166TrainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, Season166WordEffectView.New())

	return views
end

function Season166_2_4TrainViewContainer:buildTabViews(tabContainerId)
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

function Season166_2_4TrainViewContainer:setOverrideCloseClick(overrideCloseFunc, overrideCloseObj)
	self.navigateView:setOverrideClose(overrideCloseFunc, overrideCloseObj)
end

return Season166_2_4TrainViewContainer
