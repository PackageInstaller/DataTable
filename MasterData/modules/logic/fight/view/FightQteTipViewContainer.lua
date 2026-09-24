-- chunkname: @modules/logic/fight/view/FightQteTipViewContainer.lua

module("modules.logic.fight.view.FightQteTipViewContainer", package.seeall)

local FightQteTipViewContainer = class("FightQteTipViewContainer", BaseViewContainer)

function FightQteTipViewContainer:buildViews()
	return {
		FightQteTipView.New()
	}
end

return FightQteTipViewContainer
