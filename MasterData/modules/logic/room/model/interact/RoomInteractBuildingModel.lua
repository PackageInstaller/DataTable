-- chunkname: @modules/logic/room/model/interact/RoomInteractBuildingModel.lua

module("modules.logic.room.model.interact.RoomInteractBuildingModel", package.seeall)

local RoomInteractBuildingModel = class("RoomInteractBuildingModel", BaseModel)

function RoomInteractBuildingModel:onInit()
	self:reInit()
end

function RoomInteractBuildingModel:reInit()
	return
end

function RoomInteractBuildingModel:clear()
	RoomInteractBuildingModel.super.clear(self)

	self._heroId2BuildingUidDict = {}
end

function RoomInteractBuildingModel:init()
	self._heroId2BuildingUidDict = {}

	local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()
	local tRoomCharacterModel = RoomCharacterModel.instance

	for _, buildingMO in ipairs(buildingMOList) do
		local interactMO = buildingMO:getInteractMO()

		if interactMO then
			local buildingUid = interactMO.id
			local heroIdList = interactMO:getHeroIdList()

			for i = #heroIdList, 1, -1 do
				local heroId = heroIdList[i]

				if tRoomCharacterModel:getCharacterMOById(heroId) == nil then
					interactMO:removeHeroId(heroId)
				elseif self._heroId2BuildingUidDict[heroId] == nil then
					self._heroId2BuildingUidDict[heroId] = buildingUid
				elseif self._heroId2BuildingUidDict[heroId] ~= buildingUid then
					interactMO:removeHeroId(heroId)
				end
			end
		end
	end
end

function RoomInteractBuildingModel:checkAllHero()
	local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for _, buildingMO in ipairs(buildingMOList) do
		local interactMO = buildingMO:getInteractMO()

		if interactMO then
			interactMO:checkHeroIdList()
		end
	end
end

function RoomInteractBuildingModel:setSelectBuildingMO(buildingMO)
	self._selectBuildingMO = buildingMO
	self._selectInteractMO = nil

	if buildingMO then
		self._selectInteractMO = buildingMO:getInteractMO()
	end
end

function RoomInteractBuildingModel:isSelectHeroId(heroId)
	if self._selectInteractMO and self._selectInteractMO:isHasHeroId(heroId) then
		return true
	end

	return false
end

function RoomInteractBuildingModel:addInteractHeroId(buildingUid, heroId)
	local interactMO = self:_getInteractMOByUid(buildingUid)

	if interactMO and not interactMO:isHeroMax() then
		local oldUid = self._heroId2BuildingUidDict[heroId]

		self._heroId2BuildingUidDict[heroId] = buildingUid

		interactMO:addHeroId(heroId)

		if oldUid then
			self:removeInteractHeroId(oldUid, heroId)
		end
	end
end

function RoomInteractBuildingModel:removeInteractHeroId(buildingUid, heroId)
	local interactMO = self:_getInteractMOByUid(buildingUid)

	if interactMO and interactMO:isHasHeroId(heroId) then
		interactMO:removeHeroId(heroId)

		if self._heroId2BuildingUidDict[heroId] == buildingUid then
			self._heroId2BuildingUidDict[heroId] = nil
		end
	end
end

function RoomInteractBuildingModel:_getInteractMOByUid(buildingUid)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

	if buildingMO then
		return buildingMO:getInteractMO()
	end

	return nil
end

RoomInteractBuildingModel.instance = RoomInteractBuildingModel.New()

return RoomInteractBuildingModel
