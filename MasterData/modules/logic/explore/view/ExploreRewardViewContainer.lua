-- chunkname: @modules/logic/explore/view/ExploreRewardViewContainer.lua

module("modules.logic.explore.view.ExploreRewardViewContainer", package.seeall)

local ExploreRewardViewContainer = class("ExploreRewardViewContainer", BaseViewContainer)

function ExploreRewardViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "mask/#scroll_view1"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#go_rewarditem"
	scrollParam.cellClass = ExploreBonusItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 700
	scrollParam.cellHeight = 154
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 25
	scrollParam.frameUpdateMs = 100

	local scrollParam2 = ListScrollParam.New()

	scrollParam2.scrollGOPath = "mask/#scroll_view2"
	scrollParam2.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam2.prefabUrl = "#go_rewarditem"
	scrollParam2.cellClass = ExploreBonusItem
	scrollParam2.scrollDir = ScrollEnum.ScrollDirV
	scrollParam2.lineCount = 1
	scrollParam2.cellWidth = 700
	scrollParam2.cellHeight = 154
	scrollParam2.cellSpaceH = 0
	scrollParam2.cellSpaceV = 0
	scrollParam2.startSpace = 25
	scrollParam2.frameUpdateMs = 100

	local animationDelayTimes = {}

	for i = 1, 10 do
		animationDelayTimes[i] = (i - 1) * 0.06
	end

	return {
		ExploreRewardView.New(),
		LuaListScrollViewWithAnimator.New(ExploreTaskModel.instance:getTaskList(1), scrollParam, animationDelayTimes),
		LuaListScrollViewWithAnimator.New(ExploreTaskModel.instance:getTaskList(2), scrollParam2, animationDelayTimes),
		TabViewGroup.New(1, "#go_btns")
	}
end

function ExploreRewardViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return ExploreRewardViewContainer
