-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyItemModel.lua

module("modules.logic.sp01.odyssey.model.OdysseyItemModel", package.seeall)

local OdysseyItemModel = class("OdysseyItemModel", BaseModel)

function OdysseyItemModel:onInit()
	self:reInit()
end

function OdysseyItemModel:reInit()
	self.itemMoMap = {}
	self.itemMoUidMap = {}
	self.itemMoList = {}
	self.itemSuitCountDic = {}
	self.taskItemCount = 0
	self.equipItemCount = 0
	self.reddotShowMap = {}
	self.hasClickItemMap = {}
	self.addOuterItemMap = {}
end

function OdysseyItemModel:updateBagInfo(bagInfo)
	self:updateItemInfo(bagInfo.items)
end

function OdysseyItemModel:updateItemInfo(itemInfoList, isPush)
	tabletool.clear(self.itemMoList)
	tabletool.clear(self.itemSuitCountDic)

	self.taskItemCount = 0
	self.equipItemCount = 0
	self.reddotShowMap = {}

	for index, itemInfo in ipairs(itemInfoList) do
		local itemMoList = self.itemMoMap[itemInfo.id]

		if not itemMoList then
			itemMoList = {}
			self.itemMoMap[itemInfo.id] = itemMoList
		end

		local itemMo = itemMoList[itemInfo.uid]

		if not itemMo then
			itemMo = OdysseyItemMo.New()

			itemMo:init(itemInfo.id)

			itemMoList[itemInfo.uid] = itemMo
			self.itemMoUidMap[itemInfo.uid] = itemMo
		end

		itemMo:updateInfo(itemInfo, isPush)

		if itemMo.config.type == OdysseyEnum.ItemType.Item then
			self.taskItemCount = self.taskItemCount + itemInfo.count
		elseif itemMo.config.type == OdysseyEnum.ItemType.Equip then
			self.equipItemCount = self.equipItemCount + itemInfo.count
		end

		table.insert(self.itemMoList, itemMo)

		local itemConfig = OdysseyConfig.instance:getItemConfig(itemInfo.id)

		self.itemSuitCountDic[itemConfig.suitId] = not self.itemSuitCountDic[itemConfig.suitId] and 1 or self.itemSuitCountDic[itemConfig.suitId] + 1

		self:buildReddotShowInfo(itemMo)
	end
end

function OdysseyItemModel:buildReddotShowInfo(itemMo)
	local reddotTypeMap = self.reddotShowMap[itemMo.config.type]

	reddotTypeMap = reddotTypeMap or {}
	reddotTypeMap[itemMo.uid] = itemMo:isNew() and itemMo or nil
	self.reddotShowMap[itemMo.config.type] = reddotTypeMap
end

function OdysseyItemModel:refreshItemInfo(itemInfoList)
	for index, itemInfo in ipairs(itemInfoList) do
		local itemMo = self.itemMoUidMap[itemInfo.uid]

		if itemMo then
			itemMo:updateInfo(itemInfo)
		end
	end

	for uid, itemMo in pairs(self.itemMoUidMap) do
		self:buildReddotShowInfo(itemMo)
	end
end

function OdysseyItemModel:getItemCount(itemId)
	local itemMoList = self.itemMoMap[itemId]

	if not itemMoList then
		return 0
	end

	local itemCount = 0

	for _, itemMo in pairs(itemMoList) do
		itemCount = itemCount + itemMo.count
	end

	return itemCount
end

function OdysseyItemModel:getItemMoUidMap()
	return self.itemMoUidMap
end

function OdysseyItemModel:getItemMoByUid(equipUid)
	return self.itemMoUidMap[equipUid]
end

function OdysseyItemModel:cleanAllAddCount()
	for uid, itemMo in pairs(self.itemMoUidMap) do
		itemMo:cleanAddCount()
	end

	self.addOuterItemMap = {}
end

function OdysseyItemModel:getItemMoList()
	return self.itemMoList
end

function OdysseyItemModel:haveSuitItem(suitId)
	return self.itemSuitCountDic[suitId] and self.itemSuitCountDic[suitId] > 0
end

function OdysseyItemModel:haveTaskItem()
	return self.taskItemCount and self.taskItemCount > 0
end

function OdysseyItemModel:haveEquipItem()
	return self.equipItemCount and self.equipItemCount > 0
end

function OdysseyItemModel:checkIsItemNewFlag(itemType)
	if itemType then
		local reddotTypeMap = self.reddotShowMap[itemType]

		if reddotTypeMap and next(reddotTypeMap) then
			return true, reddotTypeMap or {}
		end

		return false
	else
		for type = OdysseyEnum.ItemType.Item, OdysseyEnum.ItemType.Equip do
			local reddotTypeMap = self.reddotShowMap[type]

			if reddotTypeMap and next(reddotTypeMap) then
				return true, reddotTypeMap or {}
			end
		end
	end

	return false
end

function OdysseyItemModel:setHasClickItem(itemUid)
	self.hasClickItemMap[itemUid] = itemUid
end

function OdysseyItemModel:isHasClickItem(itemUid)
	return self.hasClickItemMap[itemUid]
end

function OdysseyItemModel:cleanHasClickItemState()
	self.hasClickItemMap = {}
end

function OdysseyItemModel:checkBagTagShowReddot(itemType)
	local equipReddotShow, reddotTypeMap = self:checkIsItemNewFlag(itemType)
	local canShowEquipReddot = equipReddotShow
	local isExitNotClickItem = false

	if equipReddotShow then
		for uid, itemMo in pairs(reddotTypeMap) do
			local isHasClickItem = self:isHasClickItem(uid)

			if not isHasClickItem then
				isExitNotClickItem = true

				break
			end
		end
	end

	return canShowEquipReddot and isExitNotClickItem
end

function OdysseyItemModel:getHasClickItemList()
	local itemUidList = {}

	for itemUid, _ in pairs(self.hasClickItemMap) do
		local itemMo = self:getItemMoByUid(itemUid)

		if itemMo:isNew() then
			table.insert(itemUidList, itemUid)
		end
	end

	return itemUidList
end

function OdysseyItemModel:setAddOuterItem(addItemList)
	self.addOuterItemMap = {}

	for index, itemData in ipairs(addItemList) do
		local itemMo = self.addOuterItemMap[itemData.materilId]

		if not itemMo then
			itemMo = OdysseyOuterItemMo.New()
			self.addOuterItemMap[itemData.materilId] = itemMo
		end

		itemMo:updateInfo(itemData)
	end
end

function OdysseyItemModel:getAddOuterItemList()
	local addOuterItemList = {}

	for itemUid, itemMo in pairs(self.addOuterItemMap) do
		if itemMo.addCount > 0 then
			table.insert(addOuterItemList, itemMo)
		end
	end

	return addOuterItemList
end

OdysseyItemModel.instance = OdysseyItemModel.New()

return OdysseyItemModel
