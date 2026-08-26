-- chunkname: @modules/logic/gm/view/GMErrorViewContainer.lua

module("modules.logic.gm.view.GMErrorViewContainer", package.seeall)

local GMErrorViewContainer = class("GMErrorViewContainer", BaseViewContainer)

function GMErrorViewContainer:buildViews()
	local views = {}
	local listScrollParam = ListScrollParam.New()

	listScrollParam.scrollGOPath = "panel/list/list"
	listScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	listScrollParam.prefabUrl = "panel/list/list/Viewport/item"
	listScrollParam.cellClass = GMErrorItem
	listScrollParam.scrollDir = ScrollEnum.ScrollDirV
	listScrollParam.lineCount = 1
	listScrollParam.cellWidth = 900
	listScrollParam.cellHeight = 100
	listScrollParam.cellSpaceH = 2
	listScrollParam.cellSpaceV = 0

	table.insert(views, GMErrorView.New())
	table.insert(views, LuaListScrollView.New(GMLogModel.instance.errorModel, listScrollParam))

	return views
end

return GMErrorViewContainer
