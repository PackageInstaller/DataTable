-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/model/UnitCompScheduleModel.lua

module("logic.scene.unit.component.model.UnitCompScheduleModel", package.seeall)

local M = class("UnitCompScheduleModel", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._targetRoomId = 0
	self._scheduleData = nil
	self._curWorkStatus = nil
	self._curWorkType = nil
end

function M:onInit()
	self._targetRoomId = 0
	self._scheduleData = nil
	self._curWorkStatus = nil
	self._curWorkType = nil
end

function M:onReset()
	self._targetRoomId = 0
	self._scheduleData = nil
	self._curWorkStatus = nil
	self._curWorkType = nil
end

function M:onDestroy()
	self:onReset()
end

function M:setScheduleTargetRoomId(roomId)
	self._targetRoomId = roomId
end

function M:getScheduleTargetRoomId()
	local gmBehavior, gmSchedule = HouseGMController.instance:getEffectBehaviorOrSchedule(self._unit.heroId)

	if gmBehavior then
		local workStatus = HouseSceneUtil.getWorkStatusByBehavior(gmBehavior)

		return HouseSceneUtil.getRoomIdByWorkStatus(self._unit.heroId, workStatus, self:getWorkType(), self._scheduleData)
	elseif gmSchedule then
		return HouseSceneUtil.getRoomIdByWorkStatus(self._unit.heroId, gmSchedule, self:getWorkType(), self._scheduleData)
	end

	return self._targetRoomId
end

function M:setScheduleData(scheduleData)
	self._scheduleData = scheduleData
	self._curWorkType = nil

	if self._scheduleData then
		local workCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseWorker, self._scheduleData.job)

		self._curWorkType = workCO.workType
	end
end

function M:refreshWorkStatus()
	if not self._scheduleData then
		return
	end

	self._targetRoomId, self._curWorkStatus = HouseSceneUtil.getRoomIdBySchedule(self._scheduleData)
end

function M:getCurWorkStatus()
	return self._curWorkStatus
end

function M:setCurWorkStatus(status)
	self._curWorkStatus = status
end

function M:getWorkType()
	return self._curWorkType
end

return M
