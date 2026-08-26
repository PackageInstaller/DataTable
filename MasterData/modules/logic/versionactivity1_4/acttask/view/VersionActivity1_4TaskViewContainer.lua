-- chunkname: @modules/logic/versionactivity1_4/acttask/view/VersionActivity1_4TaskViewContainer.lua

module("modules.logic.versionactivity1_4.acttask.view.VersionActivity1_4TaskViewContainer", package.seeall)

local VersionActivity1_4TaskViewContainer = class("VersionActivity1_4TaskViewContainer", BaseViewContainer)

function VersionActivity1_4TaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Right/#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = VersionActivity1_4TaskItem
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

	self._taskScrollView = LuaListScrollViewWithAnimator.New(VersionActivity1_4TaskListModel.instance, scrollParam, times)

	return {
		self._taskScrollView,
		VersionActivity1_4TaskView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function VersionActivity1_4TaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity1_4TaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

function VersionActivity1_4TaskViewContainer:getScrollView()
	return self._taskScrollView
end

return VersionActivity1_4TaskViewContainer
