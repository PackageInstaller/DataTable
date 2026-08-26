-- chunkname: @modules/logic/meilanni/view/MeilanniSettlementViewContainer.lua

module("modules.logic.meilanni.view.MeilanniSettlementViewContainer", package.seeall)

local MeilanniSettlementViewContainer = class("MeilanniSettlementViewContainer", BaseViewContainer)

function MeilanniSettlementViewContainer:buildViews()
	local views = {}

	table.insert(views, MeilanniSettlementView.New())

	return views
end

return MeilanniSettlementViewContainer
