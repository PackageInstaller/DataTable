-- chunkname: @modules/logic/room/model/common/RoomStoreOrderModel.lua

module("modules.logic.room.model.common.RoomStoreOrderModel", package.seeall)

local RoomStoreOrderModel = class("RoomStoreOrderModel", BaseModel)

function RoomStoreOrderModel:getMOByList(materialDataMOList)
	if materialDataMOList and #materialDataMOList > 0 then
		local list = self:getList()

		for i = 1, #list do
			local mo = list[i]

			if mo:isSameValue(materialDataMOList) then
				return mo
			end
		end
	end

	return nil
end

function RoomStoreOrderModel:addByStoreItemMOList(storeItemMOList, goodsId, themeId)
	local orderMO = self:getById(goodsId)

	if not orderMO then
		orderMO = RoomStoreOrderMO.New()

		self:addAtLast(orderMO)
	end

	orderMO:init(goodsId, themeId)

	for i = 1, #storeItemMOList do
		local stroeItemMO = storeItemMOList[i]
		local canBuyNum = stroeItemMO:getCanBuyNum()

		if canBuyNum > 0 then
			orderMO:addValue(stroeItemMO.materialType, stroeItemMO.itemId, canBuyNum)
		end
	end

	return orderMO
end

RoomStoreOrderModel.instance = RoomStoreOrderModel.New()

return RoomStoreOrderModel
