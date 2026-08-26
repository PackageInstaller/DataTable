-- chunkname: @modules/logic/activity/view/SummerSignPart1ViewContainer_1_2.lua

module("modules.logic.activity.view.SummerSignPart1ViewContainer_1_2", package.seeall)

local SummerSignPart1ViewContainer_1_2 = class("SummerSignPart1ViewContainer_1_2", BaseViewContainer)

function SummerSignPart1ViewContainer_1_2:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_daylist/#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = ActivityNorSignItem_1_2
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 7
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 590
	scrollParam.cellSpaceH = 4.1
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(ActivityNorSignItemListModel_1_2.instance, scrollParam))
	table.insert(views, SummerSignPart1View_1_2.New())

	return views
end

return SummerSignPart1ViewContainer_1_2
