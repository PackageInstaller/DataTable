-- chunkname: @modules/logic/fight/view/FightCardDescViewContainer.lua

module("modules.logic.fight.view.FightCardDescViewContainer", package.seeall)

local FightCardDescViewContainer = class("FightCardDescViewContainer", BaseViewContainer)

function FightCardDescViewContainer:buildViews()
	return {
		FightCardDescView.New()
	}
end

return FightCardDescViewContainer
