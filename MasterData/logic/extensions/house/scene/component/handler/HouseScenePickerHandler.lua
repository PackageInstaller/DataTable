-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/component/handler/HouseScenePickerHandler.lua

module("logic.extensions.house.scene.component.handler.HouseScenePickerHandler", package.seeall)

local M = class("HouseScenePickerHandler", SceneComponentBase)
local AnimationState = HouseEnum.AnimationState
local PlayerStatus = HouseEnum.PlayerStatus
local PerformCtrlType = HouseEnum.PerformCtrlType
local BehaviorStatus = HouseEnum.BehaviorStatus
local HouseFeatureKey = "feature_key_of_house"
local minPosZ = -480
local maxPosZ = -30
local vec3Temp = Vector3.New()

M.RotateType = {
	Left = 1,
	Right = 2
}

function M:onInit()
	self._singleDragingId = -999
	self._isMultiDraging = false
	self._singleDragPos = Vector3.New()
	self._beginDragPos = Vector3.New()
	self._unitDragPos = Vector3.New()
	self._ringType = 0
	self._camRadius = nil
	self._camContrastAngle = nil
	self._curScreenScale = nil
	self._multiTouchChecker = nil
	self._dragingUnit = false
	self._dragData = {}
	self._tmpGoHitLst = {}
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	self._mainCameraTarget = CameraTargetMgr.instance:getMainCameraTarget()
	self._houseCameraUnit = VirtualCameraMgr.instance:getActiveCamera()

	if self._houseCameraUnit:getMainGO() then
		self:_initCamera()
	else
		self._houseCameraUnit:setLoadedCallback(self._initCamera, self)
	end

	self:_setEvent(true)
end

function M:_initCamera()
	self._houseCameraUnit:setFieldOfView(HouseSceneUtil.getCamFOV())
	self._houseCameraUnit:setLoadedCallback(nil, nil)

	local relativeComponent = self._houseCameraUnit._relativeComponent

	relativeComponent.enabled = false

	local roomId = HouseModel.instance:getOnceEnterRoomId()

	self:showByRoomId(roomId)
end

function M:onExitScene()
	self:_setEvent(false)

	self._houseCameraUnit = nil
	self._mainCameraTarget = nil
	self._singleDragingId = -999
	self._isMultiDraging = false
	self._ringType = 0
	self._camRadius = nil
	self._camContrastAngle = nil
	self._curScreenScale = nil

	self:setMultiTouchChecker(false)

	self._dragingUnit = false

	table.clear(self._dragData)
	self:_forceStopLerpCam()
end

function M:setMultiTouchChecker(multiTouchChecker)
	self._multiTouchChecker = multiTouchChecker
end

function M:getRingType()
	return self._ringType
end

function M:showByRoomId(roomId)
	local angle = HouseModel.instance:getLastHouseCamContrastAngle()

	if roomId then
		local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)

		angle = roomCO.angle
		self._ringType = NavMeshUtil.getRingTypeByZoneId(roomId)
	else
		roomId = HouseModel.instance:getDefaultRoomId()
		self._ringType = HouseModel.instance:getLastRingType()
	end

	if not angle then
		local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, roomId)

		angle = roomCO.angle
	end

	self:_setCameraAngle(angle)
	self:initCameraByRingType(HouseModel.instance:getScaleNormal())
end

function M:initCameraByRingType(scale)
	self._curScreenScale = scale
	self._camContrastAngle = self:_getCameraAngle()

	local minRadius, maxRadius = self:_getRingRadiusRange()

	self._camRadius = (minRadius + maxRadius) / 2

	self:_changeRingPosZByScale(scale, true)
	self:_changeCameraPosByAngle(self._camContrastAngle, self._camRadius)
	self:_dispatchCamRefresh()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHit, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDrag, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDrag, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDrag, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_MULTI_DRAG, self._onMultiDrag, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_LONGPRESS, self._onLongPress, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_LONGPRESS_EXIT, self._onLongPressExit, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_SCENE_SCALE_RING_POSZ, self._onScaleRingPosZ, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_SCENE_CHANGE_RING_TYPE, self._onChangeRingType, self)

		self._timerEndUnitHello = SchedulerCtrl.New(self._onFinishUnitHello, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHit, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDrag, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDrag, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDrag, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_MULTI_DRAG, self._onMultiDrag, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_LONGPRESS, self._onLongPress, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_LONGPRESS_EXIT, self._onLongPressExit, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_SCENE_SCALE_RING_POSZ, self._onScaleRingPosZ, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_SCENE_CHANGE_RING_TYPE, self._onChangeRingType, self)
		self._timerEndUnitHello:clear()
	end
end

function M:_dispatchCamRefresh()
	HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_CAMERA_REFRESH, self._ringType, self._camContrastAngle)
end

function M:_onSceneHit(e, isHit, hitGO, hitPoint, clickCount)
	if hitGO then
		table.clear(self._tmpGoHitLst)

		local scenePickerView = ScenePickerViewFacade.instance:getScenePickerView()

		if scenePickerView then
			local raycastProxy = scenePickerView:getRaycastProxy()

			for i = 0, raycastProxy:GetHitCount() - 1 do
				local go = raycastProxy:GetHitGameObject(i)

				if go then
					table.insert(self._tmpGoHitLst, go)
				end
			end
		end

		if HouseMainStateModel.instance:getState() == HouseMainEnum.State.ExploreMode then
			if hitGO.layer == SceneLayer.Unit_Value then
				local go = GoUtil.FindFirstTaggedParent(hitGO)
				local arr = string.split(go.name, "_")
				local arrLength = #arr

				if arrLength > 1 and arr[1] == "liftdoor" then
					local parent = hitGO.transform.parent
					local parentName = parent.gameObject.name
					local parentArr = string.split(parentName, "_")
					local elevatorId = parentArr[#parentArr]

					if arr[2] == "entertrigger" then
						HouseDispatcher:dispatchEvent(HouseEventType.ELEAVTOR_MAINPLAYER_ENTER, tonumber(elevatorId), true)
					elseif arr[2] == "button" then
						HouseDispatcher:dispatchEvent(HouseEventType.ELEAVTOR_MAINPLAYER_BUTTON, tonumber(elevatorId), tonumber(arr[arrLength]))
					end
				end
			end

			self:_dealHitMulti(self._tmpGoHitLst, self._dealHitUnitPlayer, self)
		elseif not HouseFacade.instance:isEditingFurniture() then
			self:_endDragUnit(self._unitDragPos, true)

			if not (#self._tmpGoHitLst > 0) or self:_dealHitMulti(self._tmpGoHitLst, self._dealHitUnitPlayer, self) then
				-- block empty
			elseif self:_dealHitMulti(self._tmpGoHitLst, self._dealHitFurniture, self) then
				-- block empty
			elseif self:_dealHitMulti(self._tmpGoHitLst, self._dealHitRoomToFocus, self) then
				-- block empty
			end
		end
	end

	self:_forceStopLerpCam()
end

function M:_dealHitMulti(goLst, func, handler)
	local canExcute = false

	for _, hitGO in ipairs(goLst or {}) do
		canExcute = canExcute or func(handler, hitGO)
	end

	return canExcute
end

function M:_dealHitUnitPlayer(hitGO)
	local canExcute = false

	if not self._dragingUnit then
		local hitParent = hitGO.transform.parent.parent

		if hitParent then
			local heroUnit = Astral.LuaComponentContainer.Get(hitParent.gameObject, UnitPlayer)

			if heroUnit then
				local zoneId = heroUnit.navMesh:getCurZoneId()

				if zoneId < 2000 then
					local openTyp = HouseMainRoomModel.instance:getRoomOpenTyp(zoneId)

					if openTyp == HouseMainEnum.RoomOpenTyp.OpenActive or openTyp == HouseMainEnum.RoomOpenTyp.OpenUnActive then
						canExcute = true

						self:_onClickHero(heroUnit)
					end
				else
					canExcute = true

					self:_onClickHero(heroUnit)
				end
			end
		end
	end

	return canExcute
end

function M:_dealHitFurniture(hitGO)
	local canExcute = false

	if HouseMainStateModel.instance:getState() == HouseMainEnum.State.FocusRoom then
		local hitParent = hitGO.transform.parent

		if hitParent then
			local furnitureUnit = Astral.LuaComponentContainer.Get(hitParent.gameObject, HouseFurnitureUnit)

			if furnitureUnit then
				canExcute = true

				local _id = furnitureUnit.model:getFurnitureId()

				ToolTipsMgr.showHouseFurnitureSimpleInfoTips(_id)
			end
		end
	end

	return canExcute
end

function M:_dealHitRoomToFocus(hitGO)
	return HouseFocusController.instance:dealHitRoomToFocus(hitGO)
end

function M:_onBeginDrag(e, position, pointerId)
	if self:getMultiDragValid() or self._singleDragingId >= 0 then
		return
	end

	self._beginDragStartTime = os.clock()
	self._singleDragingId = pointerId

	self._singleDragPos:Set(position:Get())
	self._beginDragPos:Set(position:Get())
	self._unitDragPos:Set(position:Get())
	self:_findDragUnit(position)
end

function M:_onDrag(e, position, pointerId)
	if self._singleDragingId == pointerId then
		if position.x < 0 or position.x > UnityEngine.Screen.width or position.y < 0 or position.y > UnityEngine.Screen.height then
			self:_onEndDrag(e, position, pointerId)

			return
		end

		if self:getDragingUnit() then
			self._unitDragPos:Set(position:Get())
			self:_onDragUnit(position)

			return
		end

		if self:getMultiDragValid() then
			return
		end

		if HouseMainStateModel.instance:getState() == HouseMainEnum.State.Normal then
			self:_forceStopLerpCam()

			local offsetX = self._singleDragPos.x - position.x
			local offsetY = self._singleDragPos.y - position.y

			offsetX = offsetX * self:_getDragSpeed()
			offsetY = offsetY * self:_getDragSpeed()

			self:_rotateCamByScreenOffset(offsetX, offsetY)
		end

		self._singleDragPos:Set(position:Get())
	end
end

function M:_onEndDrag(e, position, pointerId)
	if self._singleDragingId == pointerId then
		self._singleDragingId = -999

		self:_endDragUnit(position)
	end

	if not self._isMultiDraging and HouseMainStateModel.instance:getState() == HouseMainEnum.State.Normal then
		local offsetTime = os.clock() - self._beginDragStartTime
		local offsetX = self._beginDragPos.x - position.x

		if math.abs(offsetX) > ViewMgr.instance:getUIWidth() * 0.15 and offsetTime < 0.35 then
			offsetX = offsetX * self:_getDragSpeed()

			self:_lerpCamByScreenOffset(offsetX, 0)
		end
	end

	self._isMultiDraging = false
end

function M:_onMultiDrag(e, centerX, centerY, scale, distance, isFirstMultiDrag)
	if self:getDragingUnit() then
		return
	end

	self._isMultiDraging = true
	self._singleDragingId = -999

	if HouseMainStateModel.instance:getState() == HouseMainEnum.State.Normal then
		local deltaScale = (scale - 1) * 1
		local targetScale = self._curScreenScale + deltaScale

		self:_changeRingPosZByScale(targetScale, true)
	end
end

function M:_onLongPress(e, isOn, position)
	if isOn and not self:getMultiDragValid() then
		self._unitDragPos:Set(position:Get())
		self:_findDragUnit(position)
	end
end

function M:_onLongPressExit(e)
	local unit = self:getDragingUnit()

	if unit then
		self:_endDragUnit(self._unitDragPos)
	end
end

function M:getMultiDragValid()
	if self._multiTouchChecker then
		return self._multiTouchChecker.IsValid
	end

	return self._isMultiDraging
end

function M:_onScaleRingPosZ(e, scale)
	self:_changeRingPosZByScale(scale)
end

function M:_onChangeRingType(e, ringType)
	if ringType > 0 and ringType ~= self._ringType then
		self:_forceStopLerpCam()

		self._ringType = ringType

		self:initCameraByRingType(0)
	end
end

function M:_onClickHero(heroUnit)
	local state = HouseMainStateModel.instance:getState()

	if not self._dragingUnit then
		heroUnit.progressBar:showMood()
		HouseFacade.instance:openHeroTipsView(heroUnit)
	end

	self:_showDragUnitHello(heroUnit)
end

function M:_rotateCamByScreenOffset(screenOffsetX, screenOffsetY)
	local deltaAngle = screenOffsetX * (HouseMainEnum.RingAnglePerUnitFactor[self._ringType] or 0.8)
	local camAngle = self:_getCameraAngle()

	camAngle = camAngle + deltaAngle
	self._camContrastAngle = camAngle

	local minRadius, maxRadius = self:_getRingRadiusRange()
	local deltaRadius = screenOffsetY * 0.8

	self._camRadius = self._camRadius - deltaRadius
	self._camRadius = math.max(minRadius, math.min(maxRadius, self._camRadius))

	self:_changeCameraPosByAngle(self._camContrastAngle, self._camRadius)
	self:_setCameraAngle(camAngle)
	self:_dispatchCamRefresh()
end

function M:_lerpCamByScreenOffset(screenOffsetX, screenOffsetY)
	local offsetX = math.abs(screenOffsetX)

	if offsetX <= 0.8 then
		self._camLerpPattern = 1
	elseif offsetX <= 2.6 then
		self._camLerpPattern = 3.2
	else
		self._camLerpPattern = 3.7
	end

	local duration = 2
	local deltaAngle = screenOffsetX * (HouseMainEnum.RingAnglePerUnitFactor[self._ringType] or 0.8) * self._camLerpPattern
	local camAngle = self:_getCameraAngle()
	local ease

	if self._isLerping then
		self._targetAngle, ease = self:_duelLerpEndAngle(self._targetAngle, self._targetAngle + deltaAngle)
		self._lerpCamTweener = self._lerpCamTweener:ChangeEndValue(self._targetAngle, -1, true):SetEase(ease):SetAutoKill(true):OnComplete(self._lerpCamFinish, self)
	else
		self._isLerping = true
		self._targetAngle, ease = self:_duelLerpEndAngle(camAngle, camAngle + deltaAngle)
		self._lerpCamTweener = TweenNumberUtils.FloatTo(self:_getCameraAngle(), self._targetAngle, duration, self._lerpCamUpdateCB, self):SetEase(ease):SetAutoKill(true):OnComplete(self._lerpCamFinish, self)
	end
end

function M:_duelLerpEndAngle(orgAngle, targetAngle)
	local ease = DG.Tweening.Ease.OutBack
	local isRight = orgAngle < targetAngle
	local orgCopy = self:_fixAngle(orgAngle)
	local predictAngle = self:_fixAngle(targetAngle)
	local angleLst = HouseMainRoomModel.instance:getRoomAngleLst(self._ringType)
	local minAngle = 100
	local stopAngle

	for roomId, cfgAngle in pairs(angleLst or {}) do
		if math.abs(orgCopy - cfgAngle) > 5 then
			if cfgAngle == 0 then
				if predictAngle <= 12 and predictAngle >= 0 or predictAngle >= 348 and predictAngle <= 360 then
					local offsetAngle = math.min(math.abs(predictAngle - cfgAngle), math.abs(predictAngle - 360))

					if offsetAngle < minAngle then
						minAngle = offsetAngle
						stopAngle = cfgAngle
					end
				end
			else
				local offsetAngle = math.abs(predictAngle - cfgAngle)

				if offsetAngle <= 25 and offsetAngle < minAngle then
					minAngle = offsetAngle
					stopAngle = cfgAngle
				end
			end
		end
	end

	if stopAngle then
		if isRight then
			if stopAngle < orgAngle then
				stopAngle = stopAngle + 360
			end
		elseif orgAngle < stopAngle then
			stopAngle = stopAngle - 360
		end

		targetAngle = stopAngle
		ease = DG.Tweening.Ease.OutQuint
	end

	return targetAngle, ease
end

function M:_fixAngle(angle)
	angle = angle >= 360 and angle - 360 or angle
	angle = angle < 0 and angle + 360 or angle

	return angle
end

function M:_forceStopLerpCam()
	if self._lerpCamTweener then
		self._lerpCamTweener:Kill(false)

		self._lerpCamTweener = nil
	end

	self._isLerping = false
end

function M:_lerpCamFinish()
	self:_forceStopLerpCam()
end

function M:_lerpCamUpdateCB(updateValue)
	self._camContrastAngle = updateValue

	local minRadius, maxRadius = self:_getRingRadiusRange()
	local deltaRadius = 0

	self._camRadius = self._camRadius - deltaRadius
	self._camRadius = math.max(minRadius, math.min(maxRadius, self._camRadius))

	self:_changeCameraPosByAngle(self._camContrastAngle, self._camRadius)
	self:_setCameraAngle(updateValue)
	self:_dispatchCamRefresh()
end

function M:_changeRingPosZByScale(scale, syncUI)
	self._curScreenScale = math.min(1, math.max(0, scale))

	HouseModel.instance:setScaleNormal(self._curScreenScale)

	local minPosZ, maxPosZ = self:_getRingPosZRange()
	local posZ = (maxPosZ - minPosZ) * self._curScreenScale + minPosZ
	local houseCameraPos = self._houseCameraUnit:getPosition()

	self._houseCameraUnit:setPosition(houseCameraPos.x, houseCameraPos.y, posZ)

	local minRadius, maxRadius = self:_getRingRadiusRange()

	self._camRadius = math.max(minRadius, math.min(maxRadius, self._camRadius))

	self:_changeCameraPosByAngle(self._camContrastAngle, self._camRadius)

	if syncUI == true then
		HouseDispatcher:dispatchEvent(HouseEventType.ON_SCENE_SCALE_RING_UPDATE_UI, self._curScreenScale)
	end
end

function M:_getDragSpeed()
	local houseCameraPos = self._houseCameraUnit:getPosition()

	return -0.00035 * houseCameraPos.z - 0.0005
end

function M:_getRingPosZRange()
	local cameraParam = HouseConfig.instance:getConfigByKey(ConfigName.HouseRingCameraParam, self._ringType)
	local strList = string.split(cameraParam.rangePosZ, "#")

	return tonumber(strList[1]), tonumber(strList[2])
end

function M:_getRingRadiusRange()
	local cameraParam = HouseConfig.instance:getConfigByKey(ConfigName.HouseRingCameraParam, self._ringType)
	local strList = string.split(cameraParam.rangeRadius, "#")
	local minRadius, maxRadius = tonumber(strList[1]), tonumber(strList[2])
	local baseRadius = (maxRadius + minRadius) / 2
	local canChangeRadius = (maxRadius - minRadius) / 2 * self._curScreenScale

	return baseRadius - canChangeRadius, baseRadius + canChangeRadius
end

function M:_changeCameraPosByAngle(angle, radius)
	angle = angle - 90

	local houseCameraPos = self._houseCameraUnit:getPosition()

	if radius > 0 then
		local posX = math.cos(math.rad(angle)) * radius
		local posY = math.sin(math.rad(angle)) * radius

		self._houseCameraUnit:setPosition(posX, posY, houseCameraPos.z)
	else
		self._houseCameraUnit:setPosition(0, 0, houseCameraPos.z)
	end
end

function M:_getCameraAngle()
	local camGO = self._houseCameraUnit:getMainGO()
	local rotaX, rotaY, rotaZ = Astral.TransformUtil.GetLocalRotation(camGO.transform, 0, 0, 0)

	return rotaZ
end

function M:_setCameraAngle(angleZ)
	local camGO = self._houseCameraUnit:getMainGO()

	Astral.TransformUtil.SetLocalRotation(camGO.transform, 0, 0, angleZ)
end

local kRoomScreenOffsetY = 3.5
local kAisleScreenOffsetY = 1.5

function M:_findDragUnit(screenPos)
	if self._dragingUnit then
		return
	end

	local camera = self._mainCameraTarget:getCamera()
	local ray = camera:ScreenPointToRay(screenPos)
	local va, hit = UnityEngine.Physics.Raycast(ray, tolua.out)
	local clickUnit

	if hit then
		local hitParent = hit.collider.gameObject.transform.parent.parent

		if hitParent then
			clickUnit = Astral.LuaComponentContainer.Get(hitParent.gameObject, UnitPlayer)
		end
	end

	if clickUnit then
		local isInElevator = clickUnit.model:judgeStatus(PlayerStatus.Elevator)
		local isWaitingElevator = clickUnit.model:judgeStatus(PlayerStatus.WaitingElevator)
		local runningCtrl = clickUnit.performCtrl:getRunningCtrl()
		local isDoublePerform = runningCtrl and runningCtrl:getCtrlType() == PerformCtrlType.Double
		local state = HouseMainStateModel.instance:getState()
		local isNotInRoom = state ~= HouseMainEnum.State.FocusRoom
		local isShelterInvalid = clickUnit.model:judgeBehaviorStatus(BehaviorStatus.ShelterInvalid)

		if isInElevator or isWaitingElevator or isDoublePerform or isNotInRoom or isShelterInvalid then
			return
		end
	end

	self._dragingUnit = clickUnit

	if self._dragingUnit then
		self._dragingUnit.progressBar:playProgress(0, 1, HouseConfig.instance:getDragPlayerDuration(), self._startDragUnit, self, true)
	end
end

function M:_startDragUnit()
	local unit = self:getDragingUnit()

	if unit then
		unit.model:setStatus(PlayerStatus.Draging)
		unit.progressBar:clear()
		unit.performCtrl:interrupt()
		unit.ai:stopCurrentAI()
		self:_createDragData(unit)
		unit.navMesh:setNavMeshAgentStatus(false)
		unit.meshModel:play(AnimationState.Loss, true)
		self:_onDragUnit(self._unitDragPos)
	end
end

function M:_createDragData(unit)
	self._dragData = {}

	local unitPosX, unitPosY, unitPosZ = unit.navMesh:getNavMeshGoPos()

	self._dragData.originPos = Vector3.New(unitPosX, unitPosY, unitPosZ)
	self._dragData.isRoomType = unit.navMesh:getCurAreaType() == SceneEnum.NavMeshAreas.Room

	local zoneId = unit.navMesh:getCurZoneId()
	local navMO = HouseNavigationModel.instance:getMOByZoneId(zoneId)
	local angle = navMO:getAngle()
	local A = math.cos(math.rad(angle))
	local B = math.sin(math.rad(angle))
	local leftBorderPos = navMO:getLeftBorderPos()
	local rightBorderPos = navMO:getRightBorderPos()

	self._dragData.navMO = navMO
	self._dragData.angle = angle
	self._dragData.A = A
	self._dragData.B = B
	self._dragData.Pow = A * A + B * B

	local leftBorderScreenPosX, leftBorderScreenPosY = self:_worldToScreenPosWithData(leftBorderPos.x, leftBorderPos.y)
	local rightBorderScreenPosX, rightBorderScreenPosY = self:_worldToScreenPosWithData(rightBorderPos.x, rightBorderPos.y)

	self._dragData.minScreenY = math.max(leftBorderScreenPosY, rightBorderScreenPosY)
	self._dragData.maxScreenY = self._dragData.minScreenY + kRoomScreenOffsetY
	self._dragData.minScreenX = leftBorderScreenPosX
	self._dragData.maxScreenX = rightBorderScreenPosX
	self._dragData.leftAngle = MathUtil.normalizeAngle(math.deg(math.atan2(leftBorderPos.x, -leftBorderPos.y)))
	self._dragData.rightAngle = MathUtil.normalizeAngle(math.deg(math.atan2(rightBorderPos.x, -rightBorderPos.y)))

	local leftRadius = math.sqrt(math.pow(leftBorderPos.x, 2) + math.pow(leftBorderPos.y, 2))
	local rightRadius = math.sqrt(math.pow(rightBorderPos.x, 2) + math.pow(rightBorderPos.y, 2))

	self._dragData.maxRadius = math.min(leftRadius, rightRadius)
	self._dragData.minRadius = self._dragData.maxRadius - kAisleScreenOffsetY

	local roomCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseZone, zoneId)

	if roomCO and roomCO.roomType == HouseEnum.RoomType.Living then
		self:_startDragUnitInLivingRoom(unit)

		self._dragData.isLivingRoom = true
	end
end

function M:_onDragUnit(screenPos)
	local unit = self:getDragingUnit()

	if unit and self._dragData and unit.model:judgeStatus(PlayerStatus.Draging) then
		local dragPos = Astral.GeometryUtil.ScreenTo3DWorldPoint(screenPos, self._mainCameraTarget:getCamera(), self._dragData.originPos)

		if self._dragData.isRoomType then
			if self._dragData.isLivingRoom then
				self:_onDragUnitInLivingRoom(screenPos)
			else
				local dragScreenX, dragScreenY = self:_worldToScreenPosWithData(dragPos.x, dragPos.y)

				dragScreenX = math.min(self._dragData.maxScreenX, math.max(self._dragData.minScreenX, dragScreenX))
				dragScreenY = math.min(self._dragData.maxScreenY, math.max(self._dragData.minScreenY, dragScreenY))

				local posX, posY = self:_screenToWorldPosWithData(dragScreenX, dragScreenY)

				unit.navMesh:setNavAgentPos(posX, posY, dragPos.z)
			end
		else
			local dragAngle = MathUtil.normalizeAngle(math.deg(math.atan2(dragPos.x, -dragPos.y)))
			local dragRadius = math.sqrt(math.pow(dragPos.x, 2) + math.pow(dragPos.y, 2))

			if self._dragData.leftAngle > self._dragData.rightAngle then
				if dragAngle > 180 then
					dragAngle = math.max(self._dragData.leftAngle, dragAngle)
				else
					dragAngle = math.min(self._dragData.rightAngle, dragAngle)
				end
			else
				dragAngle = math.min(self._dragData.rightAngle, math.max(self._dragData.leftAngle, dragAngle))
			end

			dragRadius = math.min(self._dragData.maxRadius, math.max(self._dragData.minRadius, dragRadius))
			dragAngle = dragAngle - 90

			local posX = math.cos(math.rad(dragAngle)) * dragRadius
			local posY = math.sin(math.rad(dragAngle)) * dragRadius

			unit.navMesh:setNavAgentPos(posX, posY, dragPos.z)
			Astral.TransformUtil.SetLocalRotation(unit.go.transform, 0, 0, dragAngle)
		end
	end
end

function M:_endDragUnit(screenPos, noShowHello)
	local unit = self:getDragingUnit()

	if unit then
		if unit.model:judgeStatus(PlayerStatus.Draging) then
			unit.model:clearStatus(PlayerStatus.Draging)
			unit.meshModel:play(AnimationState.Idle, true)

			if self._dragData.isLivingRoom then
				self:_endDragUnitInLivingRoom(unit)
			else
				if self._dragData.isRoomType then
					local dragPos = Astral.GeometryUtil.ScreenTo3DWorldPoint(screenPos, self._mainCameraTarget:getCamera(), self._dragData.originPos)
					local dragScreenX, dragScreenY = self:_worldToScreenPosWithData(dragPos.x, dragPos.y)

					dragScreenX = math.min(self._dragData.maxScreenX, math.max(self._dragData.minScreenX, dragScreenX))

					local posX, posY = self:_screenToWorldPosWithData(dragScreenX, self._dragData.minScreenY)

					unit.navMesh:setNavAgentPos(posX, posY, dragPos.z)
				end

				self:_resetDragUnit(unit)
			end
		else
			unit.progressBar:clear()

			if noShowHello ~= true then
				self:_showDragUnitHello(unit)
			end
		end
	end

	self._dragingUnit = false
	self._dragData = false
end

function M:_showDragUnitHello(unit)
	self._helloUnit = unit

	unit.performCtrl:interrupt()
	unit.performCtrl:setForbid(HouseEnum.PerformForbidKey.ShowHello, true)
	unit.ai:stopCurrentAI()
	unit.navMesh:setNavMeshAgentStatus(false)
	unit.navMeshMover:setDirection(HouseEnum.UnitDirection.Forward)
	unit.meshModel:play(AnimationState.Jump, false)

	local time = unit.meshModel:getAnimationDuration(AnimationState.Jump)

	self._timerEndUnitHello:restart(time, false)
end

function M:_onFinishUnitHello()
	if self._helloUnit then
		self._helloUnit.performCtrl:setForbid(HouseEnum.PerformForbidKey.ShowHello, false)
		self._helloUnit.meshModel:play(AnimationState.Idle, true)
		self._helloUnit.navMesh:setNavMeshAgentStatus(true)
		self._helloUnit.ai:setStop(false)
	end

	self._helloUnit = nil
end

function M:_screenToWorldPosWithData(screenPosX, screenPosY)
	local posX = (self._dragData.A * screenPosX - self._dragData.B * screenPosY) / self._dragData.Pow
	local posY = (self._dragData.B * screenPosX + self._dragData.A * screenPosY) / self._dragData.Pow

	return posX, posY
end

function M:_worldToScreenPosWithData(posX, posY)
	local screenPosX = posX * self._dragData.A + posY * self._dragData.B
	local screenPosY = posY * self._dragData.A - posX * self._dragData.B

	return screenPosX, screenPosY
end

function M:_startDragUnitInLivingRoom(unit)
	unit.mountRoot:setAvatarRootPos(0, 0.7, 0)

	local zoneId = unit.navMesh:getCurZoneId()
	local roomUnit = HouseSceneUtil.getHouseRoomUnit(zoneId)

	roomUnit.furniturePaper:changeLayerByType(HouseEnum.FurnitureOperaType.Floor)

	self._dragData.livingRoomUnit = roomUnit
end

function M:_onDragUnitInLivingRoom(screenPos)
	local unit = self:getDragingUnit()
	local layerMask = Astral.LayerUtil.GetLayerMask(SceneLayer.Stone_Value)
	local worldPos = ScenePickerViewFacade.instance:getHitPosByScreenPointWithMask(screenPos.x, screenPos.y - 240, layerMask)

	if worldPos and (worldPos.x ~= 0 or worldPos.y ~= 0 or worldPos.z ~= 0) then
		local coordX, coordY, newX, newY, newZ = self._dragData.livingRoomUnit.furnitureMap:getFurnitureCoordPosByWorldPos(worldPos, HouseEnum.FurnitureOperaType.Floor, nil, 1, 1)

		unit.navMesh:setNavAgentPos(newX, newY, newZ)

		self._dragData.coordX = coordX
		self._dragData.coordY = coordY

		local furnitureUnit = self:_tryGetTriggerFurniture()

		if furnitureUnit then
			if self:_tryTriggerFurniture(furnitureUnit, unit, true) then
				printWarn("可以触发家具", furnitureUnit.id)
			else
				printWarn("不可以触发家具", furnitureUnit.id)
			end
		end
	end
end

function M:_endDragUnitInLivingRoom(unit)
	unit.mountRoot:setAvatarRootPos(0, 0, 0)

	local furnitureUnit = self:_tryGetTriggerFurniture()

	if furnitureUnit then
		if self:_tryTriggerFurniture(furnitureUnit, unit) then
			unit.navMesh:setNavMeshAgentStatus(true)
			printWarn("触发家具，成功", furnitureUnit.id)
		else
			printWarn("触发家具，失败", furnitureUnit.id)

			if not furnitureUnit.perform:hasPathToTrigger() then
				printWarn("家具不可到达，将角色放回起点")
				unit.navMesh:setNavAgentPos(self._dragData.originPos.x, self._dragData.originPos.y, self._dragData.originPos.z)
			end

			self:_resetDragUnit(unit)
		end
	else
		if not self._dragData.livingRoomUnit.furnitureMap:hasPathToCoord(self._dragData.coordX, self._dragData.coordY) then
			printWarn("死路，将角色放回起点")
			unit.navMesh:setNavAgentPos(self._dragData.originPos.x, self._dragData.originPos.y, self._dragData.originPos.z)
		end

		self:_resetDragUnit(unit)
	end
end

function M:_resetDragUnit(unit)
	unit.navMesh:setNavMeshAgentStatus(true)
	unit.ai:setStop(false)
end

function M:_tryGetTriggerFurniture()
	local occupyUnitList = self._dragData.livingRoomUnit.furnitureMap:getFloorGridMap(self._dragData.coordX, self._dragData.coordY)

	if occupyUnitList then
		local unitId = occupyUnitList[1]

		if unitId and unitId > 0 then
			return self._dragData.livingRoomUnit.furnitureMgr:getFurnitureUnit(unitId)
		end
	end
end

function M:_tryTriggerFurniture(furniture, unit, onlyJudge)
	if self:_tryTriggerWaitingCtrl(furniture, unit, onlyJudge) then
		return true
	end

	if self:_tryCreateNewPerform(furniture, unit, onlyJudge) then
		return true
	end

	return false
end

function M:_tryTriggerWaitingCtrl(furniture, unit, onlyJudge)
	local canTrigger = false
	local ctrls = self._dragData.livingRoomUnit.furniturePerform:getCtrlsByFurniture(furniture.id)

	for _, ctrl in ipairs(ctrls) do
		if ctrl:findRemainPerformUnits({
			unit
		}, onlyJudge) then
			canTrigger = true

			break
		end
	end

	return canTrigger
end

function M:_tryCreateNewPerform(furniture, unit, onlyJudge)
	local performCOs = {}
	local furnitureId = furniture.model:getFurnitureId()
	local COs = HouseConfig.instance:getFurnPerformCOs(furnitureId)

	for _, CO in ipairs(COs) do
		if CO:canPerform(furniture, {
			unit
		}) then
			table.insert(performCOs, CO)
		end
	end

	if #performCOs > 0 then
		if onlyJudge == true then
			return true
		end

		local targetCO
		local totalWeight = 0

		for _, CO in ipairs(performCOs) do
			totalWeight = totalWeight + CO:getWeight()
		end

		local weight = math.random(1, totalWeight)

		for _, CO in ipairs(performCOs) do
			if weight <= CO:getWeight() then
				targetCO = CO

				break
			end

			weight = weight - CO:getWeight()
		end

		self._dragData.livingRoomUnit.furniturePerform:createPerformCtrl(targetCO)

		return true
	end

	return false
end

function M:getDragingUnit()
	return self._dragingUnit
end

return M
