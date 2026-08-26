-- chunkname: @modules/logic/weekwalk/view/WeekWalkShallowSettlementViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkShallowSettlementViewContainer", package.seeall)

local WeekWalkShallowSettlementViewContainer = class("WeekWalkShallowSettlementViewContainer", BaseViewContainer)

function WeekWalkShallowSettlementViewContainer:buildViews()
	return {
		WeekWalkShallowSettlementView.New()
	}
end

return WeekWalkShallowSettlementViewContainer
