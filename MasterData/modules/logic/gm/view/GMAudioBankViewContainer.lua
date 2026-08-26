-- chunkname: @modules/logic/gm/view/GMAudioBankViewContainer.lua

module("modules.logic.gm.view.GMAudioBankViewContainer", package.seeall)

local GMAudioBankViewContainer = class("GMAudioBankViewContainer", BaseViewContainer)

function GMAudioBankViewContainer:buildViews()
	local views = {}
	local listScrollParam = ListScrollParam.New()

	listScrollParam.scrollGOPath = "view/scroll"
	listScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	listScrollParam.prefabUrl = "view/scroll/item"
	listScrollParam.cellClass = GMAudioBankViewItem
	listScrollParam.scrollDir = ScrollEnum.ScrollDirV
	listScrollParam.lineCount = 1
	listScrollParam.cellWidth = 962.5
	listScrollParam.cellHeight = 85
	listScrollParam.cellSpaceH = 0
	listScrollParam.cellSpaceV = 0

	table.insert(views, GMAudioBankView.New())
	table.insert(views, LuaListScrollView.New(GMAudioBankViewModel.instance, listScrollParam))

	return views
end

return GMAudioBankViewContainer
