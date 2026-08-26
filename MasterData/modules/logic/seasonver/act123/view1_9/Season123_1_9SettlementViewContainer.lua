-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9SettlementViewContainer.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9SettlementViewContainer", package.seeall)

local Season123_1_9SettlementViewContainer = class("Season123_1_9SettlementViewContainer", BaseViewContainer)

function Season123_1_9SettlementViewContainer:buildViews()
	return {
		Season123_1_9SettlementView.New()
	}
end

function Season123_1_9SettlementViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123_1_9SettlementViewContainer
