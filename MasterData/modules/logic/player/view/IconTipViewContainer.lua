-- chunkname: @modules/logic/player/view/IconTipViewContainer.lua

module("modules.logic.player.view.IconTipViewContainer", package.seeall)

local IconTipViewContainer = class("IconTipViewContainer", BaseViewContainer)

function IconTipViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "window/left/scrollview"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = IconListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 6
	scrollParam.cellWidth = 160
	scrollParam.cellHeight = 160
	scrollParam.cellSpaceH = 5
	scrollParam.cellSpaceV = 5
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(IconListModel.instance, scrollParam))
	table.insert(views, IconTipView.New())

	return views
end

return IconTipViewContainer
