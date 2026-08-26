-- chunkname: @modules/logic/versionactivity3_6/yami/view/task/V3a6YaMiTaskViewContainer.lua

module("modules.logic.versionactivity3_6.yami.view.task.V3a6YaMiTaskViewContainer", package.seeall)

local V3a6YaMiTaskViewContainer = class("V3a6YaMiTaskViewContainer", BaseViewContainer)

function V3a6YaMiTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = V3a6YaMiTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1300
	scrollParam.cellHeight = 160
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	local times = {}

	for i = 1, 6 do
		times[i] = (i - 1) * 0.06
	end

	self._scrollview = LuaListScrollViewWithAnimator.New(V3a6YaMiTaskListModel.instance, scrollParam, times)

	table.insert(views, self._scrollview)
	table.insert(views, V3a6YaMiTaskView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "root/#go_fundingitem"))

	return views
end

function V3a6YaMiTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		self.currencyView = V3a6YaMiCurrencyView.New()

		return {
			self.currencyView
		}
	end
end

function V3a6YaMiTaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._scrollview)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return V3a6YaMiTaskViewContainer
