-- chunkname: @modules/logic/room/model/manufacture/ManufactureCritterListModel.lua

module("modules.logic.room.model.manufacture.ManufactureCritterListModel", package.seeall)

local ManufactureCritterListModel = class("ManufactureCritterListModel", ListScrollModel)
local DEFAULT_START_INDEX = 1
local DEFAULT_MAX_PREVIEW_COUNT = 50
local MIN_PREVIEW_COUNT = 5

function ManufactureCritterListModel:onInit()
	self:clear()
	self:clearData()
	self:clearSort()
end

function ManufactureCritterListModel:reInit()
	self:clearData()
	self:clearSort()
end

function ManufactureCritterListModel:clearData()
	self._newList = nil
	self._curPreviewIndex = 0
	self.critterAttrPreviewDict = {}
	self._buildingCritterAttrPreviewDict = {}
	self._buildingCritterAttrDict = {}
end

function ManufactureCritterListModel:clearSort()
	self:setOrder(CritterEnum.OrderType.MoodDown)
end

local function _sortFunction(aCritterMO, bCritterMO)
	local aCritterUid = aCritterMO:getId()
	local bCritterUid = bCritterMO:getId()
	local aWorkingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(aCritterUid)
	local bWorkingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(bCritterUid)
	local aWorkingPathId = aWorkingPathMO and aWorkingPathMO.id
	local bWorkingPathId = bWorkingPathMO and bWorkingPathMO.id
	local aWorkBuilding = ManufactureModel.instance:getCritterWorkingBuilding(aCritterUid)
	local bWorkBuilding = ManufactureModel.instance:getCritterWorkingBuilding(bCritterUid)
	local aIsWorkInCurBuilding = false
	local bIsWorkInCurBuilding = false
	local tmpWorkingUid = ManufactureCritterListModel.instance:getTmpWorkingUid()

	if tmpWorkingUid then
		aIsWorkInCurBuilding = aWorkBuilding == tmpWorkingUid or aWorkingPathId == tmpWorkingUid
		bIsWorkInCurBuilding = bWorkBuilding == tmpWorkingUid or bWorkingPathId == tmpWorkingUid
	end

	if aIsWorkInCurBuilding ~= bIsWorkInCurBuilding then
		return aIsWorkInCurBuilding
	end

	local order = ManufactureCritterListModel.instance:getOrder()
	local aMood = aCritterMO:getMoodValue()
	local bMood = bCritterMO:getMoodValue()

	if aMood ~= bMood then
		if order == CritterEnum.OrderType.MoodDown then
			return bMood < aMood
		elseif order == CritterEnum.OrderType.MoodUp then
			return aMood < bMood
		end
	end

	local aCritterId = aCritterMO:getDefineId()
	local bCritterId = bCritterMO:getDefineId()
	local aRare = CritterConfig.instance:getCritterRare(aCritterId)
	local bRare = CritterConfig.instance:getCritterRare(bCritterId)

	if aRare ~= bRare then
		if order == CritterEnum.OrderType.RareDown then
			return bRare < aRare
		elseif order == CritterEnum.OrderType.RareUp then
			return aRare < bRare
		end
	end

	if aCritterId ~= bCritterId then
		return aCritterId < bCritterId
	end

	return aCritterUid < bCritterUid
end

function ManufactureCritterListModel:setCritterNewList(workingUid, isTransport, filterMO)
	self:clearData()

	self._newList = {}

	local critterMOList = CritterModel.instance:getAllCritters()

	for _, critterMO in ipairs(critterMOList) do
		local isMaturity = critterMO:isMaturity()
		local isCultivating = critterMO:isCultivating()

		if isMaturity and not isCultivating then
			local checkWorkingManuBuilding

			if isTransport then
				local critterUid = critterMO:getId()

				checkWorkingManuBuilding = ManufactureModel.instance:getCritterWorkingBuilding(critterUid)
			end

			if not checkWorkingManuBuilding then
				if (filterMO or nil) and filterMO:isPassedFilter(critterMO) then
					table.insert(self._newList, critterMO)
				end
			end
		end
	end

	self:setTmpWorkingUid(workingUid)
	table.sort(self._newList, _sortFunction)
	self:setTmpWorkingUid()
end

function ManufactureCritterListModel:setTmpWorkingUid(workingUid)
	self._tmpWorkingUid = workingUid
end

function ManufactureCritterListModel:getTmpWorkingUid()
	return self._tmpWorkingUid
end

function ManufactureCritterListModel:getPreviewCritterUidList(startIndex)
	startIndex = startIndex or DEFAULT_START_INDEX

	local previewCritterUidList = {}

	if not self._newList then
		local list = self:getList()
		local listCount = #list
		local isPreviewAll = listCount <= self._curPreviewIndex
		local isStartIndexValid = startIndex <= listCount
		local remainPreviewCount = self._curPreviewIndex - startIndex
		local isMinPreviewCount = remainPreviewCount <= MIN_PREVIEW_COUNT

		if not isPreviewAll and isStartIndexValid and isMinPreviewCount then
			local maxPreviewCount = tonumber(CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.MaxPreviewCount)) or DEFAULT_MAX_PREVIEW_COUNT
			local endIndex = startIndex + maxPreviewCount - 1

			for i = startIndex, endIndex do
				local critterMO = list[i]

				if not critterMO then
					break
				end

				previewCritterUidList[#previewCritterUidList + 1] = critterMO:getId()
			end
		end

		return previewCritterUidList
	end
end

local _TEMP_EMPTY_TB = {}

function ManufactureCritterListModel:getPreviewAttrInfo(critterUid, buildingId, isPreview)
	local critterAttrDict = self.critterAttrPreviewDict

	if buildingId then
		local isNotPreview = isPreview == false

		if isNotPreview then
			if not self._buildingCritterAttrDict then
				local buildingDict = self._buildingCritterAttrPreviewDict

				critterAttrDict = buildingDict[buildingId] or self.critterAttrPreviewDict
			end
		end
	end

	return (critterAttrDict or nil) and (critterAttrDict[critterUid] or _TEMP_EMPTY_TB)
end

function ManufactureCritterListModel:setAttrPreview(infoList, buildingId, isPreview)
	if not infoList then
		return
	end

	local buildingCritterAttrDict

	if buildingId then
		local isNotPreview = isPreview == false

		if isNotPreview then
			if not self._buildingCritterAttrDict then
				local buildingDict = self._buildingCritterAttrPreviewDict

				if not buildingDict[buildingId] or isNotPreview then
					buildingDict[buildingId] = {}
				end

				buildingCritterAttrDict = buildingDict[buildingId]
			end
		end
	end

	for _, info in ipairs(infoList) do
		local critterUid = info.critterUid
		local attr = {
			isSpSkillEffect = info.isSpSkillEffect,
			efficiency = info.efficiency,
			moodCostSpeed = info.moodChangeSpeed,
			moodChangeSpeed = info.moodChangeSpeed,
			criRate = info.criRate
		}

		attr.skillTags = {}

		tabletool.addValues(attr.skillTags, info.skillTags)

		self.critterAttrPreviewDict[critterUid] = attr

		if buildingCritterAttrDict then
			buildingCritterAttrDict[critterUid] = attr
		end
	end

	local maxIndex = 0

	for critterUid, _ in pairs(self.critterAttrPreviewDict) do
		local index = 0

		if self._newList then
			for i, mo in ipairs(self._newList) do
				local id = mo:getId()

				if id == critterUid then
					index = i
				end
			end
		else
			local mo = self:getById(critterUid)

			if mo then
				index = self:getIndex(mo)
			end
		end

		if maxIndex < index then
			maxIndex = index
		end
	end

	self._curPreviewIndex = maxIndex
end

function ManufactureCritterListModel:setManufactureCritterList()
	self:setList(self._newList)

	self._newList = nil
end

function ManufactureCritterListModel:isCritterListEmpty()
	local count = self:getCount()

	return count <= 0
end

function ManufactureCritterListModel:setOrder(order)
	self._order = order
end

function ManufactureCritterListModel:getOrder()
	return self._order
end

ManufactureCritterListModel.instance = ManufactureCritterListModel.New()

return ManufactureCritterListModel
