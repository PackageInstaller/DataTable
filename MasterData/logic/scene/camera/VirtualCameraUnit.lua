-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/camera/VirtualCameraUnit.lua

module("logic.scene.camera.VirtualCameraUnit", package.seeall)

local VirtualCameraUnit = class("VirtualCameraUnit", AbstractGlobalReusable)
local kVirtualCameraRoot = goutil.create("VirtualCameras", false)

SceneUtil.moveGameObjectToBaseScene(kVirtualCameraRoot)

local tempVec = Vector3.New()

function VirtualCameraUnit:ctor(name)
	self.name = name
	self.mainGO = false
	self._resLoader = SingleResLoader.New()
	self._isEnable = true
	self._priority = false
	self._virtualCamera = false
	self._shakeComponent = false
	self._relativeComponent = false
	self._animator = false
end

function VirtualCameraUnit:reuse(name)
	self.name = name
end

function VirtualCameraUnit:reset()
	if self.mainGO then
		self:clearRelativeComponent()
		goutil.setActive(self.mainGO, false)
	end

	self._isEnable = true
end

function VirtualCameraUnit:destroy()
	self:_clear()
end

function VirtualCameraUnit:getMainGO()
	return self.mainGO
end

function VirtualCameraUnit:load(url)
	if self._resLoader:isSameResource(url) then
		if self.mainGO then
			self:_resetFromPrefab()
			goutil.setActive(self.mainGO, self._isEnable)
		end
	else
		self:_clear()
		self._resLoader:load(url, self._onResourceLoaded, self)
	end
end

function VirtualCameraUnit:setEnable(enable)
	self._isEnable = enable

	if self.mainGO then
		goutil.setActive(self.mainGO, enable)
	end
end

function VirtualCameraUnit:setPriority(priority)
	self._priority = priority

	if self._virtualCamera then
		self._virtualCamera.Priority = priority
	end
end

function VirtualCameraUnit:setFieldOfView(pov)
	if self._virtualCamera then
		CineCameraUtils.SetFieldOfView(self._virtualCamera, pov)
	end
end

function VirtualCameraUnit:getFieldOfView()
	if self._virtualCamera then
		return CineCameraUtils.GetFieldOfView(self._virtualCamera)
	end
end

function VirtualCameraUnit:setDampingX(damping)
	if self._virtualCamera then
		CineCameraUtils.SetDampingX(self._virtualCamera, damping)
	end
end

function VirtualCameraUnit:setDampingY(damping)
	if self._virtualCamera then
		CineCameraUtils.SetDampingY(self._virtualCamera, damping)
	end
end

function VirtualCameraUnit:setDampingZ(damping)
	if self._virtualCamera then
		CineCameraUtils.SetDampingZ(self._virtualCamera, damping)
	end
end

function VirtualCameraUnit:setPosition(x, y, z)
	Astral.TransformUtil.SetPos(self.mainGO.transform, x, y, z)
end

function VirtualCameraUnit:getPosition()
	local x, y, z = Astral.TransformUtil.GetPos(self.mainGO.transform, 0, 0, 0)

	tempVec:Set(x, y, z)

	return tempVec
end

function VirtualCameraUnit:setRotation(x, y, z)
	self._relativeComponent:SetEulerAngles(x, y, z)
end

function VirtualCameraUnit:getRotation()
	local x, y, z = self._relativeComponent:GetEulerAngles(0, 0, 0)

	tempVec:Set(x, y, z)

	return tempVec
end

function VirtualCameraUnit:doRotation(x, y, z, duration)
	self._relativeComponent:DoRotation(x, y, z, duration)
end

function VirtualCameraUnit:doPosition(x, y, z, duration)
	self._relativeComponent:DoPosition(x, y, z, duration)
end

function VirtualCameraUnit:clearRelativeComponent()
	if self._relativeComponent then
		self._relativeComponent:Clear()
	end
end

function VirtualCameraUnit:resetTransform()
	if self.mainGO then
		self:_resetFromPrefab()
	end
end

function VirtualCameraUnit:getGo()
	return self.mainGO
end

function VirtualCameraUnit:shake(lifeTime, magnitude, shakeModeValue, hakeMagnitudeDecreaseRate, cycleTime)
	if self._shakeComponent then
		self._shakeComponent:Shake(lifeTime, magnitude, shakeModeValue, hakeMagnitudeDecreaseRate, cycleTime)
	elseif enableWarnLog then
		printWarn("shake component is nil")
	end
end

function VirtualCameraUnit:stopShake()
	if self._shakeComponent then
		self._shakeComponent:Stop()
	end
end

function VirtualCameraUnit:setLoadedCallback(callbackFunc, handler)
	self._resLoadedCallback = callbackFunc
	self._resLoadedHandler = handler
end

function VirtualCameraUnit:getVirtualCameraAnimator()
	return self._animator
end

function VirtualCameraUnit:getVirtualCamera()
	return self._virtualCamera
end

function VirtualCameraUnit:_clear()
	if self.mainGO then
		goutil.destroy(self.mainGO)

		self.mainGO = false
	end

	self._resLoader:clear()

	self._priority = false
	self._virtualCamera = false
	self._shakeComponent = false
	self._relativeComponent = false
	self._animator = false
	self._resLoadedCallback = nil
	self._resLoadedHandler = nil
end

function VirtualCameraUnit:_onResourceLoaded(resource)
	self.mainGO = self._resLoader:getResInstance()

	goutil.addChildToParent(self.mainGO, kVirtualCameraRoot)
	goutil.setActive(self.mainGO, self._isEnable)

	self._virtualCamera = goutil.addComponentOnce(self.mainGO, ComponentType.CinemachineVirtualCamera)
	self._shakeComponent = CinemachineShake.Get(self.mainGO)
	self._relativeComponent = SpaceX.RelativeVirtualCamera.Get(self.mainGO)
	self._animator = goutil.addComponentOnce(self.mainGO, ComponentType.Animator)

	self:_resetFromPrefab()
	CinemachineLensAdapter.Get(self.mainGO)

	local cameraFollow = VirtualCameraMgr.instance:internal_getCameraFollow()

	self._virtualCamera.Follow = cameraFollow:internal_getTargetTransform()
	self._virtualCamera.LookAt = cameraFollow:internal_getLookAtTransform()

	if self._priority then
		self._virtualCamera.Priority = self._priority
	end

	if self._resLoadedCallback then
		self._resLoadedCallback(self._resLoadedHandler)
	end
end

function VirtualCameraUnit:_resetFromPrefab()
	local res = self._resLoader:getResource()
	local prefab = res and res:GetMainAsset()

	self._relativeComponent:SetEulerAngles(TransformUtils.GetEulerAngles(prefab.transform, 0, 0, 0))
	GameObjectUtils.SetTransformFromGameObject(self.mainGO, prefab)
end

return VirtualCameraUnit
