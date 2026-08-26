-- chunkname: @modules/logic/versionactivity2_0/dungeon/view/task/VersionActivity2_0TaskViewContainer.lua

module("modules.logic.versionactivity2_0.dungeon.view.task.VersionActivity2_0TaskViewContainer", package.seeall)

local VersionActivity2_0TaskViewContainer = class("VersionActivity2_0TaskViewContainer", BaseViewContainer)

function VersionActivity2_0TaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = VersionActivity2_0TaskItem
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

	self._taskScrollView = LuaListScrollViewWithAnimator.New(VersionActivity2_0TaskListModel.instance, scrollParam, times)

	return {
		VersionActivity2_0TaskView.New(),
		self._taskScrollView,
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function VersionActivity2_0TaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity2_0TaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return VersionActivity2_0TaskViewContainer
