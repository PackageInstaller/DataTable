-- chunkname: @modules/logic/activity/view/warmup/ActivityWarmUpGameViewContainer.lua

module("modules.logic.activity.view.warmup.ActivityWarmUpGameViewContainer", package.seeall)

local ActivityWarmUpGameViewContainer = class("ActivityWarmUpGameViewContainer", BaseViewContainer)

function ActivityWarmUpGameViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityWarmUpGameView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActivityWarmUpGameViewContainer:buildTabViews(tabContainerId)
	self.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self.navigationView
	}
end

return ActivityWarmUpGameViewContainer
