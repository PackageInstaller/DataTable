-- chunkname: @modules/logic/activitywelfare/subview/DestinyStoneGiftPickChoiceListItem.lua

module("modules.logic.activitywelfare.subview.DestinyStoneGiftPickChoiceListItem", package.seeall)

local DestinyStoneGiftPickChoiceListItem = class("DestinyStoneGiftPickChoiceListItem", LuaCompBase)

function DestinyStoneGiftPickChoiceListItem:init(go, type, itemId)
	self.go = go
	self.type = type
	self.itemId = itemId
	self._gotitle = gohelper.findChild(self.go, "go_title")
	self._gostones = gohelper.findChild(self.go, "go_stones")
	self._gostoneitem = gohelper.findChild(self.go, "go_stones/stoneitem")
	self._goempty = gohelper.findChild(self.go, "go_empty")

	self:_initItem()
	self:_addEvents()
end

function DestinyStoneGiftPickChoiceListItem:_initItem()
	self._stoneItems = self:getUserDataTb_()
end

function DestinyStoneGiftPickChoiceListItem:_addEvents()
	return
end

function DestinyStoneGiftPickChoiceListItem:_removeEvents()
	return
end

function DestinyStoneGiftPickChoiceListItem:refresh()
	self:_refreshItem()
	self:_refreshStoneItems()
end

function DestinyStoneGiftPickChoiceListItem:_refreshItem()
	return
end

function DestinyStoneGiftPickChoiceListItem:_refreshStoneItems()
	local stoneList = DestinyStoneGiftPickChoiceModel.instance:getStoneListByType(self.type, self.itemId)

	gohelper.setActive(self._goempty, #stoneList == 0)
	gohelper.setActive(self._gostones, #stoneList > 0)

	if #stoneList > 0 then
		for index, stoneMo in ipairs(stoneList) do
			if not self._stoneItems[index] then
				self._stoneItems[index] = DestinyStoneGiftPickChoiceStoneItem.New()

				local go = gohelper.cloneInPlace(self._gostoneitem)

				gohelper.setActive(go, true)
				self._stoneItems[index]:init(go, self.type, self.itemId)
			end

			self._stoneItems[index]:refresh(stoneMo)
		end
	end
end

function DestinyStoneGiftPickChoiceListItem:destroy()
	self:_removeEvents()

	if self._stoneItems then
		for i, stoneItem in ipairs(self._stoneItems) do
			stoneItem:destroy()
		end

		self._stoneItems = nil
	end
end

return DestinyStoneGiftPickChoiceListItem
