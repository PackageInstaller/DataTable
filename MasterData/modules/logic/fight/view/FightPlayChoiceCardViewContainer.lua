-- chunkname: @modules/logic/fight/view/FightPlayChoiceCardViewContainer.lua

module("modules.logic.fight.view.FightPlayChoiceCardViewContainer", package.seeall)

local FightPlayChoiceCardViewContainer = class("FightPlayChoiceCardViewContainer", BaseViewContainer)

function FightPlayChoiceCardViewContainer:buildViews()
	return {
		FightPlayChoiceCardView.New()
	}
end

return FightPlayChoiceCardViewContainer
