-- chunkname: @modules/logic/rouge/view/RougeActivityTaskViewContainer.lua

module("modules.logic.rouge.view.RougeActivityTaskViewContainer", package.seeall)

local RougeActivityTaskViewContainer = class("RougeActivityTaskViewContainer", BaseViewContainer)

function RougeActivityTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeActivityTaskView.New())
	table.insert(views, RougeActivityMileStoneView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/taskList/ScrollView"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = RougeActivityTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1160
	scrollParam.cellHeight = 165
	scrollParam.cellSpaceH = 20
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	local taskAnimationDelayTimes = {}

	for i = 1, 5 do
		taskAnimationDelayTimes[i] = (i - 1) * 0.03
	end

	self._taskScrollView = LuaListScrollViewWithAnimator.New(RougeActivityTaskListModel.instance, scrollParam, taskAnimationDelayTimes)

	table.insert(views, self._taskScrollView)

	local mileStoneAnimationDelayTimes = {}

	for i = 1, 5 do
		mileStoneAnimationDelayTimes[i] = (i - 1) * 0.03
	end

	local scrollParam2 = ListScrollParam.New()

	scrollParam2.scrollGOPath = "root/bonusNode/#scroll_reward"
	scrollParam2.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam2.prefabUrl = "root/bonusNode/#scroll_reward/Viewport/#go_content/#go_stoneitem"
	scrollParam2.cellClass = RougeActivityMileStoneItem
	scrollParam2.scrollDir = ScrollEnum.ScrollDirH
	scrollParam2.lineCount = 1
	scrollParam2.cellWidth = 210
	scrollParam2.cellHeight = 285
	scrollParam2.cellSpaceH = 30
	scrollParam2.startSpace = -10
	self.mileStoneScrollView = LuaListScrollViewWithAnimator.New(RougeActivityMileStoneListModel.instance, scrollParam2, mileStoneAnimationDelayTimes)

	table.insert(views, self.mileStoneScrollView)

	return views
end

function RougeActivityTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function RougeActivityTaskViewContainer:onContainerInit()
	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self._taskAnimRemoveItem:setMoveInterval(0)
	self._taskAnimRemoveItem:setMoveAnimationTime(0.167)
end

function RougeActivityTaskViewContainer:removeTaskItemByIndex(index, callback, callbackObj)
	if not self._taskAnimRemoveItem then
		return
	end

	self._taskAnimRemoveItem:removeByIndex(index, callback, callbackObj)
end

return RougeActivityTaskViewContainer
