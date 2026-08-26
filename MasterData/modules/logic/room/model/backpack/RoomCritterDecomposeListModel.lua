-- chunkname: @modules/logic/room/model/backpack/RoomCritterDecomposeListModel.lua

module("modules.logic.room.model.backpack.RoomCritterDecomposeListModel", package.seeall)

local RoomCritterDecomposeListModel = class("RoomCritterDecomposeListModel", ListScrollModel)
local MAX_DECOMPOSE_RATE = 6

function RoomCritterDecomposeListModel:onInit()
	self:clear()
	self:clearData()
end

function RoomCritterDecomposeListModel:reInit()
	self:clearData()
end

function RoomCritterDecomposeListModel:clearData()
	self:clearCritterList()
	self:setIsSortByRareAscend(false)
	self:setFilterRare(CritterEnum.CritterDecomposeMinRare)
	self:setFilterMature(CritterEnum.MatureFilterType.All)
end

function RoomCritterDecomposeListModel:clearCritterList()
	if self.critterList then
		tabletool.clear(self.critterList)
	else
		self.critterList = {}
	end

	self:clearSelectedCritter()
end

function RoomCritterDecomposeListModel:clearSelectedCritter()
	if self.selectedCritterDict then
		tabletool.clear(self.selectedCritterDict)
	else
		self.selectedCritterDict = {}
	end

	self.selectedCritterCount = 0

	CritterController.instance:dispatchEvent(CritterEvent.CritterDecomposeChangeSelect)
end

function RoomCritterDecomposeListModel:updateCritterList(filterMO)
	self:clearCritterList()

	local allCritterList = CritterModel.instance:getAllCritters()
	local isAllFilter = not self.filterMature or self.filterMature == CritterEnum.MatureFilterType.All
	local isMatureFilter = self.filterMature == CritterEnum.MatureFilterType.Mature

	for _, critterMO in ipairs(allCritterList) do
		local isCanDecompose = false

		if isAllFilter then
			isCanDecompose = self:checkCanDecompose(critterMO, filterMO)
		else
			local isCritterMature = critterMO:isMaturity()

			if isMatureFilter and isCritterMature or not isMatureFilter and not isCritterMature then
				isCanDecompose = self:checkCanDecompose(critterMO, filterMO)
			end
		end

		if isCanDecompose then
			table.insert(self.critterList, critterMO)
		end
	end

	self:sortCritterList()
end

function RoomCritterDecomposeListModel:checkCanDecompose(critterMO, filterMO)
	local result = false
	local isUnlock = critterMO and not critterMO:isLock()

	if isUnlock then
		local critterUid = critterMO:getId()
		local critterCfg = critterMO:getDefineCfg()
		local isCultivate = critterMO:isCultivating()
		local workBuilding = ManufactureModel.instance:getCritterWorkingBuilding(critterUid)
		local workingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(critterUid)

		if not isCultivate and not workBuilding and not workingPathMO and critterCfg.rare < MAX_DECOMPOSE_RATE then
			result = filterMO and filterMO:isPassedFilter(critterMO) or true
		end
	end

	return result
end

function RoomCritterDecomposeListModel:sortCritterList()
	local isRareAscend = self:getIsSortByRareAscend()

	if isRareAscend then
		table.sort(self.critterList, CritterHelper.sortByRareAscend)
	else
		table.sort(self.critterList, CritterHelper.sortByRareDescend)
	end
end

function RoomCritterDecomposeListModel:refreshCritterShowList()
	self:setList(self.critterList)
end

function RoomCritterDecomposeListModel:checkDecomposeCountLimit()
	local result = true
	local strCountLimit = CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.DecomposeCountLimit)
	local countLimit = tonumber(strCountLimit)

	if countLimit and self.selectedCritterDict then
		local hasMaturityCritterCount = 0
		local decomposeMaturityCritterCount = 0
		local allCritterList = CritterModel.instance:getAllCritters()

		for _, critterMO in ipairs(allCritterList) do
			local isCritterMature = critterMO:isMaturity()

			if isCritterMature then
				hasMaturityCritterCount = hasMaturityCritterCount + 1

				local critterUid = critterMO:getId()

				if self.selectedCritterDict[critterUid] then
					decomposeMaturityCritterCount = decomposeMaturityCritterCount + 1
				end
			end
		end

		local remainMaturityCritterCount = hasMaturityCritterCount - decomposeMaturityCritterCount

		if remainMaturityCritterCount < countLimit then
			result = false
		end
	end

	return result
end

function RoomCritterDecomposeListModel:fastAddCritter()
	tabletool.clear(self.selectedCritterDict)

	self.selectedCritterCount = 0

	for _, critterMO in ipairs(self.critterList) do
		local isLock = critterMO:isLock()

		if not isLock then
			local config = critterMO:getDefineCfg()
			local filterRare = self:getFilterRare()

			if filterRare >= config.rare then
				self.selectedCritterCount = self.selectedCritterCount + 1
				self.selectedCritterDict[critterMO.id] = true
			end

			if self.selectedCritterCount >= CritterEnum.DecomposeMaxCount then
				break
			end
		end
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterDecomposeChangeSelect)
end

function RoomCritterDecomposeListModel:selectDecomposeCritter(critterMO)
	if self.selectedCritterCount >= CritterEnum.DecomposeMaxCount then
		return
	end

	if self.selectedCritterDict[critterMO.id] then
		return
	end

	self.selectedCritterDict[critterMO.id] = true
	self.selectedCritterCount = self.selectedCritterCount + 1

	CritterController.instance:dispatchEvent(CritterEvent.CritterDecomposeChangeSelect)
end

function RoomCritterDecomposeListModel:unselectDecomposeCritter(critterMO)
	if not self.selectedCritterDict[critterMO.id] then
		return
	end

	self.selectedCritterDict[critterMO.id] = nil
	self.selectedCritterCount = self.selectedCritterCount - 1

	CritterController.instance:dispatchEvent(CritterEvent.CritterDecomposeChangeSelect)
end

function RoomCritterDecomposeListModel:isSelect(critterUid)
	return self.selectedCritterDict[critterUid]
end

function RoomCritterDecomposeListModel:getSelectCount()
	return self.selectedCritterCount
end

function RoomCritterDecomposeListModel:getDecomposeCritterCount()
	local result = 0

	if self.selectedCritterDict then
		for critterUid, _ in pairs(self.selectedCritterDict) do
			local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)
			local critterCfg = critterMO:getDefineCfg()
			local list = DungeonConfig.instance:getRewardItems(critterCfg.banishBonus)

			for _, v in ipairs(list) do
				result = result + v[3]
			end
		end
	end

	return result
end

function RoomCritterDecomposeListModel:getSelectUIds()
	local result = {}

	for uid, _ in pairs(self.selectedCritterDict) do
		result[#result + 1] = uid
	end

	return result
end

function RoomCritterDecomposeListModel:setFilterMature(filterMature)
	self.filterMature = filterMature
end

function RoomCritterDecomposeListModel:setFilterRare(filterRare)
	self.filterRare = filterRare
end

function RoomCritterDecomposeListModel:setIsSortByRareAscend(isAscend)
	self._rareAscend = isAscend

	CritterController.instance:dispatchEvent(CritterEvent.CritterChangeSort)
end

function RoomCritterDecomposeListModel:getFilterMature()
	return self.filterMature or CritterEnum.MatureFilterType.All
end

function RoomCritterDecomposeListModel:getFilterRare()
	return self.filterRare or CritterEnum.CritterDecomposeMinRare
end

function RoomCritterDecomposeListModel:getIsSortByRareAscend()
	return self._rareAscend
end

function RoomCritterDecomposeListModel:isEmpty()
	local count = self:getCount()

	return count <= 0
end

RoomCritterDecomposeListModel.instance = RoomCritterDecomposeListModel.New()

return RoomCritterDecomposeListModel
