-- chunkname: @modules/logic/activity/view/V2a6_WeekwalkHeart_FullViewContainer.lua

module("modules.logic.activity.view.V2a6_WeekwalkHeart_FullViewContainer", package.seeall)

local V2a6_WeekwalkHeart_FullViewContainer = class("V2a6_WeekwalkHeart_FullViewContainer", Activity189BaseViewContainer)

function V2a6_WeekwalkHeart_FullViewContainer:buildViews()
	local views = {}

	table.insert(views, V2a6_WeekwalkHeart_FullView.New())

	return views
end

function V2a6_WeekwalkHeart_FullViewContainer:actId()
	return ActivityEnum.Activity.V2a6_WeekwalkHeart
end

return V2a6_WeekwalkHeart_FullViewContainer
