-- chunkname: @modules/logic/fight/view/FightChangeHeroSelectSkillTargetViewContainer.lua

module("modules.logic.fight.view.FightChangeHeroSelectSkillTargetViewContainer", package.seeall)

local FightChangeHeroSelectSkillTargetViewContainer = class("FightChangeHeroSelectSkillTargetViewContainer", BaseViewContainer)

function FightChangeHeroSelectSkillTargetViewContainer:buildViews()
	return {
		FightChangeHeroSelectSkillTargetView.New()
	}
end

return FightChangeHeroSelectSkillTargetViewContainer
