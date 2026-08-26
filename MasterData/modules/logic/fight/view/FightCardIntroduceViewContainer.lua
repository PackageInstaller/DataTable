-- chunkname: @modules/logic/fight/view/FightCardIntroduceViewContainer.lua

module("modules.logic.fight.view.FightCardIntroduceViewContainer", package.seeall)

local FightCardIntroduceViewContainer = class("FightCardIntroduceViewContainer", BaseViewContainer)

function FightCardIntroduceViewContainer:buildViews()
	return {
		FightCardIntroduceView.New()
	}
end

return FightCardIntroduceViewContainer
