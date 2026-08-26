-- chunkname: @modules/logic/room/view/manufacture/RoomOneKeyAddPopItem.lua

module("modules.logic.room.view.manufacture.RoomOneKeyAddPopItem", package.seeall)

local RoomOneKeyAddPopItem = class("RoomOneKeyAddPopItem", RoomManufactureFormulaItem)

function RoomOneKeyAddPopItem:addEvents()
	RoomOneKeyAddPopItem.super.addEvents(self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, self.refreshSelected, self)
end

function RoomOneKeyAddPopItem:removeEvents()
	RoomOneKeyAddPopItem.super.removeEvents(self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, self.refreshSelected, self)
end

function RoomOneKeyAddPopItem:onClick()
	local curManufactureItem, curCount = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	ManufactureController.instance:oneKeySelectCustomManufactureItem(self.id, (curManufactureItem == self.id or nil) and curCount)
end

function RoomOneKeyAddPopItem:_editableInitView()
	RoomOneKeyAddPopItem.super._editableInitView(self)

	self.goselected1 = gohelper.findChild(self.viewGO, "#go_needMat/#go_selected")
	self.goselected2 = gohelper.findChild(self.viewGO, "#go_noMat/#go_selected")

	gohelper.setActive(self._txtneedMattime, false)
	gohelper.setActive(self._txtnoMattime, false)
end

function RoomOneKeyAddPopItem:onUpdateMO(mo)
	RoomOneKeyAddPopItem.super.onUpdateMO(self, mo)
	self:refreshSelected()
end

function RoomOneKeyAddPopItem:refreshItemName()
	local itemName = ManufactureConfig.instance:getManufactureItemName(self.id)
	local nameArr = string.split(itemName, "*")

	self._txtneedMatproductionName.text = nameArr[1]
	self._txtnoMatproductionName.text = nameArr[1]
end

function RoomOneKeyAddPopItem:refreshItemNum()
	local strQuantity
	local selectedItem, count = OneKeyAddPopListModel.instance:getSelectedManufactureItem()
	local hasQuantity = ManufactureModel.instance:getManufactureItemCount(self.id)
	local isSelected = selectedItem == self.id

	if isSelected then
		local _, minUnitCount = ManufactureConfig.instance:getManufactureItemUnitCountRange(self.id)
		local addCount = minUnitCount * count

		strQuantity = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_manufacture_one_key_add_count"), hasQuantity, addCount)
	else
		strQuantity = formatLuaLang("materialtipview_itemquantity", hasQuantity)
	end

	self._txtneedMatnum.text = strQuantity
	self._txtnoMatnum.text = strQuantity
end

function RoomOneKeyAddPopItem:refreshTime()
	return
end

function RoomOneKeyAddPopItem:refreshSelected()
	local selectedItem = OneKeyAddPopListModel.instance:getSelectedManufactureItem()
	local isSelected = selectedItem == self.id

	self:refreshItemNum()
	gohelper.setActive(self.goselected1, isSelected)
	gohelper.setActive(self.goselected2, isSelected)
end

return RoomOneKeyAddPopItem
