-- chunkname: @modules/logic/fight/view/FightSeasonDiceViewContainer.lua

module("modules.logic.fight.view.FightSeasonDiceViewContainer", package.seeall)

local FightSeasonDiceViewContainer = class("FightSeasonDiceViewContainer", BaseViewContainer)

function FightSeasonDiceViewContainer:buildViews()
	return {
		FightSeasonDiceView.New()
	}
end

return FightSeasonDiceViewContainer
