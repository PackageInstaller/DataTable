-- chunkname: @modules/logic/season/view3_0/Season3_0SettlementViewContainer.lua

module("modules.logic.season.view3_0.Season3_0SettlementViewContainer", package.seeall)

local Season3_0SettlementViewContainer = class("Season3_0SettlementViewContainer", BaseViewContainer)

function Season3_0SettlementViewContainer:buildViews()
	return {
		Season3_0SettlementView.New()
	}
end

function Season3_0SettlementViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season3_0SettlementViewContainer
