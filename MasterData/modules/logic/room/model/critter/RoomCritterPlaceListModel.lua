-- chunkname: @modules/logic/room/model/critter/RoomCritterPlaceListModel.lua

module("modules.logic.room.model.critter.RoomCritterPlaceListModel", package.seeall)

local RoomCritterPlaceListModel = class("RoomCritterPlaceListModel", ListScrollModel)

function RoomCritterPlaceListModel:onInit()
	self:clear()
	self:clearData()
end

function RoomCritterPlaceListModel:reInit()
	self:clearData()
end

function RoomCritterPlaceListModel:clearData()
	self:setOrder(CritterEnum.OrderType.MoodUp)
end

local function _sortFunction(aCritterMO, bCritterMO)
	local aCritterUid = aCritterMO:getId()
	local bCritterUid = bCritterMO:getId()
	local aRestBuilding = ManufactureModel.instance:getCritterRestingBuilding(aCritterUid)
	local bRestBuilding = ManufactureModel.instance:getCritterRestingBuilding(bCritterUid)
	local aIsRestInCurBuilding = false
	local bIsRestInCurBuilding = false
	local tmpCurBuildingUid = RoomCritterPlaceListModel.instance:getTmpBuildingUid()

	if tmpCurBuildingUid then
		aIsRestInCurBuilding = aRestBuilding == tmpCurBuildingUid
		bIsRestInCurBuilding = bRestBuilding == tmpCurBuildingUid
	end

	if aIsRestInCurBuilding ~= bIsRestInCurBuilding then
		return aIsRestInCurBuilding
	end

	local order = RoomCritterPlaceListModel.instance:getOrder()
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

	local aIsWorking = false
	local aWorkingBuilding = ManufactureModel.instance:getCritterWorkingBuilding(aCritterUid)
	local aWorkingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(aCritterUid)

	aIsWorking = (aWorkingBuilding or aWorkingPathMO) and true

	local bWorkingBuilding = ManufactureModel.instance:getCritterWorkingBuilding(bCritterUid)
	local bWorkingPathMO = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(bCritterUid)

	if aIsWorking ~= ((bWorkingBuilding or bWorkingPathMO) and true) then
		return aIsWorking
	end

	local aIsRest = not not aRestBuilding
	local bIsRest = not not bRestBuilding

	if aIsRest ~= bIsRest then
		return bIsRest
	end

	if aCritterId ~= bCritterId then
		return aCritterId < bCritterId
	end

	return aCritterUid < bCritterUid
end

function RoomCritterPlaceListModel:setCritterPlaceList(buildingUid)
	local list = {}
	local critterMOList = CritterModel.instance:getAllCritters()

	for _, critterMO in ipairs(critterMOList) do
		local isCultivating = critterMO:isCultivating()

		if not isCultivating then
			table.insert(list, critterMO)
		end
	end

	self:setTmpBuildingUid(buildingUid)
	table.sort(list, _sortFunction)
	self:setTmpBuildingUid()
	self:setList(list)
	self:refreshSelectList(buildingUid)
end

function RoomCritterPlaceListModel:setTmpBuildingUid(buildingUid)
	self._tmpBuildingUid = buildingUid
end

function RoomCritterPlaceListModel:getTmpBuildingUid()
	return self._tmpBuildingUid
end

function RoomCritterPlaceListModel:refreshSelectList(buildingUid)
	local selectMOList = {}
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	if buildingMO then
		local list = self:getList()

		for _, critterMO in ipairs(list) do
			local critterUid = critterMO:getId()
			local isInSeatSlot = buildingMO:isCritterInSeatSlot(critterUid)

			if isInSeatSlot then
				selectMOList[#selectMOList + 1] = critterMO
			end
		end
	end

	for _, view in ipairs(self._scrollViews) do
		view:setSelectList(selectMOList)
	end
end

function RoomCritterPlaceListModel:setOrder(order)
	self._order = order
end

function RoomCritterPlaceListModel:getOrder()
	return self._order
end

RoomCritterPlaceListModel.instance = RoomCritterPlaceListModel.New()

return RoomCritterPlaceListModel
