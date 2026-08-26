-- chunkname: @modules/logic/mainsceneswitch/controller/MainSceneSwitchCameraController.lua

module("modules.logic.mainsceneswitch.controller.MainSceneSwitchCameraController", package.seeall)

local MainSceneSwitchCameraController = class("MainSceneSwitchCameraController", BaseController)

function MainSceneSwitchCameraController:onInit()
	self:reInit()
end

function MainSceneSwitchCameraController:onInitFinish()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function MainSceneSwitchCameraController:addConstEvents()
	return
end

function MainSceneSwitchCameraController:reInit()
	return
end

function MainSceneSwitchCameraController:clear()
	TaskDispatcher.cancelTask(self._delayResize, self)

	self._showSceneId = nil
	self._calllback = nil
	self._callbackTarget = nil

	if self._rt then
		self._unitCamera.targetTexture = nil

		UnityEngine.RenderTexture.ReleaseTemporary(self._rt)

		self._rt = nil
	end

	MainSceneSwitchCameraDisplayController.instance:clear()

	if self._cameraLoader then
		self._cameraLoader:dispose()

		self._cameraLoader = nil
	end

	gohelper.destroy(self._cameraRootGO)

	self._cameraRootGO = nil
	self._cameraTrace = nil
	self._cameraCO = nil
	self._cameraTrace = nil
	self._cameraTraceGO = nil
	self._focusTrs = nil
	self._mainSceneRoot = nil
	self._unitPPVolume = nil
	self._mainCamera = nil
	self._mainCameraGO = nil
	self._mainCameraTrs = nil
	self._unitCamera = nil
	self._unitCameraGO = nil
	self._unitCameraTrs = nil
	self._isShowScene = false
end

function MainSceneSwitchCameraController:hideScene()
	MainSceneSwitchCameraDisplayController.instance:hideScene()

	self._isShowScene = false

	gohelper.setActive(self._cameraRootGO, false)
end

function MainSceneSwitchCameraController:showScene(id, callback, callbackTarget, params)
	self._showSceneId = id
	self._callback = callback
	self._callbackTarget = callbackTarget
	self._isShowScene = true
	self._params = params

	if not self._callback or not self._callbackTarget then
		logError("MainSceneSwitchCameraController showScene callback or callbackTarget is nil")

		return
	end

	self:_showScene()
end

function MainSceneSwitchCameraController:_showScene()
	if not self._showSceneId or not self._callback or not self._isShowScene then
		return
	end

	if self._cameraRootGO then
		gohelper.setActive(self._cameraRootGO, true)
		self:_initSettings()

		if not MainSceneSwitchCameraDisplayController.instance:hasSceneRoot() then
			MainSceneSwitchCameraDisplayController.instance:setSceneRoot(self._mainSceneRoot)
		end

		MainSceneSwitchCameraDisplayController.instance:showScene(self._showSceneId, self._onShowSceneFinish, self, self._params)
	else
		self:_loadCamera()
	end
end

function MainSceneSwitchCameraController:_onShowSceneFinish()
	local callback = self._callback
	local callbackTarget = self._callbackTarget

	if callback then
		self._callback(callbackTarget, self._rt)
	end
end

function MainSceneSwitchCameraController:_onScreenResize(width, height)
	if not self._cameraRootGO then
		return
	end

	self:resetParam()
	self:applyDirectly()
	TaskDispatcher.cancelTask(self._delayResize, self)
	TaskDispatcher.runDelay(self._delayResize, self, 0)
end

function MainSceneSwitchCameraController:_delayResize()
	if not self._rt or not self._isShowScene then
		return
	end

	local width, height = self:_getRTSize()

	if self._rt.width == width and self._rt.height == height then
		return
	end

	if self._rt then
		self._unitCamera.targetTexture = nil

		UnityEngine.RenderTexture.ReleaseTemporary(self._rt)

		self._rt = nil
	end

	self:_initRT()

	local callback = self._callback
	local callbackTarget = self._callbackTarget

	if callback then
		self._callback(callbackTarget, self._rt)
	end
end

function MainSceneSwitchCameraController:_loadCamera()
	if self._cameraLoader then
		return
	end

	self._cameraLoader = MultiAbLoader.New()
	self._cameraPath = "ppassets/switchscenecameraroot.prefab"

	self._cameraLoader:addPath(self._cameraPath)
	self._cameraLoader:startLoad(self._loadCameraFinish, self)
end

local CameraOffsetX = 20000

function MainSceneSwitchCameraController:_loadCameraFinish()
	local assetItem = self._cameraLoader:getAssetItem(self._cameraPath)

	self._cameraRootGO = gohelper.clone(assetItem:GetResource(), nil, "switchscenecameraroot")

	transformhelper.setLocalPos(self._cameraRootGO.transform, CameraOffsetX, 0, 0)
	self:_initCameraRootGO()

	self._cameraTrace.EnableTrace = true

	local levelId = 10101

	self:_initCurSceneCameraTrace(levelId)

	self._cameraTrace.EnableTrace = false
end

local MainCameraPath = "main/MainCamera"
local UnitCameraPath = "main/MainCamera/unitcamera"

function MainSceneSwitchCameraController:_initCameraRootGO()
	self._cameraTraceGO = gohelper.findChild(self._cameraRootGO, "main")
	self._cameraTrace = ZProj.GameCameraTrace.Get(self._cameraTraceGO)
	self._cameraTrace.EnableTrace = false

	ZProj.CameraChangeActor4Lua.Instance:SetCameraTrace(self._cameraTrace)

	self._focusTrs = gohelper.findChild(self._cameraRootGO, "focus").transform

	self._cameraTrace:SetFocusTransform(self._focusTrs)

	local mainCameraGO = gohelper.findChild(self._cameraRootGO, MainCameraPath)
	local unitCameraGO = gohelper.findChild(self._cameraRootGO, UnitCameraPath)

	self:setMainCamera(mainCameraGO)
	self:setUnitCamera(unitCameraGO)
	TaskDispatcher.runDelay(self._destoryActiveGos, self, 1)

	self._mainSceneRoot = gohelper.findChild(self._cameraRootGO, "SceneRoot/MainScene")
	self._unitPPVolume = gohelper.findChildComponent(unitCameraGO, "PPVolume", PostProcessingMgr.PPVolumeWrapType)

	MainSceneSwitchCameraDisplayController.instance:initMaps()
	MainSceneSwitchCameraDisplayController.instance:setSceneRoot(self._mainSceneRoot)
	self:_initSettings()
	self:setPPMaskType(true)
	self:_showScene()
end

function MainSceneSwitchCameraController:setPPMaskType(useSingleMask)
	self:setUnitPPValue("rolesStoryMaskActive", useSingleMask)
	self:setUnitPPValue("RolesStoryMaskActive", useSingleMask)
	self:setUnitPPValue("rgbSplitStrength", 0)
	self:setUnitPPValue("RgbSplitStrength", 0)
	self:setUnitPPValue("radialBlurLevel", 1)
	self:setUnitPPValue("RadialBlurLevel", 1)
	self:setUnitPPValue("dofFactor", 0)
	self:setUnitPPValue("DofFactor", 0)
end

function MainSceneSwitchCameraController:setUnitPPValue(key, value)
	if self._unitPPVolume then
		self._unitPPVolume.refresh = true
		self._unitPPVolume[key] = value
	end
end

function MainSceneSwitchCameraController:setLocalBloomColor(color)
	self:setUnitPPValue("localBloomColor", color)
end

function MainSceneSwitchCameraController:setMainCamera(cameraGO)
	self._mainCamera = cameraGO:GetComponent("Camera")
	self._mainCameraGO = cameraGO
	self._mainCameraTrs = cameraGO.transform
end

function MainSceneSwitchCameraController:setUnitCamera(cameraGO)
	self._unitCamera = cameraGO:GetComponent("Camera")
	self._unitCameraGO = cameraGO
	self._unitCameraTrs = cameraGO.transform
end

function MainSceneSwitchCameraController:getMainCamera()
	return self._mainCamera
end

function MainSceneSwitchCameraController:getCameraTraceGO()
	return self._cameraTraceGO
end

function MainSceneSwitchCameraController:_destoryActiveGos()
	local sceneGO = gohelper.findChild(self._mainCameraGO, "scene")

	if sceneGO then
		gohelper.destroy(sceneGO)
	end

	local unitGO = gohelper.findChild(self._unitCameraGO, "unit")

	if unitGO then
		gohelper.destroy(unitGO)
	end
end

function MainSceneSwitchCameraController:_initSettings()
	self:_initRT()
	self:_initProfile()
end

function MainSceneSwitchCameraController:_initProfile()
	local targetProfile = PostProcessingMgr.instance:getProfile()

	self._unitPPVolume:SetProfile(targetProfile)
end

function MainSceneSwitchCameraController:_initRT()
	self._rt = self._rt or self:_getRT()
	self._unitCamera.targetTexture = self._rt
end

function MainSceneSwitchCameraController:_getRT()
	local width, height = self:_getRTSize()

	return UnityEngine.RenderTexture.GetTemporary(width, height, 0, UnityEngine.RenderTextureFormat.ARGBHalf)
end

function MainSceneSwitchCameraController:_getRTSize()
	local width = self._mainCamera.pixelWidth
	local height = self._mainCamera.pixelHeight
	local ratio = width / height
	local maxTextureSize = UnityEngine.SystemInfo.maxTextureSize

	if maxTextureSize < width and height < width then
		width = maxTextureSize
		height = maxTextureSize / ratio
	end

	if maxTextureSize < height and width < height then
		height = maxTextureSize
		width = maxTextureSize * ratio
	end

	return width, height
end

function MainSceneSwitchCameraController:_initCurSceneCameraTrace(levelId)
	local sceneLevelCO = lua_scene_level.configDict[levelId]

	self._cameraCO = lua_camera.configDict[sceneLevelCO.cameraId]

	self:resetParam()
	self:applyDirectly()
end

function MainSceneSwitchCameraController:resetParam(cameraConfig)
	cameraConfig = cameraConfig or self._cameraCO

	local yaw = cameraConfig.yaw
	local pitch = cameraConfig.pitch
	local dist = cameraConfig.distance
	local fov = self:_calcFovInternal(cameraConfig)

	self.yaw = yaw

	self._cameraTrace:SetTargetParam(yaw, pitch, dist, fov, 0, 0, 0)

	local focusX = CameraOffsetX
	local focusY = cameraConfig.yOffset
	local focusZ = cameraConfig.focusZ

	self:setFocus(focusX, focusY, focusZ)
end

function MainSceneSwitchCameraController:setFocus(x, y, z)
	local focusTrs = self._focusTrs

	transformhelper.setPos(focusTrs, x, y, z)
end

function MainSceneSwitchCameraController:_calcFovInternal(cameraConfig)
	local fovRatio = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		local w, h = SettingsModel.instance:getCurrentScreenSize()

		fovRatio = 16 * h / 9 / w
	end

	local fov = cameraConfig.fov * fovRatio

	if fovRatio > 1 then
		fov = fov * 0.85
	end

	local minFov, maxFov = self:_getMinMaxFov()

	fov = Mathf.Clamp(fov, minFov, maxFov)

	return fov
end

function MainSceneSwitchCameraController:_getMinMaxFov()
	return 35, 120
end

function MainSceneSwitchCameraController:applyDirectly()
	local focusTrs = self._focusTrs

	self._cameraTrace:SetTargetFocusPos(transformhelper.getPos(focusTrs))
	self._cameraTrace:ApplyDirectly()
end

MainSceneSwitchCameraController.instance = MainSceneSwitchCameraController.New()

return MainSceneSwitchCameraController
