-- chunkname: @modules/logic/fight/view/FightFailViewContainer.lua

module("modules.logic.fight.view.FightFailViewContainer", package.seeall)

local FightFailViewContainer = class("FightFailViewContainer", BaseViewContainer)

function FightFailViewContainer:buildViews()
	return {
		FightFailView.New()
	}
end

return FightFailViewContainer
