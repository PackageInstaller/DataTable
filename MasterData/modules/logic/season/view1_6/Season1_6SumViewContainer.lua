-- chunkname: @modules/logic/season/view1_6/Season1_6SumViewContainer.lua

module("modules.logic.season.view1_6.Season1_6SumViewContainer", package.seeall)

local Season1_6SumViewContainer = class("Season1_6SumViewContainer", BaseViewContainer)

function Season1_6SumViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_6SumView.New())

	return views
end

return Season1_6SumViewContainer
