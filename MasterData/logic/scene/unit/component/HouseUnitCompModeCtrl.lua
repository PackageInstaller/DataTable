-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/HouseUnitCompModeCtrl.lua

module("logic.scene.unit.component.HouseUnitCompModeCtrl", package.seeall)

local M = class("HouseUnitCompModeCtrl", UnitComponentBase)
local kCameraRefreshKey = "CameraRefresh"
local kForceSetKey = "ForceSet"

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._lowModeMap = {}
	self._targetRingType = 1
	self._targetAngle = 0
	self._targetRoomId = 0
end

function M:onInit()
	self:_setEvents(true)
	self:_tryGetAngle()
end

function M:onReuse()
	self:_setEvents(true)
	self:_tryGetAngle()
end

function M:onReset()
	self:_setEvents(false)
	table.clear(self._lowModeMap)

	self._targetRingType = 1
	self._targetAngle = 0
	self._targetRoomId = 0
end

function M:onDestroy()
	self:onReset()

	self._lowModeMap = nil
end

function M:_setEvents(isOn)
	if isOn then
		HouseDispatcher:addEventListener(HouseEventType.ON_SCENE_CAMERA_REFRESH, self._onCameraRefresh, self)
		HouseDispatcher:addEventListener(HouseEventType.SET_FORCE_LOAD_ROOM_RES, self._onSetRoomResForceLoad, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.ON_SCENE_CAMERA_REFRESH, self._onCameraRefresh, self)
		HouseDispatcher:removeEventListener(HouseEventType.SET_FORCE_LOAD_ROOM_RES, self._onSetRoomResForceLoad, self)
	end
end

function M:_tryGetAngle()
	local roomId = HouseModel.instance:getOnceEnterRoomId() or HouseModel.instance:getDefaultRoomId()
	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)

	self._targetAngle = roomCO and roomCO.angle or 0
end

function M:update()
	self:_refreshModeByAngle()
	self:_refreshModeByRoomId()
end

function M:setLowMode(key, value)
	self._lowModeMap[key] = value

	self:_refreshLowMode()
end

function M:_refreshLowMode()
	local isLow = true

	for _, v in pairs(self._lowModeMap) do
		isLow = isLow and v
	end

	self._unit:setLowMode(isLow)
end

function M:_refreshModeByAngle()
	local unitAngle = self._unit.navMeshMover:getCurrAngle()
	local detalAngle = 60
	local minAngle = unitAngle - detalAngle
	local maxAngle = unitAngle + detalAngle

	if minAngle >= 0 and maxAngle <= 360 then
		if minAngle <= self._targetAngle and maxAngle >= self._targetAngle then
			self:setLowMode(kCameraRefreshKey, false)
		else
			self:setLowMode(kCameraRefreshKey, true)
		end
	else
		if minAngle < 0 then
			minAngle = minAngle + 360
		elseif maxAngle > 360 then
			maxAngle = maxAngle - 360
		end

		if minAngle <= self._targetAngle and self._targetAngle <= 360 or self._targetAngle >= 0 and maxAngle >= self._targetAngle then
			self:setLowMode(kCameraRefreshKey, false)
		else
			self:setLowMode(kCameraRefreshKey, true)
		end
	end
end

function M:_refreshModeByRoomId()
	if self._unit.navMesh:getCurZoneId() == self._targetRoomId then
		self:setLowMode(kForceSetKey, false)
	else
		self:setLowMode(kForceSetKey, true)
	end
end

function M:_onCameraRefresh(e, ringType, camContrastAngle)
	self._targetRingType = ringType
	self._targetAngle = MathUtil.normalizeAngle(camContrastAngle)
end

function M:_onSetRoomResForceLoad(e, roomId, force)
	if force then
		self._targetRoomId = roomId
	else
		self._targetRoomId = 0
	end
end

return M
