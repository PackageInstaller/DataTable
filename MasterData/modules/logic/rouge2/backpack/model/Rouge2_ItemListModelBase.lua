-- chunkname: @modules/logic/rouge2/backpack/model/Rouge2_ItemListModelBase.lua

module("modules.logic.rouge2.backpack.model.Rouge2_ItemListModelBase", package.seeall)

local Rouge2_ItemListModelBase = class("Rouge2_ItemListModelBase", MultiSortListScrollModel)

function Rouge2_ItemListModelBase:initSort()
	Rouge2_ItemListModelBase.super.initSort(self)
	self:addSortType(1, self._sortDefault)
	self:addOtherSort(nil, self._sortDefault)
end

function Rouge2_ItemListModelBase:initList(itemList, selectTabId)
	self:initSort()
	self:setCurSortType(1)

	self._curTabId = nil
	self._tabIdList = self:_initTabIdList()

	self:_initSplitItemMap()
	self:_buildSplitItemMap(itemList)
	self:switch(selectTabId)
end

function Rouge2_ItemListModelBase:_initSplitItemMap()
	self._tabId2ItemList = {}

	local tabIdList = self:getTabIdList()

	if tabIdList and #tabIdList > 0 then
		for _, tabId in ipairs(tabIdList) do
			self._tabId2ItemList[tabId] = {}
		end
	else
		logError("Rouge2_ItemListModelBase error tabIdList is nil")
	end
end

function Rouge2_ItemListModelBase:_buildSplitItemMap(itemList)
	if itemList then
		for _, item in ipairs(itemList) do
			self:_reallyAddItem2SplitMap(item, self:_getItemTabIds(item))
		end
	end
end

function Rouge2_ItemListModelBase:_reallyAddItem2SplitMap(item, ...)
	for i = 1, select("#", ...) do
		local key = select(i, ...)

		if self._tabId2ItemList[key] then
			table.insert(self._tabId2ItemList[key], item)
		end
	end
end

function Rouge2_ItemListModelBase:_initTabIdList()
	logError("Rouge2_ItemListModelBase._initTabIdList 需要被重写 !!!")
end

function Rouge2_ItemListModelBase:getTabIdList()
	return self._tabIdList
end

function Rouge2_ItemListModelBase:_getItemTabIds(item)
	logError("Rouge2_ItemListModelBase._getItemTabIds 需要被重写 !!!")
end

function Rouge2_ItemListModelBase._sortDefault(aItem, bItem)
	return false
end

function Rouge2_ItemListModelBase:switch(tabId)
	if self._curTabId == tabId then
		return
	end

	if self._tabId2ItemList then
		local itemList = self._tabId2ItemList[tabId]

		if not itemList then
			logError(string.format("肉鸽构筑物数据源切换失败 tabId = %s", tabId))

			return
		end

		self:setSortList(itemList)

		self._curTabId = tabId
	end
end

function Rouge2_ItemListModelBase:getCurTabId()
	return self._curTabId
end

Rouge2_ItemListModelBase.instance = Rouge2_ItemListModelBase.New()

return Rouge2_ItemListModelBase
