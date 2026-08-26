-- chunkname: @modules/logic/season/view1_5/Season1_5SettlementViewContainer.lua

module("modules.logic.season.view1_5.Season1_5SettlementViewContainer", package.seeall)

local Season1_5SettlementViewContainer = class("Season1_5SettlementViewContainer", BaseViewContainer)

function Season1_5SettlementViewContainer:buildViews()
	return {
		Season1_5SettlementView.New()
	}
end

function Season1_5SettlementViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_5SettlementViewContainer
