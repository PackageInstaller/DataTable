-- chunkname: @modules/logic/rouge2/map/view/buffabandon/Rouge2_MapBuffAbandonViewContainer.lua

module("modules.logic.rouge2.map.view.buffabandon.Rouge2_MapBuffAbandonViewContainer", package.seeall)

local Rouge2_MapBuffAbandonViewContainer = class("Rouge2_MapBuffAbandonViewContainer", BaseViewContainer)

function Rouge2_MapBuffAbandonViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapBuffAbandonView.New())

	return views
end

return Rouge2_MapBuffAbandonViewContainer
