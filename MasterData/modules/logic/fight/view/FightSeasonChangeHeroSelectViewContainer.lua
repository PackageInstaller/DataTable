-- chunkname: @modules/logic/fight/view/FightSeasonChangeHeroSelectViewContainer.lua

module("modules.logic.fight.view.FightSeasonChangeHeroSelectViewContainer", package.seeall)

local FightSeasonChangeHeroSelectViewContainer = class("FightSeasonChangeHeroSelectViewContainer", BaseViewContainer)

function FightSeasonChangeHeroSelectViewContainer:buildViews()
	return {
		FightSeasonChangeHeroSelectView.New()
	}
end

return FightSeasonChangeHeroSelectViewContainer
