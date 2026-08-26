-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityTaskViewContainer.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityTaskViewContainer", package.seeall)

local AtomicOperationActivityTaskViewContainer = class("AtomicOperationActivityTaskViewContainer", BaseViewContainer)

function AtomicOperationActivityTaskViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicOperationActivityTaskView.New())
	table.insert(views, AtomicOperationActivityMileStoneView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/taskList/ScrollView"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = AtomicOperationActivityTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 472
	scrollParam.cellHeight = 740
	scrollParam.cellSpaceH = 20
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	local taskAnimationDelayTimes = {}

	for i = 1, 6 do
		taskAnimationDelayTimes[i] = (i - 1) * 0.03
	end

	table.insert(views, LuaListScrollViewWithAnimator.New(AtomicOperationActivityTaskListModel.instance, scrollParam, taskAnimationDelayTimes))

	local mileStoneAnimationDelayTimes = {}

	for i = 1, 7 do
		mileStoneAnimationDelayTimes[i] = (i - 1) * 0.03
	end

	local scrollParam2 = ListScrollParam.New()

	scrollParam2.scrollGOPath = "root/bonusNode/#scroll_reward"
	scrollParam2.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam2.prefabUrl = "root/bonusNode/#scroll_reward/Viewport/#go_content/rewarditem"
	scrollParam2.cellClass = AtomicOperationActivityMileStoneItem
	scrollParam2.scrollDir = ScrollEnum.ScrollDirH
	scrollParam2.lineCount = 1
	scrollParam2.cellWidth = 210
	scrollParam2.cellHeight = 285
	scrollParam2.cellSpaceH = 136
	scrollParam2.startSpace = 180
	self.mileStoneScrollView = LuaListScrollViewWithAnimator.New(AtomicOperationActivityMileStoneListModel.instance, scrollParam2, mileStoneAnimationDelayTimes)

	table.insert(views, self.mileStoneScrollView)

	return views
end

function AtomicOperationActivityTaskViewContainer:buildTabViews(tabContainerId)
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

return AtomicOperationActivityTaskViewContainer
