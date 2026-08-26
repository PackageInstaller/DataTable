-- chunkname: @modules/logic/sp01/act204/view/Activity204TaskViewContainer.lua

module("modules.logic.sp01.act204.view.Activity204TaskViewContainer", package.seeall)

local Activity204TaskViewContainer = class("Activity204TaskViewContainer", BaseViewContainer)

function Activity204TaskViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity204TaskView.New())
	table.insert(views, Activity204MileStoneView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/taskList/ScrollView"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam.cellClass = Activity204TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 400
	scrollParam.cellHeight = 600
	scrollParam.cellSpaceH = 20
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 15
	scrollParam.endSpace = 50

	table.insert(views, LuaListScrollView.New(Activity204TaskListModel.instance, scrollParam))

	local scrollParam2 = ListScrollParam.New()

	scrollParam2.scrollGOPath = "root/bonusNode/#scroll_reward"
	scrollParam2.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam2.prefabUrl = "root/bonusNode/#scroll_reward/Viewport/#go_content/rewarditem"
	scrollParam2.cellClass = Activity204MileStoneItem
	scrollParam2.scrollDir = ScrollEnum.ScrollDirH
	scrollParam2.lineCount = 1
	scrollParam2.cellWidth = 487
	scrollParam2.cellHeight = 285
	scrollParam2.cellSpaceH = -57
	scrollParam2.startSpace = 0
	self.mileStoneScrollView = LuaMixScrollView.New(Activity204MileStoneListModel.instance, scrollParam2)

	table.insert(views, self.mileStoneScrollView)

	return views
end

function Activity204TaskViewContainer:buildTabViews(tabContainerId)
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

return Activity204TaskViewContainer
