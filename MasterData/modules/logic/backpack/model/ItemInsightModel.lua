-- chunkname: @modules/logic/backpack/model/ItemInsightModel.lua

module("modules.logic.backpack.model.ItemInsightModel", package.seeall)

local ItemInsightModel = class("ItemInsightModel", BaseModel)

function ItemInsightModel:onInit()
	self:reInit()
end

function ItemInsightModel:reInit()
	self._insightItemList = {}
	self._latestPushItemUids = {}
end

function ItemInsightModel:getInsightItem(uid)
	return self._insightItemList[tonumber(uid)]
end

function ItemInsightModel:getInsightItemList()
	return self._insightItemList
end

function ItemInsightModel:setInsightItemList(insightList)
	self._insightItemList = {}

	for _, v in ipairs(insightList) do
		local itemMo = ItemInsightMo.New()

		itemMo:init(v)

		self._insightItemList[tonumber(v.uid)] = itemMo
	end
end

function ItemInsightModel:changeInsightItemList(insightList)
	for _, v in ipairs(insightList) do
		local uid = tonumber(v.uid)
		local o = {}

		o.itemid = v.itemId
		o.uid = uid

		table.insert(self._latestPushItemUids, o)

		if not self._insightItemList[uid] then
			local itemMo = ItemInsightMo.New()

			itemMo:init(v)

			self._insightItemList[uid] = itemMo
		else
			self._insightItemList[uid]:reset(v)
		end
	end
end

function ItemInsightModel:getLatestInsightChange()
	return self._latestPushItemUids
end

function ItemInsightModel:getInsightItemCount(uid)
	if not self._insightItemList[uid] then
		return 0
	end

	if self._insightItemList[uid].expireTime <= ServerTime.now() then
		return 0
	end

	return self._insightItemList[uid].quantity
end

function ItemInsightModel:getInsightItemCountById(id)
	local count = 0
	local now = ServerTime.now()

	for _, itemMO in pairs(self._insightItemList) do
		if itemMO.insightId == id and self._insightItemList[itemMO.uid].expireTime > ServerTime.now() then
			count = count + itemMO.quantity
		end
	end

	return count
end

function ItemInsightModel:getInsightItemDeadline(uid)
	return self._insightItemList[uid] and tonumber(self._insightItemList[uid].expireTime) or 0
end

function ItemInsightModel:getInsightItemCoByUid(uid)
	return self._insightItemList[uid] and ItemConfig.instance:getInsightItemCo(self._insightItemList[uid].id) or nil
end

function ItemInsightModel:getEarliestExpireInsight(insightId)
	local tempInsight
	local now = ServerTime.now()

	for _, insightMo in pairs(self._insightItemList) do
		if insightMo.insightId == insightId and insightMo.quantity > 0 and insightMo.expireTime ~= 0 and now < insightMo.expireTime then
			if tempInsight then
				if tempInsight.expireTime > insightMo.expireTime then
					tempInsight = insightMo
				end
			else
				tempInsight = insightMo
			end
		end
	end

	return tempInsight
end

ItemInsightModel.instance = ItemInsightModel.New()

return ItemInsightModel
