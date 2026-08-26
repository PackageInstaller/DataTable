-- chunkname: @modules/logic/room/model/map/RoomCritterModel.lua

module("modules.logic.room.model.map.RoomCritterModel", package.seeall)

local RoomCritterModel = class("RoomCritterModel", BaseModel)

function RoomCritterModel:onInit()
	self:_clearData()
end

function RoomCritterModel:reInit()
	self:_clearData()
end

function RoomCritterModel:_clearData()
	self:clearBuildingCritterData()
end

function RoomCritterModel:clearBuildingCritterData()
	self._buildingCritterList = {}
	self._buildingCritterDict = {}
end

function RoomCritterModel:initCititer(infos)
	self:clear()

	local moList = {}

	if infos then
		for _, info in ipairs(infos) do
			local critterMO = RoomCritterMO.New()

			critterMO:init(info)
			table.insert(moList, critterMO)
		end
	end

	self:setList(moList)
end

function RoomCritterModel:initStayBuildingCritters()
	self:clearBuildingCritterData()

	local allManufactureMOList = ManufactureModel.instance:getAllManufactureMOList()

	for _, manufactureMO in ipairs(allManufactureMOList) do
		local slot2CritterDict = manufactureMO:getSlot2CritterDict()

		if slot2CritterDict then
			local buildingUid = manufactureMO:getBuildingUid()

			for slotId, critterUid in pairs(slot2CritterDict) do
				local roomCritterMO = RoomCritterMO.New()

				roomCritterMO:initWithBuildingValue(critterUid, buildingUid, slotId)

				self._buildingCritterList[#self._buildingCritterList + 1] = roomCritterMO
				self._buildingCritterDict[critterUid] = roomCritterMO
			end
		end
	end

	local allCritterBuildingMOList = ManufactureModel.instance:getAllCritterBuildingMOList()

	for _, critterBuildingMO in ipairs(allCritterBuildingMOList) do
		local seaSlot2CritterDict = critterBuildingMO:getSeatSlot2CritterDict()
		local buildingUid = critterBuildingMO:getBuildingUid()

		for slotId, critterUid in pairs(seaSlot2CritterDict) do
			local roomCritterMO = RoomCritterMO.New()

			roomCritterMO:initWithBuildingValue(critterUid, buildingUid, slotId)

			self._buildingCritterList[#self._buildingCritterList + 1] = roomCritterMO
			self._buildingCritterDict[critterUid] = roomCritterMO
		end
	end
end

function RoomCritterModel:getRoomBuildingCritterList()
	return self._buildingCritterList
end

function RoomCritterModel:getCritterMOById(uid)
	local result = self:getById(uid)

	if not result and self._buildingCritterDict then
		result = self._buildingCritterDict[uid]
	end

	if not result and self._tempCritterMO and uid == self._tempCritterMO.uid then
		return self._tempCritterMO
	end

	return result
end

function RoomCritterModel:getTrainCritterMOList()
	return self:getList()
end

function RoomCritterModel:removeTrainCritterMO(critterMO)
	self:remove(critterMO)
end

function RoomCritterModel:getAllCritterList()
	local result = {}
	local sceneCritterList = self:getList()
	local buildingCritterList = self:getRoomBuildingCritterList()

	tabletool.addValues(result, sceneCritterList)
	tabletool.addValues(result, buildingCritterList)

	return result
end

function RoomCritterModel:getTempCritterMO()
	self._tempCritterMO = self._tempCritterMO or RoomCritterMO.New()

	return self._tempCritterMO
end

RoomCritterModel.instance = RoomCritterModel.New()

return RoomCritterModel
