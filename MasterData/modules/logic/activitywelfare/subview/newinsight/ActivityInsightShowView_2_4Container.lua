-- chunkname: @modules/logic/activitywelfare/subview/newinsight/ActivityInsightShowView_2_4Container.lua

module("modules.logic.activitywelfare.subview.newinsight.ActivityInsightShowView_2_4Container", package.seeall)

local ActivityInsightShowView_2_4Container = class("ActivityInsightShowView_2_4Container", BaseViewContainer)

function ActivityInsightShowView_2_4Container:buildViews()
	local views = {}

	table.insert(views, ActivityInsightShowView_2_4.New())

	return views
end

return ActivityInsightShowView_2_4Container
