-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryRewardViewContainer.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryRewardViewContainer", package.seeall)

local RoleStoryRewardViewContainer = class("RoleStoryRewardViewContainer", BaseViewContainer)

function RoleStoryRewardViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Left/progress/#scroll_view"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam1.cellClass = RoleStoryRewardItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 268
	scrollParam1.cellHeight = 600
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 2
	self.scrollView = LuaListScrollViewWithAnimator.New(RoleStoryRewardListModel.instance, scrollParam1)

	table.insert(views, self.scrollView)
	table.insert(views, RoleStoryRewardView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function RoleStoryRewardViewContainer:getScrollView()
	return self.scrollView
end

function RoleStoryRewardViewContainer:buildTabViews(tabContainerId)
	local view = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		view
	}
end

return RoleStoryRewardViewContainer
