-- chunkname: @modules/logic/season/view1_5/Season1_5SumViewContainer.lua

module("modules.logic.season.view1_5.Season1_5SumViewContainer", package.seeall)

local Season1_5SumViewContainer = class("Season1_5SumViewContainer", BaseViewContainer)

function Season1_5SumViewContainer:buildViews()
	local views = {}

	table.insert(views, Season1_5SumView.New())

	return views
end

return Season1_5SumViewContainer
