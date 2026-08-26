-- chunkname: @modules/logic/activity/view/ActivityNoviceInsightViewContainer.lua

module("modules.logic.activity.view.ActivityNoviceInsightViewContainer", package.seeall)

local ActivityNoviceInsightViewContainer = class("ActivityNoviceInsightViewContainer", BaseViewContainer)

function ActivityNoviceInsightViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityNoviceInsightView.New())

	return views
end

return ActivityNoviceInsightViewContainer
