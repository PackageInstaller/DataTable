-- chunkname: @modules/logic/seasonver/act123/view/Season123SettlementViewContainer.lua

module("modules.logic.seasonver.act123.view.Season123SettlementViewContainer", package.seeall)

local Season123SettlementViewContainer = class("Season123SettlementViewContainer", BaseViewContainer)

function Season123SettlementViewContainer:buildViews()
	return {
		Season123SettlementView.New()
	}
end

function Season123SettlementViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		-- block empty
	end
end

return Season123SettlementViewContainer
