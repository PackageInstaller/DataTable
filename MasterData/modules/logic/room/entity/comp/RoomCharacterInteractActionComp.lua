-- chunkname: @modules/logic/room/entity/comp/RoomCharacterInteractActionComp.lua

module("modules.logic.room.entity.comp.RoomCharacterInteractActionComp", package.seeall)

local RoomCharacterInteractActionComp = class("RoomCharacterInteractActionComp", LuaCompBase)

function RoomCharacterInteractActionComp:ctor(entity)
	self.entity = entity
	self._scene = RoomCameraController.instance:getRoomScene()
	self._followPathData = RoomVehicleFollowPathData.New(3)
	self._roomVectorPool = RoomVectorPool.instance
end

function RoomCharacterInteractActionComp:init(go)
	self.go = go
	self._scene = RoomCameraController.instance:getRoomScene()
end

function RoomCharacterInteractActionComp:addEventListeners()
	return
end

function RoomCharacterInteractActionComp:removeEventListeners()
	return
end

function RoomCharacterInteractActionComp:beforeDestroy()
	self:removeEventListeners()
	self:endIneract()
end

function RoomCharacterInteractActionComp:startMove()
	return
end

function RoomCharacterInteractActionComp:_findPath(fromPosition, toPosition, moveToHeroPointName)
	self._moveToHeroPointName = moveToHeroPointName

	local seeker = self.entity.charactermove:getSeeker()

	if ZProj.AStarPathBridge.HasPossiblePath(fromPosition, toPosition, seeker:GetTag()) then
		self._scene.path:tryGetPath(self.entity:getMO(), fromPosition, toPosition, self._onPathCall, self)

		return
	else
		self:_tryPlacePointByName(self._moveToHeroPointName)
	end
end

function RoomCharacterInteractActionComp:_onPathCall(param, pathList, isError, errorMsg)
	if not isError then
		local list = self._roomVectorPool:packPosList(pathList)

		self:_setPathDataPosList(list)
	else
		self:_setPathDataPosList(nil)
		logNormal("Room pathfinding Error : " .. tostring(errorMsg))
	end

	if self._followPathData:getPosCount() > 0 then
		local characterMO = self.entity:getMO()
		local moveSpeed = characterMO:getMoveSpeed() * 0.2

		self:_killTween()

		local durtionTime = self._followPathData:getPathDistance() / moveSpeed

		self._moveFromPosition = self._followPathData:getFirstPos()
		self._tweenMoveId = self._scene.tween:tweenFloat(0, 1, durtionTime, self._frameMoveCallback, self._finishMoveCallback, self)

		self:_clearResetXYZ()
	else
		self:_tryPlacePointByName(self._moveToHeroPointName)
	end
end

function RoomCharacterInteractActionComp:_setPathDataPosList(posList)
	if self._followPathData:getPosCount() > 0 then
		local pathPosList = self._followPathData._pathPosList

		for i, pos in ipairs(pathPosList) do
			self._roomVectorPool:recycle(pos)
		end

		self._followPathData:clear()
	end

	if posList and #posList > 0 then
		for i = #posList, 1, -1 do
			self._followPathData:addPathPos(posList[i])
		end
	end
end

function RoomCharacterInteractActionComp:_killTween()
	if self._tweenMoveId then
		self._scene.tween:killById(self._tweenMoveId)

		self._tweenMoveId = nil
	end
end

function RoomCharacterInteractActionComp:_framePointCallback(value, param)
	local pointTrs = self._buildingEntity.interactComp:getPointGOTrsByName(self._interactHeroPointName)

	if not pointTrs then
		return
	end

	self._isUpdatePointPiont = true

	local tx, ty, tz = transformhelper.getPos(pointTrs)

	self.entity:setLocalPos(tx, ty, tz)
end

function RoomCharacterInteractActionComp:_frameMoveCallback(value, param)
	local distance = self._followPathData:getPathDistance() * value
	local pos = self._followPathData:getPosByDistance(distance)
	local fromPosition = self._moveFromPosition

	self._moveFromPosition = pos

	self.entity.charactermove:forcePositionAndLookDir(pos, self.entity.charactermove:getMoveToLookDirByPos(fromPosition, pos), RoomCharacterEnum.CharacterMoveState.Move)
	self:_setMOPosXYZ(pos.x, pos.y, pos.z)
	self.entity.characterspine:resetPhysics()
end

function RoomCharacterInteractActionComp:_finishMoveCallback(value, param)
	self.entity.charactermove:clearForcePositionAndLookDir()
	self.entity.characterspine:changeMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
end

function RoomCharacterInteractActionComp:_finishCallback(value, param)
	return
end

function RoomCharacterInteractActionComp:startInteract(buildingUid, siteId, showTime)
	self.entity.characterspine:setMixDuration(0)

	self._siteId = siteId
	self._buildingUid = buildingUid
	self._buildingEntity = self._scene.buildingmgr:getBuildingEntity(buildingUid)
	self._buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
	self._interactHeroPointName = RoomEnum.EntityChildKey.CritterPointList[siteId]
	self._interactStartPointName = RoomEnum.EntityChildKey.InteractStartPointList[siteId]
	self._interactBuildingMO = self._buildingMO:getInteractMO()
	self._isFindPath = self._interactBuildingMO:isFindPath()
	self._showTime = showTime

	if not self._resetPosX then
		local lx, ly, lz = self.entity:getLocalPosXYZ()

		self:_setResetXYZ(lx, ly, lz)
	end

	local delayTime = math.random() * 0.5

	self._characterMO = self.entity:getMO()

	if self._characterMO then
		self._characterMO:setLockTime(showTime + delayTime)
		self._characterMO:setIsFreeze(true)
	end

	self:_killTween()
	self:_stopFinishTask()
	self:_startFinishTask(showTime + delayTime + 0.1)
	TaskDispatcher.cancelTask(self._onStartInteract, self)
	TaskDispatcher.runDelay(self._onStartInteract, self, delayTime)
end

function RoomCharacterInteractActionComp:_onStartInteract()
	if self._isFindPath then
		local fx, fy, fz = self:_getPosXYZByPointName(self._interactStartPointName)
		local tx, ty, tz = self:_getPosXYZByPointName(self._interactHeroPointName)

		if fx and tx then
			self:_tryPlacePointByName(self._interactStartPointName)
			self:_findPath(Vector3(fx, fy, fz), Vector3(tx, ty, tz), self._interactHeroPointName)
		else
			self:_tryPlacePointByName(self._interactHeroPointName)
		end
	else
		self:_tryPlacePointByName(self._interactHeroPointName)

		self._tweenMoveId = self._scene.tween:tweenFloat(0, 1, self._showTime, self._framePointCallback, self._finishCallback, self)
	end
end

function RoomCharacterInteractActionComp:endIneract()
	self.entity.characterspine:clearMixDuration()

	self._buildingUid = nil
	self._buildingEntity = nil

	if self._characterMO then
		self._characterMO:setIsFreeze(false)
	end

	self:_resetMOPosXYZ()
	self:_killTween()
	self:_stopFinishTask()
	self:_clearResetXYZ()
	TaskDispatcher.cancelTask(self._onStartInteract, self)
end

function RoomCharacterInteractActionComp:_clearResetXYZ()
	self:_setResetXYZ(nil, nil, nil)
end

function RoomCharacterInteractActionComp:_setResetXYZ(x, y, z)
	self._resetPosX, self._resetPosY, self._resetPosZ = x, y, z
end

function RoomCharacterInteractActionComp:_resetMOPosXYZ()
	if self._resetPosX then
		self:_setMOPosXYZ(self._resetPosX, self._resetPosY, self._resetPosZ)
	end

	self:_clearResetXYZ()
end

function RoomCharacterInteractActionComp:_setMOPosXYZ(posX, posY, posZ)
	if self._characterMO then
		self._characterMO:setPositionXYZ(posX, posY, posZ)
	end
end

function RoomCharacterInteractActionComp:_stopFinishTask()
	if self._isHasInteractFinishTask then
		self._isHasInteractFinishTask = false

		TaskDispatcher.cancelTask(self._onIneractFinish, self)
	end
end

function RoomCharacterInteractActionComp:_startFinishTask(delayTime)
	if not self._isHasInteractFinishTask then
		self._isHasInteractFinishTask = true

		TaskDispatcher.runDelay(self._onIneractFinish, self, delayTime)
	end
end

function RoomCharacterInteractActionComp:_onIneractFinish()
	self._isHasInteractFinishTask = false

	self:_killTween()
	self:_resetMOPosXYZ()

	if self._isFindPath then
		local fx, fy, fz = transformhelper.getPos(self.entity.goTrs)
		local tx, ty, tz = self:_getPosXYZByPointName(self._interactStartPointName)

		if fx and tx then
			self:_findPath(Vector3(fx, fy, fz), Vector3(tx, ty, tz), self._interactStartPointName)
		else
			self:_tryPlacePointByName(self._interactStartPointName, true)
		end
	else
		self:_tryPlacePointByName(self._interactStartPointName, true)
	end

	if self._characterMO then
		self._characterMO:setIsFreeze(false)
	end
end

function RoomCharacterInteractActionComp:getIneractBuildingUid()
	return self._buildingUid
end

function RoomCharacterInteractActionComp:_getPosXYZByPointName(heroPointName)
	if not self._buildingEntity then
		return
	end

	local pointTrs = self._buildingEntity.interactComp:getPointGOTrsByName(heroPointName)

	if not pointTrs then
		return
	end

	return transformhelper.getPos(pointTrs)
end

function RoomCharacterInteractActionComp:_tryPlacePointByName(heroPointName, isNotMOPos)
	local posX, posY, posZ = self:_getPosXYZByPointName(heroPointName)

	if not posX then
		return
	end

	if isNotMOPos ~= true then
		self:_setMOPosXYZ(posX, posY, posZ)
	end

	self._toPosition = Vector3(posX, posY, posZ)
	self._playingAnimName = "out"

	local lookDir = self.entity.characterspine:getLookDir()
	local cameraRotate = self._scene.camera:getCameraRotate()
	local rotationY = cameraRotate * Mathf.Rad2Deg

	self:_playPlaceEffect(posX, posY, posZ, rotationY, "left")
	self.entity.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, self._playingAnimName, 0, self._moveEntity, self)
	self.entity.charactermove:forcePositionAndLookDir(self._toPosition, lookDir, RoomCharacterEnum.CharacterMoveState.Move)
	self.entity.characterspine:resetPhysics()
end

function RoomCharacterInteractActionComp:_moveEntity()
	self.entity.charactermove:clearForcePositionAndLookDir()
	self.entity.characterspine:changeMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
end

function RoomCharacterInteractActionComp:_playPlaceEffect(posX, posY, posZ, rotationY, animName)
	local placeEffectGO = self._scene.go:spawnEffect(RoomScenePreloader.ResEffectPlaceCharacter, nil, "placeCharacterEffect", nil, 2)

	if placeEffectGO then
		local placeEffectGOTrs = placeEffectGO.transform

		transformhelper.setPos(placeEffectGOTrs, posX, posY, posZ)
		transformhelper.setLocalRotation(placeEffectGOTrs, 0, rotationY, 0)

		if not string.nilorempty(animName) then
			local animator = gohelper.findChildComponent(placeEffectGO, "anim", RoomEnum.ComponentType.Animator)

			if animator then
				animator:Play(animName)
			end
		end
	end
end

return RoomCharacterInteractActionComp
