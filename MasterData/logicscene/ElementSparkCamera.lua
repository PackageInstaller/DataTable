-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/camera/ElementSparkCamera.lua

module("logicscene.scene.component.camera.ElementSparkCamera", package.seeall)

local ElementSparkCamera = class("ElementSparkCamera", SceneCameraBase)
local scale = 0.01

ElementSparkCamera.cameraPosZ = -3000

function ElementSparkCamera:ctor(scene)
	ElementSparkCamera.super.ctor(self, scene)

	self._cameraId = 6
	self._focusZOffset = 0
	self._focusYOffset = 0
	self._lastFocusX = 0
	self._lastFocusY = 0
	self._lastFocusZ = 0
end

function ElementSparkCamera:_initCameraFollow()
	local mainCameraGO = self._mainCamera:getGO()
	local follower = Framework.CameraMmoFollow.Get(mainCameraGO)

	follower.enabled = false

	return follower
end

function ElementSparkCamera:onExitScene()
	ElementSparkCamera.super.onExitScene(self)
	GlobalDispatcher:removeListener(self._moveChunkToCenter, self)
end

function ElementSparkCamera:onEnterSceneFinished(sceneId, bornX, bornZ)
	ElementSparkCamera.super.onEnterSceneFinished(self, sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.ElementSparkMoveChunkToCenter, self._moveChunkToCenter, self)
end

function ElementSparkCamera:lateEnterFinished()
	local mainCamera = self._mainCamera:getCamera()

	mainCamera.orthographic = true
	mainCamera.farClipPlane = 5000

	self:setFov(15)

	local mapSizeX, mapSizeY = ElementSparkElemsMgr.MapSizeX, ElementSparkElemsMgr.MapSizeY

	self._focusYOffset = 0
	self._focusZOffset = 0
	self._lastFocusX = mapSizeX / 2
	self._lastFocusY = mapSizeY / 2
	self._lastFocusZ = 0

	Framework.TransformUtil.SetPos(mainCamera.transform, self._lastFocusX, self._lastFocusY, ElementSparkCamera.cameraPosZ)
	Framework.TransformUtil.SetLocalRotation(mainCamera.transform, 0, 0, 0)

	mainCamera.orthographicSize = 5
	mainCamera.cullingMask = GlobalModel.instance.mainCamCullMask

	self._scene.stage:updateDetectors()
	self:_calCameraRange()

	local lastChunkId = ElementSparkSceneController.instance:getCurrSelectChunkId()

	if lastChunkId <= 0 then
		self:_moveMyTeamToCenter()
	else
		self:_moveChunkToCenter(lastChunkId)
	end
end

function ElementSparkCamera:update(deltaTime)
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

function ElementSparkCamera:_onTouchDown()
	self._isTouchedDown = true
	self._touchTime = 0
	self._touchDownPos = UGUIToolHelper.GetTouchPosition()
end

function ElementSparkCamera:_onTouchUp()
	self._isTouchedDown = nil
	self._touchDownPos = nil
	self._touchTime = 0
end

function ElementSparkCamera:_onTouchMove()
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

function ElementSparkCamera:setPosFocusMovement(dx, dy)
	self:setPosFocus(checknumber(self._lastFocusX) + dx, checknumber(self._lastFocusY) + dy)
end

function ElementSparkCamera:setPosFocus(x, y)
	x, y = self:_fixFocus(x, y)
	self._lastFocusX = x
	self._lastFocusY = y

	self:setYaw(0)
	self:setPitch(90)
	self:setFocus(x, y, ElementSparkCamera.cameraPosZ)
	self:applyDirectly()
end

function ElementSparkCamera:_fixFocus(x, y)
	if self._cameraRanges then
		x = math.max(x, self._cameraRanges[1])
		x = math.min(x, self._cameraRanges[2])
		y = math.max(y, self._cameraRanges[3])
		y = math.min(y, self._cameraRanges[4])
	end

	return x, y
end

function ElementSparkCamera:updateCameraParams()
	return
end

function ElementSparkCamera:_moveChunkToCenter(chunkId)
	local planId = ElementSparkController.instance:getMapPlanId()
	local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, chunkId)

	if chunkCfg then
		local x, y = ElementSparkSceneController.instance:getBgTilePos(chunkCfg.pos[1], chunkCfg.pos[2])

		self:setPosFocus(x, y)
	else
		FloatWordMgr.instance:show("目标地块不存在")
	end
end

function ElementSparkCamera:_moveMyTeamToCenter()
	local myCampId = ElementSparkModel.instance:getMyCampId()

	if myCampId > 0 then
		local planId = ElementSparkController.instance:getMapPlanId()
		local chunkId = ElementSparkModel.instance:getMyCampChunkId()
		local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, chunkId)

		if chunkCfg then
			local x, y = ElementSparkSceneController.instance:getTilePos(chunkCfg.pos, chunkCfg.anotherPos)

			self:setPosFocus(x, y)
		else
			self:setPosFocusMovement(0, 0)
		end
	else
		self:setPosFocusMovement(0, 0)
	end
end

function ElementSparkCamera:_calCameraRange()
	local ltx, lty, lbx, lby, rtx, rty, rbx, rby = ElementSparkSceneController.instance:getVectexPos()

	self._cameraRanges = {
		lbx,
		rtx,
		rby,
		lty
	}
end

return ElementSparkCamera
