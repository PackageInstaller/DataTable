-- chunkname: @modules/logic/backpack/model/ItemExpireModel.lua

module("modules.logic.backpack.model.ItemExpireModel", package.seeall)

local ItemExpireModel = class("ItemExpireModel", BaseModel)

function ItemExpireModel:onInit()
	self:reInit()
end

function ItemExpireModel:reInit()
	self._expireItemList = {}
	self._latestPushItemUids = {}
end

function ItemExpireModel:getExpireItem(uid)
	return self._expireItemList[tonumber(uid)]
end

function ItemExpireModel:getExpireItemList()
	return self._expireItemList
end

function ItemExpireModel:setExpireItemList(expireList)
	self._expireItemList = {}

	for _, v in ipairs(expireList) do
		local itemMo = ItemExpireMo.New()

		itemMo:init(v)

		self._expireItemList[tonumber(v.uid)] = itemMo
	end
end

function ItemExpireModel:changeExpireItemList(expireList)
	for _, v in ipairs(expireList) do
		local uid = tonumber(v.uid)
		local o = {}

		o.itemid = v.itemId
		o.uid = uid

		table.insert(self._latestPushItemUids, o)

		if not self._expireItemList[uid] then
			local itemMo = ItemExpireMo.New()

			itemMo:init(v)

			self._expireItemList[uid] = itemMo
		else
			self._expireItemList[uid]:reset(v)
		end
	end
end

function ItemExpireModel:getLatestExpireItemChange()
	return self._latestPushItemUids
end

function ItemExpireModel:getExpireItemCount(uid)
	if not self._expireItemList[uid] then
		return 0
	end

	if self._expireItemList[uid].expireTime <= ServerTime.now() then
		return 0
	end

	return self._expireItemList[uid].quantity
end

function ItemExpireModel:getExpireItemCountById(id)
	local count = 0
	local now = ServerTime.now()

	for _, itemMO in pairs(self._expireItemList) do
		if itemMO.expireId == id and self._expireItemList[itemMO.uid].expireTime > ServerTime.now() then
			count = count + itemMO.quantity
		end
	end

	return count
end

function ItemExpireModel:getExpireItemDeadline(uid)
	return self._expireItemList[uid] and tonumber(self._expireItemList[uid].expireTime) or 0
end

function ItemExpireModel:getExpireItemCoByUid(uid)
	return self._expireItemList[uid] and ItemConfig.instance:getExpireItemCo(self._expireItemList[uid].id) or nil
end

function ItemExpireModel:getEarliestExpireExpireItem(expireId)
	local tempExpireItem
	local now = ServerTime.now()

	for _, expireMo in pairs(self._expireItemList) do
		if expireMo.expireId == expireId and expireMo.quantity > 0 and expireMo.expireTime ~= 0 and now < expireMo.expireTime then
			if tempExpireItem then
				if tempExpireItem.expireTime > expireMo.expireTime then
					tempExpireItem = expireMo
				end
			else
				tempExpireItem = expireMo
			end
		end
	end

	return tempExpireItem
end

function ItemExpireModel:getSpecialExpireItemEarliestExpireTime(itemId)
	local expireTime = 0
	local expireitemlist = ItemExpireModel.instance:getExpireItemList() or {}

	for _, expireitem in pairs(expireitemlist) do
		if expireitem.expireId == itemId then
			local config = ItemConfig.instance:getItemSpecialExpiredItemCo(expireitem.expireId)

			if config.expireType ~= 0 and ItemExpireModel.instance:getExpireItemCount(expireitem.uid) > 0 then
				local time = ItemExpireModel.instance:getExpireItemDeadline(expireitem.uid)

				if not expireTime or expireTime == 0 or time < expireTime then
					expireTime = time
				end
			end
		end
	end

	return expireTime
end

ItemExpireModel.instance = ItemExpireModel.New()

return ItemExpireModel
