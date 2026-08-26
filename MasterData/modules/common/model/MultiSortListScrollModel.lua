-- chunkname: @modules/common/model/MultiSortListScrollModel.lua

module("modules.common.model.MultiSortListScrollModel", package.seeall)

local MultiSortListScrollModel = class("MultiSortListScrollModel", ListScrollModel)

function MultiSortListScrollModel:initSort()
	self._addSortNum = 0
	self._curSortType = nil
	self._curSortAscending = nil
	self._sortFuncList = {}
	self._sortAscendingList = {}
	self._sortList = {}
	self._firstSort = nil
	self._lastSort = nil
	self._ipair = ipairs

	function self._tableSort(a, b)
		return MultiSortListScrollModel._sortFunc(a, b, self)
	end
end

function MultiSortListScrollModel:getSortState(sortType)
	if self._curSortType == sortType then
		if not self._curSortAscending then
			local ascending = self._sortAscendingList[sortType]

			return ascending and 1 or -1
		end
	end
end

function MultiSortListScrollModel:addOtherSort(firstSort, lastSort)
	self._firstSort = firstSort
	self._lastSort = lastSort
end

function MultiSortListScrollModel:addSortType(sortType, sortFunc, ascending)
	if self._sortFuncList[sortType] then
		logError("sortType already exist")

		return
	end

	if not sortFunc then
		logError("sortFunc is nil")

		return
	end

	self._sortFuncList[sortType] = sortFunc
	self._sortAscendingList[sortType] = ascending == true
	self._addSortNum = self._addSortNum + 1
end

function MultiSortListScrollModel:setCurSortType(sortType)
	if not self._sortFuncList[sortType] then
		logError("sortType is not exist")

		return
	end

	if self._curSortType == sortType then
		self._curSortAscending = not self._curSortAscending
	else
		self._curSortAscending = self._sortAscendingList[sortType]
		self._curSortType = sortType
	end

	self:_doSort()
end

function MultiSortListScrollModel:getCurSortType()
	return self._curSortType
end

function MultiSortListScrollModel:setSortList(list)
	self._sortList = list

	self:_doSort()
end

function MultiSortListScrollModel:_doSort()
	if not self._sortList then
		return
	end

	if self._curSortType then
		if self._addSortNum ~= #self._sortFuncList then
			logError("sortFuncList is not complete")

			return
		end

		table.sort(self._sortList, self._tableSort)
	end

	self:setList(self._sortList)
end

function MultiSortListScrollModel._sortFunc(a, b, instance)
	local result

	if instance._firstSort then
		result = instance._firstSort(a, b, instance)
	end

	if result ~= nil then
		return result
	end

	result = instance._sortFuncList[instance._curSortType](a, b, instance._curSortAscending, instance)

	if result ~= nil then
		return result
	end
end

return MultiSortListScrollModel
