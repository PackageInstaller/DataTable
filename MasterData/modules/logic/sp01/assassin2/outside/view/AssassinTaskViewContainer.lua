-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinTaskViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinTaskViewContainer", package.seeall)

local AssassinTaskViewContainer = class("AssassinTaskViewContainer", BaseViewContainer)

function AssassinTaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = AssassinTaskListItem
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

	self._taskScrollView = LuaListScrollViewWithAnimator.New(AssassinTaskListModel.instance, scrollParam, times)

	return {
		self._taskScrollView,
		AssassinTaskView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function AssassinTaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function AssassinTaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return AssassinTaskViewContainer
