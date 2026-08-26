-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicTaskViewContainer.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicTaskViewContainer", package.seeall)

local VersionActivity2_4MusicTaskViewContainer = class("VersionActivity2_4MusicTaskViewContainer", BaseViewContainer)

function VersionActivity2_4MusicTaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = VersionActivity2_4MusicTaskItem
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

	self._taskScrollView = LuaListScrollViewWithAnimator.New(VersionActivity2_4MusicTaskListModel.instance, scrollParam, times)

	return {
		self._taskScrollView,
		VersionActivity2_4MusicTaskView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function VersionActivity2_4MusicTaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity2_4MusicTaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

function VersionActivity2_4MusicTaskViewContainer:addTaskItem(item)
	self._taskItemList = self._taskItemList or {}
	self._taskItemList[item] = item
end

function VersionActivity2_4MusicTaskViewContainer:getTaskItemList()
	return self._taskItemList or {}
end

return VersionActivity2_4MusicTaskViewContainer
