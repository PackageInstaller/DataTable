-- chunkname: @modules/logic/activity/view/V2a9_FreeMonthCard_FullViewContainer.lua

module("modules.logic.activity.view.V2a9_FreeMonthCard_FullViewContainer", package.seeall)

local V2a9_FreeMonthCard_FullViewContainer = class("V2a9_FreeMonthCard_FullViewContainer", BaseViewContainer)

function V2a9_FreeMonthCard_FullViewContainer:buildViews()
	local views = {}

	table.insert(views, V2a9_FreeMonthCard_FullView.New())

	return views
end

return V2a9_FreeMonthCard_FullViewContainer
