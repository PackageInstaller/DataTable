-- chunkname: @modules/logic/versionactivity3_6/doubledrop/view/V3a6DoubleDropViewContainer.lua

module("modules.logic.versionactivity3_6.doubledrop.view.V3a6DoubleDropViewContainer", package.seeall)

local V3a6DoubleDropViewContainer = class("V3a6DoubleDropViewContainer", BaseViewContainer)

function V3a6DoubleDropViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a6DoubleDropView.New())

	return views
end

return V3a6DoubleDropViewContainer
