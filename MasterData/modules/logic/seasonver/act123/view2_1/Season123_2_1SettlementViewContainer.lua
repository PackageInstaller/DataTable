-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1SettlementViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1SettlementViewContainer", package.seeall)

local Season123_2_1SettlementViewContainer = class("Season123_2_1SettlementViewContainer", BaseViewContainer)

function Season123_2_1SettlementViewContainer:buildViews()
	return {
		Season123_2_1SettlementView.New()
	}
end

function Season123_2_1SettlementViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_2_1SettlementViewContainer
