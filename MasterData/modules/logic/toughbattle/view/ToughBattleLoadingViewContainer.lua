-- chunkname: @modules/logic/toughbattle/view/ToughBattleLoadingViewContainer.lua

module("modules.logic.toughbattle.view.ToughBattleLoadingViewContainer", package.seeall)

local ToughBattleLoadingViewContainer = class("ToughBattleLoadingViewContainer", BaseViewContainer)

function ToughBattleLoadingViewContainer:buildViews()
	return {
		ToughBattleLoadingView.New()
	}
end

return ToughBattleLoadingViewContainer
