-- chunkname: @modules/logic/fight/view/FightStatViewContainer.lua

module("modules.logic.fight.view.FightStatViewContainer", package.seeall)

local FightStatViewContainer = class("FightStatViewContainer", BaseViewContainer)

function FightStatViewContainer:buildViews()
	local listParam = ListScrollParam.New()

	listParam.scrollGOPath = "view/scroll"
	listParam.prefabType = ScrollEnum.ScrollPrefabFromView
	listParam.prefabUrl = "view/scroll/item"
	listParam.cellClass = FightStatItem
	listParam.scrollDir = ScrollEnum.ScrollDirV
	listParam.lineCount = 1
	listParam.cellWidth = 1660
	listParam.cellHeight = 146
	listParam.cellSpaceH = 0
	listParam.cellSpaceV = 6.5

	local listView = LuaListScrollView.New(FightStatModel.instance, listParam)

	self.fightStatView = FightStatView.New()

	return {
		self.fightStatView,
		listView
	}
end

return FightStatViewContainer
