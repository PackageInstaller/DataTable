-- chunkname: @modules/logic/versionactivity1_3/astrology/view/VersionActivity1_3AstrologyPropViewContainer.lua

module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyPropViewContainer", package.seeall)

local VersionActivity1_3AstrologyPropViewContainer = class("VersionActivity1_3AstrologyPropViewContainer", BaseViewContainer)

function VersionActivity1_3AstrologyPropViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = CommonPropListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 270
	scrollParam.cellHeight = 250
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 50
	scrollParam.startSpace = 35
	scrollParam.endSpace = 56

	table.insert(views, LuaListScrollView.New(CommonPropListModel.instance, scrollParam))
	table.insert(views, VersionActivity1_3AstrologyPropView.New())

	return views
end

return VersionActivity1_3AstrologyPropViewContainer
