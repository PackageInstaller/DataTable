-- chunkname: @modules/logic/rouge/model/RougeCollectionUnEnchantListModel.lua

module("modules.logic.rouge.model.RougeCollectionUnEnchantListModel", package.seeall)

local RougeCollectionUnEnchantListModel = class("RougeCollectionUnEnchantListModel", ListScrollModel)

function RougeCollectionUnEnchantListModel:onInit()
	self._collections = nil
end

function RougeCollectionUnEnchantListModel:reInit()
	self:onInit()
end

function RougeCollectionUnEnchantListModel:onInitData(collectionIds)
	self._collections = {}

	if collectionIds then
		for _, collectionId in ipairs(collectionIds) do
			local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

			table.insert(self._collections, collectionMO)
		end
	end

	self:setList(self._collections)
end

function RougeCollectionUnEnchantListModel:isBagEmpty()
	return self:getCount() <= 0
end

function RougeCollectionUnEnchantListModel:markCurSelectHoleIndex(newSelectHoleIndex)
	self._selectHoleIndex = newSelectHoleIndex or 1
end

function RougeCollectionUnEnchantListModel:getCurSelectHoleIndex()
	return self._selectHoleIndex
end

function RougeCollectionUnEnchantListModel:switchSelectCollection(selectCollectionId)
	self._curSelectCollectionId = selectCollectionId
end

function RougeCollectionUnEnchantListModel:getCurSelectIndex()
	local selectCollectionId = self:getCurSelectCollectionId()
	local selectCollectionMO = self:getById(selectCollectionId)

	return (self:getIndex(selectCollectionMO))
end

function RougeCollectionUnEnchantListModel:getCurSelectCollectionId()
	return self._curSelectCollectionId
end

RougeCollectionUnEnchantListModel.instance = RougeCollectionUnEnchantListModel.New()

return RougeCollectionUnEnchantListModel
