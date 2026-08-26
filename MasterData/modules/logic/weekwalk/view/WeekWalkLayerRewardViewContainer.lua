-- chunkname: @modules/logic/weekwalk/view/WeekWalkLayerRewardViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkLayerRewardViewContainer", package.seeall)

local WeekWalkLayerRewardViewContainer = class("WeekWalkLayerRewardViewContainer", BaseViewContainer)

function WeekWalkLayerRewardViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_reward"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = WeekWalkLayerRewardItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1500
	scrollParam.cellHeight = 160
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 1
	scrollParam.startSpace = 0

	local animationDelayTimes = {}

	for i = 1, 10 do
		animationDelayTimes[i] = (i - 1) * 0.07
	end

	table.insert(views, WeekWalkLayerRewardView.New())
	table.insert(views, WeekWalkLayerRewardMenuView.New())
	table.insert(views, LuaListScrollViewWithAnimator.New(WeekWalkTaskListModel.instance, scrollParam, animationDelayTimes))

	return views
end

return WeekWalkLayerRewardViewContainer
