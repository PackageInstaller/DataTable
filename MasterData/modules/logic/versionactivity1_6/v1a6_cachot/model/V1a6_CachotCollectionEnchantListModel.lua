-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotCollectionEnchantListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionEnchantListModel", package.seeall)

local V1a6_CachotCollectionEnchantListModel = class("V1a6_CachotCollectionEnchantListModel", ListScrollModel)

function V1a6_CachotCollectionEnchantListModel:onInit()
	self._enchantList = nil
	self._curSelectEnchantId = nil
	self._enchantIndexMap = nil
end

function V1a6_CachotCollectionEnchantListModel:reInit()
	self:onInit()
	self:clear()
end

function V1a6_CachotCollectionEnchantListModel:onInitData(isExcuteEnchantSort)
	self._enchantList = self:buildEnchantDataTab(isExcuteEnchantSort)

	self:setList(self._enchantList)
end

function V1a6_CachotCollectionEnchantListModel:buildEnchantDataTab(isExcuteEnchantSort)
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local enchants = rogueInfo and rogueInfo.enchants
	local enchantList = {}

	if enchants then
		if not #enchants then
			local enchantCount = 0
			local originEnchantList = self:getList()

			for index, originEnchantMO in ipairs(originEnchantList) do
				local targetIndex = self:getEnchantIndexById(originEnchantMO.id) or index
				local enchantMO = enchants and enchants[targetIndex]

				table.insert(enchantList, enchantMO)
			end

			for index = #originEnchantList + 1, enchantCount do
				table.insert(enchantList, enchants[index])
			end

			if isExcuteEnchantSort then
				table.sort(enchantList, self.sortFunc)
			end

			return enchantList
		end
	end
end

function V1a6_CachotCollectionEnchantListModel:getEnchantIndexById(enchantId)
	if not self._enchantIndexMap then
		self._enchantIndexMap = {}

		local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
		local enchants = rogueInfo and rogueInfo.enchants

		for index, v in ipairs(enchants) do
			self._enchantIndexMap[v.id] = index
		end
	end

	return self._enchantIndexMap and self._enchantIndexMap[enchantId]
end

function V1a6_CachotCollectionEnchantListModel.sortFunc(a, b)
	local aIsEnchant = a:isEnchant()
	local bIsEnchant = b:isEnchant()

	if aIsEnchant ~= bIsEnchant then
		return not aIsEnchant
	end

	return a.id > b.id
end

function V1a6_CachotCollectionEnchantListModel:isEnchantEmpty()
	return self:getCount() <= 0
end

function V1a6_CachotCollectionEnchantListModel:selectCell(enchantId, isSelect)
	local lastSelectCollectionId = self._curSelectEnchantId

	if enchantId and enchantId > 0 and isSelect then
		self:selectCellInternal(enchantId, isSelect)
	else
		self:selectCellInternal(lastSelectCollectionId, false)
	end
end

function V1a6_CachotCollectionEnchantListModel:selectCellInternal(enchantId, isSelect)
	local collectionMO = self:getById(enchantId)
	local curSelectEnchantId

	if collectionMO then
		local selectIndex = self:getIndex(collectionMO)

		V1a6_CachotCollectionEnchantListModel.super.selectCell(self, selectIndex, isSelect)

		curSelectEnchantId = isSelect and collectionMO.id
	end

	self._curSelectEnchantId = curSelectEnchantId
end

function V1a6_CachotCollectionEnchantListModel:getCurSelectEnchantId()
	return self._curSelectEnchantId
end

V1a6_CachotCollectionEnchantListModel.instance = V1a6_CachotCollectionEnchantListModel.New()

return V1a6_CachotCollectionEnchantListModel
