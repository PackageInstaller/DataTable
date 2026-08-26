-- chunkname: @modules/logic/rouge/view/RougeFavoriteCollectionViewContainer.lua

module("modules.logic.rouge.view.RougeFavoriteCollectionViewContainer", package.seeall)

local RougeFavoriteCollectionViewContainer = class("RougeFavoriteCollectionViewContainer", BaseViewContainer)

function RougeFavoriteCollectionViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeFavoriteCollectionView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(views, TabViewGroup.New(2, "#go_content"))
	table.insert(views, TabViewGroup.New(3, "#go_rougemapdetailcontainer"))

	return views
end

function RougeFavoriteCollectionViewContainer:buildTabViews(tabContainerId)
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
		scrollParam2.cellClass = RougeCollectionListRow
		scrollParam2.scrollDir = ScrollEnum.ScrollDirV
		scrollParam2.startSpace = 0
		scrollParam2.endSpace = 0

		local scrollParam = ListScrollParam.New()

		scrollParam.scrollGOPath = "Left/#scroll_collection"
		scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
		scrollParam.prefabUrl = "Left/#scroll_collection/Viewport/Content/#go_collectionitem"
		scrollParam.cellClass = RougeCollectionHandBookItem
		scrollParam.scrollDir = ScrollEnum.ScrollDirV
		scrollParam.lineCount = 4
		scrollParam.cellWidth = 224
		scrollParam.cellHeight = 224
		scrollParam.cellSpaceH = 10
		scrollParam.cellSpaceV = 0
		scrollParam.startSpace = 61
		scrollParam.endSpace = 0

		local scrollParamEnchant = ListScrollParam.New()

		scrollParamEnchant.scrollGOPath = "Right/#go_normal/bottom/scrollview"
		scrollParamEnchant.prefabType = ScrollEnum.ScrollPrefabFromView
		scrollParamEnchant.prefabUrl = "Right/#go_normal/bottom/scrollview/Viewport/Content/Item"
		scrollParamEnchant.cellClass = RougeCollectionListDropdownItem
		scrollParamEnchant.scrollDir = ScrollEnum.ScrollDirV
		scrollParamEnchant.lineCount = 1
		scrollParamEnchant.cellWidth = 200
		scrollParamEnchant.cellHeight = 120
		scrollParamEnchant.cellSpaceH = 0
		scrollParamEnchant.cellSpaceV = 0
		scrollParamEnchant.startSpace = 20
		scrollParamEnchant.endSpace = 0
		self._dropDownView = RougeCollectionListDropdownView.New()
		self._collectinListView = RougeCollectionListView.New()

		return {
			MultiView.New({
				LuaListScrollView.New(RougeFavoriteCollectionEnchantListModel.instance, scrollParamEnchant),
				self._dropDownView,
				self._collectinListView,
				LuaMixScrollView.New(RougeCollectionListModel.instance, scrollParam2)
			}),
			MultiView.New({
				RougeCollectionHandBookView.New(),
				LuaListScrollView.New(RougeCollectionHandBookListModel.instance, scrollParam)
			})
		}
	end

	if tabContainerId == 3 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

function RougeFavoriteCollectionViewContainer:getDropDownView()
	return self._dropDownView
end

function RougeFavoriteCollectionViewContainer:getCollectionListView()
	return self._collectinListView
end

function RougeFavoriteCollectionViewContainer:selectTabView(selectId)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, selectId)
end

return RougeFavoriteCollectionViewContainer
