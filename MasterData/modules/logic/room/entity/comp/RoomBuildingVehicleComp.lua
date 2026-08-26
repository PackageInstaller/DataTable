-- chunkname: @modules/logic/room/entity/comp/RoomBuildingVehicleComp.lua

module("modules.logic.room.entity.comp.RoomBuildingVehicleComp", package.seeall)

local RoomBuildingVehicleComp = class("RoomBuildingVehicleComp", LuaCompBase)

function RoomBuildingVehicleComp:ctor(entity)
	self.entity = entity
end

function RoomBuildingVehicleComp:init(go)
	self.go = go

	local buildingMO = self:getBuilingMO()

	self._vehicleType = buildingMO.config.vehicleType

	self:_onSwitchModel()
end

function RoomBuildingVehicleComp:addEventListeners()
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, self._onSwitchModel, self)
end

function RoomBuildingVehicleComp:removeEventListeners()
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, self._onSwitchModel, self)
end

function RoomBuildingVehicleComp:beforeDestroy()
	self:removeEventListeners()
end

function RoomBuildingVehicleComp:_onSwitchModel()
	local show = RoomController.instance:isEditMode()

	if not show and not self.entity:getVehicleMO() then
		show = true
	end

	if self._vehicleType == 1 then
		gohelper.setActive(self.entity.containerGO, show)
		gohelper.setActive(self.entity.staticContainerGO, show)
	end
end

function RoomBuildingVehicleComp:getBuilingMO()
	return self.entity:getMO()
end

return RoomBuildingVehicleComp
