-- chunkname: @modules/logic/gm/view/GM_StoreView.lua

module("modules.logic.gm.view.GM_StoreView", package.seeall)

local GM_StoreView = class("GM_StoreView", BaseView)
local kYellow = "#FFFF00"
local kGreen = "#00FF00"

function GM_StoreView.register()
	GM_StoreView.StoreView_register(StoreView)
	GM_StoreView.RecommendStoreView_register(RecommendStoreView)
	GM_StoreView.PackageStoreView_register(PackageStoreView)
	GM_StoreView.PackageStoreGoodsItem_register(PackageStoreGoodsItem)
	GM_StoreView.ClothesStoreView_register(ClothesStoreView)
	GM_StoreView.StoreSkinGoodsItem_register(StoreSkinGoodsItem)
	GM_StoreView.NormalStoreView_register(NormalStoreView)
	GM_StoreView.NormalStoreGoodsItem_register(NormalStoreGoodsItem)
end

function GM_StoreView.StoreView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "_refreshTabs")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)

		local btnGM = GMMinusModel.instance:addBtnGM(self)

		recthelper.setAnchorX(btnGM.transform, 50)
		recthelper.setAnchorY(btnGM.transform, -999)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_StoreViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_StoreViewContainer.removeEvents(self)
	end

	function T._refreshTabs(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_refreshTabs", ...)

		if GM_StoreView.s_ShowAllTabId then
			for _, tabTable in ipairs(selfObj._tabsContainer) do
				if tabTable then
					local tabId = tabTable.tabId

					if tabTable then
						tabTable.txtnamecn1.text = tostring(tabId)
						tabTable.txtnamecn2.text = tostring(tabId)
					end
				end
			end
		else
			local tabConfigs = StoreModel.instance:getFirstTabs(true, true)

			for i, tabTable in ipairs(selfObj._tabsContainer) do
				if tabTable then
					local tabConfig = tabConfigs[i]

					if tabTable then
						tabTable.txtnamecn1.text = tabConfig.name
						tabTable.txtnamecn2.text = tabConfig.name
					end
				end
			end
		end
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		local id = StoreController.instance._lastViewStoreId

		if not id or id == 0 then
			id = StoreEnum.DefaultTabId
		end

		selfObj:_refreshTabs(id)
	end
end

function GM_StoreView.RecommendStoreView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "onOpen")
	GMMinusModel.instance:saveOriginalFunc(T, "_refreshSecondTabs")
	GMMinusModel.instance:saveOriginalFunc(T, "_refreshTabsItem")
	GMMinusModel.instance:saveOriginalFunc(T, "_refreshTabs")
	GMMinusModel.instance:saveOriginalFunc(T, "_onSetVisibleInternal")
	GMMinusModel.instance:saveOriginalFunc(T, "_onSetAutoToNextPage")
	GMMinusModel.instance:saveOriginalFunc(T, "onDestroyView")
	GMMinusModel.instance:saveOriginalFunc(StoreHelper, "getRecommendStoreSecondTabConfig")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_RecommendStoreViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_RecommendStoreViewContainer.removeEvents(self)
	end

	function T.onOpen(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "onOpen", ...)
		selfObj:_gm_stopBannerLoopAnimUpdate()
	end

	function T._refreshSecondTabs(selfObj, index, secondTabConfig, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_refreshSecondTabs", index, secondTabConfig, ...)

		local categoryItemTable = selfObj._categoryItemContainer[index]
		local tabId = secondTabConfig.id
		local desc = secondTabConfig.name

		if GM_RecommendStoreView.s_ShowAllTabId then
			local lastOpenedTabIdSet = GMMinusModel.instance:getFirstLogin("GM_RecommendStoreViewContainer_lastOpenedTabIdSet", {})

			desc = GM_RecommendStoreView.s_ShowAllBanner and not lastOpenedTabIdSet[tabId] and string.format("%s\n<color=#00FF00>%s (New)</color>", desc, tabId) or string.format("%s\n%s", desc, tabId)
		end

		categoryItemTable.txt_itemcn1.text = desc
		categoryItemTable.txt_itemcn2.text = desc
	end

	function T:_onSetVisibleInternal(...)
		if GM_RecommendStoreView.s_StopBannerLoopAnim then
			-- block empty
		else
			GMMinusModel.instance:callOriginalSelfFunc(self, "_onSetVisibleInternal", ...)
		end
	end

	function T:_onSetAutoToNextPage(...)
		if GM_RecommendStoreView.s_StopBannerLoopAnim then
			-- block empty
		else
			GMMinusModel.instance:callOriginalSelfFunc(self, "_onSetAutoToNextPage", ...)
		end
	end

	function T._refreshTabsItem(selfObj, ...)
		if GM_RecommendStoreView.s_ShowAllBanner then
			local _, oriStoreIds = selfObj:_gm_getRecommendStoreSecondTabConfig()

			function StoreHelper.getRecommendStoreSecondTabConfig()
				local tabIdList = selfObj:_gm_showAllBanner_GetTabIdList()
				local allSecondTabConfigs = StoreModel.instance:getRecommendSecondTabs(StoreEnum.RecommendStore, true)
				local justShowTabIdDict = {}

				for _, tabId in ipairs(tabIdList) do
					justShowTabIdDict[tabId] = true
				end

				local newShowSecondTabConfigs = {}

				for _, v in ipairs(allSecondTabConfigs) do
					if justShowTabIdDict[v.id] then
						table.insert(newShowSecondTabConfigs, v)
					end
				end

				return newShowSecondTabConfigs, oriStoreIds
			end
		end

		local storeIds = GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_refreshTabsItem", ...)

		StoreHelper.getRecommendStoreSecondTabConfig = GMMinusModel.instance:loadOriginalFunc(StoreHelper, "getRecommendStoreSecondTabConfig")

		return storeIds
	end

	function T._refreshTabs(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_refreshTabs", ...)
		selfObj:_gm_stopBannerLoopAnimUpdate()
	end

	function T.onDestroyView(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "onDestroyView", ...)

		StoreHelper.getRecommendStoreSecondTabConfig = GMMinusModel.instance:loadOriginalFunc(StoreHelper, "getRecommendStoreSecondTabConfig")
	end

	function T._gm_stopBannerLoopAnimUpdate(selfObj)
		if GM_RecommendStoreView.s_StopBannerLoopAnim then
			TaskDispatcher.cancelTask(selfObj._toNextTab, selfObj)
			TaskDispatcher.cancelTask(selfObj._onSwitchCloseAnimDone, selfObj)
		end
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		selfObj:_refreshTabsItem()
	end

	function T._gm_showAllBannerUpdate(selfObj)
		if not GM_RecommendStoreView.s_ShowAllBanner then
			return
		end

		selfObj:_refreshTabsItem()
	end

	function T._gm_getRecommendStoreSecondTabConfig(selfObj)
		return GMMinusModel.instance:callOriginalStaticFunc(StoreHelper, "getRecommendStoreSecondTabConfig")
	end

	function T._gm_showAllBanner_GetTabIdList(selfObj)
		local tabIdList = {}
		local showSecondTabConfigs, storeIds = selfObj:_gm_getRecommendStoreSecondTabConfig()

		table.sort(showSecondTabConfigs, function(a, b)
			return selfObj:_tabSortFunction(a, b)
		end)

		local lastOpenedTabIdSet = {}

		for i = 1, #showSecondTabConfigs do
			local showSecondTabConfig = showSecondTabConfigs[i]
			local tabId = showSecondTabConfig.id

			tabIdList[#tabIdList + 1] = tabId
			lastOpenedTabIdSet[tabId] = true
		end

		GMMinusModel.instance:setFirstLogin("GM_RecommendStoreViewContainer_lastOpenedTabIdSet", lastOpenedTabIdSet)

		local now = ServerTime.now()

		for _, v in ipairs(lua_store_recommend.configList) do
			local onlineTime = v.onlineTime
			local offlineTime = v.offlineTime
			local onlineTimeServerTs, offlineTimeServerTs

			onlineTimeServerTs = string.nilorempty(onlineTime) and now or TimeUtil.stringToTimestamp(onlineTime)

			if now <= onlineTimeServerTs and now <= (string.nilorempty(offlineTime) and now or TimeUtil.stringToTimestamp(offlineTime)) then
				tabIdList[#tabIdList + 1] = v.id
			end
		end

		return tabIdList
	end
end

function GM_StoreView.PackageStoreView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "_refreshSecondTabs")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_PackageStoreViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_PackageStoreViewContainer.removeEvents(self)
	end

	function T._refreshSecondTabs(selfObj, index, secondTabConfig, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_refreshSecondTabs", index, secondTabConfig, ...)

		if not GM_PackageStoreView.s_ShowAllTabId then
			return
		end

		local categoryItemTable = selfObj._categoryItemContainer[index]

		if not categoryItemTable then
			return
		end

		local desc = secondTabConfig.id .. secondTabConfig.name

		categoryItemTable.txt_itemcn1.text = desc
		categoryItemTable.txt_itemcn2.text = desc
	end

	function T._gm_showAllTabIdUpdate()
		StoreController.instance:dispatchEvent(StoreEvent.UpdatePackageStore)
	end

	function T._gm_showAllItemIdUpdate()
		StoreController.instance:dispatchEvent(StoreEvent.GoodsModelChanged)
	end
end

function GM_StoreView.PackageStoreGoodsItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "onUpdateMO")

	function T.onUpdateMO(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "onUpdateMO", ...)

		if not GM_PackageStoreView.s_ShowAllItemId then
			return
		end

		local config = selfObj._mo.config

		selfObj._txtmaterialNum.text = tostring(config.id)
	end
end

function GM_StoreView.ClothesStoreView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_ClothesStoreViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_ClothesStoreViewContainer.removeEvents(self)
	end

	function T._gm_showAllTabIdUpdate()
		StoreClothesGoodsItemListModel.instance:onModelUpdate()
	end
end

function GM_StoreView.StoreSkinGoodsItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "onUpdateMO")

	local kRed = "#FF0000"

	function T.onUpdateMO(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "onUpdateMO", ...)

		if not GM_ClothesStoreView.s_ShowAllTabId then
			return
		end

		local config = selfObj._mo.config
		local skinCO = selfObj.skinCo
		local heroId = skinCO.characterId
		local heroCO = HeroConfig.instance:getHeroCO(heroId)
		local idStr = gohelper.getRichColorText(tostring(config.id), kRed)
		local skinIdStr = gohelper.getRichColorText(tostring(skinCO.id), kRed)
		local desc = "id: " .. idStr .. "\n" .. "SkinId: " .. skinIdStr

		selfObj._txtremaintime.text = gohelper.getRichColorText(desc, kRed)
	end
end

function GM_StoreView.NormalStoreView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "_refreshSecondTabs")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_NormalStoreViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_NormalStoreViewContainer.removeEvents(self)
	end

	function T._refreshSecondTabs(selfObj, index, secondTabConfig, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_refreshSecondTabs", index, secondTabConfig, ...)

		if not GM_NormalStoreView.s_ShowAllTabId then
			return
		end

		local categoryItemTable = selfObj._categoryItemContainer[index]
		local tabId = secondTabConfig.id

		categoryItemTable.tabId = tabId
		categoryItemTable.txt_itemcn1.text = tostring(tabId) .. secondTabConfig.name
		categoryItemTable.txt_itemcn2.text = tostring(tabId) .. secondTabConfig.name
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		local id = StoreController.instance._lastViewStoreId

		if not id or id == 0 then
			id = selfObj.viewContainer:getJumpTabId()
		end

		selfObj:_refreshTabs(id, true)
	end

	function T:_gm_showAllGoodsIdUpdate()
		StoreController.instance:dispatchEvent(StoreEvent.GoodsModelChanged)
	end
end

function GM_StoreView.NormalStoreGoodsItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "refreshActGoods")
	GMMinusModel.instance:saveOriginalFunc(T, "refreshNormalGoods")

	function T.refreshActGoods(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "refreshActGoods", ...)

		if not GM_NormalStoreView.s_ShowAllGoodsId then
			return
		end

		local mo = selfObj._mo
		local goodsId = mo:getActGoodsId()

		selfObj._txtgoodsName.text = gohelper.getRichColorText(goodsId, kYellow) .. gohelper.getRichColorText("(Act)", kGreen)
	end

	function T.refreshNormalGoods(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "refreshNormalGoods", ...)

		if not GM_NormalStoreView.s_ShowAllGoodsId then
			return
		end

		local mo = selfObj._mo
		local goodsId = mo.goodsId

		selfObj._txtgoodsName.text = gohelper.getRichColorText(goodsId, kYellow)
	end
end

function GM_StoreView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
end

function GM_StoreView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
end

function GM_StoreView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
end

function GM_StoreView:onOpen()
	self:_refreshItem1()
end

function GM_StoreView:onDestroyView()
	return
end

GM_StoreView.s_ShowAllTabId = false

function GM_StoreView:_refreshItem1()
	self._item1Toggle.isOn = GM_StoreView.s_ShowAllTabId
end

function GM_StoreView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_StoreView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.StoreView_ShowAllTabIdUpdate, isOn)
end

return GM_StoreView
