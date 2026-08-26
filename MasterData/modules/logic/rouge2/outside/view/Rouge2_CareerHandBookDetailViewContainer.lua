-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CareerHandBookDetailViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_CareerHandBookDetailViewContainer", package.seeall)

local Rouge2_CareerHandBookDetailViewContainer = class("Rouge2_CareerHandBookDetailViewContainer", BaseViewContainer)

function Rouge2_CareerHandBookDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_CareerHandBookDetailView.New())

	return views
end

return Rouge2_CareerHandBookDetailViewContainer
