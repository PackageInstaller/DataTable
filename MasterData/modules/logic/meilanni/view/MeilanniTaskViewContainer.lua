-- chunkname: @modules/logic/meilanni/view/MeilanniTaskViewContainer.lua

module("modules.logic.meilanni.view.MeilanniTaskViewContainer", package.seeall)

local MeilanniTaskViewContainer = class("MeilanniTaskViewContainer", BaseViewContainer)

function MeilanniTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_reward"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = MeilanniTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1300
	scrollParam.cellHeight = 160
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 6.19
	scrollParam.startSpace = 0

	local times = {}

	for i = 1, 6 do
		times[i] = (i - 1) * 0.07
	end

	local scrollView = LuaListScrollViewWithAnimator.New(MeilanniTaskListModel.instance, scrollParam, times)

	scrollView.dontPlayCloseAnimation = true
	self._taskScrollView = scrollView

	table.insert(views, self._taskScrollView)
	table.insert(views, MeilanniTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function MeilanniTaskViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, nil, nil, nil, nil, self)

	return {
		self._navigateButtonView
	}
end

function MeilanniTaskViewContainer:onContainerInit()
	self.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self._taskScrollView)

	self.taskAnimRemoveItem:setMoveInterval(0)
end

return MeilanniTaskViewContainer
