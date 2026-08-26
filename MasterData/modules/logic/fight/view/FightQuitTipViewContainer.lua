-- chunkname: @modules/logic/fight/view/FightQuitTipViewContainer.lua

module("modules.logic.fight.view.FightQuitTipViewContainer", package.seeall)

local FightQuitTipViewContainer = class("FightQuitTipViewContainer", BaseViewContainer)

function FightQuitTipViewContainer:buildViews()
	return {
		FightQuitTipView.New(),
		Season166FightQuitTipView.New()
	}
end

return FightQuitTipViewContainer
