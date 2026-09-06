-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompSyncPos.lua

module("logicscene.scene.unit.component.UnitCompSyncPos", package.seeall)

local UnitCompSyncPos = class("UnitCompSyncPos", UnitComponentBase)
local Time = UnityEngine.Time
local syncTimeDelta = 1

function UnitCompSyncPos:onInit()
	self._lastX = 0
	self._lastY = 0
	self._nowX = 0
	self._nowY = 0
	self._lastSyncTime = 0

	self._unit.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
end

function UnitCompSyncPos:onDestroy()
	self._unit.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
end

function UnitCompSyncPos:disable(dis)
	self._disable = dis
end

function UnitCompSyncPos:joystickOn(isOn)
	if isOn then
		self:trySyncPosition()
	end
end

function UnitCompSyncPos:trySyncPosition()
	self:_trySyncPosition()

	self._lastSyncTime = Time.time
end

function UnitCompSyncPos:clear()
	self._lastX = self._nowX
	self._lastY = self._nowY
	self._lastSyncTime = Time.time
end

function UnitCompSyncPos:setLastPos(x, y)
	self._lastX = x
	self._lastY = y
	self._nowX = x
	self._nowY = y
	self._lastSyncTime = Time.time
end

function UnitCompSyncPos:update()
	self:_trySyncPosition()
end

function UnitCompSyncPos:_onUnitPosChanged(x, y, z, isTeleport)
	if isTeleport then
		self:syncPosition(x, y, isTeleport)
	else
		self._nowX = x
		self._nowY = y
	end

	local underBridge = self._unit:isUnderBridge()

	GlobalDispatcher:dispatch(GlobalNotify.MainPlayerPos, x, y, z, isTeleport, underBridge)
end

function UnitCompSyncPos:syncPosition(x, z, isTeleport)
	if self._disable then
		return
	end

	local underBridge = self._unit:isUnderBridge()

	CityAgent.instance:sendMoveReq(x, (underBridge or nil) and 1, z, isTeleport)
	self:setLastPos(x, z)
end

function UnitCompSyncPos:_trySyncPosition()
	if (self._lastX ~= self._nowX or self._lastY ~= self._nowY) and Time.time - self._lastSyncTime >= syncTimeDelta then
		self:syncPosition(self._nowX, self._nowY)
	end
end

return UnitCompSyncPos
