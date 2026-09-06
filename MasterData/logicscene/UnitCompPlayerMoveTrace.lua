-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompPlayerMoveTrace.lua

module("logicscene.scene.unit.component.animation.UnitCompPlayerMoveTrace", package.seeall)

local UnitCompPlayerMoveTrace = class("UnitCompPlayerMoveTrace", UnitComponentBase)

UnitCompPlayerMoveTrace.TIME_GENDER_MALE = 0.5
UnitCompPlayerMoveTrace.TIME_GENDER_FEMALE = 0.5

function UnitCompPlayerMoveTrace:ctor(unit)
	UnitCompPlayerMoveTrace.super.ctor(self, unit)
	self._unit.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
end

function UnitCompPlayerMoveTrace:onInit()
	self._isVisible = false
	self._active = true
	self._passTime = 0
	self._stopPassTime = 0
	self._isMoving = false
	self._checkTime = 0.5
	self._stopTime = 0.2
	self._resPath = CommonResPath.PlayerWalkTrace
end

function UnitCompPlayerMoveTrace:onDestroy()
	self._passTime = 0
	self._stopPassTime = 0
	self._isMoving = false
	self._checkTime = 0.5
	self._stopTime = 0.2
	self._resPath = CommonResPath.PlayerWalkTrace
end

function UnitCompPlayerMoveTrace:_onUnitPosChanged()
	if not self._isMoving then
		self._passTime = -0.3
	end

	self._isMoving = true
	self._stopPassTime = 0
end

function UnitCompPlayerMoveTrace:update(deltaTime)
	if not self._isVisible or not self._active then
		return
	end

	if not string.nilorempty(self._resPath) and self._isMoving == true then
		self._passTime = self._passTime + deltaTime
		self._stopPassTime = self._stopPassTime + deltaTime

		if self._stopPassTime > self._stopTime then
			self._isMoving = false
			self._stopPassTime = 0
		end

		local forward = self._unit.mountRoot:getAvatarRoot().transform.forward

		forward = -forward * 0.3

		if self._passTime > self._checkTime then
			local pos = GameUtil.getPos(self._unit.go)
			local effect = GameEffectManager.instance:playEffect(self._resPath, false, nil, pos.x + forward.x, pos.y + forward.y, pos.z + forward.z)

			effect:setScale(0.5)

			self._passTime = self._passTime % self._checkTime
		end
	end
end

function UnitCompPlayerMoveTrace:setTraceRes(resPath)
	self._resPath = resPath
end

function UnitCompPlayerMoveTrace:setShowEachTime(time)
	self._checkTime = time
end

function UnitCompPlayerMoveTrace:onUnitVisible(go)
	self._isVisible = true
end

function UnitCompPlayerMoveTrace:onUnitInVisible(go)
	self._isVisible = false
end

function UnitCompPlayerMoveTrace:setActive(active)
	self._active = active
end

return UnitCompPlayerMoveTrace
