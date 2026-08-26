-- chunkname: @modules/logic/sp02/atomic/view/AtomicRewardViewContainer.lua

module("modules.logic.sp02.atomic.view.AtomicRewardViewContainer", package.seeall)

local AtomicRewardViewContainer = class("AtomicRewardViewContainer", BaseViewContainer)

function AtomicRewardViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "progress/#scroll_view"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam1.cellClass = AtomicRewardItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 268
	scrollParam1.cellHeight = 700
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 2
	self.scrollView = LuaListScrollViewWithAnimator.New(MileStoneListModel.instance, scrollParam1)

	table.insert(views, self.scrollView)
	table.insert(views, AtomicRewardView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AtomicRewardViewContainer:getScrollView()
	return self.scrollView
end

function AtomicRewardViewContainer:buildTabViews(tabContainerId)
	local view = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		view
	}
end

return AtomicRewardViewContainer
