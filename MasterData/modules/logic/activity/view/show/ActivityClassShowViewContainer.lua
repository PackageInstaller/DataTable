-- chunkname: @modules/logic/activity/view/show/ActivityClassShowViewContainer.lua

module("modules.logic.activity.view.show.ActivityClassShowViewContainer", package.seeall)

local ActivityClassShowViewContainer = class("ActivityClassShowViewContainer", BaseViewContainer)

function ActivityClassShowViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityClassShowView.New())

	return views
end

return ActivityClassShowViewContainer
