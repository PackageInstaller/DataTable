-- chunkname: @modules/logic/rouge/dlc/102/model/RougeDLCModel102.lua

module("modules.logic.rouge.dlc.102.model.RougeDLCModel102", package.seeall)

local RougeDLCModel102 = class("RougeDLCModel102", BaseModel)

function RougeDLCModel102:clear()
	return
end

function RougeDLCModel102:getCanLevelUpSpCollectionsInSlotArea()
	local levelupCollections = {}
	local allCollections = RougeCollectionModel.instance:getSlotAreaCollection()

	if allCollections then
		for _, collectionMo in ipairs(allCollections) do
			local isSp = self:_checkIsSpCollection(collectionMo)

			if isSp then
				local isMaxLevelUp = self:_checkIsCollectionMaxLevelUp(collectionMo)

				if not isMaxLevelUp then
					table.insert(levelupCollections, collectionMo)
				end
			end
		end
	end

	return levelupCollections
end

function RougeDLCModel102:_checkIsCollectionMaxLevelUp(collectionMo)
	local attrMap = collectionMo:getAttrValueMap()

	if attrMap then
		for attrId, _ in pairs(attrMap) do
			if attrId == RougeEnum.MaxLevelSpAttrId then
				return true
			end
		end
	end

	return false
end

function RougeDLCModel102:_checkIsCollectionAllEffectActive(descInfoMap)
	for _, descInfos in pairs(descInfoMap) do
		for _, descInfo in pairs(descInfos) do
			if not descInfo.isActive then
				return false
			end
		end
	end

	return true
end

function RougeDLCModel102:_checkIsSpCollection(collectionMo)
	if collectionMo then
		local collectionCfgId = collectionMo:getCollectionCfgId()
		local collectionCo = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

		return collectionCo and collectionCo.type == RougeEnum.CollectionType.Special
	end
end

function RougeDLCModel102:getAllSpCollectionsInSlotArea()
	local spCollections = {}
	local allCollections = RougeCollectionModel.instance:getSlotAreaCollection()

	if allCollections then
		for _, collectionMo in ipairs(allCollections) do
			local isSp = self:_checkIsSpCollection(collectionMo)

			if isSp then
				table.insert(spCollections, collectionMo)
			end
		end
	end

	return spCollections
end

function RougeDLCModel102:getAllSpCollections()
	local spCollections = {}
	local allCollections = RougeCollectionModel.instance:getAllCollections()

	if allCollections then
		for _, collectionMo in ipairs(allCollections) do
			local isSp = self:_checkIsSpCollection(collectionMo)

			if isSp then
				table.insert(spCollections, collectionMo)
			end
		end
	end

	return spCollections
end

function RougeDLCModel102:getAllSpCollectionCount()
	local spCollections = self:getAllSpCollections()

	return (spCollections or nil) and (#spCollections or 0)
end

function RougeDLCModel102:getAllCanLevelUpSpCollection()
	local levelupCollections = {}
	local allCollections = RougeCollectionModel.instance:getAllCollections()

	if allCollections then
		for _, collectionMo in ipairs(allCollections) do
			local isSp = self:_checkIsSpCollection(collectionMo)

			if isSp then
				local isMaxLevelUp = self:_checkIsCollectionMaxLevelUp(collectionMo)

				if not isMaxLevelUp then
					table.insert(levelupCollections, collectionMo)
				end
			end
		end
	end

	return levelupCollections
end

function RougeDLCModel102:getAllCanLevelUpSpCollectionCount()
	local levelupCollections = self:getAllCanLevelUpSpCollection()

	if levelupCollections then
		if not #levelupCollections then
			return 0
		end
	end
end

RougeDLCModel102.instance = RougeDLCModel102.New()

return RougeDLCModel102
