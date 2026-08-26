-- chunkname: @modules/logic/versionactivity2_8/dungeontaskstore/view/store/VersionActivity2_8StoreViewContainer.lua

module("modules.logic.versionactivity2_8.dungeontaskstore.view.store.VersionActivity2_8StoreViewContainer", package.seeall)

local VersionActivity2_8StoreViewContainer = class("VersionActivity2_8StoreViewContainer", BaseViewContainer)

function VersionActivity2_8StoreViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_store"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_store/Viewport/#go_content/#go_storegoodsitem"
	scrollParam.cellClass = VersionActivity2_8DungeonTaskStoreController.instance:getModuleConfig().StoreCellClass
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 316
	scrollParam.cellHeight = 365

	return {
		VersionActivity2_8StoreView.New(),
		VersionActivity2_8StoreTalk.New(),
		LuaListScrollView.New(VersionActivity2_8StoreListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function VersionActivity2_8StoreViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end

	if tabContainerId == 2 then
		self._currencyView = CurrencyView.New({
			VersionActivity2_8DungeonTaskStoreController.instance:getModuleConfig().Currency
		})

		self._currencyView:setOpenCallback(self._onCurrencyOpen, self)

		self._currencyView.foreHideBtn = true

		return {
			self._currencyView
		}
	end
end

function VersionActivity2_8StoreViewContainer:_onCurrencyOpen()
	local item = self._currencyView:getCurrencyItem(1)

	gohelper.setActive(item.btn, false)
	gohelper.setActive(item.click, true)
	recthelper.setAnchorX(item.txt.transform, 313)
end

function VersionActivity2_8StoreViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_8DungeonTaskStoreController.instance:getModuleConfig().DungeonStore)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_8DungeonTaskStoreController.instance:getModuleConfig().DungeonStore
	})
end

return VersionActivity2_8StoreViewContainer
