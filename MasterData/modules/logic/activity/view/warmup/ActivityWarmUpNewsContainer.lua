-- chunkname: @modules/logic/activity/view/warmup/ActivityWarmUpNewsContainer.lua

module("modules.logic.activity.view.warmup.ActivityWarmUpNewsContainer", package.seeall)

local ActivityWarmUpNewsContainer = class("ActivityWarmUpNewsContainer", BaseViewContainer)

function ActivityWarmUpNewsContainer:buildViews()
	local views = {}

	table.insert(views, ActivityWarmUpNews.New())

	return views
end

return ActivityWarmUpNewsContainer
