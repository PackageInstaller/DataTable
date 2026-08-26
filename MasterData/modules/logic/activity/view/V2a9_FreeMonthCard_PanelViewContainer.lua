-- chunkname: @modules/logic/activity/view/V2a9_FreeMonthCard_PanelViewContainer.lua

module("modules.logic.activity.view.V2a9_FreeMonthCard_PanelViewContainer", package.seeall)

local V2a9_FreeMonthCard_PanelViewContainer = class("V2a9_FreeMonthCard_PanelViewContainer", BaseViewContainer)

function V2a9_FreeMonthCard_PanelViewContainer:buildViews()
	local views = {}

	table.insert(views, V2a9_FreeMonthCard_PanelView.New())

	return views
end

return V2a9_FreeMonthCard_PanelViewContainer
