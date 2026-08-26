-- chunkname: @modules/logic/activitywelfare/subview/newinsight/ActivityInsightShowViewContainer.lua

module("modules.logic.activitywelfare.subview.newinsight.ActivityInsightShowViewContainer", package.seeall)

local ActivityInsightShowViewContainer = class("ActivityInsightShowViewContainer", BaseViewContainer)

function ActivityInsightShowViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityInsightShowView.New())

	return views
end

return ActivityInsightShowViewContainer
