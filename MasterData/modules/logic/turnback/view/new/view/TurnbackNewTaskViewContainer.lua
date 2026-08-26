-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewTaskViewContainer.lua

module("modules.logic.turnback.view.new.view.TurnbackNewTaskViewContainer", package.seeall)

local TurnbackNewTaskViewContainer = class("TurnbackNewTaskViewContainer", BaseViewContainer)

function TurnbackNewTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "left/#scroll_task"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = TurnbackNewTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1136
	scrollParam.cellHeight = 152
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 6
	scrollParam.startSpace = 6
	scrollParam.frameUpdateMs = 100
	self._scrollView = LuaListScrollView.New(TurnbackTaskModel.instance, scrollParam)

	table.insert(views, self._scrollView)
	table.insert(views, TurnbackNewTaskView.New())

	return views
end

return TurnbackNewTaskViewContainer
