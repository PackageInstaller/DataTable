-- chunkname: @modules/logic/roomfishing/view/RoomFishingStoreView.lua

module("modules.logic.roomfishing.view.RoomFishingStoreView", package.seeall)

local RoomFishingStoreView = class("RoomFishingStoreView", BaseView)

function RoomFishingStoreView:onInitView()
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "#scroll_store")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_content")
	self._gostoregoodsitem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_content/#go_storegoodsitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomFishingStoreView:addEvents()
	self.addEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._onStoreInfoUpdate, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._onStoreInfoUpdate, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function RoomFishingStoreView:removeEvents()
	self.removeEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._onStoreInfoUpdate, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._onStoreInfoUpdate, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function RoomFishingStoreView:_onDailyRefresh()
	StoreRpc.instance:sendGetStoreInfosRequest({
		StoreEnum.StoreId.RoomFishingStore
	})
end

function RoomFishingStoreView:_onStoreInfoUpdate()
	self:setGoodsItems()
end

function RoomFishingStoreView:_editableInitView()
	return
end

function RoomFishingStoreView:onUpdateParam()
	return
end

function RoomFishingStoreView:onOpen()
	self:setGoodsItems()
	AudioMgr.instance:trigger(AudioEnum3_1.RoomFishing.ui_home_mingdi_jihuan)
end

local function _sortStoreItem(xMO, yMO)
	local xSoldOut = xMO:isSoldOut()
	local ySoldOut = yMO:isSoldOut()
	local xHas = xMO:alreadyHas()
	local yHas = yMO:alreadyHas()

	if xHas and not yHas then
		return false
	elseif yHas and not xHas then
		return true
	end

	if xSoldOut and not ySoldOut then
		return false
	elseif ySoldOut and not xSoldOut then
		return true
	end

	local xConfig = StoreConfig.instance:getGoodsConfig(xMO.goodsId)
	local yConfig = StoreConfig.instance:getGoodsConfig(yMO.goodsId)

	if xConfig.order ~= yConfig.order then
		return xConfig.order < yConfig.order
	end

	return xConfig.id < yConfig.id
end

function RoomFishingStoreView:setGoodsItems()
	local storeMO = FishingStoreModel.instance:getStoreGroupMO()
	local goodsList = storeMO and storeMO:getGoodsList() or {}

	table.sort(goodsList, _sortStoreItem)
	gohelper.CreateObjList(self, self._onGoodsItemShow, goodsList, self._gocontent, self._gostoregoodsitem, RoomFishingStoreItem)
end

function RoomFishingStoreView:_onGoodsItemShow(obj, data, index)
	obj:onUpdateMO(data)
end

function RoomFishingStoreView:onClose()
	return
end

function RoomFishingStoreView:onDestroyView()
	return
end

return RoomFishingStoreView
