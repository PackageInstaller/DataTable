-- chunkname: @modules/logic/fight/view/FightNaNaTargetViewContainer.lua

module("modules.logic.fight.view.FightNaNaTargetViewContainer", package.seeall)

local FightNaNaTargetViewContainer = class("FightNaNaTargetViewContainer", BaseViewContainer)

function FightNaNaTargetViewContainer:buildViews()
	local views = {}

	table.insert(views, FightNaNaTargetView.New())

	return views
end

return FightNaNaTargetViewContainer
