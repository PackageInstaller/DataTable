-- chunkname: @modules/logic/activity/view/warmup/ActivityWarmUpTipsContainer.lua

module("modules.logic.activity.view.warmup.ActivityWarmUpTipsContainer", package.seeall)

local ActivityWarmUpTipsContainer = class("ActivityWarmUpTipsContainer", BaseViewContainer)

function ActivityWarmUpTipsContainer:buildViews()
	local views = {}

	table.insert(views, ActivityWarmUpTips.New())

	return views
end

return ActivityWarmUpTipsContainer
