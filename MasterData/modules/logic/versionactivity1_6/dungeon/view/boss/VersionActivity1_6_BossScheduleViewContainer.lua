-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/boss/VersionActivity1_6_BossScheduleViewContainer.lua

module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossScheduleViewContainer", package.seeall)

local VersionActivity1_6_BossScheduleViewContainer = class("VersionActivity1_6_BossScheduleViewContainer", BaseViewContainer)

function VersionActivity1_6_BossScheduleViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.cellClass = VersionActivity1_6_BossScheduleItem
	scrollParam.scrollGOPath = "Root/#scroll_Reward"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 700
	scrollParam.cellSpaceH = 100
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 300
	self._listScrollParam = scrollParam
	self._scheduleView = VersionActivity1_6_BossScheduleView.New()

	return {
		self._scheduleView
	}
end

function VersionActivity1_6_BossScheduleViewContainer:getListScrollParam()
	return self._listScrollParam
end

return VersionActivity1_6_BossScheduleViewContainer
