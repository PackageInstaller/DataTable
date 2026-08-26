-- chunkname: @modules/logic/room/controller/RoomCharacterController.lua

module("modules.logic.room.controller.RoomCharacterController", package.seeall)

local RoomCharacterController = class("RoomCharacterController", BaseController)

function RoomCharacterController:onInit()
	self:clear()
end

function RoomCharacterController:reInit()
	self:clear()
end

function RoomCharacterController:clear()
	TaskDispatcher.cancelTask(self._refreshNextCharacterFaithUpdate, self)

	self._isCharacterListShow = false
	self._characterFocus = RoomCharacterEnum.CameraFocus.Normal
	self._lastCameraState = nil
	self._playingInteractionParam = nil
	self._dialogNextTime = nil
	self._lastSendgainCharacterFaithHeroId = nil
end

function RoomCharacterController:addConstEvents()
	return
end

function RoomCharacterController:init()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshRelateDot, self)
end

function RoomCharacterController:setCharacterFocus(characterFocus)
	self._characterFocus = characterFocus or RoomCharacterEnum.CameraFocus.Normal
end

function RoomCharacterController:getCharacterFocus()
	return self._characterFocus
end

function RoomCharacterController:setCharacterListShow(isShow)
	self._isCharacterListShow = isShow

	local scene = GameSceneMgr.instance:getCurScene()
	local cameraState = scene.camera:getCameraState()

	if cameraState ~= RoomEnum.CameraState.Character then
		self._lastCameraState = cameraState
	end

	if isShow then
		scene.camera:switchCameraState(RoomEnum.CameraState.Character, {})
	elseif cameraState == RoomEnum.CameraState.Character then
		scene.camera:switchCameraState(self._lastCameraState or RoomEnum.CameraState.Overlook, {})

		if self._lastCameraState == RoomEnum.CameraState.Normal then
			self:tryPlayAllSpecialIdle()
		end
	end

	if isShow then
		if UIBlockMgrExtend.needCircleMv then
			UIBlockMgrExtend.setNeedCircleMv(false)
		end

		ViewMgr.instance:openView(ViewName.RoomCharacterPlaceView)

		local characterMOList = RoomCharacterModel.instance:getList()

		for i, characterMO in ipairs(characterMOList) do
			scene.character:setCharacterAnimal(characterMO.heroId, false)
			scene.character:setCharacterTouch(characterMO.heroId, false)

			if characterMO:getMoveState() == RoomCharacterEnum.CharacterMoveState.Move then
				local nearestPoint = characterMO:getNearestPoint()

				characterMO:endMove()
				characterMO:setPosition(RoomCharacterHelper.getCharacterPosition3D(nearestPoint, true))
			end
		end
	else
		ViewMgr.instance:closeView(ViewName.RoomCharacterPlaceView)
	end

	self:dispatchEvent(RoomEvent.CharacterListShowChanged, isShow)
	self:dispatchEvent(RoomEvent.RefreshSpineShow)

	if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
		scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceCharacter)
	end
end

function RoomCharacterController:isCharacterListShow()
	return self._isCharacterListShow
end

function RoomCharacterController:tryCorrectAllCharacter(useRandomPoint)
	local roomCharacterMOList = RoomCharacterModel.instance:getList()

	if useRandomPoint == true then
		self:_tryRandomByCharacterList(roomCharacterMOList)

		for _, roomCharacterMO in ipairs(roomCharacterMOList) do
			self:interruptInteraction(roomCharacterMO:getCurrentInteractionId())
		end

		return
	end

	local roomCharacterMOList = RoomCharacterModel.instance:getList()
	local randomCharacterMOList

	for _, roomCharacterMO in ipairs(roomCharacterMOList) do
		local currentPosition = roomCharacterMO.currentPosition

		if not RoomCharacterHelper.canConfirmPlace(roomCharacterMO.heroId, currentPosition, roomCharacterMO.skinId, nil) then
			local nearPosition = RoomCharacterHelper.getRandomPosition() or roomCharacterMO.currentPosition
			local bestParam = RoomCharacterHelper.getRecommendHexPoint(roomCharacterMO.heroId, roomCharacterMO.skinId, Vector2.New(nearPosition.x, nearPosition.z))

			if bestParam then
				self:moveCharacterTo(roomCharacterMO, bestParam.position, false)
			else
				randomCharacterMOList = roomCharacterMOList or {}

				table.insert(randomCharacterMOList, roomCharacterMO)
			end

			self:interruptInteraction(roomCharacterMO:getCurrentInteractionId())
		end
	end

	if randomCharacterMOList then
		self:_tryRandomByCharacterList(roomCharacterMOList)
	end
end

function RoomCharacterController:checkCharacterMax()
	local maxCharacterCount = RoomCharacterModel.instance:getMaxCharacterCount()
	local placeCount = RoomCharacterModel.instance:getPlaceCount()

	if maxCharacterCount < placeCount then
		local roomCharacterMOList = {}

		tabletool.tabletool.addValues(roomCharacterMOList, RoomCharacterModel.instance:getList())

		local scene = GameSceneMgr.instance:getCurScene()

		self:_randomArray(roomCharacterMOList)

		local roomHeroIds = {}

		for _, roomCharacterMO in ipairs(roomCharacterMOList) do
			if roomCharacterMO:isPlaceSourceState() then
				if maxCharacterCount > #roomHeroIds then
					table.insert(roomHeroIds, roomCharacterMO.heroId)
				else
					local entity = scene.charactermgr:getCharacterEntity(roomCharacterMO.id)

					if entity then
						scene.charactermgr:destroyCharacter(entity)
					end

					RoomCharacterModel.instance:deleteCharacterMO(roomCharacterMO.heroId)
				end
			end
		end

		RoomRpc.instance:sendUpdateRoomHeroDataRequest(roomHeroIds)
	end
end

function RoomCharacterController:_findPlaceBlockMOList()
	local mapBlockMOList = RoomMapBlockModel.instance:getFullBlockMOList()
	local tRoomMapBuildingModel = RoomMapBuildingModel.instance
	local placeBlockMOList = {}

	for i = 1, #mapBlockMOList do
		local blockMO = mapBlockMOList[i]

		if not tRoomMapBuildingModel:getBuildingParam(blockMO.hexPoint.x, blockMO.hexPoint.y) and not RoomBuildingHelper.isInInitBlock(blockMO.hexPoint) then
			table.insert(placeBlockMOList, blockMO)
		end
	end

	return placeBlockMOList
end

function RoomCharacterController:_randomArray(array)
	RoomHelper.randomArray(array)
end

function RoomCharacterController:_getRandomResDirectionArray()
	self._randomResDirectionList = self._randomResDirectionList or {
		0,
		1,
		2,
		3,
		4,
		5,
		6
	}

	self:_randomArray(self._randomResDirectionList)

	return self._randomResDirectionList
end

function RoomCharacterController:_randomDirectionByBlockMO(characterMO, blockMO)
	local defineCfg = blockMO and blockMO:getBlockDefineCfg()

	if defineCfg then
		local resDirectionList = self:_getRandomResDirectionArray()
		local resId, direction

		for i = 1, #resDirectionList do
			if characterMO:isCanPlaceByResId(defineCfg.resourceIds[resDirectionList[i]]) then
				return RoomRotateHelper.rotateDirection(resDirectionList[i], -blockMO:getRotate())
			end
		end
	end

	return nil
end

function RoomCharacterController:tryRandomByCharacterList(roomCharacterMOList)
	self:_tryRandomByCharacterList(roomCharacterMOList)
end

function RoomCharacterController:_tryRandomByCharacterList(roomCharacterMOList)
	local blockMOList = self:_findPlaceBlockMOList()

	self:_randomArray(blockMOList)

	local count = #blockMOList
	local nextIndex = 1
	local notPlaceCharacterMOList

	RoomHelper.logEnd("RoomCharacterController:_tryRandomByCharacterList(roomCharacterMOList) start")

	for _, roomCharacterMO in ipairs(roomCharacterMOList) do
		local isNotPlace = true

		for i = nextIndex, count do
			local blockMO = blockMOList[i]
			local dire = self:_randomDirectionByBlockMO(roomCharacterMO, blockMO)

			if dire then
				local resourcePoint = ResourcePoint(blockMO.hexPoint, dire)
				local position = RoomCharacterHelper.getCharacterPosition3D(resourcePoint)
				local bestParam = RoomCharacterHelper.getRecommendHexPoint(roomCharacterMO.heroId, roomCharacterMO.skinId, Vector2.New(position.x, position.z))

				RoomHelper.logEnd(roomCharacterMO.heroConfig.name)

				if bestParam then
					blockMOList[i] = blockMOList[nextIndex]
					blockMOList[nextIndex] = blockMO
					nextIndex = nextIndex + 1

					self:moveCharacterTo(roomCharacterMO, (bestParam or nil) and (bestParam.position or position), false)

					isNotPlace = false

					break
				end
			end
		end

		if isNotPlace then
			notPlaceCharacterMOList = notPlaceCharacterMOList or {}

			table.insert(notPlaceCharacterMOList, roomCharacterMO)
		end
	end

	RoomHelper.logEnd("RoomCharacterController:_tryRandomByCharacterList(roomCharacterMOList) end")

	if notPlaceCharacterMOList then
		local posCfgList = {}

		tabletool.addValues(posCfgList, RoomConfig.instance:getBlockPlacePositionCfgList())
		self:_randomArray(posCfgList)

		if #notPlaceCharacterMOList > #posCfgList then
			logError("export_初始坐标[\"block_place_position\"] 坐标数量不足")
		end

		for i = 1, #notPlaceCharacterMOList do
			local posCfg = posCfgList[i]

			if posCfg then
				self:moveCharacterTo(notPlaceCharacterMOList[i], Vector3(posCfg.x * 0.001, posCfg.y * 0.001, posCfg.z * 0.001), false)
			end
		end
	end
end

function RoomCharacterController:moveCharacterTo(roomCharacterMO, position, height)
	local scene = GameSceneMgr.instance:getCurScene()
	local entity = scene.charactermgr:getCharacterEntity(roomCharacterMO.id)

	if entity then
		if height then
			position = RoomCharacterHelper.reCalculateHeight(position)
		end

		scene.charactermgr:moveTo(entity, position)
	end

	RoomCharacterModel.instance:resetCharacterMO(roomCharacterMO.heroId, position)
end

function RoomCharacterController:tryMoveCharacterAfterRotateCamera()
	local roomCharacterMOList = RoomCharacterModel.instance:getList()

	for _, roomCharacterMO in ipairs(roomCharacterMOList) do
		if roomCharacterMO:getMoveState() == RoomCharacterEnum.CharacterMoveState.Move then
			local remainMovePositions = roomCharacterMO:getRemainMovePositions()

			if not RoomCharacterHelper.isMoveCameraWalkable(remainMovePositions) then
				roomCharacterMO:endMove(true)
				roomCharacterMO:moveNeighbor()
			end
		end
	end
end

function RoomCharacterController:correctAllCharacterHeight()
	local roomCharacterMOList = RoomCharacterModel.instance:getList()

	for _, roomCharacterMO in ipairs(roomCharacterMOList) do
		self:correctCharacterHeight(roomCharacterMO)
	end
end

function RoomCharacterController:correctCharacterHeight(roomCharacterMO)
	local isFreeze = roomCharacterMO:getIsFreeze()

	if roomCharacterMO:getMoveState() == RoomCharacterEnum.CharacterMoveState.Move or isFreeze then
		return
	end

	local currentPosition = roomCharacterMO.currentPosition
	local worldX = currentPosition.x
	local worldZ = currentPosition.z
	local height = RoomCharacterHelper.getLandHeightByRaycast(currentPosition)

	roomCharacterMO:setPositionXYZ(worldX, height, worldZ)
end

function RoomCharacterController:checkCanSpineShow(cameraState)
	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		return false
	end

	if self:isCharacterListShow() then
		return true
	end

	return RoomEnum.CameraShowSpineMap[cameraState]
end

function RoomCharacterController:pressCharacterUp(pos, heroId)
	if heroId then
		self._pressHeroId = heroId
	end

	if not self._pressHeroId then
		return
	end

	if not self:isCharacterListShow() then
		self:setCharacterListShow(true)
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local entity = scene.charactermgr:getCharacterEntity(self._pressHeroId, SceneTag.RoomCharacter)

	if not entity then
		return
	end

	if heroId then
		local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

		if not tempCharacterMO or tempCharacterMO.id ~= heroId then
			local characterMO = RoomCharacterModel.instance:getCharacterMOById(heroId)

			scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, {
				press = true,
				heroId = heroId,
				position = characterMO.currentPosition
			})
		end

		entity:tweenUp()
		RoomCharacterPlaceListModel.instance:setSelect(heroId)
	end

	local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

	self._pressCharacterHexPoint = self._pressCharacterHexPoint or tempCharacterMO:getMoveTargetPoint().hexPoint

	local pressCharacterHexPoint = RoomBendingHelper.screenPosToHex(pos)

	if not pressCharacterHexPoint then
		return
	end

	self._pressCharacterHexPoint = pressCharacterHexPoint

	local worldPos = RoomBendingHelper.screenToWorld(pos)

	if worldPos then
		local worldX = worldPos.x
		local worldZ = worldPos.y
		local height = RoomCharacterHelper.getLandHeightByRaycast(Vector3(worldX, 0, worldZ))

		tempCharacterMO:setPositionXYZ(worldX, height, worldZ)
		entity:setLocalPos(worldX, height, worldZ, true)
	end

	self:dispatchEvent(RoomEvent.PressCharacterUp)
end

function RoomCharacterController:getPressCharacterHexPoint()
	return self._pressCharacterHexPoint
end

function RoomCharacterController:dropCharacterDown(pos)
	if not self._pressHeroId then
		return
	end

	local characterMO = RoomCharacterModel.instance:getCharacterMOById(self._pressHeroId)
	local position
	local worldPos = pos and RoomBendingHelper.screenToWorld(pos)
	local bestParam = worldPos and RoomCharacterHelper.getRecommendHexPoint(self._pressHeroId, characterMO.skinId, Vector2(worldPos.x, worldPos.y))

	if bestParam then
		position = bestParam.position
	end

	position = position or characterMO.currentPosition

	local scene = GameSceneMgr.instance:getCurScene()
	local param = {
		isPressing = true,
		position = position
	}

	self:cancelPressCharacter()
	scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceCharacter, param)
end

function RoomCharacterController:cancelPressCharacter()
	if not self._pressHeroId then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local entity = scene.charactermgr:getCharacterEntity(self._pressHeroId, SceneTag.RoomCharacter)

	if not entity then
		return
	end

	self._pressHeroId = nil
	self._pressCharacterHexPoint = nil

	entity:tweenDown()
	self:dispatchEvent(RoomEvent.DropCharacterDown)
end

function RoomCharacterController:isPressCharacter()
	return self._pressHeroId
end

function RoomCharacterController:updateCharacterFaith(roomHeroDatas)
	TaskDispatcher.cancelTask(self._refreshNextCharacterFaithUpdate, self)

	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType ~= SceneType.Room then
		return
	end

	if not RoomController.instance:isObMode() then
		return
	end

	RoomCharacterModel.instance:updateCharacterFaith(roomHeroDatas)
	self:dispatchEvent(RoomEvent.RefreshFaithShow)
	self:refreshCharacterFaithTimer()
end

function RoomCharacterController:playCharacterFaithEffect(roomHeroDatas)
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType ~= SceneType.Room then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()

	if not RoomController.instance:isObMode() then
		return
	end

	for i, roomHeroData in ipairs(roomHeroDatas) do
		local heroId = roomHeroData.heroId
		local entity = scene.charactermgr:getCharacterEntity(heroId, SceneTag.RoomCharacter)

		if entity then
			entity:playFaithEffect()
		end
	end
end

function RoomCharacterController:refreshCharacterFaithTimer()
	TaskDispatcher.cancelTask(self._refreshNextCharacterFaithUpdate, self)

	local minTime
	local roomCharacterMOList = RoomCharacterModel.instance:getList()

	for i, roomCharacterMO in ipairs(roomCharacterMOList) do
		local nextRefreshTime = roomCharacterMO.nextRefreshTime

		if nextRefreshTime and nextRefreshTime > 0 and (not minTime or nextRefreshTime < minTime) then
			minTime = nextRefreshTime
		end
	end

	if minTime and minTime > 0 then
		local nowTime = ServerTime.now()
		local delayTime = minTime - nowTime

		delayTime = math.max(1, delayTime) + 0.5

		TaskDispatcher.runDelay(self._refreshNextCharacterFaithUpdate, self, delayTime)
	end
end

function RoomCharacterController:_refreshNextCharacterFaithUpdate()
	local heroIds = {}
	local roomCharacterMOList = RoomCharacterModel.instance:getList()

	for i, roomCharacterMO in ipairs(roomCharacterMOList) do
		table.insert(heroIds, roomCharacterMO.heroId)
	end

	RoomRpc.instance:sendGetRoomObInfoRequest(false, self._getRoomObInfoReply, self)
end

function RoomCharacterController:_getRoomObInfoReply(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:updateCharacterFaith(msg.roomHeroDatas)
end

function RoomCharacterController:gainCharacterFaith(heroIds, callback, callbackObj)
	RoomRpc.instance:sendGainRoomHeroFaithRequest(heroIds, callback, callbackObj)
end

function RoomCharacterController:findGainMaxFaithHeroId()
	local maxFaithHeroId
	local maxFiathValue = -1
	local roomCharacterMOList = RoomCharacterModel.instance:getList()

	for i, roomCharacterMO in ipairs(roomCharacterMOList) do
		local heroMO = HeroModel.instance:getByHeroId(roomCharacterMO.heroId)

		if heroMO and roomCharacterMO.currentFaith > 0 then
			local tempFaith = roomCharacterMO.currentFaith + heroMO.faith

			if maxFiathValue < tempFaith then
				maxFiathValue = tempFaith
				maxFaithHeroId = roomCharacterMO.heroId
			end
		end
	end

	return maxFaithHeroId
end

function RoomCharacterController:gainAllCharacterFaith(callback, callbackObj, firstHeroId)
	local heroIds = {}
	local roomCharacterMOList = RoomCharacterModel.instance:getList()

	for i, roomCharacterMO in ipairs(roomCharacterMOList) do
		if roomCharacterMO.currentFaith > 0 then
			table.insert(heroIds, roomCharacterMO.heroId)
		end
	end

	if #heroIds > 0 then
		local indexOf = tabletool.indexOf(heroIds, firstHeroId)

		if indexOf == nil then
			firstHeroId = self:findGainMaxFaithHeroId()
			indexOf = tabletool.indexOf(heroIds, firstHeroId)
		end

		if indexOf then
			heroIds[indexOf] = heroIds[1]
			heroIds[1] = firstHeroId
		end

		self._lastSendgainCharacterFaithHeroId = firstHeroId

		self:gainCharacterFaith(heroIds, callback, callbackObj)
	end
end

function RoomCharacterController:tweenCameraFocusCharacter(heroId, cameraState)
	local roomCharacterMO = RoomCharacterModel.instance:getById(heroId)

	if not roomCharacterMO then
		return
	end

	cameraState = cameraState or RoomEnum.CameraState.Overlook

	local scene = GameSceneMgr.instance:getCurScene()
	local currentPosition = roomCharacterMO.currentPosition

	scene.camera:switchCameraState(cameraState, {
		focusX = currentPosition.x,
		focusY = currentPosition.z
	})
end

function RoomCharacterController:isCharacterFaithFull(heroId)
	local heroMO = HeroModel.instance:getByHeroId(heroId)

	if not heroMO then
		return false
	end

	local faith = heroMO.faith
	local percent = HeroConfig.instance:getFaithPercent(faith)[1]

	return percent >= 1
end

function RoomCharacterController:hideCharacterFaithFull(heroId)
	RoomCharacterModel.instance:setHideFaithFull(heroId, true)
	self:dispatchEvent(RoomEvent.RefreshFaithShow)
end

function RoomCharacterController:setCharacterFullFaithChecked(heroId)
	RedDotRpc.instance:sendShowRedDotRequest(RedDotEnum.DotNode.RoomCharacterFaithFull, false)
end

function RoomCharacterController:_refreshRelateDot(dict)
	for id, _ in pairs(dict) do
		if id == RedDotEnum.DotNode.RoomCharacterFaithFull then
			self:dispatchEvent(RoomEvent.RefreshFaithShow)

			return
		end
	end
end

function RoomCharacterController:showGainFaithToast(materialDataMOList)
	local filterList = {}
	local lastSendMO

	for i, materialDataMO in ipairs(materialDataMOList) do
		if materialDataMO.materilType == MaterialEnum.MaterialType.Faith then
			if self._lastSendgainCharacterFaithHeroId == materialDataMO.materilId then
				self._lastSendgainCharacterFaithHeroId = nil
				lastSendMO = materialDataMO
			end

			table.insert(filterList, materialDataMO)
		end
	end

	local count = #filterList

	if count <= 0 then
		return
	end

	local mo = lastSendMO or filterList[1]
	local heroMO = HeroModel.instance:getByHeroId(mo.materilId)

	if not heroMO then
		return
	end

	if count > 1 then
		GameFacade.showToast(RoomEnum.Toast.GainFaithMultipleCharacter, heroMO.config.name)
	else
		local percent = HeroConfig.instance:getFaithPercent(heroMO.faith)[1]

		GameFacade.showToast(RoomEnum.Toast.GainFaithSingleCharacter, heroMO.config.name, percent * 100)
	end

	for i, mo in ipairs(filterList) do
		local heroMO = HeroModel.instance:getByHeroId(mo.materilId)

		if heroMO then
			local percent = HeroConfig.instance:getFaithPercent(heroMO.faith)[1]

			if percent >= 1 then
				GameFacade.showToast(RoomEnum.Toast.GainFaithFull)

				return
			end
		end
	end
end

function RoomCharacterController:interruptInteraction(interactionId)
	if not interactionId then
		return
	end

	local config = RoomConfig.instance:getCharacterInteractionConfig(interactionId)

	if config.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(config.heroId)

		if roomCharacterMO then
			roomCharacterMO:setCurrentInteractionId(nil)
		end

		local relateRoomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(config.relateHeroId)

		if relateRoomCharacterMO then
			relateRoomCharacterMO:setCurrentInteractionId(nil)
		end
	elseif config.behaviour == RoomCharacterEnum.InteractionType.Building then
		-- block empty
	end

	self:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)
end

function RoomCharacterController:startInteraction(currentInteractionId, getReward, getFaith)
	if not currentInteractionId then
		return
	end

	self._interactionGetReward = getReward
	self._interactionGetFaith = getFaith

	if not self._interactionGetReward or RoomModel.instance:getInteractionState(currentInteractionId) == RoomCharacterEnum.InteractionState.Start then
		self:_onRealStartInteraction(currentInteractionId)
	else
		RoomRpc.instance:sendStartCharacterInteractionRequest(currentInteractionId, self._onStartInteraction, self)
	end
end

function RoomCharacterController:_onStartInteraction(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:_onRealStartInteraction(msg.id)
end

function RoomCharacterController:_onRealStartInteraction(id)
	local config = RoomConfig.instance:getCharacterInteractionConfig(id)

	if config.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		self:startDialogInteraction(config)
	else
		self._playingInteractionParam = {}
	end

	self:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)
end

function RoomCharacterController:startDialogInteraction(config, buildingUid)
	self._playingInteractionParam = {
		stepId = 0,
		id = config.id,
		behaviour = config.behaviour,
		dialogId = config.dialogId,
		heroId = config.heroId,
		relateHeroId = config.relateHeroId,
		selectIds = {},
		buildingUid = buildingUid,
		positionList = {}
	}

	if config.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		self:tweenDialogCamera(config)
	end
end

function RoomCharacterController:startDialogTrainCritter(config, critterUid, heroId)
	self._playingInteractionParam = {
		stepId = 0,
		id = config.id,
		behaviour = config.behaviour,
		dialogId = config.dialogId,
		heroId = config.heroId,
		relateHeroId = config.relateHeroId,
		selectIds = {},
		positionList = {},
		critterUid = critterUid
	}

	self:nextDialogInteraction()
end

function RoomCharacterController:tweenDialogCamera(config)
	local scene = GameSceneMgr.instance:getCurScene()
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(config.heroId)

	roomCharacterMO:endMove(true)

	local pos = roomCharacterMO.currentPosition

	table.insert(self._playingInteractionParam.positionList, pos)

	if config.relateHeroId == 0 then
		local cameraParam = {
			zoom = 0.2,
			focusX = pos.x,
			focusY = pos.z
		}

		scene.camera:switchCameraState(RoomEnum.CameraState.Normal, cameraParam, nil, self.interactionCameraDone, self)

		self._playingInteractionParam.cameraParam = cameraParam

		return
	end

	local relateRoomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(config.relateHeroId)

	relateRoomCharacterMO:endMove(true)

	local relatePos = relateRoomCharacterMO.currentPosition

	table.insert(self._playingInteractionParam.positionList, relatePos)

	local center = (pos + relatePos) / 2
	local target = Vector3.Normalize(relatePos - pos)
	local rotate = math.acos(Vector3.Dot(target, Vector3.forward))

	if target.x < 0 then
		rotate = RoomRotateHelper.getMod(math.pi * 2 - rotate, math.pi * 2)
	end

	local rotate1 = RoomRotateHelper.getMod(rotate + math.pi / 2, math.pi * 2)
	local rotate2 = RoomRotateHelper.getMod(rotate - math.pi / 2, math.pi * 2)
	local currentRotate = RoomRotateHelper.getMod(scene.camera:getCameraRotate(), math.pi * 2)
	local rotateOffset1 = math.min(math.abs(rotate1 - currentRotate), math.pi * 2 - math.abs(rotate1 - currentRotate))
	local rotateOffset2 = math.min(math.abs(rotate2 - currentRotate), math.pi * 2 - math.abs(rotate2 - currentRotate))

	if rotateOffset2 < rotateOffset1 then
		if not SpineLookDir.Left then
			local lookDir = SpineLookDir.Right
			local entity = scene.charactermgr:getCharacterEntity(roomCharacterMO.id, SceneTag.RoomCharacter)

			if entity and entity.charactermove then
				entity.charactermove:forcePositionAndLookDir(nil, -lookDir, nil)
			end

			local relateEntity = scene.charactermgr:getCharacterEntity(relateRoomCharacterMO.id, SceneTag.RoomCharacter)

			if relateEntity and relateEntity.charactermove then
				relateEntity.charactermove:forcePositionAndLookDir(nil, lookDir, nil)
			end

			local cameraParam = {
				zoom = 0.2,
				focusX = center.x,
				focusY = center.z,
				rotate = (lookDir == SpineLookDir.Left or nil) and rotate2
			}

			scene.camera:switchCameraState(RoomEnum.CameraState.Normal, cameraParam, nil, self.interactionCameraDone, self)

			self._playingInteractionParam.cameraParam = cameraParam
		end
	end
end

function RoomCharacterController:trynextDialogInteraction()
	if self._dialogNextTime and self._dialogNextTime > Time.time then
		return
	end

	self._dialogNextTime = Time.time + RoomCharacterEnum.DialogClickCDTime

	self:nextDialogInteraction()
end

function RoomCharacterController:interactionCameraDone()
	self:nextDialogInteraction()

	local scene = GameSceneMgr.instance:getCurScene()
end

function RoomCharacterController:nextDialogInteraction(selectIndex)
	if not self._playingInteractionParam or self._playingInteractionParam.behaviour ~= RoomCharacterEnum.InteractionType.Dialog then
		return
	end

	local preDialogConfig = RoomConfig.instance:getCharacterDialogConfig(self._playingInteractionParam.dialogId, self._playingInteractionParam.stepId)

	if not selectIndex and preDialogConfig and not string.nilorempty(preDialogConfig.selectIds) then
		self._playingInteractionParam.selectParam = GameUtil.splitString2(preDialogConfig.selectIds, true)

		self:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)

		if not ViewMgr.instance:isOpen(ViewName.RoomBranchView) then
			ViewMgr.instance:openView(ViewName.RoomBranchView)
		end

		return
	end

	if selectIndex and self._playingInteractionParam.selectParam then
		local selectId = self._playingInteractionParam.selectParam[selectIndex][1]

		self._playingInteractionParam.stepId = self._playingInteractionParam.selectParam[selectIndex][2]
		self._playingInteractionParam.selectParam = nil

		table.insert(self._playingInteractionParam.selectIds, selectId)
	else
		self._playingInteractionParam.stepId = preDialogConfig and not string.nilorempty(preDialogConfig.nextStepId) and tonumber(preDialogConfig.nextStepId) or self._playingInteractionParam.stepId + 1
	end

	local dialogConfig = RoomConfig.instance:getCharacterDialogConfig(self._playingInteractionParam.dialogId, self._playingInteractionParam.stepId)

	if not dialogConfig then
		self:finishInteraction()
	else
		self:dispatchEvent(RoomEvent.UpdateCharacterInteractionUI)

		if not ViewMgr.instance:isOpen(ViewName.RoomBranchView) then
			ViewMgr.instance:openView(ViewName.RoomBranchView)
		end
	end
end

function RoomCharacterController:finishInteraction()
	ViewMgr.instance:closeView(ViewName.RoomBranchView)

	if not self._playingInteractionParam then
		return
	end

	if self._interactionGetReward then
		self._interactionGetReward = false

		RoomRpc.instance:sendGetCharacterInteractionBonusRequest(self._playingInteractionParam.id, self._playingInteractionParam.selectIds)
	end

	if self._interactionGetFaith then
		self._interactionGetFaith = false

		RoomCharacterController.instance:gainAllCharacterFaith(nil, nil, self._playingInteractionParam.heroId)
	end

	local critterUid = self._playingInteractionParam.critterUid

	if critterUid then
		CritterController.instance:finishTrainSpecialEventByUid(critterUid)
	end

	self:endInteraction()
end

function RoomCharacterController:endInteraction()
	if not self._playingInteractionParam then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local currentInteractionId = self._playingInteractionParam.id

	self._playingInteractionParam = nil
	self._dialogNextTime = nil

	self:interruptInteraction(currentInteractionId)

	local config = RoomConfig.instance:getCharacterInteractionConfig(currentInteractionId)

	if config.behaviour == RoomCharacterEnum.InteractionType.Dialog then
		local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(config.heroId)

		if roomCharacterMO then
			roomCharacterMO:setCurrentInteractionId(nil)

			local entity = scene.charactermgr:getCharacterEntity(roomCharacterMO.id, SceneTag.RoomCharacter)

			if entity and entity.charactermove then
				entity.charactermove:clearForcePositionAndLookDir()
			end
		end

		local relateRoomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(config.relateHeroId)

		if relateRoomCharacterMO then
			relateRoomCharacterMO:setCurrentInteractionId(nil)

			local relateEntity = scene.charactermgr:getCharacterEntity(relateRoomCharacterMO.id, SceneTag.RoomCharacter)

			if relateEntity and relateEntity.charactermove then
				relateEntity.charactermove:clearForcePositionAndLookDir()
			end
		end
	end
end

function RoomCharacterController:getPlayingInteractionParam()
	return self._playingInteractionParam
end

function RoomCharacterController:tryPlayAllSpecialIdle()
	local roomCharacterMOList = RoomCharacterModel.instance:getList()

	for i, roomCharacterMO in ipairs(roomCharacterMOList) do
		self:tryPlaySpecialIdle(roomCharacterMO.id)
	end
end

function RoomCharacterController:tryPlaySpecialIdle(heroId)
	local scene = GameSceneMgr.instance:getCurScene()
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(heroId)

	if not roomCharacterMO then
		return
	end

	local entity = scene.charactermgr:getCharacterEntity(heroId)

	if not entity then
		return
	end

	if entity.characterspine:isRandomSpecialRate() then
		entity.characterspine:tryPlaySpecialIdle()

		roomCharacterMO.stateDuration = -5
	end
end

function RoomCharacterController:tweenCameraFocus(worldX, worldZ, characterFocus, callback, obj)
	local sceneType = GameSceneMgr.instance:getCurSceneType()
	local scene = GameSceneMgr.instance:getCurScene()

	if sceneType ~= SceneType.Room or not scene or not scene.camera then
		return
	end

	if RoomCharacterEnum.CameraFocus.MoreShowList == characterFocus then
		local width = UnityEngine.Screen.width
		local height = UnityEngine.Screen.height
		local scenePos = Vector2(width * 0.5, height * 0.7)
		local wordldPos = RoomBendingHelper.screenToWorld(scenePos)
		local centerPos = RoomBendingHelper.screenToWorld(Vector2(width * 0.5, height * 0.5))

		if wordldPos and centerPos then
			local deltaX = wordldPos.x - centerPos.x
			local deltaY = wordldPos.y - centerPos.y

			worldX = worldX - deltaX
			worldZ = worldZ - deltaY
		end
	end

	local cameraParam = {
		focusX = worldX,
		focusY = worldZ
	}

	scene.camera:tweenCamera(cameraParam, nil, callback, obj)
end

function RoomCharacterController:setFilterOnBirthday(isFilter)
	if isFilter then
		local hasOnBirthdayHero = RoomCharacterPlaceListModel.instance:hasHeroOnBirthday()

		if not hasOnBirthdayHero then
			GameFacade.showToast(ToastEnum.NoCharacterOnBirthday)

			return false
		end
	end

	RoomCharacterPlaceListModel.instance:setIsFilterOnBirthday(isFilter)
	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()

	return true
end

function RoomCharacterController:onCloseRoomCharacterPlaceView()
	RoomCharacterPlaceListModel.instance:setIsFilterOnBirthday()
end

RoomCharacterController.instance = RoomCharacterController.New()

return RoomCharacterController
