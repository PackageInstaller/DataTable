-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/family/FamilyUnitCompSyncPos.lua

module("logicscene.scene.unit.component.family.FamilyUnitCompSyncPos", package.seeall)

local FamilyUnitCompSyncPos = class("FamilyUnitCompSyncPos", UnitComponentBase)
local Time = UnityEngine.Time
local syncTimeDelta = 1

function FamilyUnitCompSyncPos:onInit()
	self._lastX = 0
	self._lastY = 0
	self._nowX = 0
	self._nowY = 0
	self._lastSyncTime = 0

	self._unit.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
end

function FamilyUnitCompSyncPos:onDestroy()
	self._unit.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
end

function FamilyUnitCompSyncPos:disable(dis)
	self._disable = dis
end

function FamilyUnitCompSyncPos:joystickOn(isOn)
	if isOn then
		self:trySyncPosition()
	end
end

function FamilyUnitCompSyncPos:trySyncPosition()
	self:_trySyncPosition()

	self._lastSyncTime = Time.time
end

function FamilyUnitCompSyncPos:clear()
	self._lastX = self._nowX
	self._lastY = self._nowY
	self._lastSyncTime = Time.time
end

function FamilyUnitCompSyncPos:setLastPos(x, y)
	self._lastX = x
	self._lastY = y
	self._nowX = x
	self._nowY = y
	self._lastSyncTime = Time.time
end

function FamilyUnitCompSyncPos:update()
	self:_trySyncPosition()
end

function FamilyUnitCompSyncPos:_onUnitPosChanged(x, y, z, isTeleport)
	if isTeleport then
		self:syncPosition(x, z, isTeleport)
	else
		self._nowX = x
		self._nowY = z
	end

	local underBridge = self._unit:isUnderBridge()
end

function FamilyUnitCompSyncPos:syncPosition(x, z, isTeleport)
	if self._disable then
		return
	end

	local underBridge = self._unit:isUnderBridge()
	local y = 0

	FamilySceneAgent.instance:sendPM_Cube_MoveReq(x, y, z, isTeleport)
	self:setLastPos(x, z)
end

function FamilyUnitCompSyncPos:_trySyncPosition()
	if (self._lastX ~= self._nowX or self._lastY ~= self._nowY) and Time.time - self._lastSyncTime >= syncTimeDelta then
		self:syncPosition(self._nowX, self._nowY)
	end
end

return FamilyUnitCompSyncPos
