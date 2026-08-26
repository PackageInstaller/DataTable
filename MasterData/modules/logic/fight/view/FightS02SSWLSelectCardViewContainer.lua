-- chunkname: @modules/logic/fight/view/FightS02SSWLSelectCardViewContainer.lua

module("modules.logic.fight.view.FightS02SSWLSelectCardViewContainer", package.seeall)

local FightS02SSWLSelectCardViewContainer = class("FightS02SSWLSelectCardViewContainer", BaseViewContainer)

function FightS02SSWLSelectCardViewContainer:buildViews()
	local views = {}

	table.insert(views, FightS02SSWLSelectCardView.New())

	return views
end

return FightS02SSWLSelectCardViewContainer
