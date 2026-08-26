-- chunkname: @modules/logic/rouge2/map/view/careertransfer/Rouge2_MapCareerTransferViewContainer.lua

module("modules.logic.rouge2.map.view.careertransfer.Rouge2_MapCareerTransferViewContainer", package.seeall)

local Rouge2_MapCareerTransferViewContainer = class("Rouge2_MapCareerTransferViewContainer", BaseViewContainer)

function Rouge2_MapCareerTransferViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapCareerTransferView.New())

	return views
end

return Rouge2_MapCareerTransferViewContainer
