-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/camera/VirtualCameraFollow.lua

module("logic.scene.camera.VirtualCameraFollow", package.seeall)

local VirtualCameraFollow = class("VirtualCameraFollow")

function VirtualCameraFollow:ctor()
	self._goTarget = goutil.create("FollowTarget", false)
	self._goLookAt = goutil.create("LookAtTarget", false)
	self._goCollider = goutil.create("FollowCollider", false)
	self._goEmptyConfiner = goutil.create("empty-confiner", false)

	TransformUtils.SetLocalEulerAngles(self._goEmptyConfiner.transform, 90, 0, 0)
	goutil.addChildToParent(self._goEmptyConfiner, self._goCollider)
	goutil.addComponentOnce(self._goEmptyConfiner, typeof(PolygonCollider))
	SceneUtil.moveGameObjectToBaseScene(self._goTarget)
	SceneUtil.moveGameObjectToBaseScene(self._goLookAt)
	SceneUtil.moveGameObjectToBaseScene(self._goCollider)

	self._followTargetConfiner = FollowTargetConfiner.Get(self._goTarget)
	self._loader = PrefabLoader.Get(self._goCollider)
	self._position = Vector3.New()
end

function VirtualCameraFollow:destroy()
	goutil.destroy(self._goTarget)
	goutil.destroy(self._goLookAt)
	goutil.destroy(self._goCollider)
	goutil.destroy(self._goEmptyConfiner)
	self._loader:clear()

	self._loader = false
	self._goTarget = false
	self._goLookAt = false
	self._goCollider = false
	self._goEmptyConfiner = false
	self._followTargetConfiner = false
end

function VirtualCameraFollow:setPosition(x, y, z)
	local ox, oy, oz = self._followTargetConfiner:SetPosition(x, y, z, 0, 0, 0)

	self._position:Set(ox, oy, oz)
	GlobalDispatcher:dispatchEvent(EventType.CAMERA_FOLLOW_POSITION_UPDATE)

	return ox, oy, oz
end

function VirtualCameraFollow:forceSetPosition(x, y, z)
	self._position:Set(x, y, z)
	self._followTargetConfiner:ForceSetPosition(x, y, z)
	GlobalDispatcher:dispatchEvent(EventType.CAMERA_FOLLOW_POSITION_UPDATE)
end

function VirtualCameraFollow:getPosition()
	return self._position
end

function VirtualCameraFollow:getTargetPosition()
	return Astral.TransformUtil.GetLocalPos(self._goTarget.transform, nil, nil, nil)
end

function VirtualCameraFollow:doMovePosition(x, y, z, duration)
	self:_stopTween()

	local tween, ox, oy, oz = self._followTargetConfiner:DOMovePosition(x, y, z, duration, 0, 0, 0)

	self._position:Set(ox, oy, oz)
	GlobalDispatcher:dispatchEvent(EventType.CAMERA_FOLLOW_POSITION_UPDATE)

	return tween
end

function VirtualCameraFollow:setPositionTweenSetterHandler(callback, callbackSelf)
	self._followTargetConfiner:SetTweenSetterHandler(callback, callbackSelf)
end

function VirtualCameraFollow:forceDoMovePosition(x, y, z, duration)
	self:_stopTween()

	local tween = self._followTargetConfiner:ForceDOMovePosition(x, y, z, duration)

	self._position:Set(x, y, z)
	GlobalDispatcher:dispatchEvent(EventType.CAMERA_FOLLOW_POSITION_UPDATE)

	return tween
end

function VirtualCameraFollow:_stopTween()
	self._followTargetConfiner:DOKill()
	self._followTargetConfiner:RemoveTweenSetterHandler()
end

function VirtualCameraFollow:setLookAtPosition(x, y, z)
	Astral.TransformUtil.SetPos(self._goLookAt.transform, x, y, z)
end

function VirtualCameraFollow:setRotation(x, y, z)
	DG.Tweening.DOTween.Kill(self._goTarget.transform)
	Astral.TransformUtil.SetLocalRotation(self._goTarget.transform, x, y, z)
end

function VirtualCameraFollow:doRotation(x, y, z, duration)
	Astral.TransformUtil.DOLocalRotate(self._goTarget.transform, x, y, z, duration)
end

function VirtualCameraFollow:doRotationZ(z, duration)
	Astral.TransformUtil.DOLocalRotateZ(self._goTarget.transform, z, duration)
end

function VirtualCameraFollow:setConfinerPosition(x, y, z)
	Astral.TransformUtil.SetPos(self._goCollider.transform, x, y, z)
end

function VirtualCameraFollow:setConfinerUrl(url)
	self._loader:load(url, self._onLoadCollider, self, false)
end

function VirtualCameraFollow:useEmptyConfiner()
	goutil.setActive(self._goEmptyConfiner, true)
	self._followTargetConfiner:SetPolygonCollider(self._goEmptyConfiner)
end

function VirtualCameraFollow:clearConfiner()
	self._loader:clear()
	self._followTargetConfiner:InvalidatePolygonCollider()
	goutil.setActive(self._goEmptyConfiner, false)
end

function VirtualCameraFollow:internal_getTargetTransform()
	return self._goTarget.transform
end

function VirtualCameraFollow:internal_getLookAtTransform()
	return self._goLookAt.transform
end

function VirtualCameraFollow:_onLoadCollider()
	local goInst = self._loader:getInst()

	self._followTargetConfiner:SetPolygonCollider(goInst)
	GlobalDispatcher:dispatchEvent(EventType.CAMERA_CONFINER_LOADED)
end

function VirtualCameraFollow:getPolygonColliderPolygon()
	if self._followTargetConfiner then
		return self._followTargetConfiner:GetPolygonColliderPolygon()
	end
end

function VirtualCameraFollow:isColliderValid()
	if self._followTargetConfiner then
		return self._followTargetConfiner.IsValid
	end
end

return VirtualCameraFollow
