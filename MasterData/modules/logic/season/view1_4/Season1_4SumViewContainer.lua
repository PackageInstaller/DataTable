-- chunkname: @modules/logic/season/view1_4/Season1_4SumViewContainer.lua

module("modules.logic.season.view1_4.Season1_4SumViewContainer", package.seeall)

local Season1_4SumViewContainer = class("Season1_4SumViewContainer", BaseViewContainer)

function Season1_4SumViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_4SumView.New())

	return views
end

return Season1_4SumViewContainer
