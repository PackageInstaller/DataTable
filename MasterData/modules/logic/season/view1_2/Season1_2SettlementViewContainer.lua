-- chunkname: @modules/logic/season/view1_2/Season1_2SettlementViewContainer.lua

module("modules.logic.season.view1_2.Season1_2SettlementViewContainer", package.seeall)

local Season1_2SettlementViewContainer = class("Season1_2SettlementViewContainer", BaseViewContainer)

function Season1_2SettlementViewContainer:buildViews()
	return {
		Season1_2SettlementView.New()
	}
end

function Season1_2SettlementViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_2SettlementViewContainer
