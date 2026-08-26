-- chunkname: @modules/logic/gm/view/GMGuideStatusViewContainer.lua

module("modules.logic.gm.view.GMGuideStatusViewContainer", package.seeall)

local GMGuideStatusViewContainer = class("GMGuideStatusViewContainer", BaseViewContainer)

function GMGuideStatusViewContainer:buildViews()
	local views = {}
	local listScrollParam = ListScrollParam.New()

	listScrollParam.scrollGOPath = "view/scroll"
	listScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	listScrollParam.prefabUrl = "view/scroll/item"
	listScrollParam.cellClass = GMGuideStatusItem
	listScrollParam.scrollDir = ScrollEnum.ScrollDirV
	listScrollParam.lineCount = 1
	listScrollParam.cellWidth = 800
	listScrollParam.cellHeight = 60
	listScrollParam.cellSpaceH = 0
	listScrollParam.cellSpaceV = 0

	table.insert(views, GMGuideStatusView.New())
	table.insert(views, LuaListScrollView.New(GMGuideStatusModel.instance, listScrollParam))

	return views
end

return GMGuideStatusViewContainer
