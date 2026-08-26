-- chunkname: @modules/logic/dungeon/view/DungeonMonsterViewContainer.lua

module("modules.logic.dungeon.view.DungeonMonsterViewContainer", package.seeall)

local DungeonMonsterViewContainer = class("DungeonMonsterViewContainer", BaseViewContainer)

function DungeonMonsterViewContainer:buildViews()
	local views = {}

	table.insert(views, DungeonMonsterView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_monster"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "content_prefab"
	scrollParam.cellClass = DungeonMonsterItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 130
	scrollParam.cellHeight = 130
	scrollParam.cellSpaceH = 40
	scrollParam.cellSpaceV = 40
	scrollParam.startSpace = 24
	scrollParam.endSpace = 0
	self._scrollView = LuaListScrollView.New(DungeonMonsterListModel.instance, scrollParam)

	table.insert(views, self._scrollView)
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function DungeonMonsterViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		}, 100)
	}
end

function DungeonMonsterViewContainer:getScrollView()
	return self._scrollView
end

return DungeonMonsterViewContainer
