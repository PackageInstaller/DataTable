-- chunkname: @modules/logic/versionactivity3_6/activitycollect/view/ActivityCollectViewContainer.lua

module("modules.logic.versionactivity3_6.activitycollect.view.ActivityCollectViewContainer", package.seeall)

local ActivityCollectViewContainer = class("ActivityCollectViewContainer", BaseViewContainer)

function ActivityCollectViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityCollectView.New())

	return views
end

return ActivityCollectViewContainer
