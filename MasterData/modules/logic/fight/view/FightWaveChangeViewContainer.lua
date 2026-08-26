-- chunkname: @modules/logic/fight/view/FightWaveChangeViewContainer.lua

module("modules.logic.fight.view.FightWaveChangeViewContainer", package.seeall)

local FightWaveChangeViewContainer = class("FightWaveChangeViewContainer", BaseViewContainer)

function FightWaveChangeViewContainer:buildViews()
	return {
		FightWaveChangeView.New()
	}
end

return FightWaveChangeViewContainer
