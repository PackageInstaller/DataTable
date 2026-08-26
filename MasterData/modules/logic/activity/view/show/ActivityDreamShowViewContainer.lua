-- chunkname: @modules/logic/activity/view/show/ActivityDreamShowViewContainer.lua

module("modules.logic.activity.view.show.ActivityDreamShowViewContainer", package.seeall)

local ActivityDreamShowViewContainer = class("ActivityDreamShowViewContainer", BaseViewContainer)

function ActivityDreamShowViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityDreamShowView.New())

	return views
end

return ActivityDreamShowViewContainer
