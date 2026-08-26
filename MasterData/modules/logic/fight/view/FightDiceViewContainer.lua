-- chunkname: @modules/logic/fight/view/FightDiceViewContainer.lua

module("modules.logic.fight.view.FightDiceViewContainer", package.seeall)

local FightDiceViewContainer = class("FightDiceViewContainer", BaseViewContainer)

function FightDiceViewContainer:buildViews()
	return {
		FightDiceView.New()
	}
end

return FightDiceViewContainer
