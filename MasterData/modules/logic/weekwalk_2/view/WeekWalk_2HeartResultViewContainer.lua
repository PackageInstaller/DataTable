-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2HeartResultViewContainer.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2HeartResultViewContainer", package.seeall)

local WeekWalk_2HeartResultViewContainer = class("WeekWalk_2HeartResultViewContainer", BaseViewContainer)

function WeekWalk_2HeartResultViewContainer:buildViews()
	local views = {}

	table.insert(views, WeekWalk_2HeartResultView.New())

	return views
end

return WeekWalk_2HeartResultViewContainer
