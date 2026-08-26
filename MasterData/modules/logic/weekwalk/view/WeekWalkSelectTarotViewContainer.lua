-- chunkname: @modules/logic/weekwalk/view/WeekWalkSelectTarotViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkSelectTarotViewContainer", package.seeall)

local WeekWalkSelectTarotViewContainer = class("WeekWalkSelectTarotViewContainer", BaseViewContainer)

function WeekWalkSelectTarotViewContainer:buildViews()
	return {
		WeekWalkSelectTarotView.New()
	}
end

return WeekWalkSelectTarotViewContainer
