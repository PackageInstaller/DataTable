-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompPhysics2D.lua

module("logicscene.scene.unit.component.UnitCompPhysics2D", package.seeall)

local UnitCompPhysics2D = class("UnitCompPhysics2D", UnitComponentBase)

function UnitCompPhysics2D:ctor(unit)
	UnitCompPhysics2D.super.ctor(self, unit)

	self._rigidBody = nil
	self._circle2D = nil
end

function UnitCompPhysics2D:onDestroy()
	self._unit = nil
	self._circle2D = nil
	self._rigidBody = nil
end

function UnitCompPhysics2D:update(deltaTime)
	return
end

function UnitCompPhysics2D:onUnitVisible(go)
	self._circle2D = self._unit.go:GetComponent(typeof("UnityEngine.CircleCollider2D")) or self._unit.go:AddComponent(typeof("UnityEngine.CircleCollider2D"))
	self._circle2D.offset = Vector2.New(0, 0.1)
	self._circle2D.radius = 0.1
	self._rigidBody = self._unit.go:GetComponent(typeof("UnityEngine.Rigidbody2D"))
end

function UnitCompPhysics2D:setKinematic(isKinematic)
	if self._rigidBody then
		self._rigidBody.isKinematic = isKinematic
	end
end

function UnitCompPhysics2D:onUnitInVisible(go)
	return
end

return UnitCompPhysics2D
