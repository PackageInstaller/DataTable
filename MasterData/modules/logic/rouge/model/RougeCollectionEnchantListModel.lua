-- chunkname: @modules/logic/rouge/model/RougeCollectionEnchantListModel.lua

module("modules.logic.rouge.model.RougeCollectionEnchantListModel", package.seeall)

local RougeCollectionEnchantListModel = class("RougeCollectionEnchantListModel", ListScrollModel)

function RougeCollectionEnchantListModel:onInit()
	self._enchantList = nil
	self._curSelectEnchantId = nil
end

function RougeCollectionEnchantListModel:reInit()
	self:onInit()
	self:clear()
end

function RougeCollectionEnchantListModel:onInitData(isExcuteEnchantSort)
	self._enchantList = self:buildEnchantDataTab(isExcuteEnchantSort)

	self:setList(self._enchantList)

	local curSelectEnchantId = self:getCurSelectEnchantId()
	local curSelectEnchantMO = self:getById(curSelectEnchantId)

	if curSelectEnchantMO then
		self:selectCell(curSelectEnchantId, true)
	end
end

function RougeCollectionEnchantListModel:buildEnchantDataTab(isExcuteEnchantSort)
	local slotCollections = RougeCollectionModel.instance:getSlotAreaCollection()
	local bagCollections = RougeCollectionModel.instance:getBagAreaCollection()
	local enchantList = self:buildEnchantMOList(slotCollections, bagCollections)

	if isExcuteEnchantSort then
		if not self.sortFunc then
			local listSortFunc = self.sortFunc2

			table.sort(enchantList, listSortFunc)

			return enchantList
		end
	end
end

function RougeCollectionEnchantListModel:buildEnchantMOList(slotCollections, bagCollections)
	local enchantList = {}

	if slotCollections then
		for _, collection in pairs(slotCollections) do
			self:dealCollectionInfo(collection, enchantList)
		end
	end

	if bagCollections then
		for _, collection in pairs(bagCollections) do
			self:dealCollectionInfo(collection, enchantList)
		end
	end

	return enchantList
end

function RougeCollectionEnchantListModel:dealCollectionInfo(collection, enchantList)
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collection.cfgId)
	local isEnchantType = collectionCfg.type == RougeEnum.CollectionType.Enchant
	local createCollection

	if isEnchantType then
		createCollection = self:createRougeEnchantMO(collection.id, collection.cfgId)

		table.insert(enchantList, createCollection)
	else
		local enchantIds = collection:getAllEnchantId()
		local enchantCfgIds = collection:getAllEnchantCfgId()

		if enchantIds then
			for holeIndex, enchantId in pairs(enchantIds) do
				if enchantId > 0 then
					local enchantCfgId = enchantCfgIds[holeIndex]
					local enchantCfg = RougeCollectionConfig.instance:getCollectionCfg(enchantCfgId)

					if enchantCfg then
						createCollection = self:createRougeEnchantMO(enchantId, enchantCfgId)

						createCollection:updateEnchantTargetId(collection.id)
						table.insert(enchantList, createCollection)
					end
				end
			end
		end
	end
end

function RougeCollectionEnchantListModel:createRougeEnchantMO(enchantId, enchantCfgId)
	local createCollection = RougeCollectionMO.New()

	createCollection:init({
		id = enchantId,
		itemId = enchantCfgId
	})

	return createCollection
end

function RougeCollectionEnchantListModel.sortFunc(a, b)
	local aIsEnchant = a:isEnchant2Collection()
	local bIsEnchant = b:isEnchant2Collection()

	if aIsEnchant ~= bIsEnchant then
		return not aIsEnchant
	end

	local aCfg = RougeCollectionConfig.instance:getCollectionCfg(a.cfgId)
	local bCfg = RougeCollectionConfig.instance:getCollectionCfg(b.cfgId)

	if aCfg then
		if not aCfg.showRare then
			local aShowRare = 0

			if bCfg then
				if not bCfg.showRare then
					local bShowRare = 0

					if aShowRare ~= bShowRare then
						return bShowRare < aShowRare
					end

					return a.id < b.id
				end
			end
		end
	end
end

function RougeCollectionEnchantListModel.sortFunc2(a, b)
	local originAMO = RougeCollectionEnchantListModel.instance:getById(a.id)
	local originBMO = RougeCollectionEnchantListModel.instance:getById(b.id)
	local isOriginAExit = originAMO ~= nil
	local isOriginBExit = originBMO ~= nil

	if isOriginAExit ~= isOriginBExit then
		return isOriginAExit
	end

	if isOriginAExit and isOriginBExit then
		local originAIndex = RougeCollectionEnchantListModel.instance:getIndex(originAMO)
		local originBIndex = RougeCollectionEnchantListModel.instance:getIndex(originBMO)

		if originAIndex ~= originBIndex then
			return originAIndex < originBIndex
		end
	end

	return a.id < b.id
end

function RougeCollectionEnchantListModel:executeSortFunc()
	table.sort(self._enchantList, self.sortFunc)
	self:setList(self._enchantList)
end

function RougeCollectionEnchantListModel:isEnchantEmpty()
	return self:getCount() <= 0
end

function RougeCollectionEnchantListModel:selectCell(enchantId, isSelect)
	local lastSelectCollectionId = self._curSelectEnchantId

	if enchantId and enchantId > 0 then
		self:_selectCellInternal(enchantId, isSelect)
	else
		self:_selectCellInternal(lastSelectCollectionId, false)
	end
end

function RougeCollectionEnchantListModel:_selectCellInternal(enchantId, isSelect)
	local collectionMO = self:getById(enchantId)
	local curSelectEnchantId

	if collectionMO then
		local selectIndex = self:getIndex(collectionMO)

		RougeCollectionEnchantListModel.super.selectCell(self, selectIndex, isSelect)

		self._curSelectEnchantId = isSelect and collectionMO.id or nil
	end
end

function RougeCollectionEnchantListModel:getCurSelectEnchantId()
	return self._curSelectEnchantId
end

RougeCollectionEnchantListModel.instance = RougeCollectionEnchantListModel.New()

return RougeCollectionEnchantListModel
