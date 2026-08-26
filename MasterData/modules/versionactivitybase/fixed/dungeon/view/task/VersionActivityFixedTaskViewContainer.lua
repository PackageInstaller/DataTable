-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/task/VersionActivityFixedTaskViewContainer.lua

module("modules.versionactivitybase.fixed.dungeon.view.task.VersionActivityFixedTaskViewContainer", package.seeall)

local VersionActivityFixedTaskViewContainer = class("VersionActivityFixedTaskViewContainer", BaseViewContainer)

function VersionActivityFixedTaskViewContainer:buildViews()
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = VersionActivityFixedHelper.getVersionActivityTaskItem(self._bigVersion, self._smallVersion)
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

	self._taskScrollView = LuaListScrollViewWithAnimator.New(VersionActivityFixedTaskListModel.instance, scrollParam, times)

	return {
		self._taskScrollView,
		VersionActivityFixedHelper.getVersionActivityTaskView(self._bigVersion, self._smallVersion).New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function VersionActivityFixedTaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivityFixedTaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return VersionActivityFixedTaskViewContainer
