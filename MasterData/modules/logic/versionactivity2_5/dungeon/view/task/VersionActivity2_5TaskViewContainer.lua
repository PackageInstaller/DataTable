-- chunkname: @modules/logic/versionactivity2_5/dungeon/view/task/VersionActivity2_5TaskViewContainer.lua

module("modules.logic.versionactivity2_5.dungeon.view.task.VersionActivity2_5TaskViewContainer", package.seeall)

local VersionActivity2_5TaskViewContainer = class("VersionActivity2_5TaskViewContainer", BaseViewContainer)

function VersionActivity2_5TaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = VersionActivity2_5TaskItem
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

	self._taskScrollView = LuaListScrollViewWithAnimator.New(VersionActivity2_5TaskListModel.instance, scrollParam, times)

	return {
		self._taskScrollView,
		VersionActivity2_5TaskView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function VersionActivity2_5TaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity2_5TaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return VersionActivity2_5TaskViewContainer
