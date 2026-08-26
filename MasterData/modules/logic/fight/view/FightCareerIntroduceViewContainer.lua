-- chunkname: @modules/logic/fight/view/FightCareerIntroduceViewContainer.lua

module("modules.logic.fight.view.FightCareerIntroduceViewContainer", package.seeall)

local FightCareerIntroduceViewContainer = class("FightCareerIntroduceViewContainer", BaseViewContainer)

function FightCareerIntroduceViewContainer:buildViews()
	return {
		FightCareerIntroduceView.New()
	}
end

return FightCareerIntroduceViewContainer
