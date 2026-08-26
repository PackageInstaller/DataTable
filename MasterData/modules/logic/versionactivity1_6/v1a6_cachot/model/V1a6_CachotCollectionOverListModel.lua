-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotCollectionOverListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionOverListModel", package.seeall)

local V1a6_CachotCollectionOverListModel = class("V1a6_CachotCollectionOverListModel", ListScrollModel)

function V1a6_CachotCollectionOverListModel:onInit()
	self._collectionList = nil
end

function V1a6_CachotCollectionOverListModel:reInit()
	self:onInit()
end

function V1a6_CachotCollectionOverListModel:onInitData()
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local collections = rogueInfo and rogueInfo.collections

	self._collectionList = {}

	if collections then
		for _, collectionMO in ipairs(collections) do
			table.insert(self._collectionList, collectionMO)
		end
	end

	table.sort(self._collectionList, self.sortFunc)
	self:setList(self._collectionList)
end

function V1a6_CachotCollectionOverListModel.sortFunc(a, b)
	local aCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(a.cfgId)
	local bCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(b.cfgId)

	if aCfg and bCfg and aCfg.type ~= bCfg.type then
		return aCfg.type < bCfg.type
	end

	return a.id > b.id
end

function V1a6_CachotCollectionOverListModel:isBagEmpty()
	return self:getCount() <= 0
end

V1a6_CachotCollectionOverListModel.instance = V1a6_CachotCollectionOverListModel.New()

return V1a6_CachotCollectionOverListModel
