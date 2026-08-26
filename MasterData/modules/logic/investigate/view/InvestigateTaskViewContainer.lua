-- chunkname: @modules/logic/investigate/view/InvestigateTaskViewContainer.lua

module("modules.logic.investigate.view.InvestigateTaskViewContainer", package.seeall)

local InvestigateTaskViewContainer = class("InvestigateTaskViewContainer", BaseViewContainer)

function InvestigateTaskViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = InvestigateTaskItem
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

	self._taskScrollView = LuaListScrollViewWithAnimator.New(InvestigateTaskListModel.instance, scrollParam, times)

	return {
		self._taskScrollView,
		InvestigateTaskView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function InvestigateTaskViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

function InvestigateTaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return InvestigateTaskViewContainer
