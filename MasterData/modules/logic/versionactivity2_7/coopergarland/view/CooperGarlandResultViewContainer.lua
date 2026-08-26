-- chunkname: @modules/logic/versionactivity2_7/coopergarland/view/CooperGarlandResultViewContainer.lua

module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandResultViewContainer", package.seeall)

local CooperGarlandResultViewContainer = class("CooperGarlandResultViewContainer", BaseViewContainer)

function CooperGarlandResultViewContainer:buildViews()
	local views = {}

	table.insert(views, CooperGarlandResultView.New())

	return views
end

return CooperGarlandResultViewContainer
