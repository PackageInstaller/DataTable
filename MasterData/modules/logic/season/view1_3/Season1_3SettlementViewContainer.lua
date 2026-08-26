-- chunkname: @modules/logic/season/view1_3/Season1_3SettlementViewContainer.lua

module("modules.logic.season.view1_3.Season1_3SettlementViewContainer", package.seeall)

local Season1_3SettlementViewContainer = class("Season1_3SettlementViewContainer", BaseViewContainer)

function Season1_3SettlementViewContainer:buildViews()
	return {
		Season1_3SettlementView.New()
	}
end

function Season1_3SettlementViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_3SettlementViewContainer
