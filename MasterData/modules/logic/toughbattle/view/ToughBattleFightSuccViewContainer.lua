-- chunkname: @modules/logic/toughbattle/view/ToughBattleFightSuccViewContainer.lua

module("modules.logic.toughbattle.view.ToughBattleFightSuccViewContainer", package.seeall)

local ToughBattleFightSuccViewContainer = class("ToughBattleFightSuccViewContainer", BaseViewContainer)

function ToughBattleFightSuccViewContainer:buildViews()
	return {
		ToughBattleFightSuccView.New()
	}
end

return ToughBattleFightSuccViewContainer
