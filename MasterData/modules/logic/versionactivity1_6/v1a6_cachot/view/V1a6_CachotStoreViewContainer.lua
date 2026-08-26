-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotStoreViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotStoreViewContainer", package.seeall)

local V1a6_CachotStoreViewContainer = class("V1a6_CachotStoreViewContainer", BaseViewContainer)

function V1a6_CachotStoreViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_store"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_store/Viewport/#go_storeItem/#go_storegoodsitem"
	scrollParam.cellClass = V1a6_CachotStoreItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 356
	scrollParam.cellHeight = 376
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 30
	scrollParam.frameUpdateMs = 100

	return {
		V1a6_CachotStoreView.New(),
		LuaListScrollView.New(V1a6_CachotStoreListModel.instance, scrollParam),
		V1a6_CachotCurrencyView.New("top")
	}
end

return V1a6_CachotStoreViewContainer
