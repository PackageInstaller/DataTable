-- chunkname: @modules/logic/scene/room/comp/RoomSceneCameraComp.lua

module("modules.logic.scene.room.comp.RoomSceneCameraComp", package.seeall)

local RoomSceneCameraComp = class("RoomSceneCameraComp", BaseSceneComp)

function RoomSceneCameraComp:onInit()
	self.cameraGO = nil
	self.camera = nil
	self._moveDistance = 2
end

function RoomSceneCameraComp:_setCPMinMaxStr(state, minDic, maxDic, numstr)
	local nums = string.splitToNumber(numstr, "#")

	self:_setCPMinMax(state, minDic, maxDic, nums)
end

function RoomSceneCameraComp:_setCPMinMax(state, minDic, maxDic, nums)
	minDic[state] = nums[1]
	maxDic[state] = nums[2]
end

function RoomSceneCameraComp:_setFogMinMax(state, minDic, maxDic, param)
	local fogRangeXYZW = GameUtil.splitString2(param.fogRangeXYZW, true)
	local nearColorRGBA = GameUtil.splitString2(param.fogNearColorRGBA, true)
	local farColorRGBA = GameUtil.splitString2(param.fogFarColorRGBA, true)
	local fogParticles = string.splitToNumber(param.fogParticles, "#")
	local fogViewType = string.splitToNumber(param.fogViewType, "#")

	for i = 1, 2 do
		local dic = i == 1 and minDic or maxDic

		dic[state] = {
			maxParticles = fogParticles[i],
			centerY = fogRangeXYZW[i][1],
			height = fogRangeXYZW[i][2],
			fogRangeZ = fogRangeXYZW[i][3],
			fogRangeW = fogRangeXYZW[i][4],
			nearColorR = nearColorRGBA[i][1],
			nearColorG = nearColorRGBA[i][2],
			nearColorB = nearColorRGBA[i][3],
			nearColorA = nearColorRGBA[i][4],
			farColorR = farColorRGBA[i][1],
			farColorG = farColorRGBA[i][2],
			farColorB = farColorRGBA[i][3],
			farColorA = farColorRGBA[i][4],
			fogViewType = fogViewType[i]
		}
	end
end

function RoomSceneCameraComp:_initCameraParam()
	self._angleMin = {}
	self._angleMax = {}
	self._distanceMin = {}
	self._distanceMax = {}
	self._bendingAmountMin = {}
	self._bendingAmountMax = {}
	self._blurMin = {}
	self._blurMax = {}
	self._fogParamMin = {}
	self._fogParamMax = {}
	self._offsetHorizonMin = {}
	self._offsetHorizonMax = {}
	self._oceanFogMin = {}
	self._oceanFogMax = {}
	self._lightRangeMin = {}
	self._lightRangeMax = {}
	self._lightOffsetMin = {}
	self._lightOffsetMax = {}
	self._shadowOffsetMin = {}
	self._shadowOffsetMax = {}
	self._touchMoveSpeedMin = {}
	self._touchMoveSpeedMax = {}
	self._zoomInitValue = {}
	self._lightMinMin = {}
	self._lightMinMax = {}
	self._offsetHeightMap = {}
	self._camerClipPlaneMin = {}
	self._camerClipPlaneMax = {}
	self._isShadowHideMap = {}

	local gameMode = RoomModel.instance:getGameMode()

	for stateName, stateId in pairs(RoomEnum.CameraState) do
		local param = RoomConfig.instance:getCameraParamByStateId(stateId, gameMode)

		self._offsetHeightMap[stateId] = 0

		if param then
			self:_setCPMinMaxStr(stateId, self._angleMin, self._angleMax, param.angle)
			self:_setCPMinMaxStr(stateId, self._distanceMin, self._distanceMax, param.distance)
			self:_setCPMinMaxStr(stateId, self._bendingAmountMin, self._bendingAmountMax, param.bendingAmount)
			self:_setCPMinMaxStr(stateId, self._touchMoveSpeedMin, self._touchMoveSpeedMax, param.touchMoveSpeed)
			self:_setCPMinMaxStr(stateId, self._blurMin, self._blurMax, param.blur)
			self:_setCPMinMaxStr(stateId, self._offsetHorizonMin, self._offsetHorizonMax, param.offsetHorizon)
			self:_setCPMinMaxStr(stateId, self._oceanFogMin, self._oceanFogMax, param.oceanFog)
			self:_setCPMinMaxStr(stateId, self._lightMinMin, self._lightMinMax, param.lightMin)
			self:_setFogMinMax(stateId, self._fogParamMin, self._fogParamMax, param)
			self:_setCPMinMax(stateId, self._shadowOffsetMin, self._shadowOffsetMax, GameUtil.splitString2(param.shadowOffsetXYZW, true))
			self:_setCPMinMax(stateId, self._lightRangeMin, self._lightRangeMax, {
				0.5,
				0.5
			})
			self:_setCPMinMax(stateId, self._lightOffsetMin, self._lightOffsetMax, {
				0.5,
				0.5
			})
			self:_setCPMinMax(stateId, self._camerClipPlaneMin, self._camerClipPlaneMax, {
				0.01,
				100
			})

			self._zoomInitValue[stateId] = param.zoom * 0.001
			self._isShadowHideMap[stateId] = true
		else
			logError(string.format("小屋相机镜头配置缺失[RoomEnum.CameraState.%s]:【export_镜头参数】state:%s", stateName, stateId))
		end
	end

	for i, stateId in ipairs(RoomEnum.CameraOverlooks) do
		self._camerClipPlaneMin[stateId] = 0.3
		self._isShadowHideMap[stateId] = false
	end

	self._cameraSwitchAudioDict = {
		[RoomEnum.CameraState.Overlook] = {
			[RoomEnum.CameraState.Normal] = AudioEnum.Room.play_ui_home_lens_push,
			[RoomEnum.CameraState.Character] = AudioEnum.Room.play_ui_home_lens_push,
			[RoomEnum.CameraState.Manufacture] = AudioEnum.Room.play_ui_home_lens_push,
			[RoomEnum.CameraState.OverlookAll] = AudioEnum.Room.play_ui_home_lens_pull
		},
		[RoomEnum.CameraState.OverlookAll] = {
			[RoomEnum.CameraState.Normal] = AudioEnum.Room.play_ui_home_lens_push,
			[RoomEnum.CameraState.Character] = AudioEnum.Room.play_ui_home_lens_push,
			[RoomEnum.CameraState.Overlook] = AudioEnum.Room.play_ui_home_lens_push,
			[RoomEnum.CameraState.Manufacture] = AudioEnum.Room.play_ui_home_lens_push
		},
		[RoomEnum.CameraState.Normal] = {
			[RoomEnum.CameraState.Overlook] = AudioEnum.Room.play_ui_home_lens_pull,
			[RoomEnum.CameraState.OverlookAll] = AudioEnum.Room.play_ui_home_lens_pull
		},
		[RoomEnum.CameraState.Character] = {
			[RoomEnum.CameraState.Overlook] = AudioEnum.Room.play_ui_home_lens_pull
		},
		[RoomEnum.CameraState.Manufacture] = {
			[RoomEnum.CameraState.Overlook] = AudioEnum.Room.play_ui_home_lens_pull
		}
	}
	self._cameraStateInEditYDict = {
		[RoomEnum.CameraState.Normal] = 0.3,
		[RoomEnum.CameraState.Manufacture] = 0.3
	}

	local points = {}
	local mapMaxRadius = CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius)

	for i = 1, 6 do
		local hexPoint = HexPoint.directions[i] * mapMaxRadius

		table.insert(points, HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize))
	end

	self._editModeConvexHull = RoomCameraHelper.getConvexHull(points)
end

function RoomSceneCameraComp:setChangeCameraParamsById(stateId, cfgId)
	if RoomEnum.ChangeCameraParamDict[stateId] then
		local param = RoomConfig.instance:getCharacterBuildingInteractCameraConfig(cfgId)

		param = param or RoomConfig.instance:getCameraParamByStateId(stateId, RoomModel.instance:getGameMode())

		if param then
			self:_setCPMinMaxStr(stateId, self._angleMin, self._angleMax, param.angle)
			self:_setCPMinMaxStr(stateId, self._distanceMin, self._distanceMax, param.distance)

			if param.focusXYZ then
				local focusXYZ = string.splitToNumber(param.focusXYZ, "#")

				if param.focusXYZ then
					self._offsetHeightMap[stateId] = param.focusXYZ[2] or 0
				end
			end
		end
	end
end

function RoomSceneCameraComp:setCharacterbuildingInteractionById(cfgId)
	local stateId = RoomEnum.CameraState.InteractionCharacterBuilding

	self:setChangeCameraParamsById(stateId, cfgId)
end

function RoomSceneCameraComp:init(sceneId, levelId)
	TaskDispatcher.runRepeat(self._onUpdate, self, 0)
	self:_initCameraParam()
	self:_initCamera()

	self._scene = self:getCurScene()
	self._cameraParam = nil
	self._realCameraParam = nil
	self._tempRealCameraParam = nil
	self._offsetY = 0
	self.cameraGO = CameraMgr.instance:getMainCameraGO()
	self.cameraTrs = CameraMgr.instance:getMainCameraTrs()
	self.camera = CameraMgr.instance:getMainCamera()
	self.orthCameraGO = CameraMgr.instance:getOrthCameraGO()
	self.orthCamera = CameraMgr.instance:getOrthCamera()

	RenderPipelineSetting.SetCameraRenderingLayerMask(self.orthCamera, 128)
	PostProcessingMgr.setCameraLayer(self.orthCamera, "Scene", true)
	PostProcessingMgr.setCameraLayer(self.orthCamera, "SceneOpaque", true)
	PostProcessingMgr.setCameraLayer(self.orthCamera, "CullOnLowQuality", true)
	PostProcessingMgr.setCameraLayer(self.orthCamera, "CullByDistance", true)
	PostProcessingMgr.setCameraLayer(self.orthCamera, "SceneOrthogonal", false)
	PostProcessingMgr.setCameraLayer(self.orthCamera, "SceneOrthogonalOpaque", false)

	self.orthCameraTrs = self.orthCameraGO.transform
	self.orthCameraTrs.position = Vector3(0, 3.5, 0)
	self.orthCameraTrs.rotation = Quaternion.Euler(90, 0, 0)

	self:_setCanvasCamera()
	self:resetTransform()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function RoomSceneCameraComp:_initCamera()
	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
	transformhelper.setLocalRotation(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
end

function RoomSceneCameraComp:onSceneStart(sceneId, levelId)
	self:_onScreenResize(UnityEngine.Screen.width, UnityEngine.Screen.height)
end

function RoomSceneCameraComp:onSceneClose()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)

	if self._tweenOffsetYId then
		self._scene.tween:killById(self._tweenOffsetYId)

		self._tweenOffsetYId = nil
	end

	TaskDispatcher.cancelTask(self._onUpdate, self)
	TaskDispatcher.cancelTask(self._forceUpdataTransform, self)
	UIBlockMgr.instance:endBlock(UIBlockKey.RoomCameraTweening)

	if self._tweenId then
		self._scene.tween:killById(self._tweenId)

		self._tweenId = nil
	end

	transformhelper.setPos(self.cameraTrs, 0, 0, 0)
	transformhelper.setLocalRotation(self.cameraTrs, 0, 0, 0)
	RenderPipelineSetting.SetCameraRenderingLayerMask(self.orthCamera, 1)
	PostProcessingMgr.setCameraLayer(self.orthCamera, "Scene", false)
	PostProcessingMgr.setCameraLayer(self.orthCamera, "SceneOpaque", false)
	PostProcessingMgr.setCameraLayer(self.orthCamera, "CullOnLowQuality", false)
	PostProcessingMgr.setCameraLayer(self.orthCamera, "CullByDistance", false)
	PostProcessingMgr.setCameraLayer(self.orthCamera, "SceneOrthogonal", true)
	PostProcessingMgr.setCameraLayer(self.orthCamera, "SceneOrthogonalOpaque", true)

	self.orthCamera = nil
	self._cameraParam = nil
	self._realCameraParam = nil
	self._tempRealCameraParam = nil
	self.cameraGO = nil
	self.cameraTrs = nil
	self.camera = nil

	self:_hideOrthCamera()

	self.orthCameraGO = nil
	self.orthCameraTrs = nil

	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self._onScreenResize, self)
end

function RoomSceneCameraComp:move(deltaX, deltaY)
	self:moveTo(self._cameraParam.focusX + deltaX, self._cameraParam.focusY + deltaY)
end

function RoomSceneCameraComp:moveTo(x, y)
	local point = Vector2(x, y)
	local convexHull
	local offsetPosition = RoomCameraHelper.getOffsetPosition(Vector2(self._cameraParam.focusX, self._cameraParam.focusY), Vector2(x, y), RoomController.instance:isEditMode() and self._editModeConvexHull or RoomMapBlockModel.instance:getConvexHull())

	self._cameraParam.focusX = offsetPosition.x
	self._cameraParam.focusY = offsetPosition.y
	self._realCameraParam = self:cameraParamToRealCameraParam(self._cameraParam)

	self:updateTransform()
end

function RoomSceneCameraComp:zoom(deltaZoom)
	self:zoomTo(self._cameraParam.zoom + deltaZoom)
end

function RoomSceneCameraComp:zoomTo(zoom)
	self._cameraParam.zoom = Mathf.Clamp(zoom, 0, 1)
	self._realCameraParam = self:cameraParamToRealCameraParam(self._cameraParam)

	self:updateTransform()
end

function RoomSceneCameraComp:rotate(deltaRotate)
	self:rotateTo(self._cameraParam.rotate + deltaRotate)
end

function RoomSceneCameraComp:rotateTo(rotate)
	self._cameraParam.rotate = RoomRotateHelper.getMod(rotate, 2 * Mathf.PI)
	self._realCameraParam = self:cameraParamToRealCameraParam(self._cameraParam)

	self:updateTransform()
end

function RoomSceneCameraComp:getZoomInitValue(cameraState)
	return (self._zoomInitValue or nil) and (self._zoomInitValue[cameraState] or 0.5)
end

function RoomSceneCameraComp:resetTransform()
	self._cameraState = RoomEnum.CameraState.Overlook

	local isInFishing = FishingModel.instance:isInFishing()

	if isInFishing then
		self._cameraState = RoomEnum.CameraState.OverlookAll
	end

	self._cameraParam = {
		focusY = 0,
		focusX = 0,
		rotate = 0,
		zoom = self:getZoomInitValue(self._cameraState)
	}
	self._realCameraParam = self:cameraParamToRealCameraParam(self._cameraParam)
	self._savedCameraParam = LuaUtil.deepCopy(self._cameraParam)
	self._savedCameraState = self._cameraState
	self._isTweening = false

	UIBlockMgr.instance:endBlock(UIBlockKey.RoomCameraTweening)
	self:updateTransform()
	TaskDispatcher.runDelay(self._forceUpdataTransform, self, 0.0001)
	self:_updateCameraClipPlane()
end

function RoomSceneCameraComp:_forceUpdataTransform()
	self:updateTransform(true)
end

function RoomSceneCameraComp:cameraParamToRealCameraParam(cameraParam, cameraState)
	cameraState = cameraState or self._cameraState

	local pos = self:focusToPos(cameraParam.zoom, Vector2(cameraParam.focusX, cameraParam.focusY), cameraParam.rotate, cameraState, cameraParam.isPart)
	local offsetHeight = self:zoomToOffsetY(cameraParam.zoom, cameraState)

	return {
		zoom = cameraParam.zoom,
		bendingAmount = self:zoomToBendingAmount(cameraParam.zoom, cameraState),
		angle = self:zoomToAngle(cameraParam.zoom, cameraState),
		distance = self:zoomToDistance(cameraParam.zoom, cameraState),
		blur = self:zoomToBlur(cameraParam.zoom, cameraState),
		fogParam = self:zoomToFogParam(cameraParam.zoom, cameraState),
		offsetHorizon = self:zoomToOffsetHorizon(cameraParam.zoom, cameraState),
		oceanFog = self:zoomToOceanFog(cameraParam.zoom, cameraState),
		lightRange = self:zoomToLightRange(cameraParam.zoom, cameraState),
		lightOffset = self:zoomToLightOffset(cameraParam.zoom, cameraState),
		lightMin = self:zoomToLightMin(cameraParam.zoom, cameraState),
		shadowOffset = self:zoomToShadowOffset(cameraParam.zoom, cameraState),
		touchMoveSpeed = self:zoomToTouchMoveSpeed(cameraParam.zoom, cameraState),
		posX = pos.x,
		posY = pos.y,
		rotate = cameraParam.rotate,
		height = offsetHeight + self:zoomToHeight(cameraParam.zoom, Vector2(cameraParam.focusX, cameraParam.focusY), cameraState, cameraParam.isPart)
	}
end

function RoomSceneCameraComp:updateTransform(forceUpdate)
	local dirty = forceUpdate

	if not self._tempRealCameraParam then
		dirty = true
	else
		for k, v in pairs(self._realCameraParam) do
			if type(v) == "table" then
				for k2, v2 in pairs(v) do
					if v2 ~= self._tempRealCameraParam[k][k2] then
						dirty = true

						break
					end
				end
			elseif v ~= self._tempRealCameraParam[k] then
				dirty = true
			end

			if dirty then
				break
			end
		end
	end

	if not dirty then
		return
	end

	self._tempRealCameraParam = LuaUtil.deepCopy(self._realCameraParam)
	RoomController.instance.touchMoveSpeed = self._realCameraParam.touchMoveSpeed

	self._scene.bending:setBendingAmount(self._realCameraParam.bendingAmount)
	self._scene.bending:setBendingPosition(Vector3(self._realCameraParam.posX, 0, self._realCameraParam.posY))
	self._scene.fog:setFogParam(self._realCameraParam.fogParam)
	self._scene.bending:setSkylineOffset(self._realCameraParam.offsetHorizon)
	self._scene.ocean:setOceanFog(self._realCameraParam.oceanFog)
	self._scene.light:setLightMin(self._realCameraParam.lightMin)
	self._scene.light:setLightRange(self._realCameraParam.lightRange)
	self._scene.light:setLightOffset(self._realCameraParam.lightOffset)

	local shadowOffset = self._realCameraParam.shadowOffset

	self._scene.character:setShadowOffset(Vector4(shadowOffset[1], shadowOffset[2], shadowOffset[3], shadowOffset[4]))

	local length = self._realCameraParam.distance * Mathf.Cos(self._realCameraParam.angle)
	local posY = self._realCameraParam.distance * Mathf.Sin(self._realCameraParam.angle) + self._realCameraParam.height
	local posX = -Mathf.Sin(self._realCameraParam.rotate) * length + self._realCameraParam.posX
	local posZ = -Mathf.Cos(self._realCameraParam.rotate) * length + self._realCameraParam.posY
	local offsetY = posY + self._offsetY + self._scene.cameraFollow:getCameraOffsetY()

	offsetY = math.max(0.11, offsetY)
	self._position = Vector3(posX, offsetY, posZ)

	local rotationX = Mathf.Rad2Deg * self._realCameraParam.angle
	local rotationY = Mathf.Rad2Deg * self._realCameraParam.rotate

	self._rotation = Quaternion.Euler(rotationX, rotationY, 0)
	self._orthRotation = Quaternion.Euler(90, rotationY, 0)
	self._inventoryRotation = Quaternion.Euler(0, rotationY, 0)

	transformhelper.setPos(self.cameraTrs, self._position.x, self._position.y, self._position.z)
	transformhelper.setRotation(self.cameraTrs, self._rotation.x, self._rotation.y, self._rotation.z, self._rotation.w)
	transformhelper.setPos(self._scene.go.virtualCameraTrs, self._position.x, self._position.y, self._position.z)
	self:_setPosXZ(self._scene.go.virtualCameraXZTrs, posX, posZ)
	transformhelper.setRotation(self._scene.go.virtualCameraTrs, self._rotation.x, self._rotation.y, self._rotation.z, self._rotation.w)
	transformhelper.setRotation(self.orthCameraTrs, self._orthRotation.x, self._orthRotation.y, self._orthRotation.z, self._orthRotation.w)
	transformhelper.setRotation(self._scene.go.inventoryRootTrs, self._inventoryRotation.x, self._inventoryRotation.y, self._inventoryRotation.z, self._inventoryRotation.w)
	self:_setPosXZ(self._scene.go.inventoryRootTrs, posX, posZ)
	self:_setPosXZ(self.orthCameraTrs, posX, posZ)
	RoomMapController.instance:dispatchEvent(RoomEvent.CameraTransformUpdate)
	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateBlur, self._realCameraParam.blur)
	self:_cameraUpdateMask()

	if self._scene.graphics ~= nil then
		if self._isShadowHideMap[self._cameraState] or self._realCameraParam.distance < 2.7 then
			self._scene.graphics:setupShadowParam(false, self._realCameraParam.distance)
		else
			self._scene.graphics:setupShadowParam(true, self._realCameraParam.distance)
		end
	end

	if SLFramework.FrameworkSettings.IsEditor then
		-- block empty
	end
end

function RoomSceneCameraComp:_cameraUpdateMask()
	self._isCameraUpdateMask = true
	self._cameraUpdateMaskFrame = 0
end

function RoomSceneCameraComp:_onUpdate()
	if self._isCameraUpdateMask then
		if self._cameraUpdateMaskFrame < 1 then
			self._cameraUpdateMaskFrame = self._cameraUpdateMaskFrame + 1
		else
			self._isCameraUpdateMask = false

			RoomMapController.instance:dispatchEvent(RoomEvent.CameraUpdateFinish)
		end
	end
end

function RoomSceneCameraComp:_setPosXZ(trans, posX, posZ)
	local _, transY, _ = transformhelper.getPos(trans)

	transformhelper.setPos(trans, posX, transY, posZ)
end

function RoomSceneCameraComp:focusToPos(zoom, cameraFocus, cameraRotate, cameraState, isPart)
	local offset = Vector2.zero

	if cameraState == RoomEnum.CameraState.Normal and not isPart then
		local offsetY = (1 - zoom) * 0.90432 + zoom * 1.204425
		local originalOffset = Vector2(0, offsetY)

		offset.x = originalOffset.x * Mathf.Cos(cameraRotate) + originalOffset.y * Mathf.Sin(cameraRotate)
		offset.y = originalOffset.y * Mathf.Cos(cameraRotate) - originalOffset.x * Mathf.Sin(cameraRotate)
	end

	return cameraFocus + offset
end

function RoomSceneCameraComp:zoomToTouchMoveSpeed(zoom, cameraState)
	return (1 - zoom) * self._touchMoveSpeedMin[cameraState] + zoom * self._touchMoveSpeedMax[cameraState]
end

function RoomSceneCameraComp:zoomToOffsetY(zoom, cameraState)
	return self._offsetHeightMap[cameraState] or 0
end

function RoomSceneCameraComp:zoomToAngle(zoom, cameraState)
	local angle = (1 - zoom) * self._angleMin[cameraState] + zoom * self._angleMax[cameraState]

	return angle * Mathf.Deg2Rad
end

function RoomSceneCameraComp:zoomToBendingAmount(zoom, cameraState)
	return (1 - zoom) * self._bendingAmountMin[cameraState] + zoom * self._bendingAmountMax[cameraState]
end

function RoomSceneCameraComp:zoomToDistance(zoom, cameraState)
	return (1 - zoom) * self._distanceMin[cameraState] + zoom * self._distanceMax[cameraState]
end

function RoomSceneCameraComp:zoomToBlur(zoom, cameraState)
	return (1 - zoom) * self._blurMin[cameraState] + zoom * self._blurMax[cameraState]
end

function RoomSceneCameraComp:zoomToFogParam(zoom, cameraState)
	local fogParam = {}

	for k, v in pairs(self._fogParamMin[cameraState]) do
		fogParam[k] = (1 - zoom) * v + zoom * self._fogParamMax[cameraState][k]
	end

	return fogParam
end

function RoomSceneCameraComp:zoomToOffsetHorizon(zoom, cameraState)
	return (1 - zoom) * self._offsetHorizonMin[cameraState] + zoom * self._offsetHorizonMax[cameraState]
end

function RoomSceneCameraComp:zoomToOceanFog(zoom, cameraState)
	return (1 - zoom) * self._oceanFogMin[cameraState] + zoom * self._oceanFogMax[cameraState]
end

function RoomSceneCameraComp:zoomToHeight(zoom, cameraFocus, cameraState, isPart)
	if cameraState ~= RoomEnum.CameraState.Normal or isPart then
		return 0
	end

	return RoomCharacterHelper.getLandHeightByRaycast(Vector3(cameraFocus.x, 0, cameraFocus.y)) - RoomCharacterEnum.CharacterHeightOffset
end

function RoomSceneCameraComp:zoomToLightRange(zoom, cameraState)
	return (1 - zoom) * self._lightRangeMin[cameraState] + zoom * self._lightRangeMax[cameraState]
end

function RoomSceneCameraComp:zoomToLightOffset(zoom, cameraState)
	return (1 - zoom) * self._lightOffsetMin[cameraState] + zoom * self._lightOffsetMax[cameraState]
end

function RoomSceneCameraComp:zoomToLightMin(zoom, cameraState)
	return (1 - zoom) * self._lightMinMin[cameraState] + zoom * self._lightMinMax[cameraState]
end

function RoomSceneCameraComp:zoomToShadowOffset(zoom, cameraState)
	local shadowOffset = {}

	for k, v in pairs(self._shadowOffsetMin[cameraState]) do
		shadowOffset[k] = (1 - zoom) * v + zoom * self._shadowOffsetMax[cameraState][k]
	end

	return shadowOffset
end

function RoomSceneCameraComp:switchCameraState(cameraState, cameraParam, frameCallback, finishCallback, callbackObj)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	self:_switchCameraStatePre(cameraState)

	if cameraParam then
		self:tweenCamera(cameraParam, frameCallback, finishCallback, callbackObj)
	end

	self:_switchCameraStateAft(cameraState)
end

function RoomSceneCameraComp:switchCameraStateWithRealCameraParam(cameraState, realCameraParam, frameCallback, finishCallback, callbackObj)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	self:_switchCameraStatePre(cameraState)

	if realCameraParam then
		self:tweenRealCamera(realCameraParam, frameCallback, finishCallback, callbackObj)
	end

	self:_switchCameraStateAft(cameraState)
end

function RoomSceneCameraComp:_switchCameraStatePre(cameraState)
	if self._cameraState ~= RoomEnum.CameraState.Normal and self._cameraState ~= RoomEnum.CameraState.Character and (cameraState == RoomEnum.CameraState.Normal or cameraState == RoomEnum.CameraState.Character) then
		RoomCharacterController.instance:correctAllCharacterHeight()
	end

	if self._cameraSwitchAudioDict[self._cameraState] then
		local audioId = self._cameraSwitchAudioDict[self._cameraState][cameraState]

		if audioId then
			AudioMgr.instance:trigger(audioId)
		end

		if self._cameraState == RoomEnum.CameraState.Normal or self._cameraState == RoomEnum.CameraState.Overlook then
			self._savedCameraParam = LuaUtil.deepCopy(self._cameraParam)
			self._savedCameraState = self._cameraState
		end

		if self._cameraState ~= cameraState then
			self._cameraState = cameraState

			self:_updateCameraClipPlane()
			RoomMapController.instance:dispatchEvent(RoomEvent.CameraStateUpdate)
		end
	end
end

function RoomSceneCameraComp:_switchCameraStateAft(cameraState)
	if self._cameraState == RoomEnum.CameraState.Normal then
		RoomBuildingController.instance:setBuildingListShow(false)
		RoomCharacterController.instance:setCharacterListShow(false)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshUIShow)
	RoomCharacterController.instance:dispatchEvent(RoomEvent.RefreshSpineShow)
end

function RoomSceneCameraComp:tweenCamera(cameraParam, frameCallback, finishCallback, callbackObj, immediate)
	for key, value in pairs(cameraParam) do
		self._cameraParam[key] = value
	end

	local realCameraParam = self:cameraParamToRealCameraParam(self._cameraParam)

	self:tweenRealCamera(realCameraParam, frameCallback, finishCallback, callbackObj, immediate)
end

function RoomSceneCameraComp:tweenRealCamera(realCameraParam, frameCallback, finishCallback, callbackObj, immediate)
	if self._tweenId then
		self._scene.tween:killById(self._tweenId)

		self._tweenId = nil
	end

	local tweenRealCameraParam = {}

	tweenRealCameraParam.srcParam = LuaUtil.deepCopy(self._realCameraParam)
	tweenRealCameraParam.dstParam = realCameraParam
	tweenRealCameraParam.frameCallback = frameCallback
	tweenRealCameraParam.finishCallback = finishCallback
	tweenRealCameraParam.callbackObj = callbackObj

	local time = 0

	if tweenRealCameraParam.dstParam.bendingAmount then
		local subTime = Mathf.Abs(tweenRealCameraParam.dstParam.bendingAmount - tweenRealCameraParam.srcParam.bendingAmount)

		time = Mathf.Max(subTime, time)
	end

	if tweenRealCameraParam.dstParam.angle then
		local subTime = Mathf.Abs(tweenRealCameraParam.dstParam.angle - tweenRealCameraParam.srcParam.angle)

		time = Mathf.Max(subTime, time)
	end

	if tweenRealCameraParam.dstParam.distance then
		local subTime = Mathf.Abs(tweenRealCameraParam.dstParam.distance - tweenRealCameraParam.srcParam.distance)

		time = Mathf.Max(subTime, time)
	end

	if tweenRealCameraParam.dstParam.posX then
		local subTime = Mathf.Abs(tweenRealCameraParam.dstParam.posX - tweenRealCameraParam.srcParam.posX) / 2.5

		time = Mathf.Max(subTime, time)
	end

	if tweenRealCameraParam.dstParam.posY then
		local subTime = Mathf.Abs(tweenRealCameraParam.dstParam.posY - tweenRealCameraParam.srcParam.posY) / 2.5

		time = Mathf.Max(subTime, time)
	end

	if tweenRealCameraParam.dstParam.rotate then
		local rotateA = RoomRotateHelper.getMod(tweenRealCameraParam.dstParam.rotate, Mathf.PI * 2)
		local rotateB = RoomRotateHelper.getMod(tweenRealCameraParam.srcParam.rotate, Mathf.PI * 2)
		local diffRotate = Mathf.Abs(rotateA - rotateB)

		if diffRotate > Mathf.PI then
			diffRotate = 2 * Mathf.PI - diffRotate
		end

		local subTime = diffRotate / 2

		time = Mathf.Max(subTime, time)
	end

	if tweenRealCameraParam.dstParam.blur then
		local subTime = Mathf.Abs(tweenRealCameraParam.dstParam.blur - tweenRealCameraParam.srcParam.blur) / 1

		time = Mathf.Max(subTime, time)
	end

	if tweenRealCameraParam.dstParam.height then
		local subTime = Mathf.Abs(tweenRealCameraParam.dstParam.height - tweenRealCameraParam.srcParam.height) / 2.5

		time = Mathf.Max(subTime, time)
	end

	if time > 0 then
		if immediate then
			self:_tweenCameraFinish(tweenRealCameraParam)
		else
			time = Mathf.Clamp(time, 0.8, 1)
			self._isTweening = true

			UIBlockMgr.instance:startBlock(UIBlockKey.RoomCameraTweening)

			self._tweenId = self._scene.tween:tweenFloat(0, 1, time, self._tweenCameraFrame, self._tweenCameraFinish, self, tweenRealCameraParam, EaseType.InOutQuart)
		end
	elseif tweenRealCameraParam.finishCallback then
		tweenRealCameraParam.finishCallback(tweenRealCameraParam.callbackObj)
	end
end

function RoomSceneCameraComp:_tweenCameraFrame(lerp, param)
	for key, value in pairs(param.dstParam) do
		if type(value) == "table" then
			for key2, value2 in pairs(value) do
				self._realCameraParam[key][key2] = (1 - lerp) * param.srcParam[key][key2] + lerp * value2
			end
		else
			self._realCameraParam[key] = key == "rotate" and RoomRotateHelper.simpleRotate(lerp, param.srcParam[key], value) or (1 - lerp) * param.srcParam[key] + lerp * value
		end
	end

	if param.dstParam.rotate then
		self._realCameraParam.rotate = RoomRotateHelper.simpleRotate(lerp, param.srcParam.rotate, param.dstParam.rotate)
	end

	self:updateTransform()

	if param.frameCallback then
		if param.callbackObj then
			param.frameCallback(param.callbackObj, lerp)
		else
			param.frameCallback(lerp)
		end
	end
end

function RoomSceneCameraComp:_tweenCameraFinish(param)
	for key, value in pairs(param.dstParam) do
		self._realCameraParam[key] = value
	end

	self:updateTransform()

	self._isTweening = false

	UIBlockMgr.instance:endBlock(UIBlockKey.RoomCameraTweening)

	if param.finishCallback then
		if param.callbackObj then
			param.finishCallback(param.callbackObj)
		else
			param.finishCallback()
		end
	end
end

function RoomSceneCameraComp:getCameraPosition()
	return self._position
end

function RoomSceneCameraComp:getCameraRotation()
	return self._rotation
end

function RoomSceneCameraComp:getCameraFocus()
	if self._cameraParam then
		return Vector2(self._cameraParam.focusX, self._cameraParam.focusY)
	end

	return Vector2(0, 0)
end

function RoomSceneCameraComp:getCameraRotate()
	return (self._cameraParam or nil) and (self._cameraParam.rotate or 0)
end

function RoomSceneCameraComp:getCameraZoom()
	return (self._cameraParam or nil) and (self._cameraParam.zoom or 0.5)
end

function RoomSceneCameraComp:getCameraParam()
	return self._cameraParam
end

function RoomSceneCameraComp:getRealCameraParam()
	return self._realCameraParam
end

function RoomSceneCameraComp:getSavedCameraParam()
	return self._savedCameraParam
end

function RoomSceneCameraComp:getSavedCameraState()
	return self._savedCameraState
end

function RoomSceneCameraComp:getCameraState()
	return self._cameraState
end

function RoomSceneCameraComp:isTweening()
	return self._isTweening
end

function RoomSceneCameraComp:_setCanvasCamera()
	local canvasGO = self._scene.go.canvasGO
	local canvas = canvasGO:GetComponent(typeof(UnityEngine.Canvas))

	canvas.worldCamera = CameraMgr.instance:getUnitCamera()
end

local ReferenceFov = 60
local ReferenceResolution = 1.7777777777777777

function RoomSceneCameraComp:_onScreenResize(width, height)
	local virtualCameraList = CameraMgr.instance:getVirtualCameras()
	local screenResolution = width / height
	local fovMultiple = ReferenceResolution / screenResolution
	local fov = ReferenceFov * fovMultiple

	fov = Mathf.Clamp(fov, 60, 120)

	local mainCamera = CameraMgr.instance:getMainCamera()

	mainCamera.fieldOfView = fov

	local unitCamera = CameraMgr.instance:getUnitCamera()

	unitCamera.fieldOfView = fov
end

function RoomSceneCameraComp:playCameraAnim(animName)
	if animName == "idle" then
		self:tweenOffsetY(0)
	elseif animName == "in_show" then
		self:tweenOffsetY(0, 0.3, 2)
	elseif animName == "in_edit" then
		self:tweenOffsetY(0, self._cameraStateInEditYDict[self._cameraState] or -0.3, 2)
	elseif animName == "out_show" then
		self:tweenOffsetY(0.3, 0, 2)
	elseif animName == "out_edit" then
		self:tweenOffsetY(-0.3, 0, 2)
	end
end

function RoomSceneCameraComp:tweenOffsetY(from, to, duration)
	if self._tweenOffsetYId then
		self._scene.tween:killById(self._tweenOffsetYId)

		self._tweenOffsetYId = nil
	end

	self._offsetY = from

	self:updateTransform(true)

	if not to or from == to then
		return
	end

	self._tweenOffsetYId = self._scene.tween:tweenFloat(from, to, duration, self._tweenOffsetYFrame, self._tweenOffsetYFinish, self, {
		from = from,
		to = to
	}, EaseType.OutQuad)
end

function RoomSceneCameraComp:_tweenOffsetYFrame(value, param)
	self._offsetY = value

	self:updateTransform(true)
end

function RoomSceneCameraComp:_tweenOffsetYFinish(param)
	self._offsetY = param.to

	self:updateTransform(true)
end

function RoomSceneCameraComp:_updateCameraClipPlane()
	if self._camerClipPlaneMin[self._cameraState] and self.camera then
		self.camera.nearClipPlane = self._camerClipPlaneMin[self._cameraState]
		self.camera.farClipPlane = self._camerClipPlaneMax[self._cameraState]
	end
end

function RoomSceneCameraComp:refreshOrthCamera()
	gohelper.setActive(self.orthCameraGO, true)
	TaskDispatcher.cancelTask(self._hideOrthCamera, self)
	TaskDispatcher.runDelay(self._hideOrthCamera, self, 0.01)
end

function RoomSceneCameraComp:_hideOrthCamera()
	TaskDispatcher.cancelTask(self._hideOrthCamera, self)
	gohelper.setActive(self.orthCameraGO, false)
end

return RoomSceneCameraComp
