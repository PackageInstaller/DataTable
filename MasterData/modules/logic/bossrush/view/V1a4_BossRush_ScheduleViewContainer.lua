-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_ScheduleViewContainer.lua

module("modules.logic.bossrush.view.V1a4_BossRush_ScheduleViewContainer", package.seeall)

local V1a4_BossRush_ScheduleViewContainer = class("V1a4_BossRush_ScheduleViewContainer", BaseViewContainer)

function V1a4_BossRush_ScheduleViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.cellClass = V1a4_BossRush_ScheduleItem
	scrollParam.scrollGOPath = "Root/#scroll_Reward"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 700
	scrollParam.cellSpaceH = 150
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 150
	self._listScrollParam = scrollParam
	self._scheduleView = V1a4_BossRush_ScheduleView.New()

	return {
		self._scheduleView
	}
end

function V1a4_BossRush_ScheduleViewContainer:getListScrollParam()
	return self._listScrollParam
end

return V1a4_BossRush_ScheduleViewContainer
