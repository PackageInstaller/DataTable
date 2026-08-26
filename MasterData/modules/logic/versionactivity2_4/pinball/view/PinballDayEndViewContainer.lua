-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballDayEndViewContainer.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballDayEndViewContainer", package.seeall)

local PinballDayEndViewContainer = class("PinballDayEndViewContainer", BaseViewContainer)

function PinballDayEndViewContainer:buildViews()
	return {
		PinballDayEndView.New()
	}
end

return PinballDayEndViewContainer
