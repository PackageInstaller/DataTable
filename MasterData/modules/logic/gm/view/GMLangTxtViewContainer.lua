-- chunkname: @modules/logic/gm/view/GMLangTxtViewContainer.lua

module("modules.logic.gm.view.GMLangTxtViewContainer", package.seeall)

local GMLangTxtViewContainer = class("GMLangTxtViewContainer", BaseViewContainer)

function GMLangTxtViewContainer:buildViews()
	local views = {}
	local listScrollParam = ListScrollParam.New()

	listScrollParam.scrollGOPath = "view/scroll"
	listScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	listScrollParam.prefabUrl = "view/scroll/item"
	listScrollParam.cellClass = GMLangTxtItem
	listScrollParam.scrollDir = ScrollEnum.ScrollDirV
	listScrollParam.lineCount = 1
	listScrollParam.cellWidth = 800
	listScrollParam.cellHeight = 60
	listScrollParam.cellSpaceH = 0
	listScrollParam.cellSpaceV = 0
	self._langTxtView = GMLangTxtView.New()

	table.insert(views, self._langTxtView)
	table.insert(views, LuaListScrollView.New(GMLangTxtModel.instance, listScrollParam))

	return views
end

function GMLangTxtViewContainer:onLangTxtClick(v)
	self._langTxtView:onLangTxtClick(v)
end

return GMLangTxtViewContainer
