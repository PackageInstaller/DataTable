-- chunkname: @modules/logic/fight/view/FightSkillStrengthenViewContainer.lua

module("modules.logic.fight.view.FightSkillStrengthenViewContainer", package.seeall)

local FightSkillStrengthenViewContainer = class("FightSkillStrengthenViewContainer", BaseViewContainer)

function FightSkillStrengthenViewContainer:buildViews()
	return {
		FightSkillStrengthenView.New()
	}
end

return FightSkillStrengthenViewContainer
