-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballBuildViewContainer.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballBuildViewContainer", package.seeall)

local PinballBuildViewContainer = class("PinballBuildViewContainer", BaseViewContainer)

function PinballBuildViewContainer:buildViews()
	return {
		PinballBuildView.New()
	}
end

return PinballBuildViewContainer
