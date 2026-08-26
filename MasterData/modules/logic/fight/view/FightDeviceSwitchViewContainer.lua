-- chunkname: @modules/logic/fight/view/FightDeviceSwitchViewContainer.lua

module("modules.logic.fight.view.FightDeviceSwitchViewContainer", package.seeall)

local FightDeviceSwitchViewContainer = class("FightDeviceSwitchViewContainer", BaseViewContainer)

function FightDeviceSwitchViewContainer:buildViews()
	return {
		FightDeviceSwitchView.New()
	}
end

return FightDeviceSwitchViewContainer
