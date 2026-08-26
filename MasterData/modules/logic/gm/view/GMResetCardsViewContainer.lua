-- chunkname: @modules/logic/gm/view/GMResetCardsViewContainer.lua

module("modules.logic.gm.view.GMResetCardsViewContainer", package.seeall)

local GMResetCardsViewContainer = class("GMResetCardsViewContainer", BaseViewContainer)

function GMResetCardsViewContainer:buildViews()
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "viewport1"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam1.prefabUrl = "viewport1/item"
	scrollParam1.cellClass = GMResetCardsItem1
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 170
	scrollParam1.cellHeight = 250
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 0

	local scrollParam2 = ListScrollParam.New()

	scrollParam2.scrollGOPath = "viewport2"
	scrollParam2.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam2.prefabUrl = "viewport2/item"
	scrollParam2.cellClass = GMResetCardsItem2
	scrollParam2.scrollDir = ScrollEnum.ScrollDirH
	scrollParam2.lineCount = 2
	scrollParam2.cellWidth = 170
	scrollParam2.cellHeight = 250
	scrollParam2.cellSpaceH = 0
	scrollParam2.cellSpaceV = 20
	scrollParam2.startSpace = 0

	local views = {}

	table.insert(views, GMResetCardsView.New())
	table.insert(views, LuaListScrollView.New(GMResetCardsModel.instance:getModel1(), scrollParam1))
	table.insert(views, LuaListScrollView.New(GMResetCardsModel.instance:getModel2(), scrollParam2))

	return views
end

return GMResetCardsViewContainer
