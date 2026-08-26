-- chunkname: @modules/logic/activitywelfare/subview/ActivityNoviceSignViewContainer.lua

module("modules.logic.activitywelfare.subview.ActivityNoviceSignViewContainer", package.seeall)

local ActivityNoviceSignViewContainer = class("ActivityNoviceSignViewContainer", BaseViewContainer)

function ActivityNoviceSignViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_daylist/#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = ActivityNoviceSignItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 190
	scrollParam.cellHeight = 520
	scrollParam.cellSpaceH = 3.16
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 5

	table.insert(views, LuaListScrollView.New(ActivityNoviceSignItemListModel.instance, scrollParam))
	table.insert(views, ActivityNoviceSignView.New())

	return views
end

return ActivityNoviceSignViewContainer
