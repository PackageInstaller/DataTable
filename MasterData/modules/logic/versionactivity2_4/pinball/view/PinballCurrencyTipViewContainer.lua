-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballCurrencyTipViewContainer.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballCurrencyTipViewContainer", package.seeall)

local PinballCurrencyTipViewContainer = class("PinballCurrencyTipViewContainer", BaseViewContainer)

function PinballCurrencyTipViewContainer:buildViews()
	return {
		PinballCurrencyTipView.New()
	}
end

return PinballCurrencyTipViewContainer
