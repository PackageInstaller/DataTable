-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_SettlementViewContainer.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_SettlementViewContainer", package.seeall)

local Rouge2_SettlementViewContainer = class("Rouge2_SettlementViewContainer", BaseViewContainer)

function Rouge2_SettlementViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_SettlementView.New())

	return views
end

return Rouge2_SettlementViewContainer
