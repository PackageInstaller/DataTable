-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballUpgradeViewContainer.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballUpgradeViewContainer", package.seeall)

local PinballUpgradeViewContainer = class("PinballUpgradeViewContainer", BaseViewContainer)

function PinballUpgradeViewContainer:buildViews()
	return {
		PinballUpgradeView.New()
	}
end

return PinballUpgradeViewContainer
