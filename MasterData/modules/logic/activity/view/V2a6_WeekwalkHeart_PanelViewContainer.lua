-- chunkname: @modules/logic/activity/view/V2a6_WeekwalkHeart_PanelViewContainer.lua

module("modules.logic.activity.view.V2a6_WeekwalkHeart_PanelViewContainer", package.seeall)

local V2a6_WeekwalkHeart_PanelViewContainer = class("V2a6_WeekwalkHeart_PanelViewContainer", Activity189BaseViewContainer)

function V2a6_WeekwalkHeart_PanelViewContainer:buildViews()
	local views = {}

	table.insert(views, V2a6_WeekwalkHeart_PanelView.New())

	return views
end

function V2a6_WeekwalkHeart_PanelViewContainer:actId()
	return ActivityEnum.Activity.V2a6_WeekwalkHeart
end

return V2a6_WeekwalkHeart_PanelViewContainer
