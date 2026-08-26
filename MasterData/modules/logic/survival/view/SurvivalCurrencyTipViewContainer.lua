-- chunkname: @modules/logic/survival/view/SurvivalCurrencyTipViewContainer.lua

module("modules.logic.survival.view.SurvivalCurrencyTipViewContainer", package.seeall)

local SurvivalCurrencyTipViewContainer = class("SurvivalCurrencyTipViewContainer", BaseViewContainer)

function SurvivalCurrencyTipViewContainer:buildViews()
	return {
		SurvivalCurrencyTipView.New()
	}
end

return SurvivalCurrencyTipViewContainer
