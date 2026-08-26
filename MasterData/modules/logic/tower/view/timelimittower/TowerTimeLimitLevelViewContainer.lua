-- chunkname: @modules/logic/tower/view/timelimittower/TowerTimeLimitLevelViewContainer.lua

module("modules.logic.tower.view.timelimittower.TowerTimeLimitLevelViewContainer", package.seeall)

local TowerTimeLimitLevelViewContainer = class("TowerTimeLimitLevelViewContainer", BaseViewContainer)

function TowerTimeLimitLevelViewContainer:buildViews()
	local views = {}

	self.towerTimeLimitLevelInfoView = TowerTimeLimitLevelInfoView.New()

	table.insert(views, TowerTimeLimitLevelView.New())
	table.insert(views, self.towerTimeLimitLevelInfoView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function TowerTimeLimitLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerLimit)

		return {
			self.navigateView
		}
	end
end

function TowerTimeLimitLevelViewContainer:getTowerTimeLimitLevelInfoView()
	return self.towerTimeLimitLevelInfoView
end

function TowerTimeLimitLevelViewContainer:setOverrideCloseClick(overrideCloseFunc, overrideCloseObj)
	self.navigateView:setOverrideClose(overrideCloseFunc, overrideCloseObj)
end

return TowerTimeLimitLevelViewContainer
