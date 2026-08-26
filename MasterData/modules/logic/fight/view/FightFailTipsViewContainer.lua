-- chunkname: @modules/logic/fight/view/FightFailTipsViewContainer.lua

module("modules.logic.fight.view.FightFailTipsViewContainer", package.seeall)

local FightFailTipsViewContainer = class("FightFailTipsViewContainer", BaseViewContainer)

function FightFailTipsViewContainer:buildViews()
	return {
		FightFailTipsView.New()
	}
end

return FightFailTipsViewContainer
