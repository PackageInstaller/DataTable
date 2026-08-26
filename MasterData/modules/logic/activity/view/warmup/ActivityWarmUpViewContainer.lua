-- chunkname: @modules/logic/activity/view/warmup/ActivityWarmUpViewContainer.lua

module("modules.logic.activity.view.warmup.ActivityWarmUpViewContainer", package.seeall)

local ActivityWarmUpViewContainer = class("ActivityWarmUpViewContainer", BaseViewContainer)

function ActivityWarmUpViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityWarmUpView.New())

	return views
end

return ActivityWarmUpViewContainer
