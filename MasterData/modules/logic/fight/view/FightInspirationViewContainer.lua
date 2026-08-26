-- chunkname: @modules/logic/fight/view/FightInspirationViewContainer.lua

module("modules.logic.fight.view.FightInspirationViewContainer", package.seeall)

local FightInspirationViewContainer = class("FightInspirationViewContainer", BaseViewContainer)

function FightInspirationViewContainer:buildViews()
	return {
		FightInspirationView.New()
	}
end

return FightInspirationViewContainer
