-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186TaskViewContainer.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186TaskViewContainer", package.seeall)

local Activity186TaskViewContainer = class("Activity186TaskViewContainer", BaseViewContainer)

function Activity186TaskViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity186TaskView.New())
	table.insert(views, Activity186MileStoneView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/taskList/ScrollView"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam.cellClass = Activity186TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 364
	scrollParam.cellHeight = 450
	scrollParam.cellSpaceH = 20
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	table.insert(views, LuaListScrollView.New(Activity186TaskListModel.instance, scrollParam))

	local scrollParam2 = ListScrollParam.New()

	scrollParam2.scrollGOPath = "root/bonusNode/#scroll_reward"
	scrollParam2.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam2.prefabUrl = "root/bonusNode/#scroll_reward/Viewport/#go_content/rewarditem"
	scrollParam2.cellClass = Activity186MileStoneItem
	scrollParam2.scrollDir = ScrollEnum.ScrollDirH
	scrollParam2.lineCount = 1
	scrollParam2.cellWidth = 210
	scrollParam2.cellHeight = 285
	scrollParam2.cellSpaceH = 30
	scrollParam2.startSpace = -10
	self.mileStoneScrollView = LuaListScrollViewWithAnimator.New(Activity186MileStoneListModel.instance, scrollParam2)

	table.insert(views, self.mileStoneScrollView)

	return views
end

function Activity186TaskViewContainer:buildTabViews(tabContainerId)
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

return Activity186TaskViewContainer
