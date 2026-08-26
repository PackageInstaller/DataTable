-- chunkname: @modules/logic/store/view/RoomStoreGoodsItem.lua

module("modules.logic.store.view.RoomStoreGoodsItem", package.seeall)

local RoomStoreGoodsItem = class("RoomStoreGoodsItem", NormalStoreGoodsItem)

function RoomStoreGoodsItem:onUpdateMO(mo)
	RoomStoreGoodsItem.super.onUpdateMO(self, mo)
end

function RoomStoreGoodsItem:refreshRare()
	local isShowRare = false
	local rect = {}

	rect.anchorX = -9.5
	rect.anchorY = -2
	rect.width = 354.5
	rect.height = 280

	if self._mo:getIsActGoods() then
		UISpriteSetMgr.instance:setStoreGoodsSprite(self._rare, FurnaceTreasureEnum.RareBgName)

		isShowRare = true
	elseif self.itemConfig then
		local subType = self.itemConfig.subType

		if subType == 23 then
			self:_setSpecialBg(rect)

			isShowRare = true
		else
			UISpriteSetMgr.instance:setStoreGoodsSprite(self._rare, "rare" .. self.itemConfig.rare)

			isShowRare = true
		end
	end

	recthelper.setAnchor(self._rare.transform, rect.anchorX, rect.anchorY)
	recthelper.setWidth(self._rare.transform, rect.width)
	recthelper.setHeight(self._rare.transform, rect.height)
	gohelper.setActive(self._rare.gameObject, isShowRare)
end

function RoomStoreGoodsItem:_setSpecialBg(rect)
	UISpriteSetMgr.instance:setRoomSprite(self._rare, "room_qualityframe_" .. self.itemConfig.rare)

	rect.anchorX = 4.5
	rect.anchorY = 29
	rect.width = 335
	rect.height = 310
end

return RoomStoreGoodsItem
