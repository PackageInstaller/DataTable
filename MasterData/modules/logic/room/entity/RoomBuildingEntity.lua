-- chunkname: @modules/logic/room/entity/RoomBuildingEntity.lua

module("modules.logic.room.entity.RoomBuildingEntity", package.seeall)

local RoomBuildingEntity = class("RoomBuildingEntity", RoomBaseEntity)

function RoomBuildingEntity:ctor(entityId)
	RoomBuildingEntity.super.ctor(self)
	self:setEntityId(entityId)
end

function RoomBuildingEntity:setEntityId(entityId)
	self.id = entityId
	self.entityId = self.id
end

function RoomBuildingEntity:getTag()
	return SceneTag.RoomBuilding
end

function RoomBuildingEntity:init(go)
	self.containerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.ContainerGOKey)
	self.staticContainerGO = self.containerGO
	self.containerGOTrs = self.containerGO.transform
	self.goTrs = go.transform

	RoomBuildingEntity.super.init(self, go)
	gohelper.addAkGameObject(self.go)
	AudioMgr.instance:RegisterGameObj(self.go)

	self._buildingPartCountDict = {}
end

function RoomBuildingEntity:playAudio(audioId)
	if audioId and audioId ~= 0 then
		self.__isHasAuidoTrigger = true

		AudioMgr.instance:trigger(audioId, self.go, false)
	end
end

function RoomBuildingEntity:initComponents()
	self:addComp("effect", RoomEffectComp)
	self:addComp("alphaThresholdComp", RoomAlphaThresholdComp)

	local isObMode = RoomController.instance:isObMode()

	if isObMode then
		self:addComp("atmosphere", RoomAtmosphereComp)
	end

	if isObMode or RoomController.instance:isDebugNormalMode() then
		self:addComp("collider", RoomColliderComp)
	end

	local mo = self:getMO()

	if mo and mo.config then
		local config = mo.config

		if config.crossload ~= 0 then
			self:addComp("crossloadComp", RoomCrossloadComp)
		end

		if config.vehicleType ~= 0 then
			self:addComp("buildingVehicleComp", RoomBuildingVehicleComp)
		end

		if config.audioExtendType == RoomBuildingEnum.AudioExtendType.Clock12Hour then
			self:addComp("buildingClockComp", RoomBuildingClockComp)
		elseif config.audioExtendType == RoomBuildingEnum.AudioExtendType.AnimatorEvent then
			self:addComp("animEventAudioComp", RoomAnimEventAudioComp)
		end

		if not string.nilorempty(mo.config.linkBlock) then
			self:addComp("buildingLinkBlockComp", RoomBuildingLinkBlockComp)
		end

		if config.reflerction == 1 then
			self:addComp("reflerctionComp", RoomBuildingReflectionComp)
		end

		if config.canLevelUp then
			self:addComp("buildingLevelComp", RoomBuildingLevelComp)
		end

		if config.buildingType == RoomBuildingEnum.BuildingType.Rest then
			self:addComp("summonComp", RoomBuildingSummonComp)
		end

		if config.buildingType == RoomBuildingEnum.BuildingType.Interact then
			self:addComp("interactComp", RoomBuildingInteractComp)
		end
	end

	self:addComp("nightlight", RoomNightLightComp)
	self:addComp("critter", RoomBuildingCritterComp)
	self:addComp("cameraFollowTargetComp", RoomCameraFollowTargetComp)
end

function RoomBuildingEntity:onStart()
	RoomBuildingEntity.super.onStart(self)
	RoomBuildingController.instance:registerCallback(RoomEvent.PressBuildingUp, self._refreshPressEffect, self)
	RoomBuildingController.instance:registerCallback(RoomEvent.DropBuildingDown, self._refreshPressEffect, self)
	RoomBuildingController.instance:registerCallback(RoomEvent.SetBuildingColliderEnable, self._setColliderEnable, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, self._characterListShowChanged, self)
end

function RoomBuildingEntity:refreshName()
	local mo = self:getMO()

	self.go.name = RoomResHelper.getBlockName(mo.hexPoint)
end

function RoomBuildingEntity:refreshRotation(tween)
	local mo = self:getMO()

	if self._rotationTweenId then
		ZProj.TweenHelper.KillById(self._rotationTweenId)
	end

	if false then
		self._rotationTweenId = ZProj.TweenHelper.DOLocalRotate(self.containerGOTrs, 0, mo.rotate * 60, 0, 0.1, nil, self, nil, EaseType.Linear)
	else
		transformhelper.setLocalRotation(self.containerGOTrs, 0, mo.rotate * 60, 0)
	end
end

function RoomBuildingEntity:refreshBuilding()
	self:_refreshBuilding()
	self:_refreshPressEffect()

	if self.buildingLinkBlockComp then
		self.buildingLinkBlockComp:refreshLink()
	end

	if self.reflerctionComp then
		self.reflerctionComp:refreshReflection()
	end
end

function RoomBuildingEntity:transformPoint(x, y, z)
	return (self.containerGOTrs:TransformPoint(x, y, z))
end

function RoomBuildingEntity:_refreshBuilding()
	local mo = self:getMO()
	local effectKey = RoomEnum.EffectKey.BuildingGOKey

	if mo then
		local alphaThresholdValue = self:getAlphaThresholdValue()
		local alphaThreshold = not not alphaThresholdValue

		if not self.effect:isHasEffectGOByKey(effectKey) or mo.config.canLevelUp and self._lastLevel ~= mo.level then
			self._listalphaThresholdValue = alphaThresholdValue
			self._lastLevel = mo.level

			if not RoomBuildingEnum.VehicleTypeOffestY[mo.config.vehicleType] then
				self.effect:addParams({
					[effectKey] = {
						deleteChildPath = "0",
						pathfinding = true,
						res = self:_getBuildingRes(),
						alphaThreshold = alphaThreshold,
						alphaThresholdValue = alphaThresholdValue,
						localPos = Vector3(0, RoomBuildingEnum.VehicleTypeOffestY[mo.config.vehicleType], 0)
					}
				})
				self.effect:refreshEffect()
			end
		elseif self._listalphaThresholdValue ~= alphaThresholdValue then
			self._listalphaThresholdValue = alphaThresholdValue

			self.effect:setMPB(effectKey, false, alphaThreshold, alphaThresholdValue)
		end
	elseif self.effect:isHasKey(effectKey) then
		self._listalphaThresholdValue = nil

		self.effect:removeParams({
			effectKey
		})
		self.effect:refreshEffect()
	end
end

function RoomBuildingEntity:getAlphaThresholdValue()
	local tempMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if tempMO and tempMO.id == self.id then
		local cfg = RoomConfig.instance:getBuildingConfig(tempMO.buildingId)
		local alphaThreshold = cfg.alphaThreshold * 0.001

		if RoomBuildingController.instance:isPressBuilding() then
			return alphaThreshold
		end

		local hexPoint = tempMO.hexPoint

		if RoomBuildingHelper.isInInitBlock(hexPoint) then
			return alphaThreshold
		end

		local blockMO = RoomMapBlockModel.instance:getBlockMO(hexPoint.x, hexPoint.y)

		if blockMO and RoomBuildingHelper.checkBuildResId(tempMO.buildingId, blockMO:getResourceList(true)) == false then
			return alphaThreshold
		end

		local canConfirmParam, errorCode = RoomBuildingHelper.canConfirmPlace(tempMO.buildingId, tempMO.hexPoint, tempMO.rotate, nil, nil, false, tempMO.levels, true)

		if not canConfirmParam then
			return alphaThreshold
		end
	end

	return nil
end

function RoomBuildingEntity:_refreshPressEffect()
	local pressBuildingUid = RoomBuildingController.instance:isPressBuilding()

	if pressBuildingUid and pressBuildingUid == self.id then
		if not self.effect:isHasKey(RoomEnum.EffectKey.BuildingPressEffectKey) then
			local buildingMO = self:getMO()
			local buildingConfigParam = RoomMapModel.instance:getBuildingConfigParam(buildingMO.buildingId)
			local offset = buildingConfigParam.offset

			self.effect:addParams({
				[RoomEnum.EffectKey.BuildingPressEffectKey] = {
					res = RoomScenePreloader.ResVXXuXian,
					localPos = Vector3(offset.x, offset.y - 1, offset.z)
				}
			})
		end

		self.effect:refreshEffect()
	elseif self.effect:isHasKey(RoomEnum.EffectKey.BuildingPressEffectKey) then
		self.effect:removeParams({
			RoomEnum.EffectKey.BuildingPressEffectKey
		})
		self.effect:refreshEffect()
	end
end

function RoomBuildingEntity:onEffectRebuild()
	if not self._isSmokeAnimPlaying then
		self:_playSmokeAnim(false)
	end

	self:setSideIsActive(RoomEnum.EntityChildKey.OutSideKey, true)
	self:setSideIsActive(RoomEnum.EntityChildKey.InSideKey, false)

	local bodyGO = self:getBodyGO()

	if bodyGO then
		RoomMapController.instance:dispatchEvent(RoomEvent.RoomVieiwConfirmRefreshUI)
	end

	local roomScene = RoomCameraController.instance:getRoomScene()

	if roomScene then
		roomScene.buildingcrittermgr:refreshCritterPosByBuilding(self.id)
	end
end

function RoomBuildingEntity:_characterListShowChanged(isShow)
	self:_setColliderEnable(not isShow)
end

function RoomBuildingEntity:_setColliderEnable(isEnable, buildingUid)
	if buildingUid and buildingUid ~= self.id then
		return
	end

	if self.collider then
		self.collider:setEnable(isEnable)
	end
end

function RoomBuildingEntity:getHeadGO()
	return self:_findBuildingGOChild(RoomEnum.EntityChildKey.HeadGOKey)
end

function RoomBuildingEntity:getBodyGO()
	return self:_findBuildingGOChild(RoomEnum.EntityChildKey.BodyGOKey)
end

function RoomBuildingEntity:playAnimator(animName)
	return self.effect:playEffectAnimator(RoomEnum.EffectKey.BuildingGOKey, animName)
end

function RoomBuildingEntity:playSmokeEffect()
	self:_returnSmokeEffect()
	self:_playSmokeAnim(true)

	self._isSmokeAnimPlaying = true

	TaskDispatcher.runDelay(self._delayReturnSmokeEffect, self, 3)
end

function RoomBuildingEntity:_delayReturnSmokeEffect()
	self._isSmokeAnimPlaying = false

	self:_playSmokeAnim(false)
end

function RoomBuildingEntity:_returnSmokeEffect()
	TaskDispatcher.cancelTask(self._delayReturnSmokeEffect, self)
end

function RoomBuildingEntity:_playSmokeAnim(isStart)
	local smokeGO = self:_findBuildingGOChild(RoomEnum.EntityChildKey.SmokeGOKey)

	if smokeGO then
		if isStart then
			gohelper.setActive(smokeGO, false)
		end

		gohelper.setActive(smokeGO, isStart)
	end
end

function RoomBuildingEntity:setSideIsActive(argsSideKey, isActive)
	local sideKey = argsSideKey or RoomEnum.EntityChildKey.InSideKey
	local sidePath = string.format("%s/%s", 1, sideKey)
	local goSide = self:_findBuildingGOChild(sidePath)

	gohelper.setActive(goSide, isActive)
end

function RoomBuildingEntity:getPlayerInsideInteractionNode()
	return (self:_findBuildingGOChild(RoomEnum.EntityChildKey.PositionZeroKey))
end

function RoomBuildingEntity:getSpineWidgetNode(index)
	local name = string.format(RoomEnum.EntityChildKey.InteractSpineNode, index)

	return (self:_findBuildingGOChild(name))
end

function RoomBuildingEntity:getCritterPoint(slotId)
	if not slotId then
		return
	end

	local name = string.format(RoomEnum.EntityChildKey.CritterPoint, slotId + 1)

	return (self:_findBuildingGOChild(name))
end

function RoomBuildingEntity:getBuildingGO()
	return self.effect:getEffectGO(RoomEnum.EffectKey.BuildingGOKey)
end

function RoomBuildingEntity:_findBuildingGOChild(childPath)
	return self.effect:getGameObjectByPath(RoomEnum.EffectKey.BuildingGOKey, childPath)
end

function RoomBuildingEntity:setLocalPos(x, y, z, tween)
	ZProj.TweenHelper.KillByObj(self.go.transform)

	if tween then
		ZProj.TweenHelper.DOLocalMove(self.go.transform, x, y, z, 0.1)
	else
		transformhelper.setLocalPos(self.go.transform, x, y, z)
	end

	self:refreshName()
end

function RoomBuildingEntity:tweenUp()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_drag)
	ZProj.TweenHelper.KillByObj(self.containerGO.transform)
	ZProj.TweenHelper.DOLocalMoveY(self.containerGO.transform, self:_getBuildingDragUp(), 0.2)
end

function RoomBuildingEntity:tweenDown()
	local mo = self:getMO()

	if mo then
		AudioMgr.instance:trigger(mo:getPlaceAudioId())
	end

	ZProj.TweenHelper.KillByObj(self.containerGO.transform)
	ZProj.TweenHelper.DOLocalMoveY(self.containerGO.transform, 0, 0.2)
end

function RoomBuildingEntity:_getBuildingDragUp()
	local mo = self:getMO()
	local cfg = RoomConfig.instance:getBuildingConfig(mo.buildingId)

	if cfg and cfg.dragUpHeight then
		return cfg.dragUpHeight * 0.001
	end

	return 1
end

function RoomBuildingEntity:tweenAlphaThreshold(from, to, duration)
	if self.alphaThresholdComp then
		self.alphaThresholdComp:tweenAlphaThreshold(from, to, duration)
	end
end

function RoomBuildingEntity:_getBuildingRes()
	local mo = self:getMO()

	return (RoomResHelper.getBuildingPath(mo.buildingId, mo.level))
end

function RoomBuildingEntity:_getBuildingPartRes(levelGroup, level)
	return RoomResHelper.getPartPathList(levelGroup, level)
end

function RoomBuildingEntity:beforeDestroy()
	self:_returnSmokeEffect()
	ZProj.TweenHelper.KillByObj(self.go.transform)
	ZProj.TweenHelper.KillByObj(self.containerGO.transform)

	if self._rotationTweenId then
		ZProj.TweenHelper.KillById(self._rotationTweenId)
	end

	for _, comp in ipairs(self._compList) do
		if comp.beforeDestroy then
			comp:beforeDestroy()
		end
	end

	if self.__isHasAuidoTrigger then
		self.__isHasAuidoTrigger = false

		AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home, self.go, false)
	end

	AudioMgr.instance:UnregisterGameObj(self.go)
	self:removeEvent()
end

function RoomBuildingEntity:removeEvent()
	RoomBuildingController.instance:unregisterCallback(RoomEvent.PressBuildingUp, self._refreshPressEffect, self)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.DropBuildingDown, self._refreshPressEffect, self)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.SetBuildingColliderEnable, self._setColliderEnable, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, self._characterListShowChanged, self)
end

function RoomBuildingEntity:setBatchEnabled(isEnabled)
	self.effect:setBatch(RoomEnum.EffectKey.BuildingGOKey, isEnabled)
end

function RoomBuildingEntity:getMO()
	return RoomMapBuildingModel.instance:getBuildingMOById(self.id)
end

function RoomBuildingEntity:getVehicleMO()
	return RoomMapVehicleModel.instance:getVehicleMOByBuilingUid(self.id)
end

function RoomBuildingEntity:getCharacterMeshRendererList()
	return self.effect:getMeshRenderersByKey(RoomEnum.EffectKey.BuildingGOKey)
end

function RoomBuildingEntity:getOccupyDict()
	local mo = self:getMO()

	if not mo or not mo.hexPoint then
		return nil
	end

	if self._lastHexPoint ~= mo.hexPoint or self._lastRotate ~= mo.rotate then
		self._lastHexPoint = HexPoint(mo.hexPoint.x, mo.hexPoint.y)
		self._lastRotate = mo.rotate
		self._lastOccupyDict = RoomBuildingHelper.getOccupyDict(mo.buildingId, mo.hexPoint, mo.rotate, mo.buildingUid)
		self._lastHexPointList = {}

		for x, dic in pairs(self._lastOccupyDict) do
			for y, buildingParam in pairs(dic) do
				table.insert(self._lastHexPointList, buildingParam.hexPoint)
			end
		end
	end

	return self._lastOccupyDict, self._lastHexPointList
end

return RoomBuildingEntity
