-- chunkname: @modules/logic/fight/view/FightSpecialTipViewContainer.lua

module("modules.logic.fight.view.FightSpecialTipViewContainer", package.seeall)

local FightSpecialTipViewContainer = class("FightSpecialTipViewContainer", BaseViewContainer)

function FightSpecialTipViewContainer:buildViews()
	return {
		FightSpecialTipView.New()
	}
end

function FightSpecialTipViewContainer:onContainerCloseFinish()
	FightController.instance:dispatchEvent(FightEvent.SetPlayCardPartOriginPos)
end

return FightSpecialTipViewContainer
