-- chunkname: @modules/logic/fight/view/FightSkipTimelineViewContainer.lua

module("modules.logic.fight.view.FightSkipTimelineViewContainer", package.seeall)

local FightSkipTimelineViewContainer = class("FightSkipTimelineViewContainer", BaseViewContainer)

function FightSkipTimelineViewContainer:buildViews()
	return {
		FightSkipTimelineView.New()
	}
end

return FightSkipTimelineViewContainer
