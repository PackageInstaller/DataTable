-- chunkname: @modules/logic/fight/view/FightBLESelectCrystalViewContainer.lua

module("modules.logic.fight.view.FightBLESelectCrystalViewContainer", package.seeall)

local FightBLESelectCrystalViewContainer = class("FightBLESelectCrystalViewContainer", BaseViewContainer)

function FightBLESelectCrystalViewContainer:buildViews()
	local views = {}

	table.insert(views, FightBLESelectCrystalView.New())

	return views
end

return FightBLESelectCrystalViewContainer
