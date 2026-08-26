-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionUnlockedViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionUnlockedViewContainer", package.seeall)

local V1a6_CachotCollectionUnlockedViewContainer = class("V1a6_CachotCollectionUnlockedViewContainer", BaseViewContainer)

function V1a6_CachotCollectionUnlockedViewContainer:buildViews()
	self._scrollParam = ListScrollParam.New()
	self._scrollParam.scrollGOPath = "#go_info/#scroll_view"
	self._scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	self._scrollParam.prefabUrl = "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem"
	self._scrollParam.cellClass = V1a6_CachotCollectionUnLockItem
	self._scrollParam.scrollDir = ScrollEnum.ScrollDirV
	self._scrollParam.lineCount = 5
	self._scrollParam.cellWidth = 280
	self._scrollParam.cellHeight = 260
	self._scrollParam.cellSpaceH = 0
	self._scrollParam.cellSpaceV = 0
	self._scrollParam.startSpace = 50
	self._scrollParam.endSpace = 0

	return {
		V1a6_CachotCollectionUnlockedView.New(),
		LuaListScrollView.New(V1a6_CachotCollectionUnLockListModel.instance, self._scrollParam)
	}
end

function V1a6_CachotCollectionUnlockedViewContainer:getListScrollParam()
	return self._scrollParam
end

return V1a6_CachotCollectionUnlockedViewContainer
