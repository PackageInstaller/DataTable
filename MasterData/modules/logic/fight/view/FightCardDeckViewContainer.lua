-- chunkname: @modules/logic/fight/view/FightCardDeckViewContainer.lua

module("modules.logic.fight.view.FightCardDeckViewContainer", package.seeall)

local FightCardDeckViewContainer = class("FightCardDeckViewContainer", BaseViewContainer)

function FightCardDeckViewContainer:buildViews()
	return {
		FightCardDeckView.New()
	}
end

return FightCardDeckViewContainer
