-- chunkname: @modules/logic/fight/view/FightLorentzCardCopyViewContainer.lua

module("modules.logic.fight.view.FightLorentzCardCopyViewContainer", package.seeall)

local FightLorentzCardCopyViewContainer = class("FightLorentzCardCopyViewContainer", BaseViewContainer)

function FightLorentzCardCopyViewContainer:buildViews()
	return {
		FightLorentzCardCopyView.New()
	}
end

return FightLorentzCardCopyViewContainer
