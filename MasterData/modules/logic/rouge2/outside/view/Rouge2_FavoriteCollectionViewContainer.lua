-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_FavoriteCollectionViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_FavoriteCollectionViewContainer", package.seeall)

local Rouge2_FavoriteCollectionViewContainer = class("Rouge2_FavoriteCollectionViewContainer", BaseViewContainer)

function Rouge2_FavoriteCollectionViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_FavoriteCollectionView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(views, TabViewGroup.New(2, "#go_content"))
	table.insert(views, TabViewGroup.New(3, "#go_rougemapdetailcontainer"))

	return views
end

function Rouge2_FavoriteCollectionViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end

	if tabContainerId == 2 then
		local scrollParam2 = MixScrollParam.New()

		scrollParam2.scrollGOPath = "Left/#scroll_collection"
		scrollParam2.prefabType = ScrollEnum.ScrollPrefabFromRes
		scrollParam2.prefabUrl = self._viewSetting.otherRes[1]
		scrollParam2.cellClass = Rouge2_CollectionListRow
		scrollParam2.scrollDir = ScrollEnum.ScrollDirV
		scrollParam2.startSpace = 0
		scrollParam2.endSpace = 0

		local scrollParam = ListScrollParam.New()

		scrollParam.scrollGOPath = "Left/#scroll_collection"
		scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
		scrollParam.prefabUrl = "Left/#scroll_collection/Viewport/#go_content/#go_collectionitem"
		scrollParam.cellClass = Rouge2_CollectionFormulaItem
		scrollParam.scrollDir = ScrollEnum.ScrollDirV
		scrollParam.lineCount = 5
		scrollParam.cellWidth = 180
		scrollParam.cellHeight = 180
		scrollParam.cellSpaceH = 0
		scrollParam.cellSpaceV = 0
		scrollParam.startSpace = 0
		scrollParam.endSpace = 0

		local scrollParamFormulaNeed = ListScrollParam.New()

		scrollParamFormulaNeed.scrollGOPath = "Right/need/#scroll_need"
		scrollParamFormulaNeed.prefabType = ScrollEnum.ScrollPrefabFromView
		scrollParamFormulaNeed.prefabUrl = "Right/need/#scroll_need/Viewport/Content/#go_collectionitem"
		scrollParamFormulaNeed.cellClass = Rouge2_CollectionFormulaItem
		scrollParamFormulaNeed.scrollDir = ScrollEnum.ScrollDirV
		scrollParamFormulaNeed.lineCount = 5
		scrollParamFormulaNeed.cellWidth = 180
		scrollParamFormulaNeed.cellHeight = 180
		scrollParamFormulaNeed.cellSpaceH = 0
		scrollParamFormulaNeed.cellSpaceV = 10
		scrollParamFormulaNeed.startSpace = 10
		scrollParamFormulaNeed.endSpace = 0
		self._collectionListView = Rouge2_CollectionListView.New()
		self._formulaListView = Rouge2_CollectionFormulaView.New()

		return {
			MultiView.New({
				self._collectionListView,
				LuaMixScrollView.New(Rouge2_CollectionListModel.instance, scrollParam2)
			}),
			MultiView.New({
				self._formulaListView,
				LuaListScrollView.New(Rouge2_CollectionFormulaNeedListModel.instance, scrollParamFormulaNeed),
				LuaListScrollView.New(Rouge2_CollectionFormulaListModel.instance, scrollParam)
			})
		}
	end

	if tabContainerId == 3 then
		return {
			Rouge2_CollectionDetailBtnComp.New()
		}
	end
end

function Rouge2_FavoriteCollectionViewContainer:getCollectionListView()
	return self._collectinListView
end

function Rouge2_FavoriteCollectionViewContainer:getFormulaListView()
	return self._formulaListView
end

function Rouge2_FavoriteCollectionViewContainer:selectTabView(selectId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, selectId)
end

return Rouge2_FavoriteCollectionViewContainer
