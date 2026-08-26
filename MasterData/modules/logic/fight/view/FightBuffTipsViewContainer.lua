-- chunkname: @modules/logic/fight/view/FightBuffTipsViewContainer.lua

module("modules.logic.fight.view.FightBuffTipsViewContainer", package.seeall)

local FightBuffTipsViewContainer = class("FightBuffTipsViewContainer", BaseViewContainer)

function FightBuffTipsViewContainer:buildViews()
	return {
		FightBuffTipsView.New()
	}
end

return FightBuffTipsViewContainer
