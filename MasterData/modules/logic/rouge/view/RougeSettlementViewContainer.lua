-- chunkname: @modules/logic/rouge/view/RougeSettlementViewContainer.lua

module("modules.logic.rouge.view.RougeSettlementViewContainer", package.seeall)

local RougeSettlementViewContainer = class("RougeSettlementViewContainer", BaseViewContainer)

function RougeSettlementViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeSettlementView.New())

	return views
end

return RougeSettlementViewContainer
