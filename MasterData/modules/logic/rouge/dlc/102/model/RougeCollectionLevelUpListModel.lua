-- chunkname: @modules/logic/rouge/dlc/102/model/RougeCollectionLevelUpListModel.lua

module("modules.logic.rouge.dlc.102.model.RougeCollectionLevelUpListModel", package.seeall)

local RougeCollectionLevelUpListModel = class("RougeCollectionLevelUpListModel", ListScrollModel)

function RougeCollectionLevelUpListModel:initList(maxSelectCount, baseTagFilterMap, extraTagFilterMap, filterUnique)
	local collectionMoList = RougeDLCModel102.instance:getAllCanLevelUpSpCollection()

	self.maxSelectCount = maxSelectCount
	self.selectCount = 0
	self.selectMoList = {}
	self.allMoList = {}
	self.baseTagFilterMap = baseTagFilterMap
	self.extraTagFilterMap = extraTagFilterMap

	for _, collectionMo in ipairs(collectionMoList) do
		self:addCollection(collectionMo.id, collectionMo.cfgId, filterUnique)
	end

	self.showMoList = {}

	self:filterCollection()
end

function RougeCollectionLevelUpListModel:addCollection(uid, collectionId, filterUnique)
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

function RougeCollectionLevelUpListModel:filterCollection()
	tabletool.clear(self.showMoList)

	for _, mo in ipairs(self.allMoList) do
		if RougeCollectionHelper.checkCollectionHasAnyOneTag(mo.collectionId, nil, self.baseTagFilterMap, self.extraTagFilterMap) then
			table.insert(self.showMoList, mo)
		end
	end
end

function RougeCollectionLevelUpListModel:refresh()
	self:setList(self.showMoList)
end

function RougeCollectionLevelUpListModel:getSelectMoList()
	return self.selectMoList
end

function RougeCollectionLevelUpListModel:checkCanSelect()
	return #self.selectMoList < self.maxSelectCount
end

function RougeCollectionLevelUpListModel:getSelectCount()
	return self.selectCount
end

function RougeCollectionLevelUpListModel:selectMo(mo)
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

function RougeCollectionLevelUpListModel:deselectMo(mo)
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

function RougeCollectionLevelUpListModel:isFiltering()
	return not GameUtil.tabletool_dictIsEmpty(self.baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(self.extraTagFilterMap)
end

function RougeCollectionLevelUpListModel:getAllMoCount()
	return (self.allMoList or nil) and (#self.allMoList or 0)
end

function RougeCollectionLevelUpListModel:clear()
	self.maxSelectCount = nil
	self.selectCount = nil
	self.selectMoList = nil
	self.allMoList = nil
	self.showMoList = nil
	self.baseTagFilterMap = nil
	self.extraTagFilterMap = nil
end

RougeCollectionLevelUpListModel.instance = RougeCollectionLevelUpListModel.New()

return RougeCollectionLevelUpListModel
