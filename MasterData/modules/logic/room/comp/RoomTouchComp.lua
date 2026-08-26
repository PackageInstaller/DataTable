-- chunkname: @modules/logic/room/comp/RoomTouchComp.lua

module("modules.logic.room.comp.RoomTouchComp", package.seeall)

local RoomTouchComp = class("RoomTouchComp", LuaCompBase)

function RoomTouchComp:ctor()
	return
end

function RoomTouchComp:init(go)
	self._stationaryRadius = 5
	self._characterPressThreshold = 0
	self._characterPressThresholdNormal = 0.3
	self._uiRootGO = gohelper.find("UIRoot")
	self._hudGO = gohelper.find("UIRoot/HUD")
	self._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(UnityEngine.EventSystems.EventSystem.current)
	self._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	self._scene = GameSceneMgr.instance:getCurScene()

	if GamepadController.instance:isOpen() then
		GamepadController.instance:registerCallback(GamepadEvent.AxisChange, self._onAxisChange, self)
		GamepadController.instance:registerCallback(GamepadEvent.KeyUp, self._onKeyUp, self)
		GamepadController.instance:registerCallback(GamepadEvent.KeyDown, self._onKeyDown, self)
	end

	self:_resetState()
end

function RoomTouchComp:onUpdate()
	if not UnityEngine.EventSystems.EventSystem.current then
		self:_resetState(true)

		return
	end

	if UIBlockMgr.instance:isBlock() and not RoomCharacterController.instance:isPressCharacter() then
		self:_resetState(true)

		return
	end

	if ZProj.TouchEventMgr.Fobidden then
		self:_resetState(true)

		return
	end

	if not self:_canTouch() then
		self:_resetState(true)

		return
	end

	self._screenScaleX = 1920 / UnityEngine.Screen.width
	self._screenScaleY = 1080 / UnityEngine.Screen.height
	self._scale = math.sqrt(self._screenScaleX^2 + self._screenScaleY^2)

	if GamepadController.instance:isOpen() then
		self:_handleGamepadToucInput()
	elseif BootNativeUtil.isStandalonePlayer() or self:getIsEmulator() then
		if PCInputController.instance:getIsUse() then
			self:_handleNewKeyInput()
		else
			self:_handleKeyInput()
		end

		self:_handleMouseInput()
	elseif BootNativeUtil.isMobilePlayer() then
		self:_handleTouchInput()
	end

	if self._isUIDragScreenScroll then
		self:_screenScroll(GamepadController.instance:getMousePosition())
	end
end

function RoomTouchComp:getIsEmulator()
	local curTime = Time.realtimeSinceStartup

	if self._lastGetEmulatorTime == nil or curTime - self._lastGetEmulatorTime > 10 then
		self._isEmulator = SDKMgr.instance:isEmulator()
		self._lastGetEmulatorTime = curTime
	end

	return self._isEmulator
end

function RoomTouchComp:_onAxisChange(key, value)
	if key == GamepadEnum.KeyCode.RightStickHorizontal then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, value * 0.1)
	elseif key == GamepadEnum.KeyCode.RightStickVertical then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchScale, value * 0.1)
	end
end

function RoomTouchComp:_onKeyUp(key)
	if key == GamepadEnum.KeyCode.A then
		self:_handleGamepadToucInput(false, true)
	end
end

function RoomTouchComp:_onKeyDown(key)
	if key == GamepadEnum.KeyCode.A then
		self:_handleGamepadToucInput(true, false)
	end
end

function RoomTouchComp:onDestroy()
	if GamepadController.instance:isOpen() then
		GamepadController.instance:unregisterCallback(GamepadEvent.AxisChange, self._onAxisChange, self)
		GamepadController.instance:unregisterCallback(GamepadEvent.KeyUp, self._onKeyUp, self)
		GamepadController.instance:unregisterCallback(GamepadEvent.KeyDown, self._onKeyDown, self)
	end
end

function RoomTouchComp:_resetState(coverUI)
	self._coverUI = coverUI
	self._hasMoved = false
	self._touch1DownPosition = nil
	self._coverUI3DGO = nil
	self._moveRotate = nil
	self._moveScale = nil
	self._addRotate = 0
	self._addScale = 0
	self._press = false
	self._pressTime = 0
	self._startOnBuildingUid = nil
	self._startOnHeroId = nil
	self._needDispatchUp = false
	self._mouseDownPosition = nil
	self._lastMousePosition = nil
	self._isUIDragScreenScroll = false

	RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding)
end

function RoomTouchComp:_canTouch()
	if ViewMgr.instance:isOpen(ViewName.RoomMiniMapView) or ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) or ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.RoomCharacterPlaceInfoView) or ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView) or ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
		return false
	end

	if self._scene.camera:isTweening() and not RoomCharacterController.instance:isPressCharacter() then
		return false
	end

	if RoomCharacterHelper.isInDialogInteraction() then
		return false
	end

	return true
end

function RoomTouchComp:_handleKeyInput()
	if ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.HelpView) then
		return
	end

	local deltaRotate = 0
	local rotateScale = -1 * Time.deltaTime

	rotateScale = rotateScale * RoomController.instance.rotateSpeed

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.Q) then
		deltaRotate = deltaRotate - rotateScale
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.E) then
		deltaRotate = deltaRotate + rotateScale
	end

	if deltaRotate ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, deltaRotate)
	end

	local deltaMoveX = 0
	local deltaMoveY = 0
	local moveScale = -800 * Time.deltaTime

	moveScale = moveScale * RoomController.instance.moveSpeed

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
		deltaMoveX = deltaMoveX - moveScale
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
		deltaMoveX = deltaMoveX + moveScale
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
		deltaMoveY = deltaMoveY + moveScale
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.S) then
		deltaMoveY = deltaMoveY - moveScale
	end

	if deltaMoveX ~= 0 or deltaMoveY ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(deltaMoveX, deltaMoveY))
	end

	local deltaScale = 0
	local scaleScale = 1 * Time.deltaTime

	scaleScale = scaleScale * RoomController.instance.scaleSpeed

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.R) then
		deltaScale = deltaScale + scaleScale
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.F) then
		deltaScale = deltaScale - scaleScale
	end

	if deltaScale ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchScale, deltaScale)
	end
end

function RoomTouchComp:_handleNewKeyInput()
	local deltaRotate = 0
	local rotateScale = -1 * Time.deltaTime

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 17) then
		deltaRotate = deltaRotate - rotateScale
	end

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 18) then
		deltaRotate = deltaRotate + rotateScale
	end

	if deltaRotate ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, deltaRotate)
	end

	local deltaMoveX = 0
	local deltaMoveY = 0
	local moveScale = -800 * Time.deltaTime

	moveScale = moveScale * RoomController.instance.moveSpeed

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 14) then
		deltaMoveX = deltaMoveX - moveScale
	end

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 16) then
		deltaMoveX = deltaMoveX + moveScale
	end

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 13) then
		deltaMoveY = deltaMoveY + moveScale
	end

	if PCInputController.instance:getActivityFunPress(PCInputModel.Activity.room, 15) then
		deltaMoveY = deltaMoveY - moveScale
	end

	if deltaMoveX ~= 0 or deltaMoveY ~= 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(deltaMoveX, deltaMoveY))
	end
end

function RoomTouchComp:_handleMouseInput()
	local scrollWheel = UnityEngine.Input.mouseScrollDelta
	local confirm = gohelper.findChild(self._hudGO, "RoomView/go_normalroot/go_confirm/roomviewconfirm(Clone)/go_confirm/go_container")
	local confirmView = confirm and confirm.activeSelf

	if scrollWheel and scrollWheel.y ~= 0 and not confirmView then
		local deltaScale = -3 * scrollWheel.y * Time.deltaTime

		RoomMapController.instance:dispatchEvent(RoomEvent.TouchScale, deltaScale)
	end

	if not UnityEngine.Input.GetMouseButtonDown(0) and not UnityEngine.Input.GetMouseButton(0) and not UnityEngine.Input.GetMouseButtonUp(0) and not UnityEngine.Input.GetMouseButtonDown(1) and not UnityEngine.Input.GetMouseButton(1) and not UnityEngine.Input.GetMouseButtonUp(1) then
		if self._needDispatchUp then
			self:_dispatchMouseUp()
		end

		self:_resetState(false)

		return
	end

	if self._coverUI then
		return
	end

	self._needDispatchUp = true

	local mousePosition = UnityEngine.Input.mousePosition

	self._lastMousePosition = self._lastMousePosition or mousePosition

	local ui2dList, ui3dList = self:_getCoverUIList(mousePosition)

	if (UnityEngine.Input.GetMouseButtonDown(0) or UnityEngine.Input.GetMouseButtonDown(1)) and #ui2dList > 0 then
		self._coverUI = true

		return
	end

	if UnityEngine.Input.GetMouseButtonDown(0) then
		self._coverUI3DGO = #ui3dList > 0 and ui3dList[1] or nil
	end

	if UnityEngine.Input.GetMouseButtonDown(0) or UnityEngine.Input.GetMouseButtonDown(1) then
		self._mouseDownPosition = mousePosition

		local roomTouchTag, id = self:_getPressEntity(self._mouseDownPosition)

		if roomTouchTag == RoomEnum.TouchTab.RoomBuilding then
			self._startOnBuildingUid = id
		elseif roomTouchTag == RoomEnum.TouchTab.RoomCharacter then
			self._startOnHeroId = id
		end
	elseif UnityEngine.Input.GetMouseButton(0) or UnityEngine.Input.GetMouseButton(1) then
		self._mouseDownPosition = self._mouseDownPosition or mousePosition

		if self._hasMoved then
			local deltaPosition = mousePosition - self._lastMousePosition

			if UnityEngine.Input.GetMouseButton(0) then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(deltaPosition.x * self._screenScaleX, deltaPosition.y * self._screenScaleY))
			else
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, deltaPosition.x * self._screenScaleX / 800)
			end
		elseif self._press then
			if self._startOnBuildingUid then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, mousePosition)
			elseif self._startOnHeroId then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, mousePosition)
			end

			self:_screenScroll(mousePosition)
		else
			if Vector2.Distance(self._mouseDownPosition, mousePosition) > self._stationaryRadius then
				if self._startOnBuildingUid then
					self._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, mousePosition, self._startOnBuildingUid)
				else
					self._hasMoved = true
				end
			end

			if not self._hasMoved then
				self._pressTime = self._pressTime + Time.deltaTime

				if RoomCharacterController.instance:isCharacterListShow() then
					if not self._characterPressThreshold then
						local characterPressThreshold = self._characterPressThresholdNormal

						if characterPressThreshold < self._pressTime and self._startOnHeroId then
							self._press = true

							RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, mousePosition, self._startOnHeroId)
						end
					end
				end
			end
		end
	elseif UnityEngine.Input.GetMouseButtonUp(0) then
		if not self._hasMoved and not self._press then
			if not self._coverUI3DGO then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickScene, mousePosition)
			elseif self._coverUI3DGO == ui3dList[1] then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickUI3D, self._coverUI3DGO)
			end
		end

		self:_dispatchMouseUp()
		self:_resetState(false)
	end

	self._lastMousePosition = mousePosition
end

function RoomTouchComp:_dispatchMouseUp()
	local mousePosition = UnityEngine.Input.mousePosition

	if self._press then
		if self._startOnBuildingUid then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding, mousePosition)
		elseif self._startOnHeroId then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropCharacter, mousePosition)
		end
	end
end

function RoomTouchComp:_handleTouchInput()
	local touchCount = UnityEngine.Input.touchCount

	if touchCount <= 0 then
		if self._needDispatchUp then
			self:_dispatchTouchUp()
		end

		self:_resetState(false)

		return
	end

	if self._coverUI then
		return
	end

	self._needDispatchUp = true

	if touchCount == 1 then
		self:_handleSingleTouchInput()
	elseif touchCount >= 2 then
		self:_handleMultiTouchInput()
	end
end

function RoomTouchComp:_handleSingleTouchInput()
	local touch1 = UnityEngine.Input.GetTouch(0)
	local touch1Position = touch1.position
	local touch1DeltaPosition = touch1.deltaPosition
	local touch1UI2dList, touch1UI3dList = self:_getCoverUIList(touch1Position)

	if touch1.phase == TouchPhase.Began and #touch1UI2dList > 0 then
		self._coverUI = true

		return
	end

	if touch1.phase == TouchPhase.Began then
		self._coverUI3DGO = #touch1UI3dList > 0 and touch1UI3dList[1] or nil
	end

	if touch1.phase == TouchPhase.Began then
		self._touch1DownPosition = touch1Position

		local roomTouchTag, id = self:_getPressEntity(self._touch1DownPosition)

		if roomTouchTag == RoomEnum.TouchTab.RoomBuilding then
			self._startOnBuildingUid = id
		elseif roomTouchTag == RoomEnum.TouchTab.RoomCharacter then
			self._startOnHeroId = id
		end
	elseif touch1.phase == TouchPhase.Moved or touch1.phase == TouchPhase.Stationary then
		if self._hasMoved then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(touch1DeltaPosition.x * self._screenScaleX, touch1DeltaPosition.y * self._screenScaleY))
		elseif self._press then
			if self._startOnBuildingUid then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, touch1Position)
			elseif self._startOnHeroId then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, touch1Position)
			end

			self:_screenScroll(touch1Position)
		else
			self._touch1DownPosition = self._touch1DownPosition or touch1Position

			if Vector2.Distance(touch1Position, self._touch1DownPosition) > self._stationaryRadius then
				if self._startOnBuildingUid then
					self._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, touch1Position, self._startOnBuildingUid)
				else
					self._hasMoved = true
				end
			end

			if not self._hasMoved then
				self._pressTime = self._pressTime + Time.deltaTime

				if RoomCharacterController.instance:isCharacterListShow() then
					if not self._characterPressThreshold then
						local characterPressThreshold = self._characterPressThresholdNormal

						if characterPressThreshold < self._pressTime and self._startOnHeroId then
							self._press = true

							RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, touch1Position, self._startOnHeroId)
						end
					end
				end
			end
		end
	elseif touch1.phase == TouchPhase.Ended or touch1.phase == TouchPhase.Canceled then
		if not self._hasMoved and not self._press then
			if not self._coverUI3DGO then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickScene, touch1Position)
			elseif #touch1UI3dList > 0 and self._coverUI3DGO == touch1UI3dList[1] then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickUI3D, self._coverUI3DGO)
			end
		end

		self:_dispatchTouchUp()
		self:_resetState(false)
	end
end

function RoomTouchComp:_handleGamepadToucInput(isDown, isUp)
	local isDownA = GamepadController.instance:isDownA()

	if not isDownA and not isUp then
		if self._needDispatchUp then
			self:_dispatchGamepadKeyUp()
		end

		self:_resetState(false)

		return
	end

	if self._coverUI then
		return
	end

	self._needDispatchUp = true

	local mousePosition = GamepadController.instance:getScreenPos()

	self._lastMousePosition = self._lastMousePosition or mousePosition

	local ui2dList, ui3dList = self:_getCoverUIList(mousePosition)

	if isDown and #ui2dList > 0 then
		self._coverUI = true

		return
	end

	if UnityEngine.Input.GetMouseButtonDown(0) then
		self._coverUI3DGO = #ui3dList > 0 and ui3dList[1] or nil
	end

	if isDown then
		self._mouseDownPosition = mousePosition

		local roomTouchTag, id = self:_getPressEntity(self._mouseDownPosition)

		if roomTouchTag == RoomEnum.TouchTab.RoomBuilding then
			self._startOnBuildingUid = id
		elseif roomTouchTag == RoomEnum.TouchTab.RoomCharacter then
			self._startOnHeroId = id
		end
	elseif isDownA then
		self._mouseDownPosition = self._mouseDownPosition or mousePosition

		if self._hasMoved then
			local deltaPosition = mousePosition - self._lastMousePosition

			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(deltaPosition.x * self._screenScaleX, deltaPosition.y * self._screenScaleY))
		elseif self._press then
			if self._startOnBuildingUid then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, mousePosition)
			elseif self._startOnHeroId then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, mousePosition)
			end

			self:_screenScroll(mousePosition)
		else
			if Vector2.Distance(self._mouseDownPosition, mousePosition) > self._stationaryRadius then
				if self._startOnBuildingUid then
					self._press = true

					RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, mousePosition, self._startOnBuildingUid)
				else
					self._hasMoved = true
				end
			end

			if not self._hasMoved then
				self._pressTime = self._pressTime + Time.deltaTime

				if RoomCharacterController.instance:isCharacterListShow() then
					if not self._characterPressThreshold then
						local characterPressThreshold = self._characterPressThresholdNormal

						if characterPressThreshold < self._pressTime and self._startOnHeroId then
							self._press = true

							RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressCharacter, mousePosition, self._startOnHeroId)
						end
					end
				end
			end
		end
	elseif isUp then
		if not self._hasMoved and not self._press then
			if not self._coverUI3DGO then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickScene, mousePosition)
			elseif self._coverUI3DGO == ui3dList[1] then
				RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickUI3D, self._coverUI3DGO)
			end
		end

		self:_dispatchGamepadKeyUp()
		self:_resetState(false)
	end

	self._lastMousePosition = mousePosition
end

function RoomTouchComp:_dispatchGamepadKeyUp()
	local mousePosition = GamepadController.instance:getScreenPos()

	if self._press then
		if self._startOnBuildingUid then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding, mousePosition)
		elseif self._startOnHeroId then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropCharacter, mousePosition)
		end
	end
end

function RoomTouchComp:_dispatchTouchUp()
	local touchCount = UnityEngine.Input.touchCount
	local touch1 = touchCount > 0 and UnityEngine.Input.GetTouch(0)

	if touch1 then
		if not touch1.position then
			local touch1Position = Vector2(0, 0)

			if self._press then
				if self._startOnBuildingUid then
					RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding, touch1Position)
				elseif self._startOnHeroId then
					RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropCharacter, touch1Position)
				end
			end
		end
	end
end

function RoomTouchComp:_handleMultiTouchInput()
	local touch1 = UnityEngine.Input.GetTouch(0)
	local touch1Position = touch1.position
	local touch1DeltaPosition = touch1.deltaPosition
	local touch1UI2dList, touch1UI3dList = self:_getCoverUIList(touch1Position)
	local touch2 = UnityEngine.Input.GetTouch(1)
	local touch2Position = touch2.position
	local touch2DeltaPosition = touch2.deltaPosition
	local touch2UI2dList, touch2UI3dList = self:_getCoverUIList(touch2Position)

	if touch1.phase == TouchPhase.Began and #touch1UI2dList > 0 or touch2.phase == TouchPhase.Began and #touch2UI2dList > 0 then
		self._coverUI = true

		return
	end

	self._hasMoved = true

	if (touch1.phase == TouchPhase.Moved or touch1.phase == TouchPhase.Stationary) and (touch2.phase == TouchPhase.Moved or touch2.phase == TouchPhase.Stationary) then
		local touch1OriginalPosition = touch1Position - touch1DeltaPosition
		local touch2OriginalPosition = touch2Position - touch2DeltaPosition

		if Vector2.Distance(touch1Position, touch2Position) < self._stationaryRadius or Vector2.Distance(touch1OriginalPosition, touch2OriginalPosition) < self._stationaryRadius then
			return
		end

		local originalDistance = Vector2.Distance(touch1OriginalPosition, touch2OriginalPosition)
		local distance = Vector2.Distance(touch1Position, touch2Position)
		local scale = distance - originalDistance

		scale = -0.0005 * scale * self._scale

		local rotate = self:_getDeltaAngle(touch1OriginalPosition, touch2OriginalPosition, touch1Position, touch2Position)

		if self._moveRotate then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchRotate, rotate)
		elseif self._moveScale then
			RoomMapController.instance:dispatchEvent(RoomEvent.TouchScale, scale)
		else
			self._addRotate = self._addRotate + rotate
			self._addScale = self._addScale + scale

			if math.abs(self._addRotate) > 0.08 then
				self._moveRotate = true
			elseif math.abs(self._addScale) > 0.02 then
				self._moveScale = true
			end
		end
	end
end

function RoomTouchComp:_getCoverUIList(position)
	self._pointerEventData.position = position

	UnityEngine.EventSystems.EventSystem.current:RaycastAll(self._pointerEventData, self._raycastResults)

	local touchUI2dList = {}
	local touchUI3dList = {}
	local iter = self._raycastResults:GetEnumerator()

	while iter:MoveNext() do
		local raycastResult = iter.Current
		local raycaster = raycastResult.module

		if self:_isRaycaster2d(raycaster, raycastResult.gameObject) then
			table.insert(touchUI2dList, raycastResult.gameObject)
		else
			table.insert(touchUI3dList, raycastResult.gameObject)
		end
	end

	return touchUI2dList, touchUI3dList
end

function RoomTouchComp:_isRaycaster2d(raycaster, go)
	local raycasterGO = raycaster.gameObject
	local isRaycaster2d = raycasterGO.transform:IsChildOf(self._uiRootGO.transform)
	local goui = gohelper.findChild(self._uiRootGO, "HUD/RoomView/go_normalroot/go_ui")

	if goui and go then
		isRaycaster2d = isRaycaster2d and not go.transform:IsChildOf(goui.transform)
	end

	return isRaycaster2d
end

function RoomTouchComp:_getDeltaAngle(touch1OriginalPosition, touch2OriginalPosition, touch1Position, touch2Position)
	local center = (touch1Position + touch2Position) / 2
	local originalCenter = (touch1OriginalPosition + touch2OriginalPosition) / 2
	local offset = center - originalCenter
	local offset1OriginalPosition = touch1OriginalPosition + offset
	local originalDirection = Vector2.Normalize(offset1OriginalPosition - center)
	local direction = Vector2.Normalize(touch1Position - center)
	local deltaAngle = Vector2.Angle(originalDirection, direction)
	local originalAngle = Vector2.Angle(Vector2.right, originalDirection)
	local angle = Vector2.Angle(Vector2.right, direction)

	if originalDirection.y < 0 then
		originalAngle = 360 - originalAngle
	end

	if direction.y < 0 then
		angle = 360 - angle
	end

	local deltaAngle = angle - originalAngle

	if deltaAngle >= 180 then
		deltaAngle = deltaAngle - 180
	elseif deltaAngle <= -180 then
		deltaAngle = deltaAngle + 180
	end

	if deltaAngle > 90 then
		deltaAngle = deltaAngle - 180
	elseif deltaAngle < -90 then
		deltaAngle = deltaAngle + 180
	end

	local scale = 2

	return deltaAngle * Mathf.Deg2Rad * scale
end

function RoomTouchComp:_getPressEntity(mousePosition)
	local roomTouchTag, id = RoomBendingHelper.getRaycastEntity(mousePosition, true)

	if roomTouchTag == RoomEnum.TouchTab.RoomBuilding and id then
		if RoomHelper.isFSMState(RoomEnum.FSMEditState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm) then
			local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(id)
			local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

			if not buildingMO or not tempBuildingMO or tempBuildingMO.id ~= buildingMO.id then
				return nil
			end

			if RoomBuildingController.instance:isBuildingListShow() then
				return roomTouchTag, buildingMO.id
			end
		end
	elseif roomTouchTag == RoomEnum.TouchTab.RoomCharacter and id and (RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm)) then
		local characterMO = RoomCharacterModel.instance:getCharacterMOById(id)

		if RoomCharacterController.instance:isCharacterListShow() then
			local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

			if not characterMO or not tempCharacterMO or tempCharacterMO.id ~= characterMO.id then
				return nil
			end
		end

		return roomTouchTag, characterMO.id
	end

	return nil
end

function RoomTouchComp:setUIDragScreenScroll(isDragStart)
	self._isUIDragScreenScroll = isDragStart
end

function RoomTouchComp:_screenScroll(mousePosition)
	local dragX = 0
	local dragY = 0
	local anchorPos = recthelper.screenPosToAnchorPos(mousePosition, self._hudGO.transform)
	local width = recthelper.getWidth(self._hudGO.transform)
	local height = recthelper.getHeight(self._hudGO.transform)

	if anchorPos.x > width * 0.4 then
		dragX = 1
	elseif anchorPos.x < -width * 0.4 then
		dragX = -1
	end

	if anchorPos.y > height * 0.4 then
		dragY = 1
	elseif anchorPos.y < -height * 0.4 then
		dragY = -1
	end

	local dragVector = Vector2(dragX, dragY)

	if dragVector == Vector2(0, 0) then
		return
	end

	if self._scene.camera:isTweening() then
		return
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, dragVector * -4)
end

return RoomTouchComp
