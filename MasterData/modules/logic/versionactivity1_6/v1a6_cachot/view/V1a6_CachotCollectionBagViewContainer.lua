-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionBagViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionBagViewContainer", package.seeall)

local V1a6_CachotCollectionBagViewContainer = class("V1a6_CachotCollectionBagViewContainer", BaseViewContainer)

function V1a6_CachotCollectionBagViewContainer:buildViews()
	local scrollParam = self:getScrollParam()

	self._scrollView = LuaListScrollView.New(V1a6_CachotCollectionBagListModel.instance, scrollParam)

	return {
		V1a6_CachotCollectionBagView.New(),
		self._scrollView
	}
end

function V1a6_CachotCollectionBagViewContainer:getScrollView()
	return self._scrollView
end

function V1a6_CachotCollectionBagViewContainer:getScrollParam()
	if not self._scrollParam then
		self._scrollParam = ListScrollParam.New()
		self._scrollParam.scrollGOPath = "left/#scroll_view"
		self._scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		self._scrollParam.prefabUrl = self._viewSetting.otherRes[1]
		self._scrollParam.cellClass = V1a6_CachotCollectionBagItem
		self._scrollParam.scrollDir = ScrollEnum.ScrollDirV
		self._scrollParam.lineCount = 4
		self._scrollParam.cellWidth = 248
		self._scrollParam.cellHeight = 256
		self._scrollParam.cellSpaceH = 0
		self._scrollParam.cellSpaceV = 0
		self._scrollParam.startSpace = 0
		self._scrollParam.endSpace = 0
	end

	return self._scrollParam
end

return V1a6_CachotCollectionBagViewContainer
