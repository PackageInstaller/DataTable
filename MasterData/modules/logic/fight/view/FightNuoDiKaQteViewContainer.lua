-- chunkname: @modules/logic/fight/view/FightNuoDiKaQteViewContainer.lua

module("modules.logic.fight.view.FightNuoDiKaQteViewContainer", package.seeall)

local FightNuoDiKaQteViewContainer = class("FightNuoDiKaQteViewContainer", BaseViewContainer)

function FightNuoDiKaQteViewContainer:buildViews()
	return {
		FightNuoDiKaQteView.New()
	}
end

return FightNuoDiKaQteViewContainer
