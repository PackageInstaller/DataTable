-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompPhysics3D.lua

module("logicscene.scene.unit.component.UnitCompPhysics3D", package.seeall)

local UnitCompPhysics3D = class("UnitCompPhysics3D", UnitComponentBase)

function UnitCompPhysics3D:ctor(unit)
	UnitCompPhysics3D.super.ctor(self, unit)

	self._rigidBody = nil
	self._circle3D = nil
end

function UnitCompPhysics3D:onDestroy()
	self._unit = nil
	self._circle3D = nil
	self._rigidBody = nil
end

function UnitCompPhysics3D:update(deltaTime)
	return
end

function UnitCompPhysics3D:onUnitVisible(go)
	self._circle3D = self._unit.go:GetComponent(typeof("UnityEngine.SphereCollider")) or self._unit.go:AddComponent(typeof("UnityEngine.SphereCollider"))
	self._circle3D.center = Vector3.New(0, 0.1, 0)
	self._circle3D.radius = 0.1
	self._rigidBody = self._unit.go:GetComponent(typeof("UnityEngine.Rigidbody"))
end

function UnitCompPhysics3D:setKinematic(isKinematic)
	if self._rigidBody then
		self._rigidBody.isKinematic = isKinematic
	end
end

function UnitCompPhysics3D:onUnitInVisible(go)
	return
end

return UnitCompPhysics3D
