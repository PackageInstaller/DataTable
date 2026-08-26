-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/task/VersionActivity1_6TaskViewContainer.lua

module("modules.logic.versionactivity1_6.dungeon.view.task.VersionActivity1_6TaskViewContainer", package.seeall)

local VersionActivity1_6TaskViewContainer = class("VersionActivity1_6TaskViewContainer", BaseViewContainer)

function VersionActivity1_6TaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = VersionActivity1_6TaskItem
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

	self._taskScrollView = LuaListScrollViewWithAnimator.New(VersionActivity1_6TaskListModel.instance, scrollParam, times)

	return {
		self._taskScrollView,
		VersionActivity1_6TaskView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function VersionActivity1_6TaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity1_6TaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return VersionActivity1_6TaskViewContainer
