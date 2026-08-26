-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8SettlementViewContainer.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8SettlementViewContainer", package.seeall)

local Season123_1_8SettlementViewContainer = class("Season123_1_8SettlementViewContainer", BaseViewContainer)

function Season123_1_8SettlementViewContainer:buildViews()
	return {
		Season123_1_8SettlementView.New()
	}
end

function Season123_1_8SettlementViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_1_8SettlementViewContainer
