-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2LayerRewardViewContainer.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2LayerRewardViewContainer", package.seeall)

local WeekWalk_2LayerRewardViewContainer = class("WeekWalk_2LayerRewardViewContainer", BaseViewContainer)

function WeekWalk_2LayerRewardViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_reward"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = WeekWalk_2LayerRewardItem
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

	table.insert(views, WeekWalk_2LayerRewardView.New())
	table.insert(views, WeekWalk_2LayerRewardViewMenuView.New())
	table.insert(views, LuaListScrollViewWithAnimator.New(WeekWalk_2TaskListModel.instance, scrollParam, animationDelayTimes))

	return views
end

return WeekWalk_2LayerRewardViewContainer
