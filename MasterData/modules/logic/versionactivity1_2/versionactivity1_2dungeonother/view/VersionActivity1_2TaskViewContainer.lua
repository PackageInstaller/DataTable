-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeonother/view/VersionActivity1_2TaskViewContainer.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2TaskViewContainer", package.seeall)

local VersionActivity1_2TaskViewContainer = class("VersionActivity1_2TaskViewContainer", BaseViewContainer)

function VersionActivity1_2TaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_list"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = VersionActivity1_2TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1160
	scrollParam.cellHeight = 160
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 5.63

	local times = {}

	for i = 1, 6 do
		times[i] = (i - 1) * 0.06
	end

	self._taskScrollView = LuaListScrollViewWithAnimator.New(VersionActivity1_2TaskListModel.instance, scrollParam, times)

	return {
		self._taskScrollView,
		VersionActivity1_2TaskView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function VersionActivity1_2TaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivity1_2TaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return VersionActivity1_2TaskViewContainer
