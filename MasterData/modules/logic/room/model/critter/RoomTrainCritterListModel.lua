-- chunkname: @modules/logic/room/model/critter/RoomTrainCritterListModel.lua

module("modules.logic.room.model.critter.RoomTrainCritterListModel", package.seeall)

local RoomTrainCritterListModel = class("RoomTrainCritterListModel", ListScrollModel)

function RoomTrainCritterListModel:onInit()
	self:_clearData()
end

function RoomTrainCritterListModel:reInit()
	self:_clearData()
end

function RoomTrainCritterListModel:clear()
	RoomTrainCritterListModel.super.clear(self)
	self:_clearData()
end

function RoomTrainCritterListModel:_clearData()
	return
end

function RoomTrainCritterListModel:setCritterList(filterMO)
	self._filterMO = filterMO

	if self._sortAttrId == nil then
		self._sortAttrId = CritterEnum.AttributeType.Efficiency
	end

	if self._isSortHightToLow == nil then
		self._isSortHightToLow = true
	end

	self:updateCritterList()
end

function RoomTrainCritterListModel:updateCritterList(needShowUid)
	local filterMO = self._filterMO
	local moList = {}
	local trainCritterMODict = {}
	local critterMOList = CritterModel.instance:getList()

	for i = 1, #critterMOList do
		local critterMO = critterMOList[i]

		if critterMO and not critterMO:isMaturity() then
			if critterMO:isCultivating() and needShowUid ~= critterMO.id or filterMO and not filterMO:isPassedFilter(critterMO) then
				trainCritterMODict[critterMO.id] = critterMO
			else
				table.insert(moList, critterMO)
			end
		end
	end

	self._trainCritterMODict = trainCritterMODict

	table.sort(moList, self:_getSortFunction())
	self:setList(moList)
end

function RoomTrainCritterListModel:sortByAttrId(attrId, isHightToLow)
	if attrId ~= nil then
		self._sortAttrId = attrId
	end

	if isHightToLow ~= nil then
		self._isSortHightToLow = isHightToLow
	end

	self:sort(self:_getSortFunction())
end

function RoomTrainCritterListModel:_getSortFunction()
	self._trainHeroMO = RoomTrainHeroListModel.instance:getById(RoomTrainHeroListModel.instance:getSelectId())

	if self._sortFunc then
		return self._sortFunc
	end

	function self._sortFunc(a, b)
		if self._trainHeroMO then
			local aCt = self:_getCritterValue(self._trainHeroMO, a)
			local bCt = self:_getCritterValue(self._trainHeroMO, b)

			if aCt ~= bCt then
				return bCt < aCt
			end
		end

		local aValue, aIncrRate = self:_getAttrValue(a, self._sortAttrId)
		local bValue, bIncrRate = self:_getAttrValue(b, self._sortAttrId)

		if aIncrRate ~= bIncrRate then
			if self._isSortHightToLow then
				return bIncrRate < aIncrRate
			end

			return aIncrRate < bIncrRate
		end

		if aValue ~= bValue then
			if self._isSortHightToLow then
				return bValue < aValue
			end

			return aValue < bValue
		end

		return CritterHelper.sortByTotalAttrValue(a, b)
	end

	return self._sortFunc
end

function RoomTrainCritterListModel:_getCritterValue(trainHeroMO, critterMO)
	if trainHeroMO:chcekPrefernectCritterId(critterMO:getDefineId()) then
		local pfType = trainHeroMO:getPrefernectType()

		if pfType == CritterEnum.PreferenceType.All then
			return 110
		elseif pfType == CritterEnum.PreferenceType.Catalogue then
			return 120
		elseif pfType == CritterEnum.PreferenceType.Critter then
			return 130
		end

		return 10
	end

	return 0
end

function RoomTrainCritterListModel:_getAttrValue(a, arrId)
	if arrId == CritterEnum.AttributeType.Efficiency then
		return a.efficiency, a.efficiencyIncrRate
	elseif arrId == CritterEnum.AttributeType.Patience then
		return a.patience, a.patienceIncrRate
	elseif arrId == CritterEnum.AttributeType.Lucky then
		return a.lucky, a.luckyIncrRate
	end

	return 0
end

function RoomTrainCritterListModel:getSortAttrId()
	return self._sortAttrId
end

function RoomTrainCritterListModel:getSortIsHightToLow()
	return self._isSortHightToLow
end

function RoomTrainCritterListModel:clearSelect()
	for i, view in ipairs(self._scrollViews) do
		view:setSelect(nil)
	end

	self._selectUid = nil
end

function RoomTrainCritterListModel:_refreshSelect()
	local selectMO = self:getById(self._selectUid)

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomTrainCritterListModel:setSelect(critterUid)
	self._selectUid = critterUid

	self:_refreshSelect()
end

function RoomTrainCritterListModel:getSelectId()
	return self._selectUid
end

function RoomTrainCritterListModel:getById(id)
	local mo = RoomTrainCritterListModel.super.getById(self, id)
	local var_18_0

	if not mo then
		::label_18_0::

		var_18_0 = self._trainCritterMODict and self._trainCritterMODict[id]
	end

	return var_18_0
end

function RoomTrainCritterListModel:setFilterResType(includeList, excludeList)
	self._filterIncludeList = {}
	self._filterExcludeList = {}

	self:_setList(self._filterIncludeList, includeList)
	self:_setList(self._filterExcludeList, excludeList)
end

function RoomTrainCritterListModel:isFilterType(includeList, excludeList)
	if self:_isSameValue(self._filterIncludeList, includeList) and self:_isSameValue(self._filterExcludeList, excludeList) then
		return true
	end

	return false
end

function RoomTrainCritterListModel:isFilterTypeEmpty()
	return self:_isEmptyList(self._filterTypeList)
end

function RoomTrainCritterListModel:_setList(targetArray, addArray)
	tabletool.addValues(targetArray, addArray)
end

function RoomTrainCritterListModel:_isListValue(targetArray, value)
	if value and tabletool.indexOf(targetArray, value) then
		return true
	end

	return false
end

function RoomTrainCritterListModel:_isSameValue(targetArray, array)
	if self:_isEmptyList(targetArray) and self:_isEmptyList(array) then
		return true
	end

	if #targetArray ~= #array then
		return false
	end

	for _, value in ipairs(array) do
		if not tabletool.indexOf(targetArray, value) then
			return false
		end
	end

	for _, value in ipairs(targetArray) do
		if not tabletool.indexOf(array, value) then
			return false
		end
	end

	return true
end

function RoomTrainCritterListModel:_isEmptyList(targetArray)
	return targetArray == nil or #targetArray < 1
end

RoomTrainCritterListModel.instance = RoomTrainCritterListModel.New()

return RoomTrainCritterListModel
