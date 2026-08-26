-- chunkname: @modules/logic/activity/view/V3a3_DoubleDanActivity_PanelViewContainer.lua

module("modules.logic.activity.view.V3a3_DoubleDanActivity_PanelViewContainer", package.seeall)

local V3a3_DoubleDanActivity_PanelViewContainer = class("V3a3_DoubleDanActivity_PanelViewContainer", V3a3_DoubleDanActivityViewImplContainer)

function V3a3_DoubleDanActivity_PanelViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a3_DoubleDanActivity_PanelView.New())

	return views
end

return V3a3_DoubleDanActivity_PanelViewContainer
