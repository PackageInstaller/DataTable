-- chunkname: @modules/logic/activitywelfare/subview/newinsight/ActivityInsightShowView_2_6Container.lua

module("modules.logic.activitywelfare.subview.newinsight.ActivityInsightShowView_2_6Container", package.seeall)

local ActivityInsightShowView_2_6Container = class("ActivityInsightShowView_2_6Container", BaseViewContainer)

function ActivityInsightShowView_2_6Container:buildViews()
	local views = {}

	table.insert(views, ActivityInsightShowView_2_6.New())

	return views
end

return ActivityInsightShowView_2_6Container
