-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaSmeltResultViewContainer.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaSmeltResultViewContainer", package.seeall)

local LoperaSmeltResultViewContainer = class("LoperaSmeltResultViewContainer", BaseViewContainer)

function LoperaSmeltResultViewContainer:buildViews()
	return {
		LoperaSmeltResultView.New()
	}
end

return LoperaSmeltResultViewContainer
