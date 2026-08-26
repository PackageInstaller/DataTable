-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/task/VersionActivity2_4TaskViewContainer.lua

module("modules.logic.versionactivity2_4.dungeon.view.task.VersionActivity2_4TaskViewContainer", package.seeall)

local VersionActivity2_4TaskViewContainer = class("VersionActivity2_4TaskViewContainer", BaseViewContainer)

function VersionActivity2_4TaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = VersionActivity2_4TaskItem
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

	self._taskScrollView = LuaListScrollViewWithAnimator.New(VersionActivity2_4TaskListModel.instance, scrollParam, times)

	return {
		self._taskScrollView,
		VersionActivity2_4TaskView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function VersionActivity2_4TaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity2_4TaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return VersionActivity2_4TaskViewContainer
