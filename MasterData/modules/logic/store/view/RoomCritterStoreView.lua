-- chunkname: @modules/logic/store/view/RoomCritterStoreView.lua

module("modules.logic.store.view.RoomCritterStoreView", package.seeall)

local RoomCritterStoreView = class("RoomCritterStoreView", BaseView)

function RoomCritterStoreView:onInitView()
	self._scrolltab = gohelper.findChildScrollRect(self.viewGO, "#scroll_tab")
	self._gotab = gohelper.findChild(self.viewGO, "#scroll_tab/Viewport/Content/#go_tab")
	self._scrollgoods = gohelper.findChildScrollRect(self.viewGO, "#scroll_goods")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterStoreView:addEvents()
	self.addEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._updateInfo, self)
end

function RoomCritterStoreView:removeEvents()
	self.removeEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._updateInfo, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._updateInfo, self)
end

function RoomCritterStoreView:_editableInitView()
	return
end

function RoomCritterStoreView:onUpdateParam()
	return
end

function RoomCritterStoreView:_updateInfo()
	StoreCritterGoodsItemListModel.instance:setMOList(StoreEnum.StoreId.CritterStore)
end

function RoomCritterStoreView:onOpen()
	gohelper.setActive(self._gotab, false)
	gohelper.setActive(self._scrolltab.gameObject, false)
	StoreRpc.instance:sendGetStoreInfosRequest({
		StoreEnum.StoreId.CritterStore
	}, self._updateInfo, self)
end

function RoomCritterStoreView:_getTabItem(index)
	self._tabItems = self._tabItems or self:getUserDataTb_()

	local item = self._tabItems[index]

	if not item then
		item = {}

		local go = gohelper.cloneInPlace(self._gotab)

		item.goSelect = gohelper.findChild(go, "bg/select")
		item.btn = gohelper.findChildButtonWithAudio(go, "bg/btn")

		item.btn:AddClickListener(self._onClickTab, self, index)

		item.txt = gohelper.findChildText(go, "txt")
		item.go = go
	end

	self._tabItems[index] = item

	return item
end

function RoomCritterStoreView:_onClickTab(index)
	if self._selectTabIndex == index then
		return
	end

	self._selectTabIndex = index

	self:_refreshSelectTab()
end

function RoomCritterStoreView:onClose()
	return
end

function RoomCritterStoreView:onDestroyView()
	if self._tabItems then
		for i = 1, #self._tabItems do
			self._tabItems[i].btn:RemoveClickListener()
		end
	end
end

return RoomCritterStoreView
