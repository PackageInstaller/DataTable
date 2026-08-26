-- chunkname: @modules/logic/room/model/backpack/RoomBackpackCritterListModel.lua

module("modules.logic.room.model.backpack.RoomBackpackCritterListModel", package.seeall)

local RoomBackpackCritterListModel = class("RoomBackpackCritterListModel", ListScrollModel)

function RoomBackpackCritterListModel:onInit()
	self:clear()
	self:clearData()
end

function RoomBackpackCritterListModel:reInit()
	self:clearData()
end

function RoomBackpackCritterListModel:clearData()
	self:setIsSortByRareAscend(false)
	self:setMatureFilterType(CritterEnum.MatureFilterType.All)
end

local function _sortFunction(aCritterMO, bCritterMO)
	local aCritterUid = aCritterMO:getId()
	local bCritterUid = bCritterMO:getId()
	local aCritterId = aCritterMO:getDefineId()
	local bCritterId = bCritterMO:getDefineId()
	local aRare = CritterConfig.instance:getCritterRare(aCritterId)
	local bRare = CritterConfig.instance:getCritterRare(bCritterId)

	if aRare ~= bRare then
		local isRareAscend = RoomBackpackCritterListModel.instance:getIsSortByRareAscend()

		if isRareAscend then
			return aRare < bRare
		else
			return bRare < aRare
		end
	end

	local aIsWorking = false
	local aWorkingBuilding = ManufactureModel.instance:getCritterWorkingBuilding(aCritterUid)
	local aWorkingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(aCritterUid)

	aIsWorking = (aWorkingBuilding or aWorkingPathMO) and true

	local bWorkingBuilding = ManufactureModel.instance:getCritterWorkingBuilding(bCritterUid)
	local bWorkingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(bCritterUid)

	if aIsWorking ~= ((bWorkingBuilding or bWorkingPathMO) and true) then
		return aIsWorking
	end

	local aIsMature = aCritterMO:isMaturity()
	local bIsMature = bCritterMO:isMaturity()

	if aIsMature ~= bIsMature then
		return aIsMature
	end

	local aIsCultivating = aCritterMO:isCultivating()
	local bIsCultivating = bCritterMO:isCultivating()

	if aIsCultivating ~= bIsCultivating then
		return aIsCultivating
	end

	if aCritterId ~= bCritterId then
		return aCritterId < bCritterId
	end

	return aCritterUid < bCritterUid
end

function RoomBackpackCritterListModel:setBackpackCritterList(filterMO)
	local allCritterList = CritterModel.instance:getAllCritters()
	local list = {}
	local matureIsAll = not self.matureFilterType or self.matureFilterType == CritterEnum.MatureFilterType.All
	local filterIsMature = self.matureFilterType == CritterEnum.MatureFilterType.Mature

	for i, critterMO in ipairs(allCritterList) do
		if (filterMO or nil) and filterMO:isPassedFilter(critterMO) then
			if matureIsAll then
				list[#list + 1] = critterMO
			else
				local isCritterMature = critterMO:isMaturity()

				if filterIsMature and isCritterMature or not filterIsMature and not isCritterMature then
					list[#list + 1] = critterMO
				end
			end
		end
	end

	table.sort(list, _sortFunction)
	self:setList(list)
end

function RoomBackpackCritterListModel:setIsSortByRareAscend(isAscend)
	self._rareAscend = isAscend
end

function RoomBackpackCritterListModel:setMatureFilterType(filterType)
	self.matureFilterType = filterType
end

function RoomBackpackCritterListModel:getIsSortByRareAscend()
	return self._rareAscend
end

function RoomBackpackCritterListModel:getMatureFilterType()
	return self.matureFilterType
end

function RoomBackpackCritterListModel:isBackpackEmpty()
	local count = self:getCount()

	return count <= 0
end

RoomBackpackCritterListModel.instance = RoomBackpackCritterListModel.New()

return RoomBackpackCritterListModel
