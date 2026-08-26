-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3SettlementViewContainer.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3SettlementViewContainer", package.seeall)

local Season123_2_3SettlementViewContainer = class("Season123_2_3SettlementViewContainer", BaseViewContainer)

function Season123_2_3SettlementViewContainer:buildViews()
	return {
		Season123_2_3SettlementView.New()
	}
end

function Season123_2_3SettlementViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_2_3SettlementViewContainer
