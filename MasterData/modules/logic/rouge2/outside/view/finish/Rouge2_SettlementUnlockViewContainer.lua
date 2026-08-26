-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_SettlementUnlockViewContainer.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_SettlementUnlockViewContainer", package.seeall)

local Rouge2_SettlementUnlockViewContainer = class("Rouge2_SettlementUnlockViewContainer", BaseViewContainer)

function Rouge2_SettlementUnlockViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_SettlementUnlockView.New())

	return views
end

return Rouge2_SettlementUnlockViewContainer
