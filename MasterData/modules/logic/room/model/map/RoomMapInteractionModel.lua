-- chunkname: @modules/logic/room/model/map/RoomMapInteractionModel.lua

module("modules.logic.room.model.map.RoomMapInteractionModel", package.seeall)

local RoomMapInteractionModel = class("RoomMapInteractionModel", BaseModel)

function RoomMapInteractionModel:onInit()
	self:_clearData()
end

function RoomMapInteractionModel:reInit()
	self:_clearData()
end

function RoomMapInteractionModel:clear()
	RoomMapInteractionModel.super.clear(self)
	self:_clearData()
end

function RoomMapInteractionModel:init()
	self:clear()
end

function RoomMapInteractionModel:_clearData()
	self._buildingInteraction = {}
	self._buildingHexpointIndexDic = {}

	if self._builidngInteractionModel then
		self._builidngInteractionModel:clear()
	else
		self._builidngInteractionModel = BaseModel.New()
	end
end

function RoomMapInteractionModel:initInteraction()
	self:_clearData()

	local configList = RoomConfig.instance:getCharacterInteractionConfigList()

	self.hexPointRanges = HexPoint.Zero:getInRanges(2)

	for i = 1, #configList do
		local cfg = configList[i]

		if cfg.behaviour == RoomCharacterEnum.InteractionType.Building then
			self:_addInteractionBuilding(cfg)
		end
	end
end

function RoomMapInteractionModel:getBuildingRangeIndexList(buildingUid)
	return self._buildingHexpointIndexDic[buildingUid]
end

function RoomMapInteractionModel:_addInteractionBuilding(cfg)
	local buildingMOList = self:_getBuildingMOListByBuildingId(cfg.buildingId)

	if buildingMOList and #buildingMOList > 0 then
		local buildingUids = {}

		self._buildingInteraction[cfg.id] = buildingUids

		for _, mo in ipairs(buildingMOList) do
			table.insert(buildingUids, mo.id)

			self._buildingHexpointIndexDic[mo.id] = self._buildingHexpointIndexDic[mo.id] or self:_getBuildingRangeIndex(mo.buildingId, mo.hexPoint, mo.rotate, self.hexPointRanges)
		end

		local mo = RoomInteractionMO.New()

		mo:init(cfg.id, cfg.id, buildingUids)
		self._builidngInteractionModel:addAtLast(mo)
	end
end

function RoomMapInteractionModel:_getBuildingMOListByBuildingId(buildingId)
	local tempMOlist = {}
	local list = RoomMapBuildingModel.instance:getList()

	for i = 1, #list do
		local buildingMO = list[i]

		if buildingMO.buildingId == buildingId then
			table.insert(tempMOlist, buildingMO)
		end
	end

	return tempMOlist
end

function RoomMapInteractionModel:_getBuildingRangeIndex(buildingId, hexPoint, rotate, hexPointRanges)
	local list = {}
	local tRoomResourceModel = RoomResourceModel.instance
	local occupyDict = RoomBuildingHelper.getOccupyDict(buildingId, hexPoint, rotate)

	for x, dict in pairs(occupyDict) do
		for y, _ in pairs(dict) do
			for i = 1, #hexPointRanges do
				local neighbor = hexPointRanges[i]
				local dx = x + neighbor.x
				local dy = neighbor.y + y
				local index = tRoomResourceModel:getIndexByXY(dx, dy)

				if not tabletool.indexOf(list, index) then
					table.insert(list, index)
				end
			end
		end
	end

	return list
end

function RoomMapInteractionModel:getBuildingInteractionMOList()
	return self._builidngInteractionModel:getList()
end

function RoomMapInteractionModel:getBuildingInteractionMO(id)
	return self._builidngInteractionModel:getById(id)
end

RoomMapInteractionModel.instance = RoomMapInteractionModel.New()

return RoomMapInteractionModel
