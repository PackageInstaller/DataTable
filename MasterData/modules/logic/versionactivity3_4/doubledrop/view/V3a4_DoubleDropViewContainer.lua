-- chunkname: @modules/logic/versionactivity3_4/doubledrop/view/V3a4_DoubleDropViewContainer.lua

module("modules.logic.versionactivity3_4.doubledrop.view.V3a4_DoubleDropViewContainer", package.seeall)

local V3a4_DoubleDropViewContainer = class("V3a4_DoubleDropViewContainer", BaseViewContainer)

function V3a4_DoubleDropViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a4_DoubleDropView.New())

	return views
end

return V3a4_DoubleDropViewContainer
