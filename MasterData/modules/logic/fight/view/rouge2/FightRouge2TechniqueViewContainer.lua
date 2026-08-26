-- chunkname: @modules/logic/fight/view/rouge2/FightRouge2TechniqueViewContainer.lua

module("modules.logic.fight.view.rouge2.FightRouge2TechniqueViewContainer", package.seeall)

local FightRouge2TechniqueViewContainer = class("FightRouge2TechniqueViewContainer", BaseViewContainer)

function FightRouge2TechniqueViewContainer:buildViews()
	local views = {}

	table.insert(views, FightRouge2TechniqueView.New())

	return views
end

return FightRouge2TechniqueViewContainer
