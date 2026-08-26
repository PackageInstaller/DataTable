-- chunkname: @modules/logic/tips/view/FightCommonTipViewContainer.lua

module("modules.logic.tips.view.FightCommonTipViewContainer", package.seeall)

local FightCommonTipViewContainer = class("FightCommonTipViewContainer", BaseViewContainer)

function FightCommonTipViewContainer:buildViews()
	return {
		FightCommonTipView.New()
	}
end

return FightCommonTipViewContainer
