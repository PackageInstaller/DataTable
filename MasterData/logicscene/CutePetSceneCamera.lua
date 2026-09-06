-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/camera/CutePetSceneCamera.lua

module("logicscene.scene.component.camera.CutePetSceneCamera", package.seeall)

local CutePetSceneCamera = class("CutePetSceneCamera", SceneCameraBase)
local scale = 0.05

CutePetSceneCamera.cameraRotX = 20
CutePetSceneCamera.cameraRotY = 90
CutePetSceneCamera.cameraRotZ = 0
CutePetSceneCamera.cameraPosX = 8
CutePetSceneCamera.cameraPosY = 29.8697
CutePetSceneCamera.cameraPosZ = -82.3046

function CutePetSceneCamera:ctor(scene)
	CutePetSceneCamera.super.ctor(self, scene)

	self._cameraId = 4
	self._travelCameraId = 5
	self._focusZOffset = 0
	self._focusYOffset = 0
	self._lastFocusX = 0
	self._lastFocusY = 0
	self._lastFocusZ = 0
end

function CutePetSceneCamera:_initCameraFollow()
	local mainCameraGO = self._mainCamera:getGO()
	local follower = Framework.CameraMmoFollow.Get(mainCameraGO)

	follower.enabled = false

	return follower
end

function CutePetSceneCamera:setCameraParams(fov, dist, pitch, yaw)
	self:setFov(fov)
	self:setDist(dist)
	self:setPitch(pitch)
	self:setYaw(yaw)
end

function CutePetSceneCamera:shake(lifeTime, magnitude, shakeMode, shakeMagnitudeDecreaseRate)
	if not self._shaker then
		return
	end

	shakeMode = shakeMode or Framework.ShakeMode.Sphere
	shakeMagnitudeDecreaseRate = shakeMagnitudeDecreaseRate or 0.1

	self._shaker:Shake(lifeTime, magnitude, shakeMode, shakeMagnitudeDecreaseRate)
end

function CutePetSceneCamera:stopShake()
	if not self._shaker then
		return
	end

	self._shaker:Clear()
end

function CutePetSceneCamera:onEnterSceneFinished()
	local cameraCO = SceneConfig.instance:getCameraCo(self._cameraId)

	CutePetSceneCamera.cameraPosY = cameraCO.focusYOffset
	CutePetSceneCamera.cameraPosZ = cameraCO.focusZOffset
	CutePetSceneCamera.cameraPosX = cameraCO.cameraDist
	CutePetSceneCamera.cameraRotX = cameraCO.pitch
	CutePetSceneCamera.cameraRotY = cameraCO.yaw

	local mainCamera = self._mainCamera:getCamera()

	mainCamera.farClipPlane = 1000
	mainCamera.orthographic = false

	self:setFov(cameraCO.fov)
	Framework.TransformUtil.SetPos(mainCamera.transform, CutePetSceneCamera.cameraPosX, CutePetSceneCamera.cameraPosY, CutePetSceneCamera.cameraPosZ)
	Framework.TransformUtil.SetLocalRotation(mainCamera.transform, CutePetSceneCamera.cameraRotX, CutePetSceneCamera.cameraRotY, CutePetSceneCamera.cameraRotZ)

	self._focusYOffset = CutePetSceneCamera.cameraPosY
	self._focusZOffset = CutePetSceneCamera.cameraPosZ
	self._lastFocusX = CutePetSceneCamera.cameraPosX
	self._lastFocusY = 0
	self._lastFocusZ = 0

	local minX, minZ, maxX, maxZ = -12, CutePetSceneCamera.cameraPosZ, 12, CutePetSceneCamera.cameraPosZ

	self._cameraOringinRanges = {
		minX + CutePetSceneCamera.cameraPosX,
		minZ,
		maxX + CutePetSceneCamera.cameraPosX,
		maxZ
	}

	local camSizeH = mainCamera.orthographicSize * 2
	local camSizeW = mainCamera.aspect * camSizeH

	self._cameraRanges = {}
	self._cameraRanges[1] = self._cameraOringinRanges[1] + camSizeW * 0.5
	self._cameraRanges[2] = self._cameraOringinRanges[2] + camSizeH * 0.5
	self._cameraRanges[3] = self._cameraOringinRanges[3] - camSizeW * 0.5
	self._cameraRanges[4] = self._cameraOringinRanges[4] - camSizeH * 0.5

	local groundCamera = GlobalModel.instance.groundCamera

	groundCamera.farClipPlane = 1200

	self:setPosFocusMovement(0, 0)
end

function CutePetSceneCamera:onExitScene()
	self._follower.enabled = false
end

function CutePetSceneCamera:updateCameraParams()
	return
end

function CutePetSceneCamera:resetCamera()
	self._isCanMove = true

	local mainCamera = self._mainCamera:getCamera()

	Framework.TransformUtil.SetPos(mainCamera.transform, CutePetSceneCamera.cameraPosX, CutePetSceneCamera.cameraPosY, CutePetSceneCamera.cameraPosZ)
	Framework.TransformUtil.SetLocalRotation(mainCamera.transform, CutePetSceneCamera.cameraRotX, CutePetSceneCamera.cameraRotY, CutePetSceneCamera.cameraRotZ)
end

function CutePetSceneCamera:update(deltaTime)
	if not self._isTouchedDown then
		if UGUIToolHelper.IsTouchDown() and not UGUIToolHelper.IsOverUI() then
			self:_onTouchDown()
		end
	elseif UGUIToolHelper.IsTouchUp() then
		self:_onTouchUp()
	else
		self._touchTime = (self._touchTime or 0) + deltaTime

		self:_onTouchMove()
	end
end

function CutePetSceneCamera:_onTouchDown()
	self._isTouchedDown = true
	self._touchTime = 0
	self._touchDownPos = UGUIToolHelper.GetTouchPosition()
end

function CutePetSceneCamera:_onTouchMove()
	if self._isCanMove == false then
		self:_onTouchUp()

		return
	end

	local mousePos = UGUIToolHelper.GetTouchPosition()
	local a, b = GameUtil.checkVector2(mousePos), GameUtil.checkVector2(self._touchDownPos)
	local directionX, directionY = b.x - a.x, b.y - a.y

	self._touchDownPos = mousePos

	if self._touchTime < 0.1 then
		return
	end

	directionX = directionX * scale
	directionY = directionY * scale

	self:setPosFocusMovement(directionX, directionY)
end

function CutePetSceneCamera:_onTouchUp()
	self._isTouchedDown = nil
	self._touchDownPos = nil
	self._touchTime = 0
end

function CutePetSceneCamera:setPosFocusMovement(dx, dy)
	self:setPosFocus(checknumber(self._lastFocusX) + dx, 0, checknumber(self._lastFocusZ) + dy)
end

function CutePetSceneCamera:setPosFocus(x, y, z)
	y = checknumber(self._focusYOffset) + y
	z = checknumber(self._focusZOffset) + z
	x, z = self:_fixFocus(x, z)
	self._lastFocusX = x
	self._lastFocusZ = z - checknumber(self._focusZOffset)

	self:setYaw(90 - CutePetSceneCamera.cameraRotY)
	self:setPitch(90 - CutePetSceneCamera.cameraRotX)
	self:setFocus(x, y, z)
	self:applyDirectly()
end

function CutePetSceneCamera:_fixFocus(x, y)
	if self._cameraRanges then
		x = math.max(x, self._cameraRanges[1])
		x = math.min(x, self._cameraRanges[3])
		y = math.max(y, self._cameraRanges[2])
		y = math.min(y, self._cameraRanges[4])
	end

	return x, y
end

function CutePetSceneCamera:setFix()
	self._isCanMove = false
end

function CutePetSceneCamera:setRelease(...)
	self._isCanMove = true
end

function CutePetSceneCamera:setToTravel()
	local cameraCO = SceneConfig.instance:getCameraCo(self._travelCameraId)
	local mainCamera = self._mainCamera:getCamera()

	Framework.TransformUtil.SetPos(mainCamera.transform, cameraCO.cameraDist, cameraCO.focusYOffset, cameraCO.focusZOffset)
	self:setYaw(90 - cameraCO.yaw)
	self:setPitch(90 - cameraCO.pitch)
end

function CutePetSceneCamera:setToNomal()
	self:setPosFocusMovement(0, 0)
end

return CutePetSceneCamera
