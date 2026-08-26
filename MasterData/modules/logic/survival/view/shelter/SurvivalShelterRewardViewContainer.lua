-- chunkname: @modules/logic/survival/view/shelter/SurvivalShelterRewardViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalShelterRewardViewContainer", package.seeall)

local SurvivalShelterRewardViewContainer = class("SurvivalShelterRewardViewContainer", BaseViewContainer)

function SurvivalShelterRewardViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Left/progress/#scroll_view"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam1.cellClass = SurvivalShelterRewardItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 268
	scrollParam1.cellHeight = 700
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 2
	self.scrollView = LuaListScrollViewWithAnimator.New(SurvivalShelterRewardListModel.instance, scrollParam1)

	table.insert(views, self.scrollView)
	table.insert(views, SurvivalShelterRewardView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function SurvivalShelterRewardViewContainer:getScrollView()
	return self.scrollView
end

function SurvivalShelterRewardViewContainer:buildTabViews(tabContainerId)
	local view = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		view
	}
end

return SurvivalShelterRewardViewContainer
