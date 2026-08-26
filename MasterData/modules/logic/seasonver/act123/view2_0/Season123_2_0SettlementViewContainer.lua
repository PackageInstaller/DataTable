-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0SettlementViewContainer.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0SettlementViewContainer", package.seeall)

local Season123_2_0SettlementViewContainer = class("Season123_2_0SettlementViewContainer", BaseViewContainer)

function Season123_2_0SettlementViewContainer:buildViews()
	return {
		Season123_2_0SettlementView.New()
	}
end

function Season123_2_0SettlementViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_2_0SettlementViewContainer
