-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapEntrustDetailViewContainer.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapEntrustDetailViewContainer", package.seeall)

local Rouge2_MapEntrustDetailViewContainer = class("Rouge2_MapEntrustDetailViewContainer", BaseViewContainer)

function Rouge2_MapEntrustDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapEntrustDetailView.New())
	table.insert(views, Rouge2_MapCoinView.New())

	return views
end

return Rouge2_MapEntrustDetailViewContainer
