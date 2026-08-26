-- chunkname: @modules/logic/season/view/SeasonSettlementViewContainer.lua

module("modules.logic.season.view.SeasonSettlementViewContainer", package.seeall)

local SeasonSettlementViewContainer = class("SeasonSettlementViewContainer", BaseViewContainer)

function SeasonSettlementViewContainer:buildViews()
	return {
		SeasonSettlementView.New()
	}
end

function SeasonSettlementViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return SeasonSettlementViewContainer
