-- chunkname: @modules/logic/room/view/common/RoomStoreGoodsTipItem.lua

module("modules.logic.room.view.common.RoomStoreGoodsTipItem", package.seeall)

local RoomStoreGoodsTipItem = class("RoomStoreGoodsTipItem", ListScrollCellExtend)

function RoomStoreGoodsTipItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomStoreGoodsTipItem:addEvents()
	return
end

function RoomStoreGoodsTipItem:removeEvents()
	return
end

function RoomStoreGoodsTipItem:_editableInitView()
	self._goeprice = gohelper.findChild(self.viewGO, "go_price")
	self._gofinish = gohelper.findChild(self.viewGO, "go_finish")
	self._txtgold = gohelper.findChildText(self.viewGO, "go_price/txt_gold")
	self._imagegold = gohelper.findChildImage(self.viewGO, "go_price/image_gold")
	self._txtname = gohelper.findChildText(self.viewGO, "txt_name")
	self._txtnum = gohelper.findChildText(self.viewGO, "txt_num")
	self._gobg = gohelper.findChild(self.viewGO, "go_bg")
	self._txtowner = gohelper.findChildText(self.viewGO, "go_finish/txt_owner")
end

function RoomStoreGoodsTipItem:_refreshUI()
	local quantity = self._roomStoreItemMO:getItemQuantity()
	local needNum = self._roomStoreItemMO:getNeedNum()
	local isFinish = needNum <= quantity

	gohelper.setActive(self._goeprice, not isFinish)
	gohelper.setActive(self._gofinish, isFinish)

	if isFinish then
		self._txtowner.text = string.format(luaLang("roommaterialtipview_owner"), tostring(quantity))
	end

	local cfg = self._roomStoreItemMO:getItemConfig()

	if cfg then
		self._txtname.text = cfg.name or ""
	end

	self._txtnum.text = self:_getStateStr(needNum, quantity)

	gohelper.setActive(self._gobg, self._index % 2 == 0)

	if not isFinish then
		local showUseTicket = self._roomStoreItemMO:checkShowTicket()
		local isSelectTicket = not RoomStoreItemListModel.instance:getIsSelectCurrency() and showUseTicket
		local id
		local costId = RoomStoreItemListModel.instance:getCostId()

		if not isSelectTicket then
			local costInfo = self._roomStoreItemMO:getCostById(costId or 1)
			local costType = costInfo.itemType
			local itemid = costInfo.itemId
			local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(costType, itemid)

			id = costConfig.icon
		else
			id = self._roomStoreItemMO:getTicketId()
		end

		local str = string.format("%s_1", id)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagegold, str)

		self._txtgold.text = not isSelectTicket and self._roomStoreItemMO:getTotalPriceByCostId(costId) or 1
	end
end

function RoomStoreGoodsTipItem:_getStateStr(itemNum, quantity)
	return string.format("%s/%s", quantity, itemNum)
end

function RoomStoreGoodsTipItem:onUpdateMO(mo)
	self._roomStoreItemMO = mo

	self:_refreshUI()
end

function RoomStoreGoodsTipItem:onSelect(isSelect)
	return
end

function RoomStoreGoodsTipItem:onDestroyView()
	return
end

return RoomStoreGoodsTipItem
