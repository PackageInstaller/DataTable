-- chunkname: @modules/logic/fight/view/FightWeekWalkEnemyTipsViewContainer.lua

module("modules.logic.fight.view.FightWeekWalkEnemyTipsViewContainer", package.seeall)

local FightWeekWalkEnemyTipsViewContainer = class("FightWeekWalkEnemyTipsViewContainer", BaseViewContainer)

function FightWeekWalkEnemyTipsViewContainer:buildViews()
	return {
		FightWeekWalkEnemyTipsView.New()
	}
end

return FightWeekWalkEnemyTipsViewContainer
