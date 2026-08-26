-- chunkname: @modules/logic/rouge2/map/view/nextlayer/Rouge2_NextLayerViewContainer.lua

module("modules.logic.rouge2.map.view.nextlayer.Rouge2_NextLayerViewContainer", package.seeall)

local Rouge2_NextLayerViewContainer = class("Rouge2_NextLayerViewContainer", BaseViewContainer)

function Rouge2_NextLayerViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_NextLayerView.New())

	return views
end

return Rouge2_NextLayerViewContainer
