-- chunkname: @modules/logic/fight/view/rouge2/FightRouge2Check362ViewContainer.lua

module("modules.logic.fight.view.rouge2.FightRouge2Check362ViewContainer", package.seeall)

local FightRouge2Check362ViewContainer = class("FightRouge2Check362ViewContainer", BaseViewContainer)

function FightRouge2Check362ViewContainer:buildViews()
	return {
		FightRouge2Check362View.New()
	}
end

return FightRouge2Check362ViewContainer
