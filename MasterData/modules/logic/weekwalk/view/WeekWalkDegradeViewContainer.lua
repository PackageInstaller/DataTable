-- chunkname: @modules/logic/weekwalk/view/WeekWalkDegradeViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkDegradeViewContainer", package.seeall)

local WeekWalkDegradeViewContainer = class("WeekWalkDegradeViewContainer", BaseViewContainer)

function WeekWalkDegradeViewContainer:buildViews()
	local views = {}

	table.insert(views, WeekWalkDegradeView.New())

	return views
end

return WeekWalkDegradeViewContainer
