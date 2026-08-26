-- chunkname: @modules/logic/activity/view/V3a3_DoubleDanActivity_FullViewContainer.lua

module("modules.logic.activity.view.V3a3_DoubleDanActivity_FullViewContainer", package.seeall)

local V3a3_DoubleDanActivity_FullViewContainer = class("V3a3_DoubleDanActivity_FullViewContainer", V3a3_DoubleDanActivityViewImplContainer)

function V3a3_DoubleDanActivity_FullViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a3_DoubleDanActivity_FullView.New())

	return views
end

return V3a3_DoubleDanActivity_FullViewContainer
