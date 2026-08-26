-- chunkname: @modules/logic/rouge/model/RougeCollectionModel.lua

module("modules.logic.rouge.model.RougeCollectionModel", package.seeall)

local RougeCollectionModel = class("RougeCollectionModel", BaseModel)

function RougeCollectionModel:ctor()
	self:init()
end

function RougeCollectionModel:init()
	self._slotCellStateMap = {}
	self._collectionPlaceMap = {}
	self._collectionIdMap = {}
	self._collectionRareMap = {}
	self._enchants = {}
	self._curSlotAreaSize = nil
	self._slotCollections = BaseModel.New()
	self._bagCollections = BaseModel.New()
	self._allCollections = BaseModel.New()
	self._effectTriggerTab = {}
	self._tempCollectionAttrMap = nil
end

function RougeCollectionModel:getAllCollections()
	return self._allCollections:getList()
end

function RougeCollectionModel:getAllCollectionCount()
	return self._allCollections:getCount()
end

function RougeCollectionModel:onReceiveNewInfo2Slot(serverMsg, reason)
	if not serverMsg then
		return
	end

	local collectionIds = {}

	for _, info in ipairs(serverMsg) do
		local collectionMO = RougeCollectionHelper.buildNewCollectionSlotMO(info)

		table.insert(collectionIds, collectionMO.id)
		self:tryAddCollection2SlotArea(collectionMO)
	end

	local isNewGetCollection = RougeCollectionHelper.isNewGetCollection(reason)

	if isNewGetCollection then
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.GetNewCollections, collectionIds, reason, RougeEnum.CollectionPlaceArea.SlotArea)
	end
end

function RougeCollectionModel:tryAddCollection2SlotArea(collectionMO)
	if not collectionMO then
		return
	end

	local collectionId = collectionMO.id
	local exitSameMO = self._slotCollections:getById(collectionId)

	if exitSameMO then
		self:tryRemoveSlotCollection(collectionId)
	end

	self._slotCollections:addAtLast(collectionMO)
	self._allCollections:addAtLast(collectionMO)
	self:markCollection2IdMap(collectionMO)
	self:markCollection2RareMap(collectionMO)
	self:markCollectionSlotArea(collectionMO)
	self:tryMarkCollection2EnchantList(collectionMO)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.PlaceCollection2SlotArea, collectionMO)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionAttr, collectionId)
end

function RougeCollectionModel:tryMarkCollection2EnchantList(collectionMO)
	if not collectionMO then
		return
	end

	local collectionCfgId = collectionMO.cfgId
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

	if not collectionCfg then
		return
	end

	local isEnchant = collectionCfg.type == RougeEnum.CollectionType.Enchant

	if isEnchant then
		table.insert(self._enchants, collectionMO)
	end
end

function RougeCollectionModel:tryRemoveCollectionEnchantList(collectionId)
	if not self._enchants then
		return
	end

	for i = #self._enchants, 1, -1 do
		if self._enchants[i] and self._enchants[i].id == collectionId then
			self._enchants[i] = nil

			return
		end
	end
end

function RougeCollectionModel:markCollection2IdMap(collectionMO)
	if not collectionMO then
		return
	end

	local collectionCfgId = collectionMO.cfgId

	self._collectionIdMap[collectionCfgId] = self._collectionIdMap[collectionCfgId] or {}

	table.insert(self._collectionIdMap[collectionCfgId], collectionMO)
end

function RougeCollectionModel:removeCollectionIdMap(collectionId, collectionCfgId)
	local mos = self._collectionIdMap[collectionCfgId]

	if not mos then
		return
	end

	for index, mo in pairs(mos) do
		if mo.id == collectionId then
			table.remove(mos, index)

			return
		end
	end
end

function RougeCollectionModel:markCollection2RareMap(collectionMO)
	if not collectionMO then
		return
	end

	local collectionCfgId = collectionMO.cfgId
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

	if collectionCfg then
		if not collectionCfg.showRare then
			local showRare = 0

			self._collectionRareMap[showRare] = self._collectionRareMap[showRare] or {}

			local collectionId = collectionMO.id

			self._collectionRareMap[showRare][collectionId] = collectionMO
		end
	end
end

function RougeCollectionModel:removeCollectionRareMap(collectionId, collectionCfgId)
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

	if collectionCfg then
		if not collectionCfg.showRare then
			local showRare = 0
			local mos = self._collectionRareMap[showRare]

			if not mos then
				return
			end

			self._collectionRareMap[showRare][collectionId] = nil
		end
	end
end

function RougeCollectionModel:getCollectionRareMap()
	return self._collectionRareMap
end

function RougeCollectionModel:markCollectionSlotArea(collectionMO)
	if not collectionMO then
		return
	end

	local leftTopPos = collectionMO:getLeftTopPos()
	local rotation = collectionMO:getRotation()
	local collectionId = collectionMO.id
	local shapeMatrix = RougeCollectionConfig.instance:getShapeMatrix(collectionMO.cfgId, rotation)

	if shapeMatrix then
		for row, rows in ipairs(shapeMatrix) do
			for col, isExist in ipairs(rows) do
				if isExist and isExist > 0 then
					local posX = leftTopPos.x + col - 1
					local posY = leftTopPos.y + row - 1

					self:markCollectionSlotCellState(collectionId, posX, posY, true)
				end
			end
		end
	end
end

function RougeCollectionModel:markCollectionSlotCellState(collectionId, posX, posY, isPlaced)
	self._slotCellStateMap = self._slotCellStateMap or {}
	self._slotCellStateMap[posX] = self._slotCellStateMap[posX] or {}

	local curPlaceCollectionId = self._slotCellStateMap[posX][posY]

	if curPlaceCollectionId and curPlaceCollectionId > 0 and curPlaceCollectionId ~= collectionId then
		return
	end

	self._slotCellStateMap[posX][posY] = isPlaced and collectionId or 0
	self._collectionPlaceMap[collectionId] = self._collectionPlaceMap[collectionId] or {}
	self._collectionPlaceMap[collectionId][posX] = self._collectionPlaceMap[collectionId][posX] or {}
	self._collectionPlaceMap[collectionId][posX][posY] = isPlaced
end

function RougeCollectionModel:tryRemoveSlotCollection(collectionId)
	local collectionMO = self._slotCollections:getById(collectionId)

	if not collectionMO then
		return
	end

	self._slotCollections:remove(collectionMO)
	self._allCollections:remove(collectionMO)
	self:removeCollectionIdMap(collectionMO.id, collectionMO.cfgId)
	self:removeCollectionRareMap(collectionMO.id, collectionMO.cfgId)
	self:tryRemoveCollectionEnchantList(collectionMO.id)
	self:releasePlaceCellState(collectionId)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.DeleteSlotCollection, collectionId)
end

function RougeCollectionModel:onReceiveNewInfo2Bag(serverMsg, reason)
	if not serverMsg then
		return
	end

	local collectionIds = {}

	for _, info in ipairs(serverMsg) do
		local collectionMO = RougeCollectionHelper.buildNewBagCollectionMO(info)

		table.insert(collectionIds, collectionMO.id)
		self:tryAddCollection2BagArea(collectionMO)
	end

	local isNewGetCollection = RougeCollectionHelper.isNewGetCollection(reason)

	if isNewGetCollection then
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.GetNewCollections, collectionIds, reason, RougeEnum.CollectionPlaceArea.BagArea)
	end
end

function RougeCollectionModel:tryAddCollection2BagArea(collectionMO)
	if not collectionMO then
		return
	end

	local collectionId = collectionMO.id

	self:tryRemoveBagCollection(collectionId)
	self._bagCollections:addAtLast(collectionMO)
	self._allCollections:addAtLast(collectionMO)
	self:markCollection2IdMap(collectionMO)
	self:markCollection2RareMap(collectionMO)
	self:tryMarkCollection2EnchantList(collectionMO)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionBag)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionAttr, collectionId)
end

function RougeCollectionModel:tryRemoveBagCollection(collectionId)
	local collectionMO = self._allCollections:getById(collectionId)

	if not collectionMO then
		return
	end

	local isCollectionInSlot = self:isCollectionPlaceInSlotArea(collectionId)

	if isCollectionInSlot then
		self:tryRemoveSlotCollection(collectionId)
	else
		self._bagCollections:remove(collectionMO)
	end

	self._allCollections:remove(collectionMO)
	self:tryRemoveCollectionEnchantList(collectionMO.id)
	self:removeCollectionIdMap(collectionMO.id, collectionMO.cfgId)
	self:removeCollectionRareMap(collectionMO.id, collectionMO.cfgId)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionBag)
end

function RougeCollectionModel:isSlotHasFilled(slotPosX, slotPosY)
	local filledCollectionId = self:getSlotFilledCollectionId(slotPosX, slotPosY)

	return filledCollectionId and filledCollectionId > 0
end

function RougeCollectionModel:getSlotFilledCollectionId(slotPosX, slotPosY)
	if self._slotCellStateMap then
		return (self._slotCellStateMap and self._slotCellStateMap[slotPosY] or nil) and (self._slotCellStateMap[slotPosY] or 0) or 0
	end
end

function RougeCollectionModel:getCollectionByUid(uid)
	return (self._allCollections:getById(uid))
end

function RougeCollectionModel:getEnchants()
	return self._enchants
end

function RougeCollectionModel:getSlotAreaCollection()
	return self._slotCollections:getList()
end

function RougeCollectionModel:getBagAreaCollection()
	return self._bagCollections:getList()
end

function RougeCollectionModel:getBagAreaCollectionCount()
	if self._bagCollections then
		return self._bagCollections:getCount()
	end

	return 0
end

function RougeCollectionModel:getSlotAreaCollectionCount()
	if self._slotCollections then
		return self._slotCollections:getCount()
	end

	return 0
end

function RougeCollectionModel:releasePlaceCellState(collectionId)
	if self._collectionPlaceMap[collectionId] then
		for slotPosX, slotPosYs in pairs(self._collectionPlaceMap[collectionId]) do
			for slotPosY, isPlace in pairs(slotPosYs) do
				self:markCollectionSlotCellState(collectionId, slotPosX, slotPosY, false)
			end
		end
	end
end

function RougeCollectionModel:getCollectionCountById(collectionCfgId)
	if self._collectionIdMap then
		return self._collectionIdMap and tabletool.len(self._collectionIdMap) or 0
	end
end

function RougeCollectionModel:getCollectionByCfgId(collectionCfgId)
	return self._collectionIdMap and self._collectionIdMap[collectionCfgId]
end

function RougeCollectionModel:rougeInlay(enchantCollectionInfo, preCollectionInfo, reason)
	if not enchantCollectionInfo then
		return
	end

	local collectionId = tonumber(enchantCollectionInfo.id)
	local originEnchantCollection = self:getCollectionByUid(collectionId)

	originEnchantCollection:updateInfo(enchantCollectionInfo)

	local preCollectionId = tonumber(preCollectionInfo.id)

	if preCollectionId > 0 then
		local originPreCollection = self:getCollectionByUid(preCollectionId)

		originPreCollection:updateInfo(preCollectionInfo)
	end

	RougeCollectionEnchantController.instance:onRougeInlayInfoUpdate(collectionId, preCollectionId)
end

function RougeCollectionModel:rougeDemount(collectionInfo, reason)
	if not collectionInfo then
		return
	end

	local collectionId = tonumber(collectionInfo.id)
	local originEnchantCollection = self:getCollectionByUid(collectionId)

	originEnchantCollection:updateInfo(collectionInfo)
	RougeCollectionEnchantController.instance:onRougeInlayInfoUpdate(collectionId)
end

function RougeCollectionModel:deleteSomeCollectionFromWarehouse(collectionIds)
	if not collectionIds then
		return
	end

	for _, collectioId in ipairs(collectionIds) do
		collectioId = tonumber(collectioId)

		self:tryRemoveBagCollection(collectioId)
	end
end

function RougeCollectionModel:deleteSomeCollectionFromSlot(collectionIds)
	if not collectionIds then
		return
	end

	for _, collectioId in ipairs(collectionIds) do
		collectioId = tonumber(collectioId)

		self:tryRemoveSlotCollection(collectioId)
	end
end

function RougeCollectionModel:isCollectionExist(collectionId)
	local collectionMO = self._allCollections:getById(collectionId)

	return collectionMO ~= nil
end

function RougeCollectionModel:isCollectionPlaceInBag(collectionId)
	local collectionMO = self._bagCollections:getById(collectionId)

	return collectionMO ~= nil
end

function RougeCollectionModel:isCollectionPlaceInSlotArea(collectionId)
	local collectionMO = self._slotCollections:getById(collectionId)

	return collectionMO ~= nil
end

function RougeCollectionModel:getCollectionPlaceArea(collectionId)
	local inBag = self:isCollectionPlaceInBag(collectionId)

	if inBag then
		return RougeEnum.CollectionPlaceArea.BagArea
	end

	local inSlot = self:isCollectionPlaceInSlotArea(collectionId)

	if inSlot then
		return RougeEnum.CollectionPlaceArea.SlotArea
	end
end

function RougeCollectionModel:oneKeyPlace2SlotArea(serverMsg)
	if not serverMsg then
		return
	end

	self:onReceiveNewInfo2Slot(serverMsg)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionBag)
end

function RougeCollectionModel:onKeyClearSlotArea()
	if not self._slotCollections then
		return
	end

	local slotCollections = self._slotCollections:getList()

	for i = #slotCollections, 1, -1 do
		local collectionId = slotCollections[i].id

		self:tryRemoveSlotCollection(collectionId)
	end

	self._slotCollections:clear()
end

function RougeCollectionModel:getCurSlotAreaSize()
	if not self._curSlotAreaSize then
		local styleCfg = RougeController.instance:getStyleConfig()
		local layoutId = styleCfg and styleCfg.layoutId
		local bagSize = RougeCollectionConfig.instance:getCollectionInitialBagSize(layoutId)
		local col = bagSize and bagSize.col
		local row = bagSize and bagSize.row

		self._curSlotAreaSize = {
			col = col,
			row = row
		}
	end

	return self._curSlotAreaSize
end

function RougeCollectionModel:getCollectionActiveEffects(collectionId)
	local collectionMO = self:getCollectionByUid(collectionId)

	if collectionMO and self:isCollectionPlaceInSlotArea(collectionId) then
		return (collectionMO:getBaseEffects())
	end
end

function RougeCollectionModel:getCollectionActiveEffectMap(collectionId)
	local baseEffects = self:getCollectionActiveEffects(collectionId)

	if baseEffects then
		local baseEffectMap = {}

		for _, effectId in ipairs(baseEffects) do
			baseEffectMap[effectId] = true
		end

		return baseEffectMap
	end
end

function RougeCollectionModel:checkIsCanCompositeCollection(synthesisCfgId)
	local compositeIds = RougeCollectionConfig.instance:getCollectionCompositeIds(synthesisCfgId)

	if not compositeIds or #compositeIds <= 0 then
		return false
	end

	local markMap = {}

	for _, compositeId in ipairs(compositeIds) do
		local compositeCollectionCount = self:getCollectionCountById(compositeId)

		if not markMap[compositeId] then
			if compositeCollectionCount < markMap[compositeId] + RougeEnum.CompositeCollectionCostCount then
				return false
			end

			markMap[compositeId] = markMap[compositeId] + RougeEnum.CompositeCollectionCostCount
		end
	end

	return true
end

function RougeCollectionModel:saveTmpCollectionTriggerEffectInfo(trigger, removeCollections, add2SlotCollectionIds, add2BagCollectionIds, showType)
	self._effectTriggerMap = self._effectTriggerMap or {}

	if self._effectTriggerMap[trigger.id] then
		for i = #self._effectTriggerTab, 1, -1 do
			local effect = self._effectTriggerTab[i]

			if effect.id == trigger.id then
				self._effectTriggerTab[i] = nil
				self._effectTriggerMap[trigger.id] = nil
			end
		end
	end

	local info = {
		trigger = trigger,
		removeCollections = removeCollections,
		add2SlotCollectionIds = add2SlotCollectionIds,
		add2BagCollectionIds = add2BagCollectionIds,
		showType = showType,
		removeCollectionMap = {}
	}

	if removeCollections then
		for _, collection in ipairs(removeCollections) do
			info.removeCollectionMap[collection.id] = collection
		end
	end

	self._effectTriggerMap[trigger.id] = true
	self._effectTriggerTab = self._effectTriggerTab or {}

	table.insert(self._effectTriggerTab, info)
end

function RougeCollectionModel:getTmpCollectionTriggerEffectInfo()
	return self._effectTriggerTab
end

function RougeCollectionModel:clearTmpCollectionTriggerEffectInfo()
	if self._effectTriggerTab then
		tabletool.clear(self._effectTriggerTab)
	end
end

function RougeCollectionModel:checkHasTmpTriggerEffectInfo()
	return self._effectTriggerTab and #self._effectTriggerTab > 0
end

function RougeCollectionModel:updateCollectionItems(itemInfo)
	if not itemInfo then
		return
	end

	for _, info in ipairs(itemInfo) do
		local collectionId = tonumber(info.id)
		local collectionMO = self:getCollectionByUid(collectionId)
		local isInSlotArea = self:isCollectionPlaceInSlotArea(collectionId)

		if isInSlotArea then
			collectionMO:updateInfo(info)
		else
			local collectionMO = RougeCollectionHelper.buildNewBagCollectionMO(info)

			self:tryAddCollection2BagArea(collectionMO)
		end
	end
end

function RougeCollectionModel:switchCollectionInfoType()
	local curInfoType = self:getCurCollectionInfoType()
	local isCurComplex = curInfoType == RougeEnum.CollectionInfoType.Complex

	if isCurComplex then
		self._curInfoType = RougeEnum.CollectionInfoType.Simple or RougeEnum.CollectionInfoType.Complex
	end

	RougeController.instance:dispatchEvent(RougeEvent.SwitchCollectionInfoType)
	self:_saveCollectionInfoType(self._curInfoType)
end

function RougeCollectionModel:getCurCollectionInfoType()
	if not self._curInfoType then
		local key = self:_getCollectionInfoTypeSaveKey()

		self._curInfoType = tonumber(PlayerPrefsHelper.getNumber(key, RougeEnum.DefaultCollectionInfoType))
	end

	return self._curInfoType
end

function RougeCollectionModel:_saveCollectionInfoType(infoType)
	infoType = infoType or RougeEnum.DefaultCollectionInfoType

	local key = self:_getCollectionInfoTypeSaveKey()

	PlayerPrefsHelper.setNumber(key, infoType)
end

function RougeCollectionModel:_getCollectionInfoTypeSaveKey()
	return (string.format("%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RougeCollectionInfoType))
end

RougeCollectionModel.instance = RougeCollectionModel.New()

return RougeCollectionModel
