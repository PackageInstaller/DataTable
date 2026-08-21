-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/comp/EffectCompTransform.lua

module("logic.battle.effect.comp.EffectCompTransform", package.seeall)

local EffectCompTransform = class("EffectCompTransform", IEffectComp)

function EffectCompTransform:onInit()
	self._loader = self.unit.loader
	self._transform = self.unit.mainGO.transform
	self._position = self._transform.position
	self._localPosition = self._transform.localPosition
	self._spineDirection = UnitSpineDir.Right
end

function EffectCompTransform:onReuse()
	return
end

function EffectCompTransform:onReset()
	return
end

function EffectCompTransform:onDestroy()
	self._loader = nil
	self._transform = nil
	self._position = nil
	self._localPosition = nil
end

function EffectCompTransform:onResourceLoaded()
	self:_updateDirection()
end

function EffectCompTransform:getPosition()
	return self._position
end

function EffectCompTransform:getLocalPosition()
	return self._localPosition
end

function EffectCompTransform:setPosition(position)
	self:setPositionXYZ(position:Get())
end

function EffectCompTransform:setPositionXYZ(x, y, z)
	if self._position.x == x and self._position.y == y and self._position.z == z then
		return
	end

	self._position:Set(x, y, z)
	Astral.TransformUtil.SetPos(self._transform, x, y, z)
end

function EffectCompTransform:setLocalPosition(localPosition)
	self:setLocalPositionXYZ(localPosition:Get())
end

function EffectCompTransform:setLocalPositionXYZ(x, y, z)
	if self._localPosition.x == x and self._localPosition.y == y and self._localPosition.z == z then
		return
	end

	self._localPosition:Set(x, y, z)
	Astral.TransformUtil.SetLocalPos(self._transform, x, y, z)
end

function EffectCompTransform:setScale(localScale)
	self:setScaleXYZ(localScale:Get())
end

function EffectCompTransform:setScaleXYZ(x, y, z)
	Astral.TransformUtil.SetLocalScale(self._transform, x, y, z)
end

function EffectCompTransform:rotationToAxis(axis)
	Astral.RotationToAxis(self._transform, axis.x, axis.y, axis.z)
end

function EffectCompTransform:setSpineDirection(spineDirection)
	self._spineDirection = spineDirection

	self:_updateDirection()
end

function EffectCompTransform:_updateDirection()
	if self._spineDirection == UnitSpineDir.Right then
		return
	end

	local inst = self._loader:getInst()

	if not inst then
		return
	end

	local trans = inst.transform
	local x, y, z = Astral.TransformUtil.GetLocalPos(trans, 0, 0, 0)

	Astral.TransformUtil.SetLocalPos(trans, -x, y, z)
	Astral.TransformUtil.SetLocalRotation(trans, 0, 180, 0)
end

function EffectCompTransform:playEffectAnim(trackName)
	local inst = self._loader:getInst()

	if not inst then
		return
	end

	local guiAnimation = inst:GetComponent(typeof(Astral.GUITimelineAniLua))

	if guiAnimation then
		guiAnimation:StopTimelineAni()
		guiAnimation:PlayAniByName(trackName)
	end
end

return EffectCompTransform
