-- chunkname: @modules/logic/season/view1_4/Season1_4SettlementViewContainer.lua

module("modules.logic.season.view1_4.Season1_4SettlementViewContainer", package.seeall)

local Season1_4SettlementViewContainer = class("Season1_4SettlementViewContainer", BaseViewContainer)

function Season1_4SettlementViewContainer:buildViews()
	return {
		Season1_4SettlementView.New()
	}
end

function Season1_4SettlementViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_4SettlementViewContainer
