-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateTaskViewContainer.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateTaskViewContainer", package.seeall)

local EliminateTaskViewContainer = class("EliminateTaskViewContainer", BaseViewContainer)

function EliminateTaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = EliminateTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1160
	scrollParam.cellHeight = 165
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0

	local times = {}

	for i = 1, 6 do
		times[i] = (i - 1) * 0.06
	end

	self._taskScrollView = LuaListScrollViewWithAnimator.New(EliminateTaskListModel.instance, scrollParam, times)

	return {
		self._taskScrollView,
		EliminateTaskView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function EliminateTaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function EliminateTaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return EliminateTaskViewContainer
