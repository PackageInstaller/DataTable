-- chunkname: @modules/logic/tips/view/FightBloodPoolTipViewContainer.lua

module("modules.logic.tips.view.FightBloodPoolTipViewContainer", package.seeall)

local FightBloodPoolTipViewContainer = class("FightBloodPoolTipViewContainer", BaseViewContainer)

function FightBloodPoolTipViewContainer:buildViews()
	return {
		FightBloodPoolTipView.New()
	}
end

return FightBloodPoolTipViewContainer
