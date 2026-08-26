-- chunkname: @modules/logic/rouge/model/RougeCollectionBagListModel.lua

module("modules.logic.rouge.model.RougeCollectionBagListModel", package.seeall)

local RougeCollectionBagListModel = class("RougeCollectionBagListModel", ListScrollModel)

function RougeCollectionBagListModel:onInitData(baseTagFilterMap, extraTagFilterMap)
	self._baseTagFilterMap = baseTagFilterMap
	self._extraTagFilterMap = extraTagFilterMap

	self:filterCollection()
	self:markCurSelectCollectionId()
end

function RougeCollectionBagListModel:filterCollection()
	local showCollectionList = {}
	local bagCollections = RougeCollectionModel.instance:getBagAreaCollection()

	if bagCollections then
		for _, collection in ipairs(bagCollections) do
			local enchantCfgIds = collection:getAllEnchantCfgId()
			local isTagFilter = RougeCollectionHelper.checkCollectionHasAnyOneTag(collection.cfgId, enchantCfgIds, self._baseTagFilterMap, self._extraTagFilterMap)

			if isTagFilter then
				table.insert(showCollectionList, collection)
			end
		end
	end

	table.sort(showCollectionList, self.sortFunc)
	self:setList(showCollectionList)
end

function RougeCollectionBagListModel.sortFunc(a, b)
	local aCfg = RougeCollectionConfig.instance:getCollectionCfg(a.cfgId)
	local bCfg = RougeCollectionConfig.instance:getCollectionCfg(b.cfgId)

	if aCfg and bCfg and aCfg.showRare ~= bCfg.showRare then
		return aCfg.showRare > bCfg.showRare
	end

	local aSize = RougeCollectionConfig.instance:getCollectionCellCount(a.cfgId, RougeEnum.CollectionEditorParamType.Shape)
	local bSize = RougeCollectionConfig.instance:getCollectionCellCount(b.cfgId, RougeEnum.CollectionEditorParamType.Shape)

	if aSize ~= bSize then
		return bSize < aSize
	end

	return a.id < b.id
end

function RougeCollectionBagListModel:isBagEmpty()
	return self:getCount() <= 0
end

function RougeCollectionBagListModel:isFiltering()
	return not GameUtil.tabletool_dictIsEmpty(self._baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(self._extraTagFilterMap)
end

function RougeCollectionBagListModel:isCollectionSelect(collectionId)
	if not collectionId or not self._curSelectCollection then
		return
	end

	return self._curSelectCollection == collectionId
end

function RougeCollectionBagListModel:markCurSelectCollectionId(newSelectCollectionId)
	self._curSelectCollection = newSelectCollectionId
end

RougeCollectionBagListModel.instance = RougeCollectionBagListModel.New()

return RougeCollectionBagListModel
