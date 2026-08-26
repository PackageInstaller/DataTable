-- chunkname: @modules/logic/room/entity/comp/RoomBuildingClockComp.lua

module("modules.logic.room.entity.comp.RoomBuildingClockComp", package.seeall)

local RoomBuildingClockComp = class("RoomBuildingClockComp", LuaCompBase)

function RoomBuildingClockComp:ctor(entity)
	self.entity = entity
end

function RoomBuildingClockComp:init(go)
	self.go = go

	local mo = self:getMO()

	self._audioExtendType = mo.config.audioExtendType
	self._audioExtendIds = string.splitToNumber(mo.config.audioExtendIds, "#") or {}
end

function RoomBuildingClockComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.OnHourReporting, self._onHourReporting, self)
end

function RoomBuildingClockComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.OnHourReporting, self._onHourReporting, self)
end

function RoomBuildingClockComp:beforeDestroy()
	self:removeEventListeners()
end

function RoomBuildingClockComp:_onHourReporting(hour)
	if RoomController.instance:isEditMode() or not hour then
		return
	end

	if self._audioExtendType == RoomBuildingEnum.AudioExtendType.Clock12Hour then
		local tempHour = (hour - 1) % 12 + 1
		local audioExtendId = self._audioExtendIds[tempHour]

		RoomHelper.audioExtendTrigger(audioExtendId, self.go)
	end
end

function RoomBuildingClockComp:getMO()
	return self.entity:getMO()
end

return RoomBuildingClockComp
