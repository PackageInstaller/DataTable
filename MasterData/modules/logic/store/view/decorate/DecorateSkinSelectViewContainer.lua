-- chunkname: @modules/logic/store/view/decorate/DecorateSkinSelectViewContainer.lua

module("modules.logic.store.view.decorate.DecorateSkinSelectViewContainer", package.seeall)

local DecorateSkinSelectViewContainer = class("DecorateSkinSelectViewContainer", BaseViewContainer)

function DecorateSkinSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, DecorateSkinSelectView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_result"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_result/Viewport/content/#go_heroitem"
	scrollParam.cellClass = DecorateSkinSelectItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 7
	scrollParam.cellWidth = 214
	scrollParam.cellHeight = 360
	scrollParam.cellSpaceH = 50
	scrollParam.cellSpaceV = 44
	scrollParam.startSpace = 30
	scrollParam.endSpace = 30
	self._scrollView = LuaListScrollView.New(DecorateSkinSelectListModel.instance, scrollParam)

	table.insert(views, self._scrollView)

	return views
end

return DecorateSkinSelectViewContainer
