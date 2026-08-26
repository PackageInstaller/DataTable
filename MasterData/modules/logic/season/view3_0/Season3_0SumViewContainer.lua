-- chunkname: @modules/logic/season/view3_0/Season3_0SumViewContainer.lua

module("modules.logic.season.view3_0.Season3_0SumViewContainer", package.seeall)

local Season3_0SumViewContainer = class("Season3_0SumViewContainer", BaseViewContainer)

function Season3_0SumViewContainer:buildViews()
	local views = {}

	table.insert(views, Season3_0SumView.New())

	return views
end

return Season3_0SumViewContainer
