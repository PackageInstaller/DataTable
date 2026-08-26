-- chunkname: @modules/logic/survival/model/SurvivalBagMo.lua

module("modules.logic.survival.model.SurvivalBagMo", package.seeall)

local SurvivalBagMo = pureTable("SurvivalBagMo")

function SurvivalBagMo:init(data)
	self.bagType = data.bagType
	self.items = {}
	self.itemsByUid = self.itemsByUid or {}
	self.totalMass = 0
	self.currencysById = {}

	for _, v in ipairs(data.item) do
		if not self.itemsByUid[v.uid] then
			local itemMo = SurvivalBagItemMo.New()

			itemMo:init(v)

			itemMo.source = self.bagType

			if itemMo:isCurrency() then
				self.currencysById[itemMo.id] = itemMo
			else
				table.insert(self.items, itemMo)
			end

			self.totalMass = self.totalMass + itemMo:getMass()
		end
	end

	self.itemsByUid = {}

	for _, itemMo in ipairs(self.items) do
		self.itemsByUid[itemMo.uid] = itemMo
	end

	for _, itemMo in pairs(self.currencysById) do
		self.itemsByUid[itemMo.uid] = itemMo
	end
end

function SurvivalBagMo:addOrUpdateItems(items)
	for _, item in ipairs(items) do
		self:addOrUpdateItem(item)
	end
end

function SurvivalBagMo:removeItems(itemUids)
	for _, uid in ipairs(itemUids) do
		self:removeItemByUid(uid)
	end
end

function SurvivalBagMo:addOrUpdateItem(item)
	local itemMo = self.itemsByUid[item.uid]

	if itemMo then
		self.totalMass = self.totalMass - itemMo:getMass()

		itemMo:init(item)

		self.totalMass = self.totalMass + itemMo:getMass()
	else
		itemMo = SurvivalBagItemMo.New()

		itemMo:init(item)

		if itemMo:isCurrency() then
			if self.currencysById[itemMo.id] then
				logError(string.format("有2个相同货币的数据：[%s]:[%s]  [%s]:[%s]", self.currencysById[item.id].uid, self.currencysById[item.id].count, item.uid, item.count))
			end

			self.currencysById[itemMo.id] = itemMo
		else
			table.insert(self.items, itemMo)
		end

		self.itemsByUid[item.uid] = itemMo
		self.totalMass = self.totalMass + itemMo:getMass()
	end

	itemMo.source = self.bagType
end

function SurvivalBagMo:removeItemByUid(itemUid)
	local itemMo = self.itemsByUid[itemUid]

	if itemMo then
		self.totalMass = self.totalMass - itemMo:getMass()

		if itemMo:isCurrency() then
			self.currencysById[itemMo.id] = nil
		else
			tabletool.removeValue(self.items, itemMo)
		end

		self.itemsByUid[itemUid] = nil

		return
	else
		logError("删除道具失败，uid：" .. tostring(itemUid))
	end
end

function SurvivalBagMo:getMaxWeightLimit()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	return (weekMo:getDerivedAttrFinalValue(SurvivalEnum.DerivedAttr.Weight))
end

function SurvivalBagMo:getCurrencyNum(currencyId)
	local currencyMo = self.currencysById[currencyId]
	local shelterCurrenctCount = 0

	if self.bagType == SurvivalEnum.ItemSource.Map then
		shelterCurrenctCount = SurvivalShelterModel.instance:getWeekInfo():getBag(SurvivalEnum.ItemSource.Shelter):getCurrencyNum(currencyId)
	end

	return ((currencyMo or nil) and (currencyMo.count or 0)) + shelterCurrenctCount
end

function SurvivalBagMo:getItemCount(itemId)
	local count = 0

	for _, itemMo in ipairs(self.items) do
		if itemMo.id == itemId then
			count = count + itemMo.count
		end
	end

	return count
end

function SurvivalBagMo:getItemCountPlus(itemId)
	local itemCo = lua_survival_item.configDict[itemId]

	if not itemCo then
		return 0
	end

	if itemCo.type == SurvivalEnum.ItemType.Currency then
		return self:getCurrencyNum(itemId)
	end

	return self:getItemCount(itemId)
end

function SurvivalBagMo:getNPCCount()
	local count = 0

	for _, itemMo in ipairs(self.items) do
		if itemMo:isNPC() then
			count = count + itemMo.count
		end
	end

	return count
end

function SurvivalBagMo:costIsEnough(costStr, attrObj, attrType)
	if string.nilorempty(costStr) then
		return true
	end

	local costList = string.split(costStr, "#")
	local cost = string.splitToNumber(costList[2], ":")
	local itemId = cost[1]
	local itemCount = cost[2]

	if attrObj and attrType then
		itemCount = attrObj:getAttr(attrType, itemCount)
	end

	local curCount = self:getItemCountPlus(itemId)

	return itemCount <= curCount, itemId, itemCount, curCount
end

function SurvivalBagMo:getItemByUid(uid)
	return self.itemsByUid[uid]
end

function SurvivalBagMo:haveReputationItem()
	return #self:getReputationItem() > 0
end

function SurvivalBagMo:getReputationItem()
	local list = {}

	for _, itemMo in ipairs(self.items) do
		if itemMo:isReputationItem() then
			table.insert(list, itemMo)
		end
	end

	return list
end

return SurvivalBagMo
