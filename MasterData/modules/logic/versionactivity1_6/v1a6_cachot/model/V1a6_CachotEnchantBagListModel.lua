-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotEnchantBagListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotEnchantBagListModel", package.seeall)

local V1a6_CachotEnchantBagListModel = class("V1a6_CachotEnchantBagListModel", ListScrollModel)

function V1a6_CachotEnchantBagListModel:onInit()
	self._collectionDataDic = nil
	self._curSelectCollectionId = nil
	self._curSelectHoleIndex = nil
end

function V1a6_CachotEnchantBagListModel:reInit()
	self:onInit()
end

function V1a6_CachotEnchantBagListModel:onInitData(category)
	self._collectionDataDic = self:getAllCollectionDataByType()

	self:switchCategory(category)
end

function V1a6_CachotEnchantBagListModel:getAllCollectionDataByType()
	local dataTabWithOutEnchant = {}
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local collectionList = rogueInfo.collections
	local AllFilterType = V1a6_CachotCollectionEnchantView.AllFilterType

	dataTabWithOutEnchant[AllFilterType] = {}

	for _, v in pairs(V1a6_CachotEnum.CollectionType) do
		dataTabWithOutEnchant[v] = {}
	end

	if collectionList then
		for _, v in ipairs(collectionList) do
			local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(v.cfgId)
			local collectionType = collectionCfg and collectionCfg.type

			if collectionType and collectionType ~= V1a6_CachotEnum.CollectionType.Enchant then
				local typeTabWithOutEnchant = dataTabWithOutEnchant[collectionType]

				table.insert(dataTabWithOutEnchant[AllFilterType], v)

				if typeTabWithOutEnchant then
					table.insert(typeTabWithOutEnchant, v)
				else
					local collectionId = collectionCfg.id

					logError(string.format("collectionType match error, collectionId = %s, collectionType = %s", collectionId, collectionType))
				end
			end
		end
	end

	for _, v in pairs(dataTabWithOutEnchant) do
		table.sort(v, self.sortFunc)
	end

	return dataTabWithOutEnchant
end

function V1a6_CachotEnchantBagListModel.sortFunc(a, b)
	local aCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(a.cfgId)
	local bCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(b.cfgId)

	if aCfg and bCfg and aCfg.holeNum ~= bCfg.holeNum and (aCfg.holeNum == 0 or bCfg.holeNum == 0) then
		return aCfg.holeNum ~= 0
	end

	if aCfg and bCfg and aCfg.type ~= bCfg.type then
		return aCfg.type < bCfg.type
	end

	return a.id > b.id
end

function V1a6_CachotEnchantBagListModel:isBagEmpty()
	return self:getCount() <= 0
end

function V1a6_CachotEnchantBagListModel:selectCell(collectionId, isSelect)
	local lastSelectCollectionId = self._curSelectCollectionId

	if collectionId and collectionId > 0 and isSelect then
		self:selectCellInternal(collectionId, isSelect)
	else
		self:selectCellInternal(lastSelectCollectionId, false)
	end
end

function V1a6_CachotEnchantBagListModel:selectCellInternal(collectionId, isSelect)
	local collectionMO = self:getById(collectionId)
	local curSelectCollectionId

	if collectionMO then
		local selectIndex = self:getIndex(collectionMO)

		V1a6_CachotEnchantBagListModel.super.selectCell(self, selectIndex, isSelect)

		curSelectCollectionId = isSelect and collectionMO.id
	end

	self._curSelectCollectionId = curSelectCollectionId
end

function V1a6_CachotEnchantBagListModel:getCurSelectCollectionId()
	return self._curSelectCollectionId
end

function V1a6_CachotEnchantBagListModel:getCurSelectHoleIndex()
	return self._curSelectHoleIndex or V1a6_CachotEnum.CollectionHole.Left
end

function V1a6_CachotEnchantBagListModel:markCurSelectHoleIndex(index)
	self._curSelectHoleIndex = index
end

function V1a6_CachotEnchantBagListModel:getCurSelectCategory()
	return self._curSelectCategory
end

function V1a6_CachotEnchantBagListModel:switchCategory(category)
	self._curSelectCategory = category or V1a6_CachotCollectionEnchantView.AllFilterType

	local collectionListByCategory = self._collectionDataDic[self._curSelectCategory]

	if collectionListByCategory then
		self:setList(collectionListByCategory)
	end
end

V1a6_CachotEnchantBagListModel.instance = V1a6_CachotEnchantBagListModel.New()

return V1a6_CachotEnchantBagListModel
