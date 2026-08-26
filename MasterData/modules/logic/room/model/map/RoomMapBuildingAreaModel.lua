-- chunkname: @modules/logic/room/model/map/RoomMapBuildingAreaModel.lua

module("modules.logic.room.model.map.RoomMapBuildingAreaModel", package.seeall)

local RoomMapBuildingAreaModel = class("RoomMapBuildingAreaModel", BaseModel)

function RoomMapBuildingAreaModel:onInit()
	self:_clearData()
end

function RoomMapBuildingAreaModel:reInit()
	self:_clearData()
end

function RoomMapBuildingAreaModel:clear()
	RoomMapBuildingAreaModel.super.clear(self)
	self:_clearData()
end

function RoomMapBuildingAreaModel:_clearData()
	self._areaBuildingDict = nil
end

function RoomMapBuildingAreaModel:init()
	self:clear()
	self:refreshBuildingAreaMOList()
end

function RoomMapBuildingAreaModel:refreshBuildingAreaMOList()
	local areaMOList = {}

	self._bType2UIdDict = {}

	local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for _, buildingMO in ipairs(buildingMOList) do
		if buildingMO:isBuildingArea() and buildingMO:isAreaMainBuilding() then
			local areaMO = self:getById(buildingMO.uid)

			if not areaMO then
				areaMO = RoomMapBuildingAreaMO.New()

				areaMO:init(buildingMO)
			else
				areaMO:clearBuildingMOList()
			end

			table.insert(areaMOList, areaMO)

			if buildingMO.config then
				self._bType2UIdDict[buildingMO.config.buildingType] = areaMO.id
			end
		end
	end

	self:setList(areaMOList)
end

function RoomMapBuildingAreaModel:getTempAreaMO()
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not tempBuildingMO or not tempBuildingMO:isBuildingArea() or not tempBuildingMO:isAreaMainBuilding() then
		return nil
	end

	self._tempAreaMO = self._tempAreaMO or RoomMapBuildingAreaMO.New()

	if self._tempAreaMO.id ~= tempBuildingMO.uid or self._tempAreaMO.mainBuildingMO ~= tempBuildingMO then
		self._tempAreaMO:init(tempBuildingMO)
	end

	return self._tempAreaMO
end

function RoomMapBuildingAreaModel:refreshAreaMOByBType(buildingType)
	self:_refreshAreaMOById(self._bType2UIdDict[buildingType])
end

function RoomMapBuildingAreaModel:refreshAreaMOByBId(buildingId)
	local cfg = RoomConfig.instance:getBuildingConfig(buildingId)

	if cfg then
		self:refreshAreaMOByBType(cfg.buildingType)
	end
end

function RoomMapBuildingAreaModel:refreshAreaMOByBUId(buildingUId)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUId)

	if buildingMO and buildingMO.config then
		self:refreshAreaMOByBType(buildingMO.config.buildingType)
	end
end

function RoomMapBuildingAreaModel:_refreshAreaMOById(id)
	local areaMO = self:getById(id)

	if areaMO then
		areaMO:clearBuildingMOList()
	end
end

function RoomMapBuildingAreaModel:getAreaMOByBType(buildingType)
	return self:getById(self._bType2UIdDict[buildingType])
end

function RoomMapBuildingAreaModel:getAreaMOByBId(buildingId)
	local cfg = RoomConfig.instance:getBuildingConfig(buildingId)

	if cfg then
		return self:getAreaMOByBType(cfg.buildingType)
	end
end

function RoomMapBuildingAreaModel:getAreaMOByBUId(buildingUId)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUId)

	if buildingMO and buildingMO.config then
		self:getAreaMOByBType(buildingMO.config.buildingType)
	end
end

function RoomMapBuildingAreaModel:getBuildingType2AreaMODict()
	local result = {}
	local areaMoList = self:getList()

	for _, areaMo in ipairs(areaMoList) do
		local buildingType = areaMo:getBuildingType()

		result[buildingType] = areaMo
	end

	return result
end

function RoomMapBuildingAreaModel:getBuildingUidByType(buildingType)
	return self._bType2UIdDict[buildingType]
end

function RoomMapBuildingAreaModel:logTest()
	local areaMOList = self:getList()

	for _, areaMO in ipairs(areaMOList) do
		local mainBuildingMO = areaMO.mainBuildingMO

		if mainBuildingMO then
			self:_logByBuildingId(mainBuildingMO.buildingId, areaMO:getRangesHexPointList())
		end
	end
end

function RoomMapBuildingAreaModel:_logByBuildingId(buildingId, rangsHexList)
	local buildingConfig = RoomConfig.instance:getBuildingConfig(buildingId)

	if not buildingConfig then
		return
	end

	local listStr = string.format("name:%s id:%s -->", buildingConfig.name, buildingId)

	for _, hexPoint in ipairs(rangsHexList) do
		if hexPoint then
			listStr = string.format("%s (%s,%s)", listStr, hexPoint.x, hexPoint.y)
		end
	end

	logNormal(listStr)
end

RoomMapBuildingAreaModel.instance = RoomMapBuildingAreaModel.New()

return RoomMapBuildingAreaModel
