-- chunkname: @modules/logic/room/entity/comp/RoomBuildingReflectionComp.lua

module("modules.logic.room.entity.comp.RoomBuildingReflectionComp", package.seeall)

local RoomBuildingReflectionComp = class("RoomBuildingReflectionComp", LuaCompBase)

function RoomBuildingReflectionComp:ctor(entity)
	self.entity = entity
	self._effectKey = RoomEnum.EffectKey.BuildingGOKey
end

function RoomBuildingReflectionComp:init(go)
	self.go = go

	local mo = self:getMO()

	self._isReflection = self:_checkReflection()
end

function RoomBuildingReflectionComp:addEventListeners()
	RoomBuildingController.instance:registerCallback(RoomEvent.DropBuildingDown, self._onDropBuildingDown, self)
end

function RoomBuildingReflectionComp:removeEventListeners()
	RoomBuildingController.instance:unregisterCallback(RoomEvent.DropBuildingDown, self._onDropBuildingDown, self)
end

function RoomBuildingReflectionComp:beforeDestroy()
	self:removeEventListeners()
end

function RoomBuildingReflectionComp:_onDropBuildingDown()
	self:refreshReflection()
end

function RoomBuildingReflectionComp:refreshReflection()
	local isReflection = self:_checkReflection()

	if self._isReflection ~= isReflection then
		self._isReflection = isReflection

		self:_updateReflection()
	end
end

function RoomBuildingReflectionComp:_updateReflection()
	local golist = self.entity.effect:getGameObjectsByName(self._effectKey, RoomEnum.EntityChildKey.ReflerctionGOKey)

	if golist and #golist > 0 then
		for i, tempGO in ipairs(golist) do
			gohelper.setActive(tempGO, self._isReflection)
		end
	end
end

function RoomBuildingReflectionComp:_checkReflection()
	if self.entity.id == RoomBuildingController.instance:isPressBuilding() then
		return false
	end

	local occupyDict, hexPointList = self:_getOccupyDict()

	if not occupyDict then
		return false
	end

	local tRoomMapBlockModel = RoomMapBlockModel.instance

	for i, hexPoint in ipairs(hexPointList) do
		local blockMO = tRoomMapBlockModel:getBlockMO(hexPoint.x, hexPoint.y)

		if blockMO and blockMO:isInMapBlock() and blockMO:hasRiver() then
			return true
		end
	end

	return false
end

function RoomBuildingReflectionComp:_getOccupyDict()
	return self.entity:getOccupyDict()
end

function RoomBuildingReflectionComp:getMO()
	return self.entity:getMO()
end

function RoomBuildingReflectionComp:onEffectRebuild()
	local effect = self.entity.effect

	if effect:isHasEffectGOByKey(self._effectKey) and not effect:isSameResByKey(self._effectKey, self._effectRes) then
		self._effectRes = effect:getEffectRes(self._effectKey)

		self:_updateReflection()
	end
end

return RoomBuildingReflectionComp
