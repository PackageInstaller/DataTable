-- chunkname: @modules/logic/fight/view/FightCardDeckGMViewContainer.lua

module("modules.logic.fight.view.FightCardDeckGMViewContainer", package.seeall)

local FightCardDeckGMViewContainer = class("FightCardDeckGMViewContainer", BaseViewContainer)

function FightCardDeckGMViewContainer:buildViews()
	return {
		FightCardDeckGMView.New()
	}
end

return FightCardDeckGMViewContainer
