-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/camera/CitySceneCameraEx.lua

module("logicscene.scene.component.camera.CitySceneCameraEx", package.seeall)

local CitySceneCameraEx = class("CitySceneCameraEx", SceneCameraBase)

CitySceneCameraEx.orthographicSize = 3.6

function CitySceneCameraEx:ctor(scene)
	CitySceneCameraEx.super.ctor(self, scene)

	self._cameraId = 1
	self._defaultPosSmoothLag = 0
	self._defaultSmoothLag = 0
end

function CitySceneCameraEx:onInit()
	return
end

function CitySceneCameraEx:_initCameraFollow()
	local mainCameraGO = self._mainCamera:getGO()
	local follower = Framework.CameraMmoFollow.Get(mainCameraGO)

	follower.enabled = false
	self._enableFollow = false

	return follower
end

function CitySceneCameraEx:onEnterScene(sceneId, bornX, bornZ)
	self._mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	local mainCam = self._mainCamera:getCamera()

	GlobalModel.instance.skillCamera.gameObject:SetActive(false)
	GlobalModel.instance.skillUICamera.gameObject:SetActive(false)
	AMCameraShake.StopShake(mainCam.gameObject)
	AMFollowTarget.StopFollow(mainCam.gameObject)
	Spine.Unity.BoneFollower.StopFollow(mainCam.gameObject)

	local cameraCO = SceneConfig.instance:getCameraCo(self._cameraId)

	self._focusYOffset = cameraCO.focusYOffset
	self._focusZOffset = cameraCO.focusZOffset
	self._lastFocusX = 0
	self._lastFocusY = 0
	self._lastFocusZ = 0

	self._mainPlayer.transform:addListener(UnitNotify.PosChanged, self._onMainUnitPosChanged, self)
end

function CitySceneCameraEx:onEnterSceneFinished(sceneId, bornX, bornZ)
	self._follower.SmoothLag = self._defaultSmoothLag
	self._follower.PosSmoothLag = self._defaultPosSmoothLag
	self._follower.enabled = true
	self._enableFollow = true
end

function CitySceneCameraEx:updateCameraParams()
	local stage = self._scene.stage
	local minX, minY, maxX, maxY = stage.wholeScene:GetCameraRange(nil, nil, nil, nil)

	self._cameraOringinRanges = {
		minX,
		minY,
		maxX,
		maxY
	}

	local mainCam = self._mainCamera:getCamera()

	mainCam.orthographic = true
	mainCam.farClipPlane = 20000
	mainCam.orthographicSize = SceneMgr.instance:getSceneCameraParams(self._scene:getSceneId())

	local cameraCO = SceneConfig.instance:getCameraCo(self._cameraId)

	self:setDist(cameraCO.cameraDist)
	self:setFov(cameraCO.fov)
	self:setPitch(cameraCO.pitch)
	self:setYaw(cameraCO.yaw + 1e-06)

	self._focusYOffset = cameraCO.focusYOffset
	self._focusZOffset = cameraCO.focusZOffset
	self._lastFocusX = 0
	self._lastFocusY = 0
	self._lastFocusZ = 0

	local camSizeH = mainCam.orthographicSize * 2
	local camSizeW = mainCam.aspect * camSizeH

	self._cameraRanges = {}
	self._cameraRanges[1] = self._cameraOringinRanges[1] + camSizeW * 0.5
	self._cameraRanges[2] = self._cameraOringinRanges[2] + camSizeH * 0.5
	self._cameraRanges[3] = self._cameraOringinRanges[3] - camSizeW * 0.5
	self._cameraRanges[4] = self._cameraOringinRanges[4] - camSizeH * 0.5

	local x, y, z = self._mainPlayer.transform:getPos()

	self:setPosFocus(x, y, z or 0)
	self:applyDirectly()
end

function CitySceneCameraEx:onExitScene()
	self._cameraRanges = nil
	self._cameraOringinRanges = nil
	self._follower.PosSmoothLag = self._defaultPosSmoothLag
	self._follower.enabled = false
	self._enableFollow = false

	self._mainPlayer.transform:removeListener(UnitNotify.PosChanged, self._onMainUnitPosChanged, self)
end

function CitySceneCameraEx:getCameraOriginRange()
	return self._cameraOringinRanges
end

function CitySceneCameraEx:enablFollowTarget(enabled)
	self._enableFollow = enabled or false
	self._follower.enabled = self._enableFollow

	self._mainPlayer.transform:removeListener(UnitNotify.PosChanged, self._onMainUnitPosChanged, self)
end

function CitySceneCameraEx:isFollowTargetEnabled()
	return self._enableFollow
end

function CitySceneCameraEx:getPosFocusYOffset()
	return self._focusYOffset
end

function CitySceneCameraEx:setPosFocusMovement(dx, dy)
	self:setPosFocus(self._lastFocusX + dx, self._lastFocusY + dy)
end

function CitySceneCameraEx:setPosFocus(x, y, z)
	self._lastFocusZ = z
	y = self._focusYOffset + y
	z = self._focusZOffset
	x, y = self:_fixFocus(x, y)
	self._lastFocusX = x
	self._lastFocusY = y - self._focusYOffset

	self:setFocus(x, y, z)
	self:applyDirectly()
end

function CitySceneCameraEx:_fixFocus(x, y)
	if self._cameraRanges then
		x = math.max(x, self._cameraRanges[1])
		x = math.min(x, self._cameraRanges[3])
		y = math.max(y, self._cameraRanges[2])
		y = math.min(y, self._cameraRanges[4])
	end

	return x, y
end

function CitySceneCameraEx:setFollowUnit(unit)
	if self._mainPlayer then
		self._mainPlayer.transform:removeListener(UnitNotify.PosChanged, self._onMainUnitPosChanged, self)
	end

	self._mainPlayer = unit

	if self._mainPlayer then
		self._mainPlayer.transform:addListener(UnitNotify.PosChanged, self._onMainUnitPosChanged, self)

		local x, y, z = self._mainPlayer.transform:getPos()

		self:setPosFocus(x, y, z or 0)
	end
end

function CitySceneCameraEx:boundCamera()
	local mainCam = self._mainCamera:getCamera()

	CameraBounds.BoundCamera(mainCam.gameObject, self._cameraRanges[1], self._cameraRanges[2], self._cameraRanges[3], self._cameraRanges[4])
end

function CitySceneCameraEx:unBoundCamera()
	local mainCam = self._mainCamera:getCamera()

	CameraBounds.UnBoundCamera(mainCam.gameObject)
end

function CitySceneCameraEx:_onMainUnitPosChanged(x, y, z, isSetPosDirectly)
	if not self._enableFollow then
		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.MainPalyerPosChange, x, y)
	self:setPosFocus(x, y, z)
end

function CitySceneCameraEx:_onAnimationStarted()
	return
end

function CitySceneCameraEx:_onAnimationEnded()
	return
end

return CitySceneCameraEx
