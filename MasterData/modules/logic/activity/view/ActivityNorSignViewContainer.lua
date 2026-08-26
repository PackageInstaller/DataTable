-- chunkname: @modules/logic/activity/view/ActivityNorSignViewContainer.lua

module("modules.logic.activity.view.ActivityNorSignViewContainer", package.seeall)

local ActivityNorSignViewContainer = class("ActivityNorSignViewContainer", BaseViewContainer)

function ActivityNorSignViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_daylist/#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = ActivityNorSignItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 7
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 590
	scrollParam.cellSpaceH = 4.1
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(ActivityNorSignItemListModel.instance, scrollParam))
	table.insert(views, ActivityNorSignView.New())

	return views
end

return ActivityNorSignViewContainer
