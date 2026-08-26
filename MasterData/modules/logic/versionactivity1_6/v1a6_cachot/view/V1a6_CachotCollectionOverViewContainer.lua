-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionOverViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionOverViewContainer", package.seeall)

local V1a6_CachotCollectionOverViewContainer = class("V1a6_CachotCollectionOverViewContainer", BaseViewContainer)

function V1a6_CachotCollectionOverViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_view/Viewport/Content/#go_unlockeditem"
	scrollParam.cellClass = V1a6_CachotCollectionOverItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 600
	scrollParam.cellHeight = 248
	scrollParam.cellSpaceH = 9
	scrollParam.cellSpaceV = 7
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0
	self._scrollView = LuaListScrollView.New(V1a6_CachotCollectionOverListModel.instance, scrollParam)

	return {
		V1a6_CachotCollectionOverView.New(),
		self._scrollView
	}
end

function V1a6_CachotCollectionOverViewContainer:getScrollView()
	return self._scrollView
end

return V1a6_CachotCollectionOverViewContainer
