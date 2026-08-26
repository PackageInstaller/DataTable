-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186GameDrawlotsViewContainer.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186GameDrawlotsViewContainer", package.seeall)

local Activity186GameDrawlotsViewContainer = class("Activity186GameDrawlotsViewContainer", BaseViewContainer)

function Activity186GameDrawlotsViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity186GameDrawlotsView.New())

	return views
end

return Activity186GameDrawlotsViewContainer
