-- chunkname: @modules/logic/gm/view/GMHelpViewBrowseViewContainer.lua

module("modules.logic.gm.view.GMHelpViewBrowseViewContainer", package.seeall)

local GMHelpViewBrowseViewContainer = class("GMHelpViewBrowseViewContainer", BaseViewContainer)

function GMHelpViewBrowseViewContainer:buildViews()
	local views = {}
	local listScrollParam = ListScrollParam.New()

	listScrollParam.scrollGOPath = "view/scroll"
	listScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	listScrollParam.prefabUrl = "view/scroll/item"
	listScrollParam.cellClass = GMHelpViewBrowseItem
	listScrollParam.scrollDir = ScrollEnum.ScrollDirV
	listScrollParam.lineCount = 1
	listScrollParam.cellWidth = 800
	listScrollParam.cellHeight = 60
	listScrollParam.cellSpaceH = 0
	listScrollParam.cellSpaceV = 0

	table.insert(views, GMHelpViewBrowseView.New())
	table.insert(views, LuaListScrollView.New(GMHelpViewBrowseModel.instance, listScrollParam))

	return views
end

return GMHelpViewBrowseViewContainer
