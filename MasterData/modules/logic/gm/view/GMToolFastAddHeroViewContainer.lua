-- chunkname: @modules/logic/gm/view/GMToolFastAddHeroViewContainer.lua

module("modules.logic.gm.view.GMToolFastAddHeroViewContainer", package.seeall)

local GMToolFastAddHeroViewContainer = class("GMToolFastAddHeroViewContainer", BaseViewContainer)

function GMToolFastAddHeroViewContainer:buildViews()
	local gmAddItemListParam = ListScrollParam.New()

	gmAddItemListParam.scrollGOPath = "container/#go_addItem/scroll"
	gmAddItemListParam.prefabType = ScrollEnum.ScrollPrefabFromView
	gmAddItemListParam.prefabUrl = "container/#go_addItem/scroll/#go_item"
	gmAddItemListParam.cellClass = GMFastAddHeroAddItem
	gmAddItemListParam.scrollDir = ScrollEnum.ScrollDirV
	gmAddItemListParam.lineCount = 1
	gmAddItemListParam.cellWidth = 794
	gmAddItemListParam.cellHeight = 100
	gmAddItemListParam.cellSpaceH = 0
	gmAddItemListParam.cellSpaceV = 0

	local hadHeroItemListParam = ListScrollParam.New()

	hadHeroItemListParam.scrollGOPath = "container/#go_herolistcontainer/scroll"
	hadHeroItemListParam.prefabType = ScrollEnum.ScrollPrefabFromView
	hadHeroItemListParam.prefabUrl = "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem"
	hadHeroItemListParam.cellClass = GMFastAddHeroHadHeroItem
	hadHeroItemListParam.scrollDir = ScrollEnum.ScrollDirV
	hadHeroItemListParam.lineCount = 1
	hadHeroItemListParam.cellWidth = 1500
	hadHeroItemListParam.cellHeight = 80
	hadHeroItemListParam.cellSpaceH = 0
	hadHeroItemListParam.cellSpaceV = 10

	return {
		LuaListScrollView.New(GMAddItemModel.instance, gmAddItemListParam),
		LuaListScrollView.New(GMFastAddHeroHadHeroItemModel.instance, hadHeroItemListParam),
		GMToolFastAddHeroView.New()
	}
end

function GMToolFastAddHeroViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

return GMToolFastAddHeroViewContainer
