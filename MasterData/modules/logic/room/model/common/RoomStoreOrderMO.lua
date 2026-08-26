-- chunkname: @modules/logic/room/model/common/RoomStoreOrderMO.lua

module("modules.logic.room.model.common.RoomStoreOrderMO", package.seeall)

local RoomStoreOrderMO = pureTable("RoomStoreOrderMO")

function RoomStoreOrderMO:ctor()
	self._materialDateMOList = {}
	self._poolList = {}
end

function RoomStoreOrderMO:init(_goodsId, themeId)
	self.id = _goodsId
	self.goodsId = _goodsId
	self.themeId = themeId

	self:clear()
end

function RoomStoreOrderMO:addValue(materialType, itemId, num)
	local mo = self:getMaterialDateMO(materialType, itemId)

	if not mo then
		mo = self:_popMaterialDateMO() or MaterialDataMO.New()

		mo:initValue(materialType, itemId, num)

		mo.tempCount = 0

		table.insert(self._materialDateMOList, mo)
	else
		mo.quantity = mo.quantity + num
	end
end

function RoomStoreOrderMO:getMaterialDateMO(materialType, itemId)
	local list = self._materialDateMOList

	for i = 1, #list do
		local mo = list[i]

		if mo.materilId == itemId and mo.materilType == materialType then
			return mo
		end
	end

	return nil
end

function RoomStoreOrderMO:isSameValue(materialDataMOList)
	self:_resetListTempCountValue()

	local flag = true

	for i = 1, #materialDataMOList do
		local tMO = materialDataMOList[i]
		local mMO = self:getMaterialDateMO(tMO.materilType, tMO.materilId)

		if mMO then
			mMO.tempCount = mMO.tempCount + tMO.quantity
		else
			flag = false

			break
		end
	end

	if flag then
		local list = self._materialDateMOList

		for i = 1, #list do
			local mo = list[i]

			if mo.quantity ~= mo.tempCount then
				flag = false

				break
			end
		end
	end

	self:_resetListTempCountValue()

	return flag
end

function RoomStoreOrderMO:_resetListTempCountValue()
	local list = self._materialDateMOList

	for i = 1, #list do
		list[i].tempCount = 0
	end
end

function RoomStoreOrderMO:_popMaterialDateMO()
	local count = #self._poolList

	if count > 0 then
		local mo = self._poolList[count]

		mo.quantity = 0
		mo.tempCount = 0

		table.remove(self._poolList, count)

		return mo
	end
end

function RoomStoreOrderMO:clear()
	if #self._materialDateMOList > 0 then
		tabletool.addArray(self._poolList, self._materialDateMOList)

		self._materialDateMOList = {}
	end
end

return RoomStoreOrderMO
