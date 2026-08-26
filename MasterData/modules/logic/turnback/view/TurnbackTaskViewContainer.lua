-- chunkname: @modules/logic/turnback/view/TurnbackTaskViewContainer.lua

module("modules.logic.turnback.view.TurnbackTaskViewContainer", package.seeall)

local TurnbackTaskViewContainer = class("TurnbackTaskViewContainer", BaseViewContainer)

function TurnbackTaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_task"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = TurnbackTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 800
	scrollParam.cellHeight = 140
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 6
	scrollParam.frameUpdateMs = 100
	self._scrollView = LuaListScrollView.New(TurnbackTaskModel.instance, scrollParam)

	return {
		self._scrollView,
		TurnbackTaskView.New()
	}
end

return TurnbackTaskViewContainer
