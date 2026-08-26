-- chunkname: @modules/logic/versionactivity1_9/dungeon/view/store/VersionActivity1_9StoreViewContainer.lua

module("modules.logic.versionactivity1_9.dungeon.view.store.VersionActivity1_9StoreViewContainer", package.seeall)

local VersionActivity1_9StoreViewContainer = class("VersionActivity1_9StoreViewContainer", BaseViewContainer)

function VersionActivity1_9StoreViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_store"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_store/Viewport/#go_content/#go_storegoodsitem"
	scrollParam.cellClass = VersionActivity1_9StoreGoodsItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 316
	scrollParam.cellHeight = 365

	return {
		VersionActivity1_9StoreView.New(),
		VersionActivity1_9StoreTalk.New(),
		LuaListScrollView.New(VersionActivity1_9StoreListModel.instance, scrollParam),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function VersionActivity1_9StoreViewContainer:buildTabViews(tabContainerId)
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
			CurrencyEnum.CurrencyType.V1a9Dungeon
		})

		self._currencyView:setOpenCallback(self._onCurrencyOpen, self)

		return {
			self._currencyView
		}
	end
end

function VersionActivity1_9StoreViewContainer:_onCurrencyOpen()
	local item = self._currencyView:getCurrencyItem(1)

	gohelper.setActive(item.btn, false)
	gohelper.setActive(item.click, true)
	recthelper.setAnchorX(item.txt.transform, 313)
end

function VersionActivity1_9StoreViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_9Enum.ActivityId.DungeonStore)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_9Enum.ActivityId.DungeonStore
	})
end

return VersionActivity1_9StoreViewContainer
