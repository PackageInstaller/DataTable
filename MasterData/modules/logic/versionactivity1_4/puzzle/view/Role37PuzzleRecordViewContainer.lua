-- chunkname: @modules/logic/versionactivity1_4/puzzle/view/Role37PuzzleRecordViewContainer.lua

module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleRecordViewContainer", package.seeall)

local Role37PuzzleRecordViewContainer = class("Role37PuzzleRecordViewContainer", BaseViewContainer)

function Role37PuzzleRecordViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_List"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_List/Viewport/Content/RecordItem"
	scrollParam.cellClass = PuzzleRecordViewItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1500
	scrollParam.cellHeight = 40
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 15
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(PuzzleRecordListModel.instance, scrollParam))
	table.insert(views, Role37PuzzleRecordView.New())

	return views
end

return Role37PuzzleRecordViewContainer
