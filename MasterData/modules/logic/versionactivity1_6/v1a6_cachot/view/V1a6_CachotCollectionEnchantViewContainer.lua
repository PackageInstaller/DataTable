-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionEnchantViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionEnchantViewContainer", package.seeall)

local V1a6_CachotCollectionEnchantViewContainer = class("V1a6_CachotCollectionEnchantViewContainer", BaseViewContainer)

function V1a6_CachotCollectionEnchantViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "left/#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "left/#scroll_view/Viewport/Content/#go_collectionbagitem"
	scrollParam.cellClass = V1a6_CachotEnchantBagItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 2
	scrollParam.cellWidth = 238
	scrollParam.cellHeight = 245
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = -8.3
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	local enchantScrollParam = ListScrollParam.New()

	enchantScrollParam.scrollGOPath = "right/#scroll_view"
	enchantScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	enchantScrollParam.prefabUrl = "right/#scroll_view/Viewport/Content/#go_collectionenchantitem"
	enchantScrollParam.cellClass = V1a6_CachotCollectionEnchantItem
	enchantScrollParam.scrollDir = ScrollEnum.ScrollDirV
	enchantScrollParam.lineCount = 1
	enchantScrollParam.cellWidth = 615
	enchantScrollParam.cellHeight = 235
	enchantScrollParam.cellSpaceH = 0
	enchantScrollParam.cellSpaceV = 0.35
	enchantScrollParam.startSpace = 0
	enchantScrollParam.endSpace = 0
	self._collectionScrollView = LuaListScrollView.New(V1a6_CachotEnchantBagListModel.instance, scrollParam)
	self._enchantScrollView = LuaListScrollView.New(V1a6_CachotCollectionEnchantListModel.instance, enchantScrollParam)
	self._collectionScrollView.onUpdateFinish = self.scrollFocusOnSelectCell

	return {
		V1a6_CachotCollectionEnchantView.New(),
		self._collectionScrollView,
		self._enchantScrollView
	}
end

function V1a6_CachotCollectionEnchantViewContainer:scrollFocusOnSelectCell()
	local selectMO = self:getFirstSelect()

	if not selectMO then
		return
	end

	local cellIndex = self._model:getIndex(selectMO)
	local lineCountAheadTarget = math.ceil(cellIndex / self._param.lineCount) - 1
	local singleItemHeightAndSpace = self._param.cellHeight + self._param.cellSpaceV
	local verticalScrollPixel = lineCountAheadTarget * singleItemHeightAndSpace + self._param.startSpace
	local curVerticalScrollPixel = self._csListScroll.VerticalScrollPixel
	local scrollOffset = verticalScrollPixel + singleItemHeightAndSpace - curVerticalScrollPixel
	local scrollHeight = recthelper.getHeight(self._csListScroll.transform)

	if scrollHeight < scrollOffset or scrollOffset < singleItemHeightAndSpace then
		self._csListScroll.VerticalScrollPixel = verticalScrollPixel
	end
end

return V1a6_CachotCollectionEnchantViewContainer
