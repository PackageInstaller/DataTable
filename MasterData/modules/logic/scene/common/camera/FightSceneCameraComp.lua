-- chunkname: @modules/logic/scene/common/camera/FightSceneCameraComp.lua

module("modules.logic.scene.common.camera.FightSceneCameraComp", package.seeall)

local FightSceneCameraComp = class("FightSceneCameraComp", BaseSceneComp)

function FightSceneCameraComp:onInit()
	self._scene = self:getCurScene()
	self._cameraTrace = CameraMgr.instance:getCameraTrace()
	self._curVirtualCameraSetId = nil
end

function FightSceneCameraComp:onSceneStart(sceneId, levelId)
	FightController.instance:registerCallback(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded, self)

	if CameraMgr.instance:hasCameraRootAnimatorPlayer() then
		local animatorPlayer = CameraMgr.instance:getCameraRootAnimatorPlayer()

		animatorPlayer:Stop()
	end

	local rootGO = CameraMgr.instance:getCameraRootGO()

	transformhelper.setPos(rootGO.transform, 0, 0, 0)

	local mainGO = CameraMgr.instance:getCameraTraceGO()

	transformhelper.setPos(mainGO.transform, 0, 0, 0)

	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = false
	self._cameraTrace.EnableTrace = false

	local mainTrs = CameraMgr.instance:getCameraTraceGO().transform

	transformhelper.setLocalPos(mainTrs, 0, 0, 0)
	transformhelper.setLocalRotation(mainTrs, 0, 0, 0)
	CameraMgr.instance:getCameraTrace():DisableTraceWithFixedParam()

	local virsualCamerasGO = CameraMgr.instance:getVirtualCameraGO()

	gohelper.setActive(virsualCamerasGO, true)

	local lightGo = gohelper.findChild(virsualCamerasGO, "light")

	gohelper.setActive(lightGo, true)
	TaskDispatcher.runDelay(self._delaySetUnitCameraFov, self, 0.01)
	self:setSceneCameraOffset()

	self._curVirtualCameraSetId = nil

	self:switchNextVirtualCamera()

	if not self._hasRecord then
		self._hasRecord = true

		self:recordParam()
	end

	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self:_onScreenResize(UnityEngine.Screen.width, UnityEngine.Screen.height)
end

function FightSceneCameraComp:_onLevelLoaded()
	self:setSceneCameraOffset()
end

function FightSceneCameraComp:onSceneClose()
	self._myTurnOffset = nil

	FightController.instance:unregisterCallback(FightEvent.OnSceneLevelLoaded, self._onLevelLoaded, self)
	TaskDispatcher.cancelTask(self._delaySetUnitCameraFov, self)
	TaskDispatcher.cancelTask(self._resetParam, self)
	self:resetCameraOffset()
	self:resetParam()
	self:enablePostProcessSmooth(false)

	local animComp = CameraMgr.instance:getCameraRootAnimator()

	animComp.speed = 1

	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
	TaskDispatcher.cancelTask(self.disableClearSlot, self)
	TaskDispatcher.cancelTask(self._delayDisableSmooth, self)
	self:disableClearSlot()
	self:_delayDisableSmooth()
end

function FightSceneCameraComp:getCurActiveVirtualCame()
	local virtualCame = self:getCurVirtualCamera(1)

	if not virtualCame.gameObject.activeInHierarchy then
		virtualCame = self:getCurVirtualCamera(2)
	end

	return virtualCame
end

function FightSceneCameraComp:enableClearSlot(resumeDelay)
	self:disableClearSlot()

	local virtualCameraRootGO = CameraMgr.instance:getVirtualCameraGO()
	local clearSlotGO = gohelper.findChild(virtualCameraRootGO, "clearslot")

	self._clearSlotVC = self:getCurActiveVirtualCame()

	if not self._clearSlotVC then
		return
	end

	local parent = self._clearSlotVC.transform.parent

	self._clearSlotParentGO = parent.gameObject
	self._tempClearSlotGO = gohelper.clone(clearSlotGO, self._clearSlotParentGO, "ClearSlot")
	self._resumeDelay = resumeDelay

	gohelper.addChild(self._tempClearSlotGO, self._clearSlotVC.gameObject)
	gohelper.setActive(self._tempClearSlotGO, false)
	TaskDispatcher.runDelay(self._delayActiveClearSlot, self, 0.01)
end

function FightSceneCameraComp:_delayActiveClearSlot()
	gohelper.setActive(self._tempClearSlotGO, true)

	if self._resumeDelay then
		TaskDispatcher.runDelay(self.disableClearSlot, self, self._resumeDelay)

		self._resumeDelay = nil
	end
end

function FightSceneCameraComp:disableClearSlot()
	if self._tempClearSlotGO then
		gohelper.addChild(self._clearSlotParentGO, self._clearSlotVC.gameObject)
		gohelper.destroy(self._tempClearSlotGO)

		self._clearSlotVC = nil
		self._tempClearSlotGO = nil
		self._clearSlotParentGO = nil
	end
end

function FightSceneCameraComp:getCurVirtualCamera(indexInSet)
	if not self._curVirtualCameraSetId then
		return CameraMgr.instance:getVirtualCamera(self._curVirtualCameraSetId, indexInSet)
	end
end

function FightSceneCameraComp:switchNextVirtualCamera()
	if not self._curVirtualCameraSetId then
		self._curVirtualCameraSetId = 1
	elseif self._curVirtualCameraSetId == 1 then
		self._curVirtualCameraSetId = 2
	elseif self._curVirtualCameraSetId == 2 then
		self._curVirtualCameraSetId = 1
	end

	CameraMgr.instance:switchVirtualCamera(self._curVirtualCameraSetId)
end

function FightSceneCameraComp:enablePostProcessSmooth(isEnable)
	local cameraRoot = CameraMgr.instance:getCameraRootGO()

	if not self._dofSmoothComp then
		local ppVolume = gohelper.findChild(cameraRoot, "main/MainCamera/unitcamera/PPVolume")

		if ppVolume then
			self._dofSmoothComp = gohelper.onceAddComponent(ppVolume, typeof(ZProj.DepthOfFieldSmooth))
			self._dofSmoothComp.maxOffset = 0.1
			self._dofSmoothComp.frameRatio = 0.02
		else
			logError("add smooth comp fail, PPVolume not exist")
		end
	end

	if self._dofSmoothComp then
		self._dofSmoothComp.enabled = isEnable
	end

	if not self._lightColorSmoothComp then
		local directLight = gohelper.findChild(cameraRoot, "main/VirtualCameras/light/direct")

		if directLight then
			self._lightColorSmoothComp = gohelper.onceAddComponent(directLight, typeof(ZProj.LightColorSmooth))
			self._lightColorSmoothComp.maxOffset = 0.1
			self._lightColorSmoothComp.frameRatio = 0.02
		else
			logError("add smooth comp fail, DirectLight not exist")
		end
	end

	if self._lightColorSmoothComp then
		self._lightColorSmoothComp.enabled = isEnable

		if isEnable then
			TaskDispatcher.runDelay(self._delayDisableSmooth, self, 0.2)
		end
	end
end

function FightSceneCameraComp:_delayDisableSmooth()
	self._lightColorSmoothComp.enabled = false
end

function FightSceneCameraComp:recordParam()
	local cameraRoot = CameraMgr.instance:getCameraRootGO()
	local directLight = gohelper.findChildComponent(cameraRoot, "main/VirtualCameras/light/direct", typeof(UnityEngine.Light))

	self._lightColor = directLight.color
	self._distortionRange = PostProcessingMgr.instance:getUnitPPValue("distortionRange")
	self._dofDistance = PostProcessingMgr.instance:getUnitPPValue("dofDistance")
	self._dofFactor = PostProcessingMgr.instance:getUnitPPValue("dofFactor")
	self._dofFarBlur = PostProcessingMgr.instance:getUnitPPValue("dofFarBlur")
	self._dofLength = PostProcessingMgr.instance:getUnitPPValue("dofLength")
	self._dofNearBlur = PostProcessingMgr.instance:getUnitPPValue("dofNearBlur")
	self._isDistortion = PostProcessingMgr.instance:getUnitPPValue("isDistortion")
	self._rgbSplitCenter = PostProcessingMgr.instance:getUnitPPValue("rgbSplitCenter")

	local virtualCamera = CameraMgr.instance:getVirtualCamera(1, 1)
	local body = ZProj.VirtualCameraWrap.Get(virtualCamera.gameObject).body
	local followerName = "Follower" .. string.sub(virtualCamera.name, string.len(virtualCamera.name))
	local follower = gohelper.findChild(virtualCamera.transform.parent.gameObject, followerName)
	local vcam = virtualCamera.transform.parent.gameObject

	self._pathOffset = body.m_PathOffset
	self._pathPosition = body.m_PathPosition
	self._xDamping = body.m_XDamping
	self._yDamping = body.m_YDamping
	self._zDamping = body.m_ZDamping
	self._followerPos = follower.transform.localPosition
	self._vcamPos = vcam.transform.localPosition
end

function FightSceneCameraComp:resetParam()
	local cameraRoot = CameraMgr.instance:getCameraRootGO()
	local directLight = gohelper.findChildComponent(cameraRoot, "main/VirtualCameras/light/direct", typeof(UnityEngine.Light))

	directLight.color = self._lightColor

	PostProcessingMgr.instance:setUnitPPValue("distortionRange", self._distortionRange)
	PostProcessingMgr.instance:setUnitPPValue("DistortionRange", self._distortionRange)
	PostProcessingMgr.instance:setUnitPPValue("dofDistance", self._dofDistance)
	PostProcessingMgr.instance:setUnitPPValue("DofDistance", self._dofDistance)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", self._dofFactor)
	PostProcessingMgr.instance:setUnitPPValue("DofFactor", self._dofFactor)
	PostProcessingMgr.instance:setUnitPPValue("dofFarBlur", self._dofFarBlur)
	PostProcessingMgr.instance:setUnitPPValue("DofFarBlur", self._dofFarBlur)
	PostProcessingMgr.instance:setUnitPPValue("dofLength", self._dofLength)
	PostProcessingMgr.instance:setUnitPPValue("DofLength", self._dofLength)
	PostProcessingMgr.instance:setUnitPPValue("dofNearBlur", self._dofNearBlur)
	PostProcessingMgr.instance:setUnitPPValue("DofNearBlur", self._dofNearBlur)
	PostProcessingMgr.instance:setUnitPPValue("isDistortion", self._isDistortion)
	PostProcessingMgr.instance:setUnitPPValue("IsDistortion", self._isDistortion)
	PostProcessingMgr.instance:setUnitPPValue("rgbSplitCenter", self._rgbSplitCenter)
	PostProcessingMgr.instance:setUnitPPValue("RgbSplitCenter", self._rgbSplitCenter)

	self._mulColor = self._mulColor or Color.New(1, 1, 1, 1)
	self._keepColor = self._keepColor or Color.New(0, 0, 0, 1)

	PostProcessingMgr.instance:setUnitPPValue("flickerType", -1)
	PostProcessingMgr.instance:setUnitPPValue("FlickerType", -1)
	PostProcessingMgr.instance:setUnitPPValue("radialBlurLevel", 1)
	PostProcessingMgr.instance:setUnitPPValue("RadialBlurLevel", 1)
	PostProcessingMgr.instance:setUnitPPValue("rgbSplitStrength", 0)
	PostProcessingMgr.instance:setUnitPPValue("RgbSplitStrength", 0)
	PostProcessingMgr.instance:setUnitPPValue("saturation", 0.5)
	PostProcessingMgr.instance:setUnitPPValue("Saturation", 0.5)
	PostProcessingMgr.instance:setUnitPPValue("contrast", 0.5)
	PostProcessingMgr.instance:setUnitPPValue("Contrast", 0.5)
	PostProcessingMgr.instance:setUnitPPValue("mulColor", self._mulColor)
	PostProcessingMgr.instance:setUnitPPValue("MulColor", self._mulColor)
	PostProcessingMgr.instance:setUnitPPValue("keepColor", self._keepColor)
	PostProcessingMgr.instance:setUnitPPValue("KeepColor", self._keepColor)
	PostProcessingMgr.instance:setUnitPPValue("inverse", false)
	PostProcessingMgr.instance:setUnitPPValue("Inverse", false)
	PostProcessingMgr.instance:setUnitPPValue("colorSceOldMoviesActive", false)
	PostProcessingMgr.instance:setUnitPPValue("ColorSceOldMoviesActive", false)

	local virtualCameras = CameraMgr.instance:getVirtualCameras()

	for _, virtualCamera in ipairs(virtualCameras) do
		local body = ZProj.VirtualCameraWrap.Get(virtualCamera.gameObject).body
		local followerName = "Follower" .. string.sub(virtualCamera.name, string.len(virtualCamera.name))
		local follower = gohelper.findChild(virtualCamera.transform.parent.gameObject, followerName)
		local vcam = virtualCamera.transform.parent.gameObject

		body.m_PathOffset = self._pathOffset
		body.m_PathPosition = self._pathPosition
		body.m_XDamping = self._xDamping
		body.m_YDamping = self._yDamping
		body.m_ZDamping = self._zDamping
		follower.transform.localPosition = self._followerPos
		vcam.transform.localPosition = self._vcamPos
	end
end

function FightSceneCameraComp:_delaySetUnitCameraFov()
	local mainCamera = CameraMgr.instance:getMainCamera()
	local unitCamera = CameraMgr.instance:getUnitCamera()

	unitCamera.fieldOfView = mainCamera.fieldOfView

	FightController.instance:dispatchEvent(FightEvent.OnCameraFovChange)
end

function FightSceneCameraComp:setSceneCameraOffset()
	self:setCameraOffset(self:getDefaultCameraOffset())
end

function FightSceneCameraComp:getDefaultCameraOffset()
	local levelId = GameSceneMgr.instance:getCurLevelId()
	local levelConfig = lua_scene_level.configDict[levelId]
	local cameraOffsetParam = levelConfig and levelConfig.cameraOffset
	local useMyTurnCamera = FightMsgMgr.sendMsg(FightMsgId.CheckUseMyTurnCamera)

	if useMyTurnCamera then
		return useMyTurnCamera
	end

	if not string.nilorempty(cameraOffsetParam) then
		return (Vector3(unpack(cjson.decode(cameraOffsetParam))))
	else
		return Vector3.New(0, 0, 0)
	end
end

function FightSceneCameraComp:setCameraOffset(offset)
	local virsualCamerasGO = CameraMgr.instance:getVirtualCameraGO()

	virsualCamerasGO.transform.localPosition = offset
end

function FightSceneCameraComp:resetCameraOffset()
	local virsualCamerasGO = CameraMgr.instance:getVirtualCameraGO()

	virsualCamerasGO.transform.localPosition = Vector3.zero
end

local ReferenceFov = 60
local ReferenceResolution = 1.7777777777777777

function FightSceneCameraComp:_onScreenResize(width, height)
	local virtualCameraList = CameraMgr.instance:getVirtualCameras()
	local screenResolution = width / height
	local scaleFactor = screenResolution / ReferenceResolution
	local fov = 2 * Mathf.Atan(Mathf.Tan(ReferenceFov * Mathf.Deg2Rad / 2) / scaleFactor) * Mathf.Rad2Deg

	fov = Mathf.Clamp(fov, 60, 120)

	for _, virtualCamera in ipairs(virtualCameraList) do
		local old = virtualCamera.m_Lens

		virtualCamera.m_Lens = Cinemachine.LensSettings.New(fov, old.OrthographicSize, old.NearClipPlane, old.FarClipPlane, old.Dutch)
	end

	TaskDispatcher.runDelay(self._delaySetUnitCameraFov, self, 0.01)
end

return FightSceneCameraComp
