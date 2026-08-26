-- chunkname: @modules/logic/fight/view/FightAiJiAoQteSelectViewContainer.lua

module("modules.logic.fight.view.FightAiJiAoQteSelectViewContainer", package.seeall)

local FightAiJiAoQteSelectViewContainer = class("FightAiJiAoQteSelectViewContainer", BaseViewContainer)

function FightAiJiAoQteSelectViewContainer:buildViews()
	return {
		FightAiJiAoQteSelectView.New()
	}
end

return FightAiJiAoQteSelectViewContainer
