-- chunkname: @modules/logic/room/entity/comp/RoomCritterSpineComp.lua

module("modules.logic.room.entity.comp.RoomCritterSpineComp", package.seeall)

local RoomCritterSpineComp = class("RoomCritterSpineComp", RoomBaseSpineComp)

function RoomCritterSpineComp:onInit()
	local roomCritterMO = self.entity:getMO()

	self._critterId = roomCritterMO.critterId
	self._skinId = roomCritterMO:getSkinId()
	self._spinePrefabRes = RoomResHelper.getCritterPath(self._skinId)
	self._materialRes = RoomCharacterEnum.MaterialPath
	self._shouldShowSpine = false
	self._isInDistance = false
	self._isShow = false
	self._isHide = false
	self._touchTamingRate = 0.6

	self:_cameraTransformUpdate()
	self:_refreshSpineShow()
end

function RoomCritterSpineComp:resetInit()
	local roomCritterMO = self.entity:getMO()

	if not roomCritterMO then
		return
	end

	if self._skinId ~= roomCritterMO:getSkinId() then
		self._critterId = roomCritterMO.critterId
		self._skinId = roomCritterMO:getSkinId()

		self:clearSpine()
		self:_refreshSpineShow()
	end
end

function RoomCritterSpineComp:addResToLoader(loader)
	loader:addPath(self._spinePrefabRes)
	loader:addPath(self._materialRes)
	self.entity.critterspineeffect:addResToLoader(loader)
end

function RoomCritterSpineComp:_onLoadOneFail(loader, assetItem)
	logError("RoomCritterSpineComp: 加载失败, url: " .. assetItem.ResPath)
end

function RoomCritterSpineComp:_onLoadFinish(loader)
	RoomCritterSpineComp.super._onLoadFinish(self, loader)

	self._mountheadGO = gohelper.findChild(self._spineGO, "mountroot/mounthead")

	if self._mountheadGO then
		self._mountheadGOTrs = self._mountheadGO.transform
	end

	self:_spawnShadowGO(loader)
	self:_updateShadowOffset()
	self:_cameraTransformUpdate()
	self:setScale(self._initScale)
	self.entity.critterspineeffect:spawnEffect(loader)
	self:refreshAnimState()
end

function RoomCritterSpineComp:_spawnShadowGO(loader)
	local shadowPrefab = self._scene.preloader:getResource(RoomScenePreloader.ResEffectCharacterShadow)

	self._shadowGO = gohelper.clone(shadowPrefab, self.entity.containerGO, "shadow")
	self._shadowGOTrs = self._shadowGO.transform

	local shadowMeshRenderer = self._shadowGO:GetComponent(typeof(UnityEngine.MeshRenderer))

	shadowMeshRenderer.sortingLayerName = "Default"

	transformhelper.setLocalPos(self._shadowGOTrs, 0, 0.01, 0)
end

function RoomCritterSpineComp:setScale(scale)
	if not scale then
		return
	end

	if gohelper.isNil(self._spineGOTrs) then
		self._initScale = scale
	else
		transformhelper.setLocalScale(self._spineGOTrs, scale, scale, scale)
	end
end

function RoomCritterSpineComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshSpineShow, self._refreshSpineShow, self)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, self._updateShadowOffset, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, self._onUpdate, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._onManufactureInfoUpdate, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._onManufactureInfoUpdate, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterFeedFood, self._onFeedFood, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterInfoPushUpdate, self._onCritterInfoUpdate, self)
end

function RoomCritterSpineComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshSpineShow, self._refreshSpineShow, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, self._updateShadowOffset, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, self._onUpdate, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._onManufactureInfoUpdate, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._onManufactureInfoUpdate, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterFeedFood, self._onFeedFood, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterInfoPushUpdate, self._onCritterInfoUpdate, self)
end

function RoomCritterSpineComp:_onUpdate()
	if self._shadowPointGOTrs and self._shadowGOTrs then
		local px, py, pz = transformhelper.getPos(self._shadowPointGOTrs)

		transformhelper.setPos(self._shadowGOTrs, px, py, pz)
	end
end

function RoomCritterSpineComp:touch(isTouch)
	local mo = self.entity:getMO()

	if math.random() >= self._touchTamingRate then
		return
	end

	TaskDispatcher.cancelTask(self._touchAfter, self)

	if isTouch and mo then
		local deltaTime = 10

		mo.isTouch = true
		self._touchAction = true

		TaskDispatcher.runDelay(self._touchAfter, self, deltaTime)
		self:play(self:_getTouchStateName(), false, true)
	else
		self:refreshAnimState()
	end
end

function RoomCritterSpineComp:_touchAfter()
	TaskDispatcher.cancelTask(self._touchAfter, self)

	local mo = self.entity:getMO()

	if mo then
		mo.isTouch = false
	end

	self._touchAction = false
end

function RoomCritterSpineComp:_getTouchStateName()
	local names = RoomCharacterEnum.CharacterTamingAnimList

	return names[math.random(1, #names)] or names[1]
end

function RoomCritterSpineComp:_onManufactureInfoUpdate(updateBuildingDict)
	local mo = self.entity:getMO()
	local stayBuildingUid = mo and mo:getStayBuilding()

	if not stayBuildingUid then
		return
	end

	if updateBuildingDict and not updateBuildingDict[stayBuildingUid] then
		return
	end

	self:refreshAnimState()
end

function RoomCritterSpineComp:_onFeedFood(critterUidDict)
	local mo = self.entity:getMO()
	local critterUid = mo and mo:getId()

	if not critterUid or critterUidDict and not critterUidDict[critterUid] then
		return
	end

	local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)
	local mood = critterMO:getMoodValue()
	local cfgMaxMood = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)
	local maxMood = tonumber(cfgMaxMood) or 0
	local animName = RoomCharacterEnum.CharacterAnimStateName.SleepEnd

	if self._curAnimState == RoomCharacterEnum.CharacterAnimStateName.Idle or self._curAnimState == RoomCharacterEnum.CharacterAnimStateName.SpecialIdle then
		animName = RoomCharacterEnum.CharacterAnimStateName.Eat
	end

	if maxMood <= mood then
		self:_realSetMoveState(RoomCharacterEnum.CharacterMoveState.MaxMoodEating)
	end

	self:play(animName, false)
end

function RoomCritterSpineComp:_onCritterInfoUpdate(critterUidDict)
	local mo = self.entity:getMO()
	local critterUid = mo and mo:getId()

	if not critterUid or critterUidDict and not critterUidDict[critterUid] then
		return
	end

	self:refreshAnimState()
end

function RoomCritterSpineComp:_refreshSpineShow()
	local cameraState = self._scene.camera:getCameraState()

	self._shouldShowSpine = RoomCharacterController.instance:checkCanSpineShow(cameraState)

	self:_refreshShowSpine()
end

function RoomCritterSpineComp:_refreshShowSpine(force)
	if self._isInDistance and self._shouldShowSpine then
		if not self._isShow or force then
			self._isShow = true
			self._isHide = false

			self:showSpine()
		end
	elseif not self._isHide or force then
		self._isShow = false
		self._isHide = true

		self:hideSpine()
	end
end

function RoomCritterSpineComp:refreshAnimState()
	local mo = self.entity:getMO()

	if not mo then
		return
	end

	self.entity:stopCommonInteractionEff(RoomCharacterEnum.CommonEffect.CritterAngry)

	local stayBuildingUid = mo:getStayBuilding()
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(stayBuildingUid)
	local buildingId = buildingMO and buildingMO.buildingId

	if buildingId then
		local buildingType = RoomConfig.instance:getBuildingType(buildingId)
		local isManufacture = ManufactureConfig.instance:isManufactureBuilding(buildingId)

		if isManufacture then
			self:playManufactureAnim(buildingMO)
		elseif buildingType == RoomBuildingEnum.BuildingType.Rest then
			self:playRestingAnim()
		end
	elseif mo.isTouch then
		if self._touchAction then
			self:play(self:_getTouchStateName(), false, false)
		else
			local idleAnim, isLoop = self:getIdleAnim()

			self:play(idleAnim, isLoop, false)
		end
	else
		local critterId = mo.critterId
		local curAnimState = self:getAnimState()
		local tempCritterMO = RoomCritterModel.instance:getTempCritterMO()

		if curAnimState ~= RoomCharacterEnum.CharacterAnimStateName.SpecialIdle or RoomCharacterHelper.getAnimStateName(self._moveState, critterId) ~= RoomCharacterHelper.getIdleAnimStateName(critterId) or tempCritterMO and tempCritterMO.id == self.entity.id then
			local newAnimStateName

			if self._moveState == RoomCharacterEnum.CharacterMoveState.Idle then
				newAnimStateName = self:getIdleAnim()

				goto label_19_0
			end

			local var_19_0 = RoomCharacterHelper.getAnimStateName(self._moveState, critterId)

			self:play(newAnimStateName, RoomCharacterEnum.CharacterLoopAnimState[self._moveState] or false, false)
		end
	end
end

function RoomCritterSpineComp:play(animState, isLoop, reStart)
	if not animState then
		return
	end

	if not self._skeletonAnim then
		return
	end

	isLoop = isLoop or false
	reStart = reStart or false

	local needPlay = reStart or animState ~= self._curAnimState or isLoop ~= self._isLoop

	if not needPlay then
		return
	end

	self._curAnimState = animState
	self._isLoop = isLoop

	if self._skeletonAnim:HasAnimation(animState) then
		self._skeletonAnim:SetAnimation(0, animState, self._isLoop, 0)
		self.entity.critterspineeffect:play(animState)
	else
		local spineName = gohelper.isNil(self._spineGO) and "nil" or self._spineGO.name

		logError(string.format("critterId:%s  skinId:%s  animName:%s  goName:%s  Animation Name not exist ", self._critterId, self._skinId, animState, spineName))
	end
end

function RoomCritterSpineComp:playManufactureAnim(buildingMO)
	local mo = self.entity:getMO()
	local critterUid = mo:getId()
	local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)
	local mood = critterMO:getMoodValue()
	local animName, isLoop = self:getIdleAnim()
	local manufactureState = buildingMO:getManufactureState()

	if mood > 0 then
		if manufactureState == RoomManufactureEnum.ManufactureState.Running then
			animName = RoomCharacterEnum.CharacterAnimStateName.Produce

			local buildingType = RoomConfig.instance:getBuildingType(buildingMO.buildingId)

			if buildingType == RoomBuildingEnum.BuildingType.Collect then
				animName = RoomCharacterEnum.CharacterAnimStateName.Collect
			end

			isLoop = true
		elseif manufactureState == RoomManufactureEnum.ManufactureState.Stop then
			animName = RoomCharacterEnum.CharacterAnimStateName.Sleep
			isLoop = true
		end
	else
		self.entity:playCommonInteractionEff(RoomCharacterEnum.CommonEffect.CritterAngry)
	end

	self:play(animName, isLoop)
end

function RoomCritterSpineComp:playRestingAnim()
	local mo = self.entity:getMO()
	local critterUid = mo:getId()
	local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)
	local mood = critterMO:getMoodValue()
	local cfgMaxMood = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)
	local maxMood = tonumber(cfgMaxMood) or 0
	local animName, isLoop = self:getIdleAnim()
	local isInSleep = self._moveState == RoomCharacterEnum.CharacterMoveState.Sleep
	local newRestCritterUid = ManufactureModel.instance:getNewRestCritter()
	local isNewRest = critterUid == newRestCritterUid

	if mood < maxMood then
		if self._curAnimState and isInSleep then
			return
		end

		if isNewRest then
			isLoop = false

			ManufactureModel.instance:setNewRestCritter()

			animName = RoomCharacterEnum.CharacterAnimStateName.SleepStart
		else
			animName = RoomCharacterEnum.CharacterAnimStateName.Sleep
		end

		self:_realSetMoveState(RoomCharacterEnum.CharacterMoveState.Sleep)
	elseif not isNewRest and self._curAnimState then
		if not isInSleep then
			return
		end

		isLoop = false
		animName = RoomCharacterEnum.CharacterAnimStateName.SleepEnd

		self:_realSetMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
	end

	self:play(animName, isLoop)
end

function RoomCritterSpineComp:_onAnimCallback(actionName, eventName, eventArgs)
	local isComplete = eventName == SpineAnimEvent.ActionComplete

	if not isComplete then
		return
	end

	local nextAnim
	local isLoop = true

	if actionName == RoomCharacterEnum.CharacterAnimStateName.Idle then
		nextAnim, isLoop = self:getIdleAnim()
	else
		if self._curAnimState ~= actionName or self._isLoop then
			return
		end

		nextAnim = RoomCharacterHelper.getNextAnimStateName(self._moveState, actionName)

		if nextAnim then
			isLoop = nextAnim == actionName
		else
			nextAnim = RoomCharacterHelper.getIdleAnimStateName(self._critterId)
		end

		if self._moveState == RoomCharacterEnum.CharacterMoveState.MaxMoodEating and nextAnim == RoomCharacterEnum.CharacterAnimStateName.Idle then
			self:_realSetMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
		end
	end

	self:play(nextAnim, isLoop, false)
end

function RoomCritterSpineComp:playAnim(animRes, animName, normalizedTime, callback, callbackObj)
	local isSuccess = self:_checkAnimator(animRes)

	self._callback = callback
	self._callbackObj = callbackObj

	if not callback then
		if isSuccess then
			self._animator.enabled = true

			self._animator:Play(animName, 0, normalizedTime or 0)
		end
	else
		TaskDispatcher.cancelTask(self._animDone, self)

		if isSuccess then
			self._animatorPlayer:Play(animName, self._animDone, self)
		else
			TaskDispatcher.runDelay(self._animDone, self, 0.1)
		end
	end
end

function RoomCritterSpineComp:_checkAnimator(animRes)
	local animController = self._scene.preloader:getResource(animRes)

	if animController then
		self._animator = gohelper.onceAddComponent(self.entity.containerGO, typeof(UnityEngine.Animator))
		self._animatorPlayer = gohelper.onceAddComponent(self.entity.containerGO, typeof(SLFramework.AnimatorPlayer))
		self._animator.runtimeAnimatorController = animController

		return true
	end

	return false
end

function RoomCritterSpineComp:clearAnim()
	self._callback = nil
	self._callbackObj = nil

	if self._animatorPlayer then
		UnityEngine.Component.DestroyImmediate(self._animatorPlayer)

		self._animatorPlayer = nil
	end

	if self._animator then
		UnityEngine.Component.DestroyImmediate(self._animator)

		self._animator = nil
	end
end

function RoomCritterSpineComp:_animDone()
	if self._callback then
		self._callback(self._callbackObj)
	end
end

function RoomCritterSpineComp:changeMoveState(moveState)
	if self._moveState == moveState then
		return
	end

	self:_realSetMoveState(moveState)
	self:refreshAnimState()
end

function RoomCritterSpineComp:_realSetMoveState(moveState)
	self._moveState = moveState
end

function RoomCritterSpineComp:characterPosChanged()
	self:_cameraTransformUpdate()
end

function RoomCritterSpineComp:_cameraTransformUpdate()
	local focus = self._scene.camera:getCameraFocus()
	local x, y, z = transformhelper.getPos(self.goTrs)
	local spinePos = Vector2(x, z)
	local distance = Vector2.Distance(focus, spinePos)

	if distance < 3.5 then
		self._isInDistance = true
	elseif distance > 4.5 then
		self._isInDistance = false
	end

	self:_refreshShowSpine()

	if self._spineGO and self._spineGO.activeInHierarchy then
		self:refreshRotation()
	end
end

function RoomCritterSpineComp:_updateShadowOffset()
	if not self._material then
		return
	end

	local shadowOffset = self._scene.character:getShadowOffset()

	self._material:SetVector("_ShadowOffset", shadowOffset)
end

function RoomCritterSpineComp:getIdleAnim()
	local isLoop = true
	local result = RoomCharacterHelper.getIdleAnimStateName(self._critterId)
	local isSpecialIdle = self:isRandomSpecialRate()

	if isSpecialIdle then
		isLoop = false
		result = RoomCharacterEnum.CharacterAnimStateName.SpecialIdle
	end

	return result, isLoop
end

function RoomCritterSpineComp:isRandomSpecialRate()
	local roomCritterMO = self.entity:getMO()
	local specialRate = roomCritterMO:getSpecialRate()

	return (specialRate > math.random() or nil) and true
end

function RoomCritterSpineComp:isShowAnimShadow()
	return true
end

function RoomCritterSpineComp:getShadowGO()
	return self._shadowGO
end

function RoomCritterSpineComp:getMountheadGO()
	return self._mountheadGO
end

function RoomCritterSpineComp:getMountheadGOTrs()
	return self._mountheadGOTrs
end

function RoomCritterSpineComp:clearSpine()
	if self.entity and self.entity.critterspineeffect then
		self.entity.critterspineeffect:clearEffect()
	end

	RoomCritterSpineComp.super.clearSpine(self)

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._shadowGO then
		gohelper.destroy(self._shadowGO)

		self._shadowGO = nil
		self._shadowGOTrs = nil
	end

	self._skeletonAnim = nil
	self._curAnimState = nil
	self._isLoop = nil
	self._mountheadGO = nil
	self._mountheadGOTrs = nil
	self._shadowPointGOTrs = nil

	self.entity:stopAllCommonInteractionEff()
	TaskDispatcher.cancelTask(self._animDone, self)
end

function RoomCritterSpineComp:beforeDestroy()
	self:removeEventListeners()
	self:clearSpine()
end

return RoomCritterSpineComp
