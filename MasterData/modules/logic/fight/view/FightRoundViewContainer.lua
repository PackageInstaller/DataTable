-- chunkname: @modules/logic/fight/view/FightRoundViewContainer.lua

module("modules.logic.fight.view.FightRoundViewContainer", package.seeall)

local FightRoundViewContainer = class("FightRoundViewContainer", BaseViewContainer)

function FightRoundViewContainer:buildViews()
	return {
		FightRoundView.New()
	}
end

return FightRoundViewContainer
