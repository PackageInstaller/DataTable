-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CareerHandBookTransferViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_CareerHandBookTransferViewContainer", package.seeall)

local Rouge2_CareerHandBookTransferViewContainer = class("Rouge2_CareerHandBookTransferViewContainer", BaseViewContainer)

function Rouge2_CareerHandBookTransferViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_CareerHandBookTransferView.New())

	return views
end

return Rouge2_CareerHandBookTransferViewContainer
