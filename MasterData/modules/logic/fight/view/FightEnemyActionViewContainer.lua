-- chunkname: @modules/logic/fight/view/FightEnemyActionViewContainer.lua

module("modules.logic.fight.view.FightEnemyActionViewContainer", package.seeall)

local FightEnemyActionViewContainer = class("FightEnemyActionViewContainer", BaseViewContainer)

function FightEnemyActionViewContainer:buildViews()
	local views = {}

	table.insert(views, FightEnemyActionView.New())

	return views
end

return FightEnemyActionViewContainer
