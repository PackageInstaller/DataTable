-- chunkname: @modules/logic/rouge/map/view/nextlayer/RougeNextLayerViewContainer.lua

module("modules.logic.rouge.map.view.nextlayer.RougeNextLayerViewContainer", package.seeall)

local RougeNextLayerViewContainer = class("RougeNextLayerViewContainer", BaseViewContainer)

function RougeNextLayerViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeNextLayerView.New())

	return views
end

return RougeNextLayerViewContainer
