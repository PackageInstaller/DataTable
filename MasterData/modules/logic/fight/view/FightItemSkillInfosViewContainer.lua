-- chunkname: @modules/logic/fight/view/FightItemSkillInfosViewContainer.lua

module("modules.logic.fight.view.FightItemSkillInfosViewContainer", package.seeall)

local FightItemSkillInfosViewContainer = class("FightItemSkillInfosViewContainer", BaseViewContainer)

function FightItemSkillInfosViewContainer:buildViews()
	return {
		FightItemSkillInfosView.New()
	}
end

return FightItemSkillInfosViewContainer
