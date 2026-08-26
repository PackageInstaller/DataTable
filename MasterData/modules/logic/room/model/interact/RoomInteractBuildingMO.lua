-- chunkname: @modules/logic/room/model/interact/RoomInteractBuildingMO.lua

module("modules.logic.room.model.interact.RoomInteractBuildingMO", package.seeall)

local RoomInteractBuildingMO = pureTable("RoomInteractBuildingMO")

function RoomInteractBuildingMO:init(buildingMO)
	self.id = buildingMO.buildingUId
	self.buildingMO = buildingMO
	self._interactHeroIdList = {}
	self._interactHeroIdMap = {}
	self.config = RoomConfig.instance:getInteractBuildingConfig(buildingMO.buildingId)
end

function RoomInteractBuildingMO:clear()
	if #self._interactHeroIdList > 0 then
		for i = #self._interactHeroIdList, 1, -1 do
			self._interactHeroIdMap[self._interactHeroIdList[i]] = false

			table.remove(self._interactHeroIdList, i)
		end
	end
end

function RoomInteractBuildingMO:addHeroId(heroId)
	if not self._interactHeroIdMap[heroId] then
		self._interactHeroIdMap[heroId] = true

		table.insert(self._interactHeroIdList, heroId)
	end
end

function RoomInteractBuildingMO:removeHeroId(heroId)
	if self._interactHeroIdMap[heroId] then
		self._interactHeroIdMap[heroId] = false

		tabletool.removeValue(self._interactHeroIdList, heroId)
	end
end

function RoomInteractBuildingMO:getHeroIdList()
	return self._interactHeroIdList
end

function RoomInteractBuildingMO:getHeroCount()
	return #self._interactHeroIdList
end

function RoomInteractBuildingMO:isHeroMax()
	if self:getHeroCount() >= self:getHeroMax() then
		return true
	end

	return false
end

function RoomInteractBuildingMO:getHeroMax()
	if self.config then
		return self.config.heroCount
	end

	return 1
end

function RoomInteractBuildingMO:isFindPath()
	if self.config and self.config.interactType == 1 then
		return true
	end

	return false
end

function RoomInteractBuildingMO:isHasHeroId(heroId)
	if self._interactHeroIdMap[heroId] then
		return true
	end

	return false
end

function RoomInteractBuildingMO:checkHeroIdList()
	if not self._interactHeroIdList then
		return
	end

	local tRoomCharacterModel = RoomCharacterModel.instance

	for i = #self._interactHeroIdList, 1, -1 do
		local heroId = self._interactHeroIdList[i]

		if tRoomCharacterModel:getCharacterMOById(heroId) == nil then
			table.remove(self._interactHeroIdList, i)

			self._interactHeroIdMap[heroId] = false
		end
	end
end

return RoomInteractBuildingMO
