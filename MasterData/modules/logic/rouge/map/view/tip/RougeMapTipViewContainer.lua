-- chunkname: @modules/logic/rouge/map/view/tip/RougeMapTipViewContainer.lua

module("modules.logic.rouge.map.view.tip.RougeMapTipViewContainer", package.seeall)

local RougeMapTipViewContainer = class("RougeMapTipViewContainer", BaseViewContainer)

function RougeMapTipViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeMapTipView.New())

	return views
end

return RougeMapTipViewContainer
