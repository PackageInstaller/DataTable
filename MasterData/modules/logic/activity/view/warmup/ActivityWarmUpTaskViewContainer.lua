-- chunkname: @modules/logic/activity/view/warmup/ActivityWarmUpTaskViewContainer.lua

module("modules.logic.activity.view.warmup.ActivityWarmUpTaskViewContainer", package.seeall)

local ActivityWarmUpTaskViewContainer = class("ActivityWarmUpTaskViewContainer", BaseViewContainer)

function ActivityWarmUpTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityWarmUpTaskView.New())

	return views
end

return ActivityWarmUpTaskViewContainer
