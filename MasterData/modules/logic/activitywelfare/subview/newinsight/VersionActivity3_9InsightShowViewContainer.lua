-- chunkname: @modules/logic/activitywelfare/subview/newinsight/VersionActivity3_9InsightShowViewContainer.lua

module("modules.logic.activitywelfare.subview.newinsight.VersionActivity3_9InsightShowViewContainer", package.seeall)

local VersionActivity3_9InsightShowViewContainer = class("VersionActivity3_9InsightShowViewContainer", BaseViewContainer)

function VersionActivity3_9InsightShowViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity3_9InsightShowView.New())

	return views
end

return VersionActivity3_9InsightShowViewContainer
