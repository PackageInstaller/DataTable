-- chunkname: @modules/logic/fight/view/FightFocusCameraAdjustViewContainer.lua

module("modules.logic.fight.view.FightFocusCameraAdjustViewContainer", package.seeall)

local FightFocusCameraAdjustViewContainer = class("FightFocusCameraAdjustViewContainer", BaseViewContainer)

function FightFocusCameraAdjustViewContainer:buildViews()
	return {
		FightFocusCameraAdjustView.New()
	}
end

return FightFocusCameraAdjustViewContainer
