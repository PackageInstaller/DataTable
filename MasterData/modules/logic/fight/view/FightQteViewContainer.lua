-- chunkname: @modules/logic/fight/view/FightQteViewContainer.lua

module("modules.logic.fight.view.FightQteViewContainer", package.seeall)

local FightQteViewContainer = class("FightQteViewContainer", BaseViewContainer)

function FightQteViewContainer:buildViews()
	return {
		FightQteView.New()
	}
end

return FightQteViewContainer
