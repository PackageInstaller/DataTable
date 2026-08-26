-- chunkname: @modules/logic/weekwalk/view/WeekWalkTarotViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkTarotViewContainer", package.seeall)

local WeekWalkTarotViewContainer = class("WeekWalkTarotViewContainer", BaseViewContainer)

function WeekWalkTarotViewContainer:buildViews()
	local views = {}

	table.insert(views, WeekWalkTarotView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_tarot"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = WeekWalkTarotItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 340
	scrollParam.cellHeight = 650
	scrollParam.cellSpaceH = 110.3
	scrollParam.cellSpaceV = 40
	scrollParam.startSpace = 10.6
	scrollParam.endSpace = 20

	local scrollView = LuaListScrollView.New(WeekWalkTarotListModel.instance, scrollParam)

	table.insert(views, scrollView)

	return views
end

return WeekWalkTarotViewContainer
