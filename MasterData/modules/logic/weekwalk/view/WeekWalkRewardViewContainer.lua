-- chunkname: @modules/logic/weekwalk/view/WeekWalkRewardViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkRewardViewContainer", package.seeall)

local WeekWalkRewardViewContainer = class("WeekWalkRewardViewContainer", BaseViewContainer)

function WeekWalkRewardViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "right/#scroll_reward"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = WeekWalkRewardItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1500
	scrollParam.cellHeight = 160
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	WeekWalkTaskListModel.instance.openRewardTime = Time.time

	table.insert(views, LuaListScrollView.New(WeekWalkTaskListModel.instance, scrollParam))
	table.insert(views, WeekWalkRewardView.New())

	return views
end

return WeekWalkRewardViewContainer
