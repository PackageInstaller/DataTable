-- chunkname: @modules/logic/fight/view/FightLoadingViewContainer.lua

module("modules.logic.fight.view.FightLoadingViewContainer", package.seeall)

local FightLoadingViewContainer = class("FightLoadingViewContainer", BaseViewContainer)

function FightLoadingViewContainer:buildViews()
	return {
		FightLoadingView.New()
	}
end

return FightLoadingViewContainer
