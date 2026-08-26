-- chunkname: @modules/logic/fight/view/FightSkillTargetViewContainer.lua

module("modules.logic.fight.view.FightSkillTargetViewContainer", package.seeall)

local FightSkillTargetViewContainer = class("FightSkillTargetViewContainer", BaseViewContainer)

function FightSkillTargetViewContainer:buildViews()
	return {
		FightSkillTargetView.New()
	}
end

return FightSkillTargetViewContainer
