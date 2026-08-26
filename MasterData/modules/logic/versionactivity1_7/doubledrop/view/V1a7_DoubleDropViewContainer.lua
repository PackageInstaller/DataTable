-- chunkname: @modules/logic/versionactivity1_7/doubledrop/view/V1a7_DoubleDropViewContainer.lua

module("modules.logic.versionactivity1_7.doubledrop.view.V1a7_DoubleDropViewContainer", package.seeall)

local V1a7_DoubleDropViewContainer = class("V1a7_DoubleDropViewContainer", BaseViewContainer)

function V1a7_DoubleDropViewContainer:buildViews()
	local views = {}

	table.insert(views, V1a7_DoubleDropView.New())

	return views
end

return V1a7_DoubleDropViewContainer
