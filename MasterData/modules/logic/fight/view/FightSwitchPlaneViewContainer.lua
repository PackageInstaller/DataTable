-- chunkname: @modules/logic/fight/view/FightSwitchPlaneViewContainer.lua

module("modules.logic.fight.view.FightSwitchPlaneViewContainer", package.seeall)

local FightSwitchPlaneViewContainer = class("FightSwitchPlaneViewContainer", BaseViewContainer)

function FightSwitchPlaneViewContainer:buildViews()
	return {
		FightSwitchPlaneView.New()
	}
end

return FightSwitchPlaneViewContainer
