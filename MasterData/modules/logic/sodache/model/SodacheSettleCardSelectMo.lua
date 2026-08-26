-- chunkname: @modules/logic/sodache/model/SodacheSettleCardSelectMo.lua

module("modules.logic.sodache.model.SodacheSettleCardSelectMo", package.seeall)

local SodacheSettleCardSelectMo = pureTable("SodacheSettleCardSelectMo")

function SodacheSettleCardSelectMo:ctor()
	self.unSelectItemsDict = {}
	self.unSelectItems = {}
	self.selectItems = {}
	self.isUseCost = false
	self.selectCount = 0
	self.selectTotalCount = 0
	self.selectCost = 0
	self.selectTotalCost = 0
	self.isBatch = false
end

function SodacheSettleCardSelectMo:setCardCountOrCost(isUseCost, count)
	self.isUseCost = isUseCost

	if isUseCost then
		self.selectTotalCost = count
	else
		self.selectTotalCount = count
	end
end

function SodacheSettleCardSelectMo:addInitItem(itemId, count)
	if not self.unSelectItemsDict[itemId] then
		local cardMo = SodacheCardMo.Create(itemId, count)

		self.unSelectItemsDict[itemId] = cardMo

		table.insert(self.unSelectItems, cardMo)
	else
		self.unSelectItemsDict[itemId].serverMo.count = self.unSelectItemsDict[itemId].serverMo.count + count
	end
end

function SodacheSettleCardSelectMo:addSelectItem(itemId, count, isTips)
	count = math.min(count, self:getItemSelectMaxCount(itemId))

	if count <= 0 then
		if isTips then
			if self.isUseCost then
				GameFacade.showToast(ToastEnum.SodacheToastId373010)
			else
				GameFacade.showToast(ToastEnum.SodacheToastId373011)
			end
		end

		return false
	end

	local cardMo = self.unSelectItemsDict[itemId]

	cardMo.serverMo.count = cardMo.serverMo.count - count
	self.selectCount = self.selectCount + count
	self.selectCost = self.selectCost + count * cardMo.serverMo.itemCo.cost

	if cardMo.serverMo.count <= 0 then
		tabletool.removeValue(self.unSelectItems, cardMo)
	end

	local isFind = false

	for i, v in ipairs(self.selectItems) do
		if v.serverMo.configId == itemId then
			isFind = true
			v.serverMo.count = v.serverMo.count + count

			break
		end
	end

	if not isFind then
		table.insert(self.selectItems, SodacheCardMo.Create(itemId, count))
	end

	return true
end

function SodacheSettleCardSelectMo:addUnselectItem(itemId, count)
	local cardMo = self.unSelectItemsDict[itemId]

	if cardMo.serverMo.count == 0 and count > 0 then
		table.insert(self.unSelectItems, cardMo)
	end

	cardMo.serverMo.count = cardMo.serverMo.count + count
	self.selectCount = self.selectCount - count
	self.selectCost = self.selectCost - count * cardMo.serverMo.itemCo.cost

	for i, v in ipairs(self.selectItems) do
		if v.serverMo.configId == itemId then
			v.serverMo.count = v.serverMo.count - count

			if v.serverMo.count <= 0 then
				table.remove(self.selectItems, i)
			end

			break
		end
	end
end

function SodacheSettleCardSelectMo:getItemSelectMaxCount(itemId)
	local cardMo = self.unSelectItemsDict[itemId]
	local count = cardMo.serverMo.count

	count = self.isUseCost and math.min(count, math.floor((self.selectTotalCost - self.selectCost) / cardMo.serverMo.itemCo.cost)) or math.min(count, self.selectTotalCount - self.selectCount)

	return count
end

function SodacheSettleCardSelectMo:fastSelectItems()
	self.tempFastItem = GameUtil.copyArray(self.unSelectItems)

	table.sort(self.tempFastItem, SodacheSettleCardSelectMo.sortItem)
	self:fastSelectAltar()

	self.tempFastItem = GameUtil.copyArray(self.unSelectItems)

	table.sort(self.tempFastItem, SodacheSettleCardSelectMo.sortItem)
	self:fastSelectOther()

	self.tempFastItem = nil
end

function SodacheSettleCardSelectMo.sortItem(a, b)
	if a.serverMo.itemCo.quality ~= b.serverMo.itemCo.quality then
		return a.serverMo.itemCo.quality > b.serverMo.itemCo.quality
	end

	local priceA = SodacheConfig.instance:getItemPrice(a.serverMo.configId)
	local priceB = SodacheConfig.instance:getItemPrice(b.serverMo.configId)

	if priceA ~= priceB then
		return priceB < priceA
	end

	if a.serverMo.itemCo.type ~= b.serverMo.itemCo.type then
		return a.serverMo.itemCo.type > b.serverMo.itemCo.type
	end

	if a.serverMo.itemCo.cost ~= b.serverMo.itemCo.cost then
		return a.serverMo.itemCo.cost > b.serverMo.itemCo.cost
	end

	return a.serverMo.configId < b.serverMo.configId
end

function SodacheSettleCardSelectMo:fastSelectAltar()
	local selectCountMap = {}

	for i, v in ipairs(self.selectItems) do
		selectCountMap[v.serverMo.configId] = v.serverMo.count
	end

	local isSelect = true
	local relicBox = SodacheModel.instance:getOutsideMo().relicBox

	while isSelect do
		isSelect = false

		for i, v in ipairs(self.tempFastItem) do
			if v.serverMo.itemCo.type == SodacheEnum.CardType.Offering then
				local needCount = relicBox:getRelicNeedCount(v.serverMo.configId) - ((not selectCountMap[v.serverMo.configId] or nil) and 0)

				if needCount > 0 then
					selectCountMap[v.serverMo.configId] = (selectCountMap[v.serverMo.configId] or 0) + needCount
					isSelect = self:addSelectItem(v.serverMo.configId, needCount)

					break
				end
			end
		end
	end
end

function SodacheSettleCardSelectMo:fastSelectOther()
	for i, v in ipairs(self.tempFastItem) do
		self:addSelectItem(v.serverMo.configId, v.serverMo.count)
	end
end

return SodacheSettleCardSelectMo
