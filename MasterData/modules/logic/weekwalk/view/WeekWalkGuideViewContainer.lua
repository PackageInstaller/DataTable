-- chunkname: @modules/logic/weekwalk/view/WeekWalkGuideViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkGuideViewContainer", package.seeall)

local WeekWalkGuideViewContainer = class("WeekWalkGuideViewContainer", BaseViewContainer)

function WeekWalkGuideViewContainer:buildViews()
	local views = {}

	table.insert(views, WeekWalkGuideView.New())

	return views
end

return WeekWalkGuideViewContainer
