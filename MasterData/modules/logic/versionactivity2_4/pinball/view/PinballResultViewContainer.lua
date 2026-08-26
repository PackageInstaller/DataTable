-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballResultViewContainer.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballResultViewContainer", package.seeall)

local PinballResultViewContainer = class("PinballResultViewContainer", BaseViewContainer)

function PinballResultViewContainer:buildViews()
	return {
		PinballResultView.New()
	}
end

return PinballResultViewContainer
