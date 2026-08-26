-- chunkname: @modules/logic/tips/view/FightDeviceCardTipViewContainer.lua

module("modules.logic.tips.view.FightDeviceCardTipViewContainer", package.seeall)

local FightDeviceCardTipViewContainer = class("FightDeviceCardTipViewContainer", BaseViewContainer)

function FightDeviceCardTipViewContainer:buildViews()
	return {
		FightDeviceCardTipView.New()
	}
end

return FightDeviceCardTipViewContainer
