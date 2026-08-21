-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gainitem/model/GainItemsData.lua

module("logic.extensions.gainitem.model.GainItemsData", package.seeall)

local M = class("GainItemsData")

function M:ctor(ItemChangedPush)
	self.originPushInfo = ItemChangedPush
	self.actualAddItems = {}
	self.mailAddItems = {}
	self.showItems = {}
	self.composeUseItems = {}
	self.addItemsBeforeConvert = {}
	self.firstRepeatUseItems = {}
	self.repeatAddItems = {}
	self.heroIdsAddBeforeConvert = {}
	self.heroRepeatUsed = {}
	self.heroRepeatAddItems = {}
	self.addItemsWithoutHeroBeforeConvert = {}
	self.isHasPlayerAttr = false

	self:parseItemPush(ItemChangedPush)
end

function M:parseItemPush(ItemChangedPush)
	self._convertLimit = ConstConfig.instance:getNumValueByKey("ItemLimitPerAdd")

	local itemComposeSource = ItemChangedPush.source

	if itemComposeSource and #itemComposeSource > 0 then
		for _, ItemNO in ipairs(itemComposeSource) do
			local itemData = ItemUtil.createItemData(ItemNO)

			itemData:setItemMarkType(EventType.ITEM_NORMAL_MARK_TYPE)
			table.insert(self.composeUseItems, itemData)
		end
	end

	local itemChangeResult = ItemChangedPush.result

	if itemChangeResult and #itemChangeResult > 0 then
		for _, ItemResult in ipairs(itemChangeResult) do
			self:_parseOneItemGainResult(ItemResult, true)
		end
	end

	self:removePlayerAttrItems()
end

function M:_parseOneItemGainResult(ItemResult, isFirst, convertSource)
	if ItemResult.convert and #ItemResult.convert > 0 then
		if #ItemResult.convert > self._convertLimit then
			printWarn("物品转换超过限制，需检查物品来源是否合法")

			return
		end

		local itemData = ItemUtil.createItemData(ItemResult.item)

		if isFirst then
			itemData:setItemMarkType(EventType.ITEM_NORMAL_MARK_TYPE)
			table.insert(self.firstRepeatUseItems, itemData)
			table.insert(self.addItemsBeforeConvert, itemData)

			if itemData:getType() == GameEnum.ItemTypeEnum.HeroType then
				table.insert(self.heroRepeatUsed, itemData)
				table.insert(self.heroIdsAddBeforeConvert, itemData:getItemId())
			else
				table.insert(self.addItemsWithoutHeroBeforeConvert, itemData)
			end
		end

		for _, v in ipairs(ItemResult.convert) do
			self:_parseOneItemGainResult(v, false, itemData)
		end

		return
	end

	local ItemNO = ItemResult.item
	local itemData

	if tonumber(ItemNO.uuid) > 0 and ItemUtil.isEquipEchoOrD6ByItemId(ItemNO.itemId) then
		itemData = ItemModel.instance:getItemDataByUuid(ItemNO.uuid)
	end

	itemData = itemData or ItemUtil.createItemData(ItemNO)

	itemData:setItemMarkType(EventType.ITEM_NORMAL_MARK_TYPE)

	if ItemResult.mail then
		table.insert(self.mailAddItems, itemData)
	else
		table.insert(self.actualAddItems, itemData)
	end

	table.insert(self.showItems, itemData)

	local isHero = itemData:getType() == GameEnum.ItemTypeEnum.HeroType

	if isHero then
		table.insert(self.heroIdsAddBeforeConvert, itemData:getItemId())
	end

	if isFirst then
		table.insert(self.addItemsBeforeConvert, itemData)

		if not isHero then
			table.insert(self.addItemsWithoutHeroBeforeConvert, itemData)
		end
	end

	if convertSource then
		table.insert(self.repeatAddItems, itemData)

		if convertSource:getType() == GameEnum.ItemTypeEnum.HeroType then
			table.insert(self.heroRepeatAddItems, itemData)
		end
	end
end

function M:removePlayerAttrItems()
	local removeId = GameEnum.CurrencyCodeEnum.AttributePoint

	self:removeDisapperaItems(removeId)
end

function M:removeDisapperaItems(removeId)
	if #self.actualAddItems > 0 then
		self.isHasPlayerAttr = TableUtil.removeByFun(self.actualAddItems, removeId, function(item, removeIdP)
			return item:getItemId() == removeIdP
		end, true)

		if self.isHasPlayerAttr then
			TableUtil.removeByFun(self.addItemsBeforeConvert, removeId, function(item, removeIdP)
				return item:getItemId() == removeIdP
			end, true)
			TableUtil.removeByFun(self.addItemsWithoutHeroBeforeConvert, removeId, function(item, removeIdP)
				return item:getItemId() == removeIdP
			end, true)
			TableUtil.removeByFun(self.showItems, removeId, function(item, removeIdP)
				return item:getItemId() == removeIdP
			end, true)
		end
	end
end

function M:add(gainItemsData)
	self:_count(self.actualAddItems, gainItemsData.actualAddItems)
	self:_count(self.mailAddItems, gainItemsData.mailAddItems)
	self:_count(self.showItems, gainItemsData.showItems)
	self:_count(self.composeUseItems, gainItemsData.composeUseItems)
	self:_count(self.addItemsBeforeConvert, gainItemsData.addItemsBeforeConvert)
	self:_count(self.firstRepeatUseItems, gainItemsData.firstRepeatUseItems)
	self:_count(self.repeatAddItems, gainItemsData.repeatAddItems)
	self:_count(self.heroRepeatUsed, gainItemsData.heroRepeatUsed)
	self:_count(self.heroRepeatAddItems, gainItemsData.heroRepeatAddItems)
	self:_count(self.addItemsWithoutHeroBeforeConvert, gainItemsData.addItemsWithoutHeroBeforeConvert)
	table.merge(self.heroIdsAddBeforeConvert, gainItemsData.heroIdsAddBeforeConvert)

	self.isHasPlayerAttr = self.isHasPlayerAttr or gainItemsData.isHasPlayerAttr

	return self
end

function M:_isItemCache(itemDataList, code)
	for _, itemData in ipairs(itemDataList) do
		if itemData:getItemId() == code then
			return itemData
		end
	end

	return false
end

function M:_count(targetItems, addItems)
	for _, itemData in ipairs(addItems) do
		local targetItem = self:_isItemCache(targetItems, itemData.code)

		if targetItem then
			local count = targetItem:getCount() + itemData:getCount()

			targetItem:setCount(count)
		else
			table.insert(targetItems, itemData)
		end
	end
end

return M
