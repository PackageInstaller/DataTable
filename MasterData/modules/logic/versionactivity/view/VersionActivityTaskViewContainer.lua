-- chunkname: @modules/logic/versionactivity/view/VersionActivityTaskViewContainer.lua

module("modules.logic.versionactivity.view.VersionActivityTaskViewContainer", package.seeall)

local VersionActivityTaskViewContainer = class("VersionActivityTaskViewContainer", BaseViewContainer)

function VersionActivityTaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_right"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = VersionActivityTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1070
	scrollParam.cellHeight = 163
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = -6

	local leftScrollParam = ListScrollParam.New()

	leftScrollParam.scrollGOPath = "#scroll_left"
	leftScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	leftScrollParam.prefabUrl = "#scroll_left/Viewport/Content/#go_item"
	leftScrollParam.cellClass = VersionActivityTaskBonusItem
	leftScrollParam.scrollDir = ScrollEnum.ScrollDirV
	leftScrollParam.lineCount = 1
	leftScrollParam.cellWidth = 610
	leftScrollParam.cellHeight = 165
	leftScrollParam.cellSpaceH = 0
	leftScrollParam.cellSpaceV = 0

	local times = {}

	for i = 1, 8 do
		times[i] = (i - 1) * 0.04
	end

	local scrollView = LuaListScrollViewWithAnimator.New(VersionActivityTaskListModel.instance, scrollParam, times)

	scrollView.dontPlayCloseAnimation = true
	self._taskScrollView = scrollView
	self._taskBonusScrollView = LuaListScrollViewWithAnimator.New(VersionActivityTaskBonusListModel.instance, leftScrollParam, times)

	return {
		scrollView,
		self._taskBonusScrollView,
		VersionActivityTaskView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function VersionActivityTaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function VersionActivityTaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

function VersionActivityTaskViewContainer:setTaskBonusScrollViewIndexOffset(offset)
	self._taskBonusScrollView.indexOffset = offset
end

return VersionActivityTaskViewContainer
