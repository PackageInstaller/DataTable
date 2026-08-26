-- chunkname: @modules/logic/versionactivity2_6/dungeon/view/task/VersionActivity2_6TaskViewContainer.lua

module("modules.logic.versionactivity2_6.dungeon.view.task.VersionActivity2_6TaskViewContainer", package.seeall)

local VersionActivity2_6TaskViewContainer = class("VersionActivity2_6TaskViewContainer", BaseViewContainer)

function VersionActivity2_6TaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = VersionActivity2_6TaskItem
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

	self._taskScrollView = LuaListScrollViewWithAnimator.New(VersionActivity2_6TaskListModel.instance, scrollParam, times)

	return {
		self._taskScrollView,
		VersionActivity2_6TaskView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function VersionActivity2_6TaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity2_6TaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return VersionActivity2_6TaskViewContainer
