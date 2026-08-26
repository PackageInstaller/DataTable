-- chunkname: @modules/logic/scene/common/camera/CameraMgr.lua

module("modules.logic.scene.common.camera.CameraMgr", package.seeall)

local CameraMgr = class("CameraMgr")
local CameraResPath = "ppassets/cameraroot.prefab"
local UrpProfilePath = "ppassets/urpassets/urpasset.asset"
local CameraRootName = "cameraroot"
local MainCameraPath = "main/MainCamera"
local UnitCameraPath = "main/MainCamera/unitcamera"
local OrthCameraPath = "main/orthCamera"
local SubCameraPath = "main/subcamera"
local UICameraPath = "UICamera"
local VirtualCameraPath = "main/VirtualCameras"

function CameraMgr:ctor()
	self._cameraRootGO = nil
	self._cameraTraceGO = nil
	self._cameraTrace = nil
	self._cameraShake = nil
	self._focusTrs = nil
	self._mainCamera = nil
	self._mainCameraGO = nil
	self._mainCameraTrs = nil
	self._uiCamera = nil
	self._uiCameraGO = nil
	self._uiCameraTrs = nil
	self._unitCamera = nil
	self._unitCameraGO = nil
	self._unitCameraTrs = nil
	self._orthCamera = nil
	self._orthCameraGO = nil
	self._orthCameraTrs = nil
	self._subCamera = nil
	self._subCameraGO = nil
	self._subCameraTrs = nil
	self._urpProfileAsset = nil
	self._sceneRootGO = nil
	self._virtualCameraList = nil
	self._virtualCameraGO = nil
	self._virtualCameraTrs = nil
	self._virtualCameraSets = nil
	self._cameraRootAnimator = nil
	self._cameraRootAnimatorPlayer = nil
end

function CameraMgr:initCamera(onInitDone, cbObj)
	self._onInitDone = onInitDone
	self._doneCbObj = cbObj

	loadAbAsset(UrpProfilePath, true, self._onLoadedUrpProfile, self)
end

function CameraMgr:_onLoadedCamera(assetItem)
	if not assetItem.IsLoadSuccess then
		logError("CameraMgr:_onLoadedCamera load fail: " .. assetItem.ResPath)
	else
		assetItem:Retain()

		self._cameraRootGO = gohelper.clone(assetItem:GetResource(), nil, CameraRootName)

		self:_initCameraRootGO()
	end

	if self._onInitDone then
		self._onInitDone(self._doneCbObj)
	end
end

function CameraMgr:_initCameraRootGO()
	self._cameraTraceGO = gohelper.findChild(self._cameraRootGO, "main")
	self._sceneRootGO = gohelper.findChild(self._cameraRootGO, "SceneRoot")
	self._sceneTransform = self._sceneRootGO.transform
	self._cameraTrace = ZProj.GameCameraTrace.Get(self._cameraTraceGO)
	self._cameraTrace.EnableTrace = false
	self._cameraShake = ZProj.CameraShake.Get(self._sceneRootGO)

	ZProj.CameraChangeActor4Lua.Instance:SetCameraTrace(self._cameraTrace)

	self._focusTrs = gohelper.findChild(self._cameraRootGO, "focus").transform

	self._cameraTrace:SetFocusTransform(self._focusTrs)

	local mainCameraGO = gohelper.findChild(self._cameraRootGO, MainCameraPath)
	local unitCameraGO = gohelper.findChild(self._cameraRootGO, UnitCameraPath)
	local orthCameraGO = gohelper.findChild(self._cameraRootGO, OrthCameraPath)
	local uiCameraGO = gohelper.findChild(self._cameraRootGO, UICameraPath)
	local subCameraGO = gohelper.findChild(self._cameraRootGO, SubCameraPath)
	local virtualCameraGO = gohelper.findChild(self._cameraRootGO, VirtualCameraPath)

	self:setMainCamera(mainCameraGO)
	self:setUICamera(uiCameraGO)
	self:setUnitCamera(unitCameraGO)
	self:setOrthCamera(orthCameraGO)
	self:setOrthCameraActive(false)
	self:setSubCamera(subCameraGO)
	self:setVirtualCamera(virtualCameraGO)

	self._showUnitCameraKeyDict = {}

	PostProcessingMgr.instance:init(mainCameraGO, unitCameraGO, uiCameraGO, self._urpProfileAsset)
	TaskDispatcher.runDelay(self._destoryActiveGos, self, 1)
end

function CameraMgr:setUnitCameraSeparate()
	self._unitCameraTrs.parent = self._mainCameraTrs.parent
end

function CameraMgr:setUnitCameraCombine()
	self._mainCameraTrs.localRotation = Vector3.zero
	self._unitCameraTrs.parent = self._mainCameraTrs
	self._unitCameraTrs.localRotation = Vector3.zero
	self._unitCameraTrs.localPosition = Vector3.zero
end

function CameraMgr:_destoryActiveGos()
	local sceneGO = gohelper.findChild(self._mainCameraGO, "scene")

	if sceneGO then
		gohelper.destroy(sceneGO)
	end

	local unitGO = gohelper.findChild(self._unitCameraGO, "unit")

	if unitGO then
		gohelper.destroy(unitGO)
	end

	local clearCameraGO = UnityEngine.GameObject.Find("ClearCamera")

	if clearCameraGO then
		gohelper.destroy(clearCameraGO)
	end
end

function CameraMgr:_onLoadedUrpProfile(assetItem)
	if not assetItem.IsLoadSuccess then
		logError("CameraMgr:_onLoadedUrpProfile load fail: " .. assetItem.ResPath)
	else
		assetItem:Retain()

		self._urpProfileAsset = assetItem:GetResource()
		UnityEngine.Rendering.GraphicsSettings.renderPipelineAsset = self._urpProfileAsset
	end

	loadAbAsset(CameraResPath, true, self._onLoadedCamera, self)
end

function CameraMgr:initCameraWithCameraRoot(onInitDone, cbObj, cameraRoot)
	self._onInitDone = onInitDone
	self._doneCbObj = cbObj
	self._cameraRootGO = cameraRoot

	loadAbAsset(UrpProfilePath, true, self._onLoadedUrpProfileWithCameraRoot, self)
end

function CameraMgr:_onLoadedUrpProfileWithCameraRoot(assetItem)
	if not assetItem.IsLoadSuccess then
		logError("CameraMgr:_onLoadedUrpProfile load fail: " .. assetItem.ResPath)
	else
		assetItem:Retain()

		self._urpProfileAsset = assetItem:GetResource()
		UnityEngine.Rendering.GraphicsSettings.renderPipelineAsset = self._urpProfileAsset
	end

	self:_initCameraRootGO()

	if self._onInitDone then
		self._onInitDone(self._doneCbObj)
	end
end

function CameraMgr:setMainCamera(cameraGO)
	self._mainCamera = cameraGO:GetComponent("Camera")
	self._mainCameraGO = cameraGO
	self._mainCameraTrs = cameraGO.transform
end

function CameraMgr:setUICamera(cameraGO)
	self._uiCamera = cameraGO:GetComponent("Camera")
	self._uiCameraGO = cameraGO
	self._uiCameraTrs = cameraGO.transform
	ViewMgr.instance:getUICanvas().worldCamera = self._uiCamera
end

function CameraMgr:setUnitCamera(cameraGO)
	self._unitCamera = cameraGO:GetComponent("Camera")
	self._unitCameraGO = cameraGO
	self._unitCameraTrs = cameraGO.transform
end

function CameraMgr:setOrthCamera(cameraGO)
	self._orthCamera = cameraGO:GetComponent("Camera")
	self._orthCameraGO = cameraGO
	self._orthCameraTrs = cameraGO.transform
end

function CameraMgr:setSubCamera(cameraGO)
	self._subCamera = cameraGO:GetComponent("Camera")
	self._subCameraGO = cameraGO
	self._subCameraTrs = cameraGO.transform
end

function CameraMgr:setVirtualCamera(virtualCameraGO)
	self._virtualCameraGO = virtualCameraGO
	self._virtualCameraTrs = virtualCameraGO.transform
	self._virtualCameraList = {}

	local pathList = {
		"set1/vcam1/CM_vcam1",
		"set1/vcam2/CM_vcam2",
		"set2/vcam3/CM_vcam3",
		"set2/vcam4/CM_vcam4"
	}

	for _, path in ipairs(pathList) do
		local virtualCamera = gohelper.findChildComponent(self._virtualCameraGO, path, typeof(Cinemachine.CinemachineVirtualCamera))

		if virtualCamera then
			table.insert(self._virtualCameraList, virtualCamera)
		end
	end

	self._virtualCameraSets = {}
	self._virtualCameraSets[1] = gohelper.findChild(virtualCameraGO, "set1")
	self._virtualCameraSets[2] = gohelper.findChild(virtualCameraGO, "set2")
end

function CameraMgr:switchVirtualCamera(setIndex)
	for i, setGO in ipairs(self._virtualCameraSets) do
		if i == setIndex then
			setGO.name = "set" .. setIndex or "disableSet"
		end

		gohelper.setActive(setGO, i == setIndex)
	end
end

function CameraMgr:getSceneCameraActive()
	local show = true

	for _, value in pairs(self._showUnitCameraKeyDict) do
		if not value then
			show = false

			break
		end
	end

	return show
end

function CameraMgr:setSceneCameraActive(active, key)
	if not self._unitCameraGO then
		return
	end

	self._showUnitCameraKeyDict[key] = not not active

	local show = self:getSceneCameraActive()

	gohelper.setActive(self._unitCameraGO, show)
	PostProcessingMgr.instance:dispatchEvent(PostProcessingEvent.onUnitCameraVisibleChange, show)
end

function CameraMgr:setOrthCameraActive(active)
	gohelper.setActive(self._orthCameraGO, active)
end

function CameraMgr:getCameraRootGO()
	return self._cameraRootGO
end

function CameraMgr:getCameraRootAnimator()
	if self._cameraRootAnimatorPlayer then
		self._cameraRootAnimatorPlayer:Stop()
	elseif SLFramework.FrameworkSettings.IsEditor and self._cameraRootGO:GetComponent(typeof(SLFramework.AnimatorPlayer)) then
		logError("CameraMgr要通过getCameraRootAnimatorPlayer获得AnimatorPlayer")
	end

	self._cameraRootAnimator = self._cameraRootAnimator or gohelper.onceAddComponent(self._cameraRootGO, typeof(UnityEngine.Animator))

	return self._cameraRootAnimator
end

function CameraMgr:setCameraRootAnimatorController(controller)
	local animator = self:getCameraRootAnimator()

	if animator.runtimeAnimatorController ~= controller then
		local controllerName = controller and controller.name

		PostProcessingMgr.instance:dispatchEvent(PostProcessingEvent.onCameraRootAnimatorControllerChange, controllerName)
	end

	animator.runtimeAnimatorController = controller
end

function CameraMgr:getCameraRootAnimatorPlayer()
	self._cameraRootAnimatorPlayer = self._cameraRootAnimatorPlayer or SLFramework.AnimatorPlayer.Get(self._cameraRootGO)

	return self._cameraRootAnimatorPlayer
end

function CameraMgr:getCameraRootAnimationEventWrap()
	self._cameraRootAnimationEventWrap = self._cameraRootAnimationEventWrap or gohelper.onceAddComponent(self._cameraRootGO, typeof(ZProj.AnimationEventWrap))

	return self._cameraRootAnimationEventWrap
end

function CameraMgr:hasCameraRootAnimatorPlayer()
	return self._cameraRootAnimatorPlayer ~= nil
end

function CameraMgr:getCameraTraceGO()
	return self._cameraTraceGO
end

function CameraMgr:getCameraTrace()
	return self._cameraTrace
end

function CameraMgr:getCameraShake()
	return self._cameraShake
end

function CameraMgr:getFocusTrs()
	return self._focusTrs
end

function CameraMgr:getMainCamera()
	return self._mainCamera
end

function CameraMgr:getMainCameraGO()
	return self._mainCameraGO
end

function CameraMgr:getMainCameraTrs()
	return self._mainCameraTrs
end

function CameraMgr:getUICamera()
	return self._uiCamera
end

function CameraMgr:getUICameraGO()
	return self._uiCameraGO
end

function CameraMgr:getUICameraTrs()
	return self._uiCameraTrs
end

function CameraMgr:getUnitCamera()
	return self._unitCamera
end

function CameraMgr:getUnitCameraGO()
	return self._unitCameraGO
end

function CameraMgr:getUnitCameraTrs()
	return self._unitCameraTrs
end

function CameraMgr:getOrthCamera()
	return self._orthCamera
end

function CameraMgr:getOrthCameraGO()
	return self._orthCameraGO
end

function CameraMgr:getSubCamera()
	return self._subCamera
end

function CameraMgr:getSubCameraGO()
	return self._subCameraGO
end

function CameraMgr:getSubCameraTrs()
	return self._subCameraTrs
end

function CameraMgr:getSceneRoot()
	return self._sceneRootGO
end

function CameraMgr:getSceneTransform()
	return self._sceneTransform
end

function CameraMgr:getVirtualCamera(setIndex, indexInSet)
	local id = (setIndex - 1) * 2 + indexInSet

	return self._virtualCameraList[id]
end

function CameraMgr:getVirtualCameras()
	return self._virtualCameraList
end

function CameraMgr:getVirtualCameraGO()
	return self._virtualCameraGO
end

function CameraMgr:setVirtualCameraChildActive(active, child)
	if not self._virtualCameraGO then
		return
	end

	local childGo = gohelper.findChild(self._virtualCameraGO, child)

	gohelper.setActive(childGo, active)
end

function CameraMgr:getVirtualCameraTrs()
	return self._virtualCameraTrs
end

function CameraMgr:setRenderScale(scale)
	if self._urpProfileAsset then
		logNormal("CameraMgr:setRenderScale scale = " .. scale)

		self._urpProfileAsset.renderScale = scale
	end
end

function CameraMgr:setRenderMSAACount(count)
	if self._urpProfileAsset then
		logNormal("CameraMgr:setRenderMSAACount count = " .. count)

		self._urpProfileAsset.msaaSampleCount = count
	end
end

function CameraMgr:getRenderScale()
	if self._urpProfileAsset then
		return self._urpProfileAsset.renderScale
	end
end

function CameraMgr:setShadowDistance(distance)
	if self._urpProfileAsset then
		self._urpProfileAsset.shadowDistance = distance
	end
end

function CameraMgr:getShadowDistance()
	if self._urpProfileAsset then
		return self._urpProfileAsset.shadowDistance
	end
end

function CameraMgr:setMainLightShadowmapResolution(resolution)
	if self._urpProfileAsset then
		self._urpProfileAsset.mainLightShadowmapResolution = resolution
	end
end

function CameraMgr:getMainLightShadowmapResolution()
	if self._urpProfileAsset then
		return self._urpProfileAsset.mainLightShadowmapResolution
	end
end

function CameraMgr:setShadowDepthBias(num)
	if self._urpProfileAsset then
		self._urpProfileAsset.shadowDepthBias = num
	end
end

function CameraMgr:getShadowDepthBias()
	if self._urpProfileAsset then
		return self._urpProfileAsset.shadowDepthBias
	end
end

function CameraMgr:setShadowNormalBias(num)
	if self._urpProfileAsset then
		self._urpProfileAsset.shadowNormalBias = num
	end
end

function CameraMgr:getShadowNormalBias()
	if self._urpProfileAsset then
		return self._urpProfileAsset.shadowNormalBias
	end
end

CameraMgr.instance = CameraMgr.New()

return CameraMgr
