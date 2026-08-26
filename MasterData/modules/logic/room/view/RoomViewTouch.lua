-- chunkname: @modules/logic/room/view/RoomViewTouch.lua

module("modules.logic.room.view.RoomViewTouch", package.seeall)

local RoomViewTouch = class("RoomViewTouch", BaseView)

function RoomViewTouch:onInitView()
	self._commonEmptyBlockMO = RoomBlockMO.New()

	self._commonEmptyBlockMO:init(RoomInfoHelper.generateEmptyMapBlockInfo(-1, 0, 0))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewTouch:addEvents()
	return
end

function RoomViewTouch:removeEvents()
	return
end

function RoomViewTouch:_editableInitView()
	self._scene = GameSceneMgr.instance:getCurScene()
	self._characterTouchStateMap = {
		[RoomEnum.CameraState.Overlook] = true,
		[RoomEnum.CameraState.Normal] = true
	}
	self._isNotCanClickEeventMap = {
		[RoomEnum.CameraState.InteractBuilding] = true
	}
end

function RoomViewTouch:_isInitBlockById(blockId)
	return RoomConfig.instance:getInitBlock(blockId) ~= nil
end

function RoomViewTouch:_onClick(pos)
	local isUIHide = RoomMapController.instance:isUIHide()

	if isUIHide then
		RoomMapController.instance:setUIHide(false)

		return
	end

	if self._isNotCanClickEeventMap[self._scene.camera:getCameraState()] then
		return
	end

	if self:_click3DGameObject(pos) then
		return
	end

	local hexPoint, direction = RoomBendingHelper.screenPosToHex(pos)

	if not hexPoint then
		return
	end

	local blockMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)

	if not blockMO and not RoomEnum.IsBlockNeedConnInit and RoomBlockHelper.isCanPlaceBlock() then
		self._commonEmptyBlockMO.hexPiont = hexPoint
		blockMO = self._commonEmptyBlockMO
	end

	if not blockMO then
		self:_checkCancelBackBlock()

		return
	end

	local worldPos = RoomBendingHelper.screenToWorld(pos)

	if RoomController.instance:isDebugMode() then
		self:_debugBlockInfo(blockMO)
		self:_clickInDebugMode(blockMO, hexPoint, direction)
	elseif RoomController.instance:isEditMode() then
		self:_debugBlockInfo(blockMO)
		self:_clickInEditMode(blockMO, hexPoint, direction)
	elseif RoomController.instance:isObMode() then
		self:_debugBlockInfo(blockMO)
		self:_clickInObMode(blockMO, hexPoint, direction, worldPos)
	end
end

function RoomViewTouch:_clickInDebugMode(blockMO, hexPoint, direction)
	local leftShift = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift)

	if leftShift then
		return
	end

	if blockMO:canPlace() then
		RoomDebugController.instance:debugPlaceBlock(hexPoint)
	elseif blockMO.blockState == RoomBlockEnum.BlockState.Map then
		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.X) then
			if RoomDebugController.instance:isDebugBuildingListShow() then
				RoomDebugController.instance:debugRotateBuilding(hexPoint)
			elseif RoomDebugController.instance:isDebugPlaceListShow() then
				RoomDebugController.instance:debugRotateBlock(hexPoint)
			end
		elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.C) then
			if RoomDebugController.instance:isDebugBuildingListShow() then
				RoomDebugController.instance:debugRootOutBuilding(hexPoint)
			elseif RoomDebugController.instance:isDebugPackageListShow() then
				RoomDebugController.instance:debugSetPackageId(blockMO.id, 0)
			elseif RoomDebugController.instance:isDebugPlaceListShow() then
				RoomDebugController.instance:debugRootOutBlock(hexPoint)
			end
		elseif RoomController.instance:isDebugNormalMode() and UnityEngine.Input.GetKey(UnityEngine.KeyCode.V) then
			RoomDebugController.instance:debugPlaceBuilding(hexPoint)
		elseif RoomController.instance:isDebugNormalMode() and UnityEngine.Input.GetKey(UnityEngine.KeyCode.B) then
			RoomDebugController.instance:debugRotateBuilding(hexPoint)
		elseif RoomController.instance:isDebugNormalMode() and UnityEngine.Input.GetKey(UnityEngine.KeyCode.N) then
			RoomDebugController.instance:debugRootOutBuilding(hexPoint)
		elseif RoomDebugController.instance:isDebugBuildingListShow() then
			RoomDebugController.instance:debugPlaceBuilding(hexPoint)
		elseif RoomDebugController.instance:isDebugPlaceListShow() then
			RoomDebugController.instance:debugReplaceBlock(hexPoint)
		elseif RoomDebugController.instance:isDebugPackageListShow() then
			if RoomDebugController.instance:isEditPackageOrder() then
				RoomDebugController.instance:debugSetPackageLastOrder(blockMO.id)
			else
				RoomDebugController.instance:debugSetPackage(blockMO.id)
			end
		end
	end
end

function RoomViewTouch:_chickSelectInventontoryBlockId(blockMO, hexPoint, direction)
	local pos = HexMath.hexToPosition(blockMO.hexPoint, RoomBlockEnum.BlockSize)

	if not RoomHelper.isOutCameraFocusCenter(pos) then
		-- block empty
	elseif not self._scene.camera:isTweening() then
		self._scene.camera:tweenCamera({
			focusX = pos.x,
			focusY = pos.y
		})
	end
end

function RoomViewTouch:_chickBackBlock(blockMO, hexPoint, direction)
	local param = {}

	param.hexPoint = hexPoint

	self._scene.fsm:triggerEvent(RoomSceneEvent.TryBackBlock, param)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function RoomViewTouch:_checkBuilding(blockMO, hexPoint, direction)
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not tempBuildingMO then
		return
	end

	if self:_isInitBlockById(blockMO.id) then
		GameFacade.showToast(RoomEnum.Toast.BuildingCannotInitBlock)

		return
	end

	local param = {}

	param.hexPoint = hexPoint

	if hexPoint ~= tempBuildingMO.hexPoint then
		AudioMgr.instance:trigger(tempBuildingMO:getPlaceAudioId())
	end

	for i = 0, 5 do
		local rotate = RoomRotateHelper.rotateRotate(tempBuildingMO.rotate, i)
		local canTry = RoomBuildingHelper.canTryPlace(tempBuildingMO.buildingId, hexPoint, rotate)

		if canTry then
			param.rotate = rotate

			self._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, param)

			break
		end
	end
end

function RoomViewTouch:_checkCancelBackBlock()
	local isBackMore = RoomMapBlockModel.instance:isBackMore()
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()

	if RoomController.instance:isEditMode() and not isBackMore and not isWaterReform and RoomHelper.isFSMState(RoomEnum.FSMEditState.BackConfirm) then
		self._scene.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
	end
end

function RoomViewTouch:_clickInEditMode(blockMO, hexPoint, direction)
	if RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm) or RoomBuildingController.instance:isBuildingListShow() then
		self:_checkBuilding(blockMO, hexPoint, direction)

		return
	end

	local isBackMore = RoomMapBlockModel.instance:isBackMore()
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()

	if not blockMO:canPlace() then
		if blockMO.id == RoomInventoryBlockModel.instance:getSelectInventoryBlockId() then
			self:_chickSelectInventontoryBlockId(blockMO, hexPoint, direction)
		elseif blockMO.blockState == RoomBlockEnum.BlockState.Map then
			if isWaterReform then
				RoomWaterReformController.instance:onClickBlock(blockMO, hexPoint)
			elseif isBackMore and self:_isInitBlockById(blockMO.id) then
				GameFacade.showToast(RoomEnum.Toast.InventoryCannotBackInitBlock)
			else
				self:_chickBackBlock(blockMO, hexPoint, direction)
			end
		end

		return
	end

	self:_checkCancelBackBlock()

	if isBackMore or isWaterReform then
		return
	end

	local firstInventoryBlockMO = RoomInventoryBlockModel.instance:getSelectInventoryBlockMO()

	if not firstInventoryBlockMO then
		GameFacade.showToast(RoomEnum.Toast.NoSelectInventoryBlock)

		return
	end

	if RoomInventoryBlockModel.instance:isMaxNum() then
		GameFacade.showToast(RoomEnum.Toast.InventoryBlockMax)

		return
	end

	if not RoomBlockHelper.isInBoundary(hexPoint) then
		GameFacade.showToast(RoomEnum.Toast.InventBlockMapPositionMax)

		return
	end

	if RoomHelper.isFSMState(RoomEnum.FSMEditState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.BackConfirm) then
		local param = {}

		param.hexPoint = hexPoint

		self._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBlock, param)
	end
end

function RoomViewTouch:_clickInObMode(blockMO, hexPoint, direction, worldPos)
	if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
		self:_checkBuilding(blockMO, hexPoint, direction)
	elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) and blockMO.blockState == RoomBlockEnum.BlockState.Map then
		local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

		if tempCharacterMO then
			local currentPosition = tempCharacterMO.currentPosition
			local worldPos3D = RoomCharacterHelper.reCalculateHeight(Vector3(worldPos.x, 0, worldPos.y))

			if worldPos3D ~= currentPosition then
				local bestParam = RoomCharacterHelper.getRecommendHexPoint(tempCharacterMO.heroId, tempCharacterMO.skinId, worldPos)

				if bestParam then
					local param = {}

					param.position = bestParam.position

					self._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, param)

					return
				end

				GameFacade.showToast(ToastEnum.RoomViewTouch)
			end
		end
	end
end

function RoomViewTouch:_click3DGameObject(pos)
	self._click3DFuncDict = self._click3DFuncDict or {
		[RoomEnum.TouchTab.RoomBuilding] = self._click3DBuilding,
		[RoomEnum.TouchTab.RoomInitBuilding] = self._click3DInitBuilding,
		[RoomEnum.TouchTab.RoomPartBuilding] = self._click3DPartBuilding,
		[RoomEnum.TouchTab.RoomCharacter] = self._click3DCharacter,
		[RoomEnum.TouchTab.RoomCritter] = self._click3DCritter,
		[RoomEnum.TouchTab.RoomTransportSite] = self._click3DTransportSite
	}

	local touchTag, id = RoomBendingHelper.getRaycastEntity(pos)
	local clickFunc = self._click3DFuncDict[touchTag]

	if clickFunc then
		return clickFunc(self, id)
	end

	return false
end

function RoomViewTouch:_isCanClickBuilding()
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		return false
	end

	return RoomController.instance:isObMode()
end

function RoomViewTouch:_click3DBuilding(uid)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(uid)

	if not buildingMO then
		return false
	end

	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			local canReplace = RoomHelper.isFSMState(RoomEnum.FSMEditState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm)

			if canReplace then
				self._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
					buildingUid = buildingMO.id,
					hexPoint = buildingMO.hexPoint,
					rotate = buildingMO.rotate
				})
				RoomShowBuildingListModel.instance:setSelect(buildingMO.id)
			end

			return canReplace
		end
	elseif self:_isCanClickBuilding() and buildingMO.config and RoomBuildingEnum.CanClickTouchBuildingType[buildingMO.config.buildingType] == true then
		RoomMap3DClickController.instance:onBuildingEntityClick(buildingMO)

		return true
	end

	return false
end

function RoomViewTouch:_click3DInitBuilding(id)
	if self:_isCanClickBuilding() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_click)
		RoomMapController.instance:openRoomInitBuildingView(0.2)

		return true
	end

	return false
end

function RoomViewTouch:_click3DPartBuilding(id)
	if self:_isCanClickBuilding() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_click)
		RoomMapController.instance:openRoomInitBuildingView(0.2, {
			partId = id
		})

		return true
	end

	return false
end

function RoomViewTouch:_click3DCharacter(id)
	local characterMO = RoomCharacterModel.instance:getCharacterMOById(id)

	if not characterMO then
		return false
	end

	if RoomController.instance:isObMode() then
		if RoomCharacterController.instance:isCharacterListShow() then
			local canReplace = RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm)

			if canReplace then
				self._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
					heroId = characterMO.heroId,
					position = characterMO.currentPosition
				})
				RoomCharacterPlaceListModel.instance:setSelect(characterMO.id)
			end

			return canReplace
		elseif self._characterTouchStateMap[self._scene.camera:getCameraState()] then
			RoomCharacterController.instance:dispatchEvent(RoomEvent.ClickCharacterInNormalCamera, characterMO.heroId)

			return true
		end
	elseif RoomController.instance:isVisitMode() and self._characterTouchStateMap[self._scene.camera:getCameraState()] then
		RoomCharacterController.instance:dispatchEvent(RoomEvent.ClickCharacterInNormalCamera, characterMO.heroId)

		return true
	end

	return false
end

function RoomViewTouch:_click3DCritter(id)
	local critterMO = RoomCritterModel.instance:getCritterMOById(id)

	if not critterMO then
		return false
	end

	if (RoomController.instance:isObMode() or RoomController.instance:isVisitMode()) and self._characterTouchStateMap[self._scene.camera:getCameraState()] then
		RoomMap3DClickController.instance:onCritterEntityClick(critterMO)

		return true
	end

	return false
end

function RoomViewTouch:_click3DTransportSite(id)
	if self:_isCanClickBuilding() then
		RoomMap3DClickController.instance:onTransportSiteClick(id)

		return true
	end

	return false
end

function RoomViewTouch:_debugBlockInfo(blockMO)
	if isDebugBuild then
		local leftShift = UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift)

		if (blockMO.blockState == RoomBlockEnum.BlockState.Map or blockMO.blockState == RoomBlockEnum.BlockState.Temp) and leftShift then
			local goPosition = HexMath.hexToPosition(blockMO.hexPoint, RoomBlockEnum.BlockSize)

			goPosition.z = goPosition.y
			goPosition.y = 0

			local cameraPosition = CameraMgr.instance:getMainCameraTrs().position
			local resourceList = blockMO:getResourceList()
			local resourceCenter = blockMO:getResourceCenter()

			logNormal(string.format("当前选中的地块(%d, %d, %d) %d, 资源: %d | %d # %d # %d # %d # %d # %d, 发声位置 : (%s, %s, %s), 摄像机位置 : (%s, %s, %s), 距离摄像机距离 : %s", blockMO.hexPoint.x, blockMO.hexPoint.y, blockMO.id, blockMO.defineId, resourceCenter, resourceList[1], resourceList[2], resourceList[3], resourceList[4], resourceList[5], resourceList[6], goPosition.x, goPosition.y, goPosition.z, cameraPosition.x, cameraPosition.y, cameraPosition.z, Vector3.Distance(goPosition, cameraPosition)))
		end
	end
end

function RoomViewTouch:_onDrag(deltaPos)
	if self._scene.cameraFollow:isFollowing() then
		return
	end

	local rotate = self._scene.camera:getCameraRotate()
	local zoom = self._scene.camera:getCameraZoom()
	local deltaX = deltaPos.x * (zoom / 2 + 1)
	local deltaY = deltaPos.y * (zoom / 2 + 1)

	if not self._scene.fsm:isTransitioning() then
		local combinedX = deltaX * Mathf.Cos(rotate) + deltaY * Mathf.Sin(rotate)
		local combinedY = -deltaX * Mathf.Sin(rotate) + deltaY * Mathf.Cos(rotate)
		local scale = -0.0025 * RoomController.instance.touchMoveSpeed

		self._scene.camera:move(combinedX * scale, combinedY * scale)
	end
end

function RoomViewTouch:_onPressBuilding(pos, buildingUid)
	local cameraState = self._scene.camera:getCameraState()

	if cameraState ~= RoomEnum.CameraState.Overlook then
		return
	end

	RoomBuildingController.instance:pressBuildingUp(pos, buildingUid)
end

function RoomViewTouch:_onDropBuilding(pos)
	local cameraState = self._scene.camera:getCameraState()

	if cameraState ~= RoomEnum.CameraState.Overlook then
		return
	end

	RoomBuildingController.instance:dropBuildingDown(pos)
end

function RoomViewTouch:_onPressCharacter(pos, heroId)
	local cameraState = self._scene.camera:getCameraState()

	if cameraState ~= RoomEnum.CameraState.Character and cameraState ~= RoomEnum.CameraState.Normal then
		return
	end

	RoomCharacterController.instance:pressCharacterUp(pos, heroId)
end

function RoomViewTouch:_onDropCharacter(pos)
	local cameraState = self._scene.camera:getCameraState()

	if cameraState ~= RoomEnum.CameraState.Character then
		return
	end

	RoomCharacterController.instance:dropCharacterDown(pos)
end

function RoomViewTouch:onOpen()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TouchClickScene, self._onClick, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TouchDrag, self._onDrag, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TouchScale, self._onScale, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TouchRotate, self._onRotate, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TouchPressBuilding, self._onPressBuilding, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TouchDropBuilding, self._onDropBuilding, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TouchPressCharacter, self._onPressCharacter, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TouchDropCharacter, self._onDropCharacter, self)
end

function RoomViewTouch:onClose()
	return
end

function RoomViewTouch:_onScale(deltaScale)
	local cameraState = self._scene.camera:getCameraState()

	if not RoomEnum.CameraCanScaleMap[cameraState] then
		return
	end

	if self._scene.fsm:isTransitioning() then
		return
	end

	if deltaScale ~= 0 then
		self._scene.camera:zoom(deltaScale)
	end
end

function RoomViewTouch:_onRotate(deltaRotate)
	if self._scene.fsm:isTransitioning() or self._scene.cameraFollow:isLockRotate() then
		return
	end

	if deltaRotate ~= 0 then
		self._scene.camera:rotate(deltaRotate)
	end
end

function RoomViewTouch:_screenPosToHexPoint(pos)
	local groundPos = self:_screenPosToGroundPos(pos)

	return groundPos and HexMath.positionToRoundHex(groundPos, RoomBlockEnum.BlockSize)
end

function RoomViewTouch:_screenPosToGroundPos(pos)
	local camera = CameraMgr.instance:getMainCamera()
	local scene = GameSceneMgr.instance:getCurScene()
	local camera = scene.camera.camera
	local height = scene.go.planeGO.transform.position.y
	local ray = camera:ScreenPointToRay(pos)

	if ray.direction.y == 0 then
		return nil
	end

	local step = (height - ray.origin.y) / ray.direction.y

	if step > 1000 or step < 0 then
		return nil
	end

	local worldPos = Vector2(ray.origin.x + ray.direction.x * step, ray.origin.z + ray.direction.z * step)
	local scale = scene.go.groundGO.transform.localScale

	if scale.x == 0 or scale.y == 0 then
		return nil
	end

	return (Vector2(worldPos.x / scale.x, worldPos.y / scale.z))
end

function RoomViewTouch:onDestroyView()
	return
end

return RoomViewTouch
