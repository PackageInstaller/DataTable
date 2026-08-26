-- chunkname: @modules/logic/store/view/StoreViewContainer.lua

module("modules.logic.store.view.StoreViewContainer", package.seeall)

local StoreViewContainer = class("StoreViewContainer", BaseViewContainer)

function StoreViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "#go_topright"))
	table.insert(views, TabViewGroup.New(3, "#go_store"))

	self.storeView = StoreView.New()

	table.insert(views, self.storeView)

	return views
end

function StoreViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local needHideHome = StoreController.instance:needHideHome()

		self.navigationView = NavigateButtonsView.New({
			true,
			not needHideHome,
			false
		})

		return {
			self.navigationView
		}
	elseif tabContainerId == 2 then
		self._currencyView = CurrencyView.New({})

		return {
			self._currencyView
		}
	elseif tabContainerId == 3 then
		local normalScrollParam = ListScrollParam.New()

		normalScrollParam.scrollGOPath = "#scroll_prop"
		normalScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		normalScrollParam.prefabUrl = self._viewSetting.otherRes[1]
		normalScrollParam.cellClass = NormalStoreGoodsItem
		normalScrollParam.scrollDir = ScrollEnum.ScrollDirV
		normalScrollParam.lineCount = 4
		normalScrollParam.cellWidth = 332
		normalScrollParam.cellHeight = 355
		normalScrollParam.cellSpaceH = 29
		normalScrollParam.cellSpaceV = 37
		normalScrollParam.startSpace = 31

		local chargeScrollParam = ListScrollParam.New()

		chargeScrollParam.scrollGOPath = "#scroll_prop"
		chargeScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		chargeScrollParam.prefabUrl = self._viewSetting.otherRes[2]
		chargeScrollParam.cellClass = ChargeStoreGoodsItem
		chargeScrollParam.scrollDir = ScrollEnum.ScrollDirV
		chargeScrollParam.lineCount = 3
		chargeScrollParam.cellWidth = 446
		chargeScrollParam.cellHeight = 406
		chargeScrollParam.cellSpaceH = 38
		chargeScrollParam.cellSpaceV = 35
		chargeScrollParam.startSpace = 0

		local clotheDataCount = StoreClothesGoodsItemListModel.instance:getCount()
		local clothesScrollParam = ListScrollParam.New()

		clothesScrollParam.scrollGOPath = "#go_has/#scroll_skin"
		clothesScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		clothesScrollParam.prefabUrl = self._viewSetting.otherRes[3]
		clothesScrollParam.cellClass = StoreSkinGoodsItem
		clothesScrollParam.scrollDir = ScrollEnum.ScrollDirV
		clothesScrollParam.lineCount = clotheDataCount == 1 and 1 or 2
		clothesScrollParam.cellWidth = 260
		clothesScrollParam.cellHeight = 408
		clothesScrollParam.cellSpaceH = 0
		clothesScrollParam.cellSpaceV = 0
		clothesScrollParam.startSpace = 0
		clothesScrollParam.notPlayAnimation = true

		local packageScrollParam = ListScrollParam.New()

		packageScrollParam.scrollGOPath = "#scroll_prop"
		packageScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		packageScrollParam.prefabUrl = self._viewSetting.otherRes[4]
		packageScrollParam.cellClass = PackageStoreGoodsItem
		packageScrollParam.scrollDir = ScrollEnum.ScrollDirV
		packageScrollParam.lineCount = 4
		packageScrollParam.cellWidth = 366
		packageScrollParam.cellHeight = 396
		packageScrollParam.cellSpaceH = 0
		packageScrollParam.cellSpaceV = 0
		packageScrollParam.startSpace = 10

		local roomScrollParam = TreeScrollParam.New()

		roomScrollParam.scrollGOPath = "#scroll_prop"
		roomScrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
		roomScrollParam.prefabUrls = {
			"roomstoreitem/root",
			"roomstoreitem/node",
			"roomstoreitem/node",
			"roomstoreitem/node",
			"roomstoreitem/node",
			"roomstoreitem/node"
		}
		roomScrollParam.cellClass = StoreRoomTreeItem
		roomScrollParam.scrollDir = ScrollEnum.ScrollDirV

		local cardAnimationDelayTimes = {}

		for i = 1, 12 do
			cardAnimationDelayTimes[i] = math.floor((i - 1) / 4) * 0.07
		end

		local ChargeAnimationDelayTimes = {}

		for i = 1, 9 do
			ChargeAnimationDelayTimes[i] = math.floor((i - 1) / 3) * 0.07
		end

		local packageAnimationDelayTimes = {}

		for i = 1, 12 do
			packageAnimationDelayTimes[i] = math.floor((i - 1) / 4) * 0.07
		end

		self._ScrollViewNormalStore = LuaListScrollViewWithAnimator.New(StoreNormalGoodsItemListModel.instance, normalScrollParam, cardAnimationDelayTimes)
		self._ScrollViewChargeStore = LuaListScrollViewWithAnimator.New(StoreChargeGoodsItemListModel.instance, chargeScrollParam, ChargeAnimationDelayTimes)
		self._ScrollViewPackageStore = LuaListScrollViewWithAnimator.New(StorePackageGoodsItemListModel.instance, packageScrollParam, packageAnimationDelayTimes)
		self._ScrollViewSkinStore = LuaListScrollViewWithAnimator.New(StoreClothesGoodsItemListModel.instance, clothesScrollParam)
		self._ScrollViewRoomStore = LuaTreeScrollView.New(StoreRoomGoodsItemListModel.instance, roomScrollParam)
		self._RecommendStoreView = RecommendStoreView.New()
		self._monthAndSeasonCardView = MonthAndSeasonCardView.New()

		return {
			MultiView.New({
				NormalStoreView.New(),
				self._ScrollViewNormalStore,
				TabViewGroup.New(6, "#go_limit")
			}),
			MultiView.New({
				ChargeStoreView.New(),
				self._ScrollViewChargeStore
			}),
			MultiView.New({
				self._ScrollViewSkinStore,
				ClothesStoreView.New(),
				ClothesStoreVideoView.New(),
				ClothesStoreDragView.New()
			}),
			MultiView.New({
				PackageStoreView.New(),
				self._ScrollViewPackageStore
			}),
			MultiView.New({
				self._RecommendStoreView
			}),
			MultiView.New({
				RoomStoreView.New(),
				self._ScrollViewRoomStore,
				TabViewGroup.New(5, "#go_critter")
			}),
			MultiView.New({
				DecorateStoreView.New()
			}),
			MultiView.New({
				self._monthAndSeasonCardView,
				TabViewGroup.New(7, "subViewContainer/#go_subViewParent")
			})
		}
	elseif tabContainerId == 4 then
		return {
			StoreMonthCardView.New(),
			GiftPacksView.New(),
			BpEnterView.New(),
			StoreNewbieChooseView.New(),
			StoreRoleSkinView.New(),
			StoreBlockPackageView.New(),
			GiftrecommendView1.New(),
			GiftrecommendView2.New(),
			StoreSeasonCardView.New(),
			StoreSkinBagView.New()
		}
	elseif tabContainerId == 5 then
		local critterScrollParam = ListScrollParam.New()

		critterScrollParam.scrollGOPath = "#scroll_goods"
		critterScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		critterScrollParam.prefabUrl = self._viewSetting.otherRes[1]
		critterScrollParam.cellClass = RoomStoreGoodsItem
		critterScrollParam.scrollDir = ScrollEnum.ScrollDirV
		critterScrollParam.lineCount = 4
		critterScrollParam.cellWidth = 332
		critterScrollParam.cellHeight = 355
		critterScrollParam.cellSpaceH = 29
		critterScrollParam.cellSpaceV = 37
		critterScrollParam.startSpace = 31

		local cardAnimationDelayTimes = {}

		for i = 1, 12 do
			cardAnimationDelayTimes[i] = math.floor((i - 1) / 4) * 0.07
		end

		self._ScrollViewRoomCritterStore = LuaListScrollViewWithAnimator.New(StoreCritterGoodsItemListModel.instance, critterScrollParam, cardAnimationDelayTimes)

		return {
			MultiView.New({
				RoomCritterStoreView.New(),
				self._ScrollViewRoomCritterStore
			})
		}
	elseif tabContainerId == 6 then
		local summonScrollParam = ListScrollParam.New()

		summonScrollParam.scrollGOPath = "#scroll_prop"
		summonScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		summonScrollParam.prefabUrl = self._viewSetting.otherRes[5]
		summonScrollParam.cellClass = SummonStoreGoodsItem
		summonScrollParam.scrollDir = ScrollEnum.ScrollDirV
		summonScrollParam.lineCount = 4
		summonScrollParam.cellWidth = 332
		summonScrollParam.cellHeight = 355
		summonScrollParam.cellSpaceH = 29
		summonScrollParam.cellSpaceV = 37
		summonScrollParam.startSpace = 31

		local cardAnimationDelayTimes = {}

		for i = 1, 12 do
			cardAnimationDelayTimes[i] = math.floor((i - 1) / 4) * 0.07
		end

		self._ScrollViewSummonStore = LuaListScrollViewWithAnimator.New(StoreNormalGoodsItemListModel.instance, summonScrollParam, cardAnimationDelayTimes)

		return {
			MultiView.New({
				StoreSummonView.New(),
				self._ScrollViewSummonStore
			})
		}
	elseif tabContainerId == 7 then
		return {
			MonthCardSubView.New(),
			SeasonCardSubView.New()
		}
	end
end

function StoreViewContainer:onContainerOpenFinish()
	self.navigationView:resetCloseBtnAudioId(AudioEnum.UI.UI_Rolesopen)
end

function StoreViewContainer:onContainerClose()
	GameUtil.onDestroyViewMember(self, "_flowGoldenMilletPresent")
	StoreViewContainer.super.onContainerClose(self)
end

function StoreViewContainer:setCurrencyType(showCost)
	local currencyTypeParam = {}

	if not string.nilorempty(showCost) then
		local costInfo = string.split(showCost, "#")

		for i = #costInfo, 1, -1 do
			table.insert(currencyTypeParam, tonumber(costInfo[i]))
		end
	end

	if self._currencyView then
		self._currencyView:setCurrencyType(currencyTypeParam)
	end
end

function StoreViewContainer:setCurrencyByParams(showCostParams)
	if self._currencyView then
		self._currencyView:setCurrencyType(showCostParams)
	end
end

function StoreViewContainer:selectTabView(jumpTabId, selectFirstTabId, jumpGoodsId, sameFirstTabId)
	self.viewParam.jumpTab = jumpTabId
	self.viewParam.jumpGoodsId = jumpGoodsId
	self._selectFirstTabId = selectFirstTabId

	local tabConfig = StoreConfig.instance:getTabConfig(selectFirstTabId)

	self.notPlayAnimation = false

	if jumpGoodsId ~= nil then
		self.notPlayAnimation = true

		if tabConfig then
			if tabConfig.prefab == StoreEnum.Prefab.NormalStore then
				self._ScrollViewNormalStore._firstUpdate = false
			elseif tabConfig.prefab == StoreEnum.Prefab.PackageStore then
				self._ScrollViewPackageStore._firstUpdate = false
			elseif tabConfig.prefab == StoreEnum.Prefab.ChargeStore then
				self._ScrollViewChargeStore._firstUpdate = false
			elseif tabConfig.prefab == StoreEnum.Prefab.RoomStore then
				self._ScrollViewRoomStore._firstUpdate = false
			end
		end
	end

	if tabConfig and tabConfig.prefab and tabConfig.prefab ~= 0 and not sameFirstTabId then
		self:dispatchEvent(ViewEvent.ToSwitchTab, 3, tabConfig.prefab)
		StoreController.instance:dispatchEvent(StoreEvent.OnSwitchTab, tabConfig)
	end
end

function StoreViewContainer:getSelectFirstTabId()
	return self._selectFirstTabId
end

function StoreViewContainer:playNormalStoreAnimation()
	self._ScrollViewNormalStore:playOpenAnimation()
end

function StoreViewContainer:playSummonStoreAnimation()
	if self._ScrollViewSummonStore ~= nil then
		self._ScrollViewSummonStore:playOpenAnimation()
	end
end

function StoreViewContainer:playChargeStoreAnimation()
	self._ScrollViewChargeStore:playOpenAnimation()
end

function StoreViewContainer:playPackageStoreAnimation()
	if self._ScrollViewPackageStore ~= nil then
		self._ScrollViewPackageStore:playOpenAnimation()
	end
end

function StoreViewContainer:playRoomtoreAnimation()
	self._ScrollViewRoomStore:playOpenAnimation()
end

function StoreViewContainer:playCritterStoreAnimation()
	self._ScrollViewRoomCritterStore:playOpenAnimation()
end

function StoreViewContainer:setRoomStoreAnimation(off)
	local roomAnimationDelayTimes = {}

	for i = off + 1, 8 do
		roomAnimationDelayTimes[i - off] = math.floor((i - 1) / 4) * 0.07
	end

	self._ScrollViewRoomStore._animationDelayTimes = roomAnimationDelayTimes
end

function StoreViewContainer:getJumpTabId()
	return self.viewParam.jumpTab
end

function StoreViewContainer:getJumpGoodsId()
	self.viewParam.jumpGoodsId = nil

	return self.viewParam.jumpGoodsId
end

function StoreViewContainer:isJumpFocus()
	return self.viewParam.isFocus
end

function StoreViewContainer:setVisibleInternal(isVisible)
	StoreViewContainer.super.setVisibleInternal(self, isVisible)
	StoreController.instance:dispatchEvent(StoreEvent.SetVisibleInternal, isVisible)
end

function StoreViewContainer:sortSkinStoreSiblingIndex()
	if self._ScrollViewSkinStore then
		local cellList

		if self._ScrollViewSkinStore then
			local count = 0

			for comp, _ in pairs(self._ScrollViewSkinStore) do
				if comp and comp._mo and comp._isUniqueSkin and comp:_isUniqueSkin() then
					cellList = cellList or {}

					table.insert(cellList, comp)
				end

				count = count + 1
			end
		end

		if cellList then
			table.sort(cellList, StoreViewContainer._sortSkinGoodsItem)

			for i = #cellList, 1, -1 do
				local skinGoodsItem = cellList[i]

				gohelper.setAsLastSibling(skinGoodsItem.parentViewGO)
			end
		end
	end
end

function StoreViewContainer:getRecommendTabIndex(tabId)
	if self._RecommendStoreView then
		return self._RecommendStoreView:getIndexByTabId(tabId)
	end

	return 1
end

function StoreViewContainer:getMonthAndSeasonTabIndex(tabId)
	if self._monthAndSeasonCardView then
		return self._monthAndSeasonCardView:getIndexByTabId(tabId)
	end

	return 1
end

function StoreViewContainer._sortSkinGoodsItem(a, b)
	if a._index ~= b._index then
		return a._index < b._index
	end
end

function StoreViewContainer:doFlowFromGoldenMilletPresent()
	GameUtil.onDestroyViewMember(self, "_flowGoldenMilletPresent")

	local StoreControllerInst = StoreController.instance
	local kViewName = ViewName.CommonPropView

	if ViewMgr.instance:isOpen(kViewName) then
		self._flowGoldenMilletPresent = GaoSiNiaoFlowSequence_Base.New()

		self._flowGoldenMilletPresent:addWork(GaoSiNiaoWork_WaitCloseView.s_create(kViewName))
		self._flowGoldenMilletPresent:addWork(FunctionWork.New(StoreControllerInst.dispatchEvent, StoreControllerInst, StoreEvent.SkinPlayPriceAnim))
		self._flowGoldenMilletPresent:start()
	else
		StoreControllerInst:dispatchEvent(StoreEvent.SkinPlayPriceAnim)
	end
end

return StoreViewContainer
