-- chunkname: @modules/logic/versionactivity1_3/armpipe/view/ArmRewardViewContainer.lua

module("modules.logic.versionactivity1_3.armpipe.view.ArmRewardViewContainer", package.seeall)

local ArmRewardViewContainer = class("ArmRewardViewContainer", BaseViewContainer)

function ArmRewardViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Root/#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = ArmRewardViewTaskItem.prefabPath
	scrollParam.cellClass = ArmRewardViewTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 824
	scrollParam.cellHeight = 158
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	local animationDelayTimes = {}

	for i = 1, 10 do
		animationDelayTimes[i] = (i - 1) * 0.06 + 0.3
	end

	table.insert(views, LuaListScrollViewWithAnimator.New(Activity124RewardListModel.instance, scrollParam, animationDelayTimes))
	table.insert(views, ArmRewardView.New())

	return views
end

function ArmRewardViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return ArmRewardViewContainer
