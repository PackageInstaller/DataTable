-- chunkname: @modules/logic/seasonver/act123/view3_5/Season123_3_5SettlementViewContainer.lua

module("modules.logic.seasonver.act123.view3_5.Season123_3_5SettlementViewContainer", package.seeall)

local Season123_3_5SettlementViewContainer = class("Season123_3_5SettlementViewContainer", BaseViewContainer)

function Season123_3_5SettlementViewContainer:buildViews()
	return {
		Season123_3_5SettlementView.New()
	}
end

return Season123_3_5SettlementViewContainer
