-- chunkname: @modules/logic/seasonver/act166/view/Season166MainViewContainer.lua

module("modules.logic.seasonver.act166.view.Season166MainViewContainer", package.seeall)

local Season166MainViewContainer = class("Season166MainViewContainer", BaseViewContainer)

function Season166MainViewContainer:buildViews()
	local views = {}

	self.Season166MainSceneView = Season166MainSceneView.New()

	table.insert(views, self.Season166MainSceneView)
	table.insert(views, Season166MainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Season166MainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		}, HelpEnum.HelpId.Season166TrainHelp)

		return {
			self.navigateView
		}
	end
end

function Season166MainViewContainer:getMainSceneView()
	return self.Season166MainSceneView
end

function Season166MainViewContainer:setOverrideCloseClick(overrideCloseFunc, overrideCloseObj)
	self.navigateView:setOverrideClose(overrideCloseFunc, overrideCloseObj)
end

function Season166MainViewContainer:setHelpBtnShowState(showState)
	self.navigateView:setHelpVisible(showState)
end

return Season166MainViewContainer
