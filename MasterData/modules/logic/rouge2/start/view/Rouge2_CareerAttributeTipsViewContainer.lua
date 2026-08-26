-- chunkname: @modules/logic/rouge2/start/view/Rouge2_CareerAttributeTipsViewContainer.lua

module("modules.logic.rouge2.start.view.Rouge2_CareerAttributeTipsViewContainer", package.seeall)

local Rouge2_CareerAttributeTipsViewContainer = class("Rouge2_CareerAttributeTipsViewContainer", BaseViewContainer)

function Rouge2_CareerAttributeTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_CareerAttributeTipsView.New())

	return views
end

return Rouge2_CareerAttributeTipsViewContainer
