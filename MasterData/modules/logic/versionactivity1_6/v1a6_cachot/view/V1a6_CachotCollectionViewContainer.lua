-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionViewContainer", package.seeall)

local V1a6_CachotCollectionViewContainer = class("V1a6_CachotCollectionViewContainer", BaseViewContainer)

function V1a6_CachotCollectionViewContainer:buildViews()
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "left/#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "left/#scroll_view/Viewport/Content/#go_collectionitem"
	scrollParam.cellClass = V1a6_CachotCollectionLineItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	return {
		V1a6_CachotCollectionView.New(),
		LuaMixScrollView.New(V1a6_CachotCollectionListModel.instance, scrollParam)
	}
end

return V1a6_CachotCollectionViewContainer
