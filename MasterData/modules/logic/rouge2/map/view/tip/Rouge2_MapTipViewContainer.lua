-- chunkname: @modules/logic/rouge2/map/view/tip/Rouge2_MapTipViewContainer.lua

module("modules.logic.rouge2.map.view.tip.Rouge2_MapTipViewContainer", package.seeall)

local Rouge2_MapTipViewContainer = class("Rouge2_MapTipViewContainer", BaseViewContainer)

function Rouge2_MapTipViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapTipView.New())

	return views
end

return Rouge2_MapTipViewContainer
