-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotCollectionListMO.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionListMO", package.seeall)

local V1a6_CachotCollectionListMO = pureTable("V1a6_CachotCollectionListMO")

function V1a6_CachotCollectionListMO:init(collectionType, isTop, maxCollectionNumSingleLine)
	self.collectionType = collectionType
	self.collectionList = {}
	self.collectionDic = {}
	self._curCollectionCount = 0
	self._isTop = isTop or false
	self._maxCollectionNumSingleLine = maxCollectionNumSingleLine
end

function V1a6_CachotCollectionListMO:addCollection(collectionConfig)
	if not self.collectionDic[collectionConfig.id] then
		self.collectionDic[collectionConfig.id] = true

		table.insert(self.collectionList, collectionConfig)

		self._curCollectionCount = self._curCollectionCount + 1
	end
end

function V1a6_CachotCollectionListMO:isFull()
	return self._curCollectionCount >= self._maxCollectionNumSingleLine
end

function V1a6_CachotCollectionListMO:getLineHeight()
	return self._isTop and 330 or 230
end

return V1a6_CachotCollectionListMO
