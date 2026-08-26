-- chunkname: @modules/logic/rouge/map/model/listmodel/RougeLossCollectionListModel.lua

module("modules.logic.rouge.map.model.listmodel.RougeLossCollectionListModel", package.seeall)

local RougeLossCollectionListModel = class("RougeLossCollectionListModel", ListScrollModel)

function RougeLossCollectionListModel:setLossType(type)
	self.lossType = type
end

function RougeLossCollectionListModel:getLossType()
	return self.lossType
end

function RougeLossCollectionListModel:initList(maxSelectCount, collectionMoList, baseTagFilterMap, extraTagFilterMap, filterUnique)
	self.maxSelectCount = maxSelectCount
	self.selectCount = 0
	self.selectMoList = {}
	self.allMoList = {}
	self.baseTagFilterMap = baseTagFilterMap
	self.extraTagFilterMap = extraTagFilterMap

	for _, collectionMo in ipairs(collectionMoList) do
		self:addCollection(collectionMo.id, collectionMo.cfgId, filterUnique)

		local enchantIdList, enchantCfgIdList = collectionMo:getAllEnchantId(), collectionMo:getAllEnchantCfgId()

		for index, uid in ipairs(enchantIdList) do
			self:addCollection(uid, enchantCfgIdList[index], filterUnique)
		end
	end

	self.showMoList = {}

	self:filterCollection()
end

function RougeLossCollectionListModel:addCollection(uid, collectionId, filterUnique)
	if not uid or not collectionId then
		return
	end

	if uid == 0 or collectionId == 0 then
		return
	end

	if filterUnique then
		if not RougeCollectionHelper.isUniqueCollection(collectionId) then
			table.insert(self.allMoList, {
				uid = uid,
				collectionId = collectionId
			})
		end
	else
		table.insert(self.allMoList, {
			uid = uid,
			collectionId = collectionId
		})
	end
end

function RougeLossCollectionListModel:filterCollection()
	tabletool.clear(self.showMoList)

	for _, mo in ipairs(self.allMoList) do
		if RougeCollectionHelper.checkCollectionHasAnyOneTag(mo.collectionId, nil, self.baseTagFilterMap, self.extraTagFilterMap) then
			table.insert(self.showMoList, mo)
		end
	end
end

function RougeLossCollectionListModel:refresh()
	self:setList(self.showMoList)
end

function RougeLossCollectionListModel:getSelectMoList()
	return self.selectMoList
end

function RougeLossCollectionListModel:checkCanSelect()
	return #self.selectMoList < self.maxSelectCount
end

function RougeLossCollectionListModel:getSelectCount()
	return self.selectCount
end

function RougeLossCollectionListModel:selectMo(mo)
	if self.selectCount >= self.maxSelectCount then
		return
	end

	if tabletool.indexOf(self.selectMoList, mo) then
		return
	end

	self.selectCount = self.selectCount + 1

	tabletool.removeValue(self.showMoList, mo)
	table.insert(self.selectMoList, mo)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectLossCollectionChange)
end

function RougeLossCollectionListModel:deselectMo(mo)
	for index, _mo in ipairs(self.selectMoList) do
		if _mo == mo then
			self.selectCount = self.selectCount - 1

			table.remove(self.selectMoList, index)
			table.insert(self.showMoList, mo)
			RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectLossCollectionChange)

			return
		end
	end
end

function RougeLossCollectionListModel:isFiltering()
	return not GameUtil.tabletool_dictIsEmpty(self.baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(self.extraTagFilterMap)
end

function RougeLossCollectionListModel:clear()
	self.maxSelectCount = nil
	self.selectCount = nil
	self.selectMoList = nil
	self.allMoList = nil
	self.showMoList = nil
	self.baseTagFilterMap = nil
	self.extraTagFilterMap = nil
	self.lossType = nil
end

RougeLossCollectionListModel.instance = RougeLossCollectionListModel.New()

return RougeLossCollectionListModel
