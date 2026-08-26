-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotCollectionBagListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionBagListModel", package.seeall)

local V1a6_CachotCollectionBagListModel = class("V1a6_CachotCollectionBagListModel", ListScrollModel)

function V1a6_CachotCollectionBagListModel:onInit()
	self._filterCollectionList = nil
end

function V1a6_CachotCollectionBagListModel:reInit()
	self:onInit()
end

function V1a6_CachotCollectionBagListModel:onInitData()
	self:onCollectionDataUpdate()
end

function V1a6_CachotCollectionBagListModel:onCollectionDataUpdate()
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local collectionList = rogueInfo and rogueInfo.collections

	self._filterCollectionList = {}

	if collectionList then
		for _, collectionMO in ipairs(collectionList) do
			table.insert(self._filterCollectionList, collectionMO)
		end
	end

	table.sort(self._filterCollectionList, self.sortFunc)

	local showCollectionList = self:insertFakeData()

	self:setList(showCollectionList)
end

function V1a6_CachotCollectionBagListModel:insertFakeData()
	local collectionEndIndex = 0

	self._unEnchantCollectionLineNum = 0
	self._enchantCollectionCount = 0

	local showCollectionList = {}

	for _, collectionMO in ipairs(self._filterCollectionList) do
		local collectionCfgId = collectionMO and collectionMO.cfgId
		local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(collectionCfgId)

		if collectionCfg and collectionCfg.type ~= V1a6_CachotEnum.CollectionType.Enchant then
			collectionEndIndex = collectionEndIndex + 1
		else
			self._enchantCollectionCount = self._enchantCollectionCount + 1
		end

		table.insert(showCollectionList, collectionMO)
	end

	local viewContainer = ViewMgr.instance:getContainer(ViewName.V1a6_CachotCollectionBagView)
	local viewParam = viewContainer and viewContainer:getScrollParam()

	if viewParam then
		if not viewParam.lineCount then
			local lineCount = 1

			self._unEnchantCollectionLineNum = math.ceil(collectionEndIndex / lineCount)

			local needInsertFakeDataNum = self._unEnchantCollectionLineNum * lineCount - collectionEndIndex

			for i = 1, needInsertFakeDataNum do
				local fakeData = {
					isFake = true,
					id = -i
				}
				local insertIndex = collectionEndIndex + i

				table.insert(showCollectionList, insertIndex, fakeData)
			end

			return showCollectionList
		end
	end
end

function V1a6_CachotCollectionBagListModel.sortFunc(a, b)
	local aCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(a.cfgId)
	local bCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(b.cfgId)

	if aCfg and bCfg and aCfg.type ~= bCfg.type then
		return aCfg.type < bCfg.type
	end

	return a.id > b.id
end

function V1a6_CachotCollectionBagListModel:isBagEmpty()
	return self:getCount() <= 0
end

function V1a6_CachotCollectionBagListModel:moveCollectionWithHole2Top()
	local isMoveSucc = false
	local fitCollectionMO = self:getFirstCollectionWithHole()

	if fitCollectionMO then
		self:remove(fitCollectionMO)
		self:addAtFirst(fitCollectionMO)

		isMoveSucc = true
	else
		logError("cannot find first collection with hole")
	end

	return isMoveSucc
end

function V1a6_CachotCollectionBagListModel:getFirstCollectionWithHole()
	local collectionList = self:getList()

	if collectionList then
		for _, collectionMO in ipairs(collectionList) do
			local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(collectionMO.cfgId)

			if collectionCfg and collectionCfg.type ~= V1a6_CachotEnum.CollectionType.Enchant and collectionCfg.holeNum > 0 then
				return collectionMO
			end
		end
	end
end

function V1a6_CachotCollectionBagListModel:getUnEnchantCollectionLineNum()
	return self._unEnchantCollectionLineNum or 0
end

function V1a6_CachotCollectionBagListModel:getEnchantCollectionNum()
	return self._enchantCollectionCount or 0
end

V1a6_CachotCollectionBagListModel.instance = V1a6_CachotCollectionBagListModel.New()

return V1a6_CachotCollectionBagListModel
