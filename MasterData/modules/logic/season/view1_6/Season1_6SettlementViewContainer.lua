-- chunkname: @modules/logic/season/view1_6/Season1_6SettlementViewContainer.lua

module("modules.logic.season.view1_6.Season1_6SettlementViewContainer", package.seeall)

local Season1_6SettlementViewContainer = class("Season1_6SettlementViewContainer", BaseViewContainer)

function Season1_6SettlementViewContainer:buildViews()
	return {
		Season1_6SettlementView.New()
	}
end

function Season1_6SettlementViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season1_6SettlementViewContainer
