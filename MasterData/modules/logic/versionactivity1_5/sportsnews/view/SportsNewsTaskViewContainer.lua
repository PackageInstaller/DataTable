-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsTaskViewContainer.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTaskViewContainer", package.seeall)

local SportsNewsTaskViewContainer = class("SportsNewsTaskViewContainer", BaseViewContainer)

function SportsNewsTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, SportsNewsTaskView.New())

	return views
end

return SportsNewsTaskViewContainer
