-- chunkname: @modules/logic/versionactivity2_6/dungeon/view/store/VersionActivity2_6StoreViewContainer.lua

module("modules.logic.versionactivity2_6.dungeon.view.store.VersionActivity2_6StoreViewContainer", package.seeall)

local VersionActivity2_6StoreViewContainer = class("VersionActivity2_6StoreViewContainer", BaseViewContainer)

function VersionActivity2_6StoreViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_store"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_store/Viewport/#go_content/#go_storegoodsitem"
	scrollParam.cellClass = VersionActivity2_6StoreGoodsItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 316
	scrollParam.cellHeight = 365

	return {
		VersionActivity2_6StoreView.New(),
		VersionActivity2_6StoreTalk.New(),
		LuaListScrollView.New(VersionActivity2_6StoreListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function VersionActivity2_6StoreViewContainer:buildTabViews(tabContainerId)
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
			CurrencyEnum.CurrencyType.V2a6Dungeon
		})

		self._currencyView:setOpenCallback(self._onCurrencyOpen, self)

		return {
			self._currencyView
		}
	end
end

function VersionActivity2_6StoreViewContainer:_onCurrencyOpen()
	local item = self._currencyView:getCurrencyItem(1)

	gohelper.setActive(item.btn, false)
	gohelper.setActive(item.click, true)
	recthelper.setAnchorX(item.txt.transform, 313)
end

function VersionActivity2_6StoreViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_6Enum.ActivityId.DungeonStore)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_6Enum.ActivityId.DungeonStore
	})
end

return VersionActivity2_6StoreViewContainer
