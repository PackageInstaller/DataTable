-- chunkname: @modules/logic/toughbattle/view/ToughBattleEnemyInfoViewContainer.lua

module("modules.logic.toughbattle.view.ToughBattleEnemyInfoViewContainer", package.seeall)

local ToughBattleEnemyInfoViewContainer = class("ToughBattleEnemyInfoViewContainer", BaseViewContainer)

function ToughBattleEnemyInfoViewContainer:buildViews()
	return {
		ToughBattleEnemyInfoView.New()
	}
end

return ToughBattleEnemyInfoViewContainer
