-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/room/UnitCompRoomModel.lua

module("logic.extensions.house.scene.unit.component.room.UnitCompRoomModel", package.seeall)

local M = class("UnitCompRoomModel", UnitComponentBase)
local RoomType = HouseEnum.RoomType
local RoomSize = HouseEnum.RoomSize

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._roomCO = nil
	self._ringType = nil
	self._subRoomType = nil
	self._navigationMO = nil
	self._leftElevatorId = nil
	self._rightElevatorId = nil
end

function M:onInit()
	self:_resetData()
end

function M:_resetData()
	self._roomCO = false
	self._ringType = false
	self._subRoomType = 0
	self._navigationMO = false
	self._leftElevatorId = false
	self._rightElevatorId = false
end

function M:onReuse()
	return
end

function M:onReset()
	self:_resetData()
end

function M:onDestroy()
	self:onReset()
end

function M:setRoomCO(roomCO)
	self._roomCO = roomCO
	self._ringType = NavMeshUtil.getRingTypeByZoneId(self._roomCO.id)

	self:refreshRoomType()
end

function M:refreshRoomType()
	self._subRoomType = 0

	if self:getRoomType() == RoomType.Shelter then
		local id = self:getRoomId()
		local protomerId = ContainmentModel.instance:getProtomerId(id)

		if protomerId > 0 then
			local protomerCO = ContainmentConfig.instance:getProtomerCoById(protomerId)

			self._subRoomType = protomerCO.shelterRoomType
		end
	elseif self:getRoomType() == RoomType.Living then
		local openType = self:getOpenType()

		if openType == HouseMainEnum.RoomOpenTyp.OpenActive or openType == HouseMainEnum.RoomOpenTyp.OpenUnActive then
			self._subRoomType = self._roomCO.size == RoomSize.Big and 7 or 1
		end
	end
end

function M:getOpenType()
	return HouseMainRoomModel.instance:getRoomOpenTyp(self:getRoomId())
end

function M:getRoomCO()
	return self._roomCO
end

function M:getRoomId()
	return self._roomCO.id
end

function M:getRoomType()
	return self._roomCO.roomType
end

function M:getSubRoomType()
	return self._subRoomType
end

function M:getLivingType()
	local zoneMo = LivingFacilitiesZoneModel.instance:getZoneById(self:getRoomId())

	return zoneMo:getType()
end

function M:getSizeType()
	return self._roomCO.size
end

function M:getRoomAngle()
	return self._roomCO.angle
end

function M:getRingType()
	return self._ringType
end

function M:setNavigationData(navMO)
	self._navigationMO = navMO

	self:_setNearElevatorData()
end

function M:_setNearElevatorData()
	local leftSuitPos = self._navigationMO:getLeftSuitPos()

	if leftSuitPos then
		self._leftElevatorId = HouseSceneUtil.getNearestElevatorId(leftSuitPos, self._ringType)
	end

	local rightSuitPos = self._navigationMO:getRightSuitPos()

	if rightSuitPos then
		self._rightElevatorId = HouseSceneUtil.getNearestElevatorId(rightSuitPos, self._ringType)
	end
end

function M:getNavigationData()
	return self._navigationMO
end

function M:getNearElevatorIds()
	if not self._leftElevatorId then
		self:_setNearElevatorData()
	end

	return {
		self._leftElevatorId,
		self._rightElevatorId
	}
end

function M:getLeftElevatorAndSuit()
	if not self._leftElevatorId then
		self:_setNearElevatorData()
	end

	local navMO = self:getNavigationData()

	return self._leftElevatorId, navMO:getLeftSuitPos()
end

function M:getRightElevatorAndSuit()
	if not self._rightElevatorId then
		self:_setNearElevatorData()
	end

	local navMO = self:getNavigationData()

	return self._rightElevatorId, navMO:getRightSuitPos()
end

function M:setLinkEnabled(enabled)
	local leftLink = self._navigationMO:getLeftLink()

	if leftLink then
		leftLink.enabled = enabled
	end

	local rightLink = self._navigationMO:getRightLink()

	if rightLink then
		rightLink.enabled = enabled
	end
end

function M:getShelterDevicePos()
	return -4.94, 0.74, 2.8
end

return M
