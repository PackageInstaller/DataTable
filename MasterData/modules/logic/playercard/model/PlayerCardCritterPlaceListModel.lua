-- chunkname: @modules/logic/playercard/model/PlayerCardCritterPlaceListModel.lua

module("modules.logic.playercard.model.PlayerCardCritterPlaceListModel", package.seeall)

local PlayerCardCritterPlaceListModel = class("PlayerCardCritterPlaceListModel", ListScrollModel)

function PlayerCardCritterPlaceListModel:onInit()
	self:clear()
	self:clearData()
end

function PlayerCardCritterPlaceListModel:reInit()
	self:clearData()
end

function PlayerCardCritterPlaceListModel:clearData()
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
	local IsASelecting = tonumber(aCritterUid) == PlayerCardModel.instance:getSelectCritterUid()
	local IsBSelecting = tonumber(bCritterUid) == PlayerCardModel.instance:getSelectCritterUid()

	if IsASelecting ~= IsBSelecting then
		return IsASelecting
	end

	if aRare ~= bRare then
		local isRareAscend = PlayerCardCritterPlaceListModel.instance:getIsSortByRareAscend()

		if isRareAscend then
			return aRare < bRare
		else
			return bRare < aRare
		end
	end

	local aIsMutate = aCritterMO:isMutate()
	local bIsMutate = bCritterMO:isMutate()

	if aIsMutate ~= bIsMutate then
		return aIsMutate
	end

	local aIsMature = aCritterMO:isMaturity()
	local bIsMature = bCritterMO:isMaturity()

	if aIsMature ~= bIsMature then
		return aIsMature
	end

	if aCritterId ~= bCritterId then
		return aCritterId < bCritterId
	end

	return aCritterUid < bCritterUid
end

function PlayerCardCritterPlaceListModel:setPlayerCardCritterList(filterMO)
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

function PlayerCardCritterPlaceListModel:setIsSortByRareAscend(isAscend)
	self._rareAscend = isAscend
end

function PlayerCardCritterPlaceListModel:setMatureFilterType(filterType)
	self.matureFilterType = filterType
end

function PlayerCardCritterPlaceListModel:getIsSortByRareAscend()
	return self._rareAscend
end

function PlayerCardCritterPlaceListModel:getMatureFilterType()
	return self.matureFilterType
end

function PlayerCardCritterPlaceListModel:selectMatureFilterType(newFilterType, filterMO)
	local matureFilterType = self:getMatureFilterType()

	if matureFilterType and matureFilterType == newFilterType then
		return
	end

	self:setMatureFilterType(newFilterType)
	self:setPlayerCardCritterList(filterMO)
end

PlayerCardCritterPlaceListModel.instance = PlayerCardCritterPlaceListModel.New()

return PlayerCardCritterPlaceListModel
