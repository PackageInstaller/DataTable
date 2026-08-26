-- chunkname: @modules/logic/reactivity/view/ReactivityTaskViewContainer.lua

module("modules.logic.reactivity.view.ReactivityTaskViewContainer", package.seeall)

local ReactivityTaskViewContainer = class("ReactivityTaskViewContainer", BaseViewContainer)

function ReactivityTaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = ReactivityTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1136
	scrollParam.cellHeight = 152
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 16

	local times = {}

	for i = 1, 8 do
		times[i] = (i - 1) * 0.04
	end

	local scrollView = LuaListScrollViewWithAnimator.New(ReactivityTaskModel.instance, scrollParam, times)

	scrollView.dontPlayCloseAnimation = true
	self._taskScrollView = scrollView

	return {
		scrollView,
		ReactivityTaskView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function ReactivityTaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function ReactivityTaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return ReactivityTaskViewContainer
