-- chunkname: @modules/logic/fight/view/FightAiJiAoQteViewContainer.lua

module("modules.logic.fight.view.FightAiJiAoQteViewContainer", package.seeall)

local FightAiJiAoQteViewContainer = class("FightAiJiAoQteViewContainer", BaseViewContainer)

function FightAiJiAoQteViewContainer:buildViews()
	return {
		FightAiJiAoQteView.New()
	}
end

return FightAiJiAoQteViewContainer
