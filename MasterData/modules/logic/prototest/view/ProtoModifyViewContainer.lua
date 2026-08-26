-- chunkname: @modules/logic/prototest/view/ProtoModifyViewContainer.lua

module("modules.logic.prototest.view.ProtoModifyViewContainer", package.seeall)

local ProtoModifyViewContainer = class("ProtoModifyViewContainer", BaseViewContainer)

function ProtoModifyViewContainer:buildViews()
	local views = {}
	local listParam = ListScrollParam.New()

	listParam.scrollGOPath = "paramlistpanel/paramscroll"
	listParam.prefabType = ScrollEnum.ScrollPrefabFromView
	listParam.prefabUrl = "paramlistpanel/paramscroll/Viewport/item"
	listParam.cellClass = ProtoModifyListItem
	listParam.scrollDir = ScrollEnum.ScrollDirV
	listParam.lineCount = 1
	listParam.cellWidth = 667
	listParam.cellHeight = 75
	listParam.cellSpaceH = 0
	listParam.cellSpaceV = 0

	table.insert(views, LuaListScrollView.New(ProtoModifyModel.instance, listParam))
	table.insert(views, ProtoModifyView.New())

	return views
end

return ProtoModifyViewContainer
