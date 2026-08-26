-- chunkname: @modules/logic/fight/view/FightTechniqueTipsViewContainer.lua

module("modules.logic.fight.view.FightTechniqueTipsViewContainer", package.seeall)

local FightTechniqueTipsViewContainer = class("FightTechniqueTipsViewContainer", BaseViewContainer)

function FightTechniqueTipsViewContainer:buildViews()
	return {
		FightTechniqueTipsView.New()
	}
end

return FightTechniqueTipsViewContainer
