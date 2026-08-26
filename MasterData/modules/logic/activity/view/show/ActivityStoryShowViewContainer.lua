-- chunkname: @modules/logic/activity/view/show/ActivityStoryShowViewContainer.lua

module("modules.logic.activity.view.show.ActivityStoryShowViewContainer", package.seeall)

local ActivityStoryShowViewContainer = class("ActivityStoryShowViewContainer", BaseViewContainer)

function ActivityStoryShowViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityStoryShowView.New())

	return views
end

return ActivityStoryShowViewContainer
