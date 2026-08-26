-- chunkname: @modules/logic/versionactivity2_4/act181/view/Activity181MainViewContainer.lua

module("modules.logic.versionactivity2_4.act181.view.Activity181MainViewContainer", package.seeall)

local Activity181MainViewContainer = class("Activity181MainViewContainer", BaseViewContainer)

function Activity181MainViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity181MainView.New())

	return views
end

return Activity181MainViewContainer
