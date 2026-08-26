-- chunkname: @modules/logic/room/entity/comp/RoomCharacterSpineComp.lua

module("modules.logic.room.entity.comp.RoomCharacterSpineComp", package.seeall)

local RoomCharacterSpineComp = class("RoomCharacterSpineComp", RoomBaseSpineComp)
local DefaulCharacterHeight = 0.01

function RoomCharacterSpineComp:onInit()
	local roomCharacterMO = self.entity:getMO()

	self._skinId = roomCharacterMO.skinId
	self._heroId = roomCharacterMO.heroId
	self._roomCharacterCfg = roomCharacterMO.roomCharacterConfig
	self._characterRes = RoomResHelper.getCharacterPath(self._skinId)
	self._animalRes = RoomResHelper.getAnimalPath(self._skinId)
	self._cameraAnimABRes = RoomResHelper.getCharacterCameraAnimABPath(roomCharacterMO.roomCharacterConfig.cameraAnimPath)
	self._cameraAnimRes = RoomResHelper.getCharacterCameraAnimPath(roomCharacterMO.roomCharacterConfig.cameraAnimPath)
	self._effectABRes = RoomResHelper.getCharacterEffectABPath(roomCharacterMO.roomCharacterConfig.effectPath)
	self._effectRes = RoomResHelper.getCharacterEffectPath(roomCharacterMO.roomCharacterConfig.effectPath)
	self._isShow = false
	self._isHide = false
	self._shouldShowCharacter = false
	self._isInDistance = false
	self._alpha = 1
	self._zeroMix = roomCharacterMO.roomCharacterConfig.zeroMix
	self._spinePrefabRes = self._characterRes

	if roomCharacterMO.isAnimal then
		self._spinePrefabRes = self._animalRes
	end

	self:refreshAnimal()
	self:_cameraTransformUpdate()
	self:_refreshSpineShow()
end

function RoomCharacterSpineComp:refreshAnimal()
	local mo = self.entity:getMO()

	if not mo then
		return
	end

	local isAnimal = mo.isAnimal

	isAnimal = isAnimal or false

	local changed = self._isAnimal ~= isAnimal

	self._isAnimal = isAnimal

	if changed then
		if isAnimal then
			self._spinePrefabRes = self._animalRes or self._characterRes
		end

		self:clearSpine()
		self:_refreshShowCharacter(true)
	end
end

function RoomCharacterSpineComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshSpineShow, self._refreshSpineShow, self)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, self._updateShadowOffset, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, self._onUpdate, self)
end

function RoomCharacterSpineComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshSpineShow, self._refreshSpineShow, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, self._updateShadowOffset, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, self._onUpdate, self)
end

function RoomCharacterSpineComp:characterPosChanged()
	self:_cameraTransformUpdate()
end

function RoomCharacterSpineComp:resetPhysics()
	if self._skeletonAnim then
		self._skeletonAnim:ResetLastPositionAndRotation()
	end
end

function RoomCharacterSpineComp:setMixDuration(mixDuration)
	if self._skeletonAnim then
		self._skeletonAnim:SetMixDuration(mixDuration)
	end
end

function RoomCharacterSpineComp:clearMixDuration()
	if self._skeletonAnim then
		self._skeletonAnim:ClearMixDuration()
	end
end

function RoomCharacterSpineComp:_cameraTransformUpdate()
	local focus = self._scene.camera:getCameraFocus()
	local x, y, z = transformhelper.getPos(self.goTrs)
	local spinePos = Vector2(x, z)
	local distance = Vector2.Distance(focus, spinePos)

	if distance < 3.5 then
		self._isInDistance = true
	elseif distance > 4.5 then
		self._isInDistance = false
	end

	self:_refreshShowCharacter()

	if self._spineGO and self._spineGO.activeInHierarchy then
		self:refreshRotation()
	end

	self:refreshEffectPos()
end

function RoomCharacterSpineComp:_onUpdate()
	if self._shadowPointGOTrs and self._shadowGOTrs then
		local px, py, pz = transformhelper.getPos(self._shadowPointGOTrs)

		transformhelper.setPos(self._shadowGOTrs, px, py, pz)
	end
end

function RoomCharacterSpineComp:refreshEffectPos()
	if not self._specialIdleGO then
		return
	end

	local pos = self._specialIdleGOTrs.position
	local offsetPos = RoomBendingHelper.worldToBendingSimple(pos)

	self._specialIdleGOTrs.localPosition = Vector3(0, offsetPos.y, 0)
end

function RoomCharacterSpineComp:_refreshSpineShow()
	local cameraState = self._scene.camera:getCameraState()

	self._shouldShowCharacter = RoomCharacterController.instance:checkCanSpineShow(cameraState)

	self:_refreshShowCharacter()
end

function RoomCharacterSpineComp:changeMoveState(moveState)
	if self._moveState == moveState then
		return
	end

	self._moveState = moveState

	self:refreshAnimState()
end

function RoomCharacterSpineComp:touch(isTouch)
	local mo = self.entity:getMO()

	TaskDispatcher.cancelTask(self._touchAfter, self)

	if isTouch then
		self._touchAction = true

		TaskDispatcher.runDelay(self._touchAfter, self, 13)

		if self:isRandomSpecialRate() then
			self:tryPlaySpecialIdle()
		else
			self:play(RoomCharacterEnum.CharacterAnimStateName.Touch, false, true)
		end

		local roleVoice = mo.roomCharacterConfig.roleVoice

		if not string.nilorempty(roleVoice) then
			local arr = string.splitToNumber(roleVoice, "|")
			local len = #arr

			if len > 0 then
				local audioLang

				if self._heroId then
					local charVoiceLangId, langStr, usingDefaultLang = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(self._heroId)
					local charVoiceLang = LangSettings.shortcutTab[charVoiceLangId]

					if not string.nilorempty(charVoiceLang) and not usingDefaultLang then
						audioLang = charVoiceLang
					end
				end

				local randomIndex = math.random(1, len)

				if audioLang then
					self:playVoiceWithLang(arr[randomIndex], audioLang)
				else
					self:playVoice(arr[randomIndex])
				end
			end
		end
	else
		self:refreshAnimState()
	end
end

function RoomCharacterSpineComp:isRandomSpecialRate()
	local roomCharacterMO = self.entity:getMO()

	if not roomCharacterMO:isHasSpecialIdle() then
		return false
	end

	local specialRate = roomCharacterMO:getSpecialRate()

	if specialRate <= math.random() then
		return false
	end

	local specialIdleWaterDistance = roomCharacterMO:getSpecialIdleWaterDistance()

	if specialIdleWaterDistance > 0 and RoomCharacterHelper.hasWaterNodeNear(self.goTrs.position, specialIdleWaterDistance) then
		return false
	end

	return true
end

function RoomCharacterSpineComp:refreshAnimState()
	local mo = self.entity:getMO()

	if not mo then
		return
	end

	if self._isAnimal then
		self:play(RoomCharacterEnum.CharacterAnimalAnimStateName.Jump, false, true)
	elseif mo.isTouch then
		if self._touchAction then
			self:play(RoomCharacterEnum.CharacterAnimStateName.Touch, false, false)
		else
			self:play(RoomCharacterHelper.getIdleAnimStateName(mo.heroId), true, false)
		end
	else
		local animState = self:getAnimState()
		local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

		if animState ~= RoomCharacterEnum.CharacterAnimStateName.SpecialIdle or RoomCharacterHelper.getAnimStateName(self._moveState, mo.heroId) ~= RoomCharacterHelper.getIdleAnimStateName(mo.heroId) or tempCharacterMO and tempCharacterMO.id == self.entity.id then
			if not RoomCharacterEnum.CharacterLoopAnimState[self._moveState] then
				local isLoop = false
				local isRest = not not (not isLoop and self._isAnimalActionComplete)

				self:play(RoomCharacterHelper.getAnimStateName(self._moveState, mo.heroId), isLoop, isRest)
			end
		end
	end
end

function RoomCharacterSpineComp:changeLookDir(lookDir)
	self:setLookDir(lookDir)
end

function RoomCharacterSpineComp:_refreshShowCharacter(force)
	if self._isInDistance and self._shouldShowCharacter then
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

function RoomCharacterSpineComp:addResToLoader(loader)
	RoomCharacterSpineComp.super.addResToLoader(self, loader)

	if not string.nilorempty(self._cameraAnimABRes) then
		loader:addPath(self._cameraAnimABRes)
	end

	if not string.nilorempty(self._effectABRes) then
		loader:addPath(self._effectABRes)
	end

	self.entity.characterspineeffect:addResToLoader(loader)
end

function RoomCharacterSpineComp:_onLoadFinish(loader)
	RoomCharacterSpineComp.super._onLoadFinish(self, loader)

	if not string.nilorempty(self._cameraAnimABRes) then
		local cameraAnimABAssetItem = loader:getAssetItem(self._cameraAnimABRes)

		self._cameraAnimController = cameraAnimABAssetItem:GetResource(self._cameraAnimRes)
	end

	if not string.nilorempty(self._effectABRes) then
		local effectABAssetItem = loader:getAssetItem(self._effectABRes)

		self._effectPrefab = effectABAssetItem:GetResource(self._effectRes)
	end

	self._mountheadGO = gohelper.findChild(self._spineGO, "mountroot/mounthead")

	if self._mountheadGO then
		self._mountheadGOTrs = self._mountheadGO.transform
	end

	self._shadowPointGOTrs = nil

	if not string.nilorempty(self._roomCharacterCfg.shadow) then
		local shadowPointGO = gohelper.findChild(self._spineGO, "mountroot/" .. self._roomCharacterCfg.shadow)

		if shadowPointGO then
			self._shadowPointGOTrs = shadowPointGO.transform
		end
	end

	self:_spawnShadowGO(loader)
	self:_updateShadowOffset()
	self.entity.characterspineeffect:spawnEffect(loader)
	self:refreshAnimState()
	self:_cameraTransformUpdate()
end

function RoomCharacterSpineComp:_spawnShadowGO(loader)
	local roomCharacterMO = self.entity:getMO()
	local canWade = roomCharacterMO:getCanWade()

	if canWade then
		return
	end

	local shadowPrefab = self._scene.preloader:getResource(RoomScenePreloader.ResEffectCharacterShadow)

	self._shadowGO = gohelper.clone(shadowPrefab, self.entity.containerGO, "shadow")
	self._shadowGOTrs = self._shadowGO.transform

	local shadowMeshRenderer = self._shadowGO:GetComponent(typeof(UnityEngine.MeshRenderer))

	shadowMeshRenderer.sortingLayerName = "Default"

	transformhelper.setLocalPos(self._shadowGOTrs, 0, DefaulCharacterHeight, 0)
end

function RoomCharacterSpineComp:_updateShadowOffset()
	if not self._material then
		return
	end

	local shadowOffset = self._scene.character:getShadowOffset()

	self._material:SetVector("_ShadowOffset", shadowOffset)
end

function RoomCharacterSpineComp:_onLoadOneFail(loader, assetItem)
	logError("RoomCharacterSpineComp: 加载失败, url: " .. assetItem.ResPath)
end

function RoomCharacterSpineComp:play(animState, isLoop, reStart)
	if not animState then
		return
	end

	if not self._skeletonAnim then
		return
	end

	isLoop = isLoop or false
	reStart = reStart or false
	self._playAnimal = self._playAnimal or false

	local needPlay = reStart or animState ~= self._curAnimState or isLoop ~= self._isLoop or self._playAnimal ~= self._isAnimal

	if not needPlay then
		return
	end

	if animState ~= RoomCharacterEnum.CharacterAnimStateName.SpecialIdle then
		self:_stopPlaySpecialIdle()
	end

	local preAnimState = self._curAnimState

	self._curAnimState = animState
	self._isLoop = isLoop
	self._playAnimal = self._isAnimal

	if self._skeletonAnim:HasAnimation(animState) then
		if self._zeroMix and (animState ~= preAnimState or reStart) then
			self._skeletonAnim:SetAnimation(0, animState, self._isLoop, 0)

			self._skeletonAnim.loop = self._isLoop
		else
			self._skeletonAnim:PlayAnim(animState, self._isLoop, reStart)
		end

		self:_moveCharacterUp(animState)
		self:_updateAnimShadow(animState)
		self.entity.characterspineeffect:play(animState)
	else
		local spineName = gohelper.isNil(self._spineGO) and "nil" or self._spineGO.name

		logError(string.format("heroId:%s  skinId:%s  animName:%s  goName:%s  Animation Name not exist ", self._heroId, self._skinId, animState, spineName))
	end
end

function RoomCharacterSpineComp:_moveCharacterUp(animName)
	TaskDispatcher.cancelTask(self._moveUp, self)
	TaskDispatcher.cancelTask(self._moveDown, self)

	local roomCharacterMO = self.entity:getMO()

	if not roomCharacterMO then
		return
	end

	local skinId = roomCharacterMO.skinId

	self._moveConfig = RoomConfig.instance:getCharacterAnimConfig(skinId, animName)

	if not self._moveConfig then
		self:_killMoveTween()

		if self._spineGO then
			self._spineMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(self._spineGOTrs, DefaulCharacterHeight, 0.05)
		end

		if self._shadowGO then
			self._shadowMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(self._shadowGOTrs, DefaulCharacterHeight, 0.05)
		end

		return
	end

	if self._moveConfig.upTime > 0 then
		TaskDispatcher.runDelay(self._moveUp, self, self._moveConfig.upTime / 1000)
	else
		self:_moveUp()
	end

	if self._moveConfig.downTime > 0 then
		TaskDispatcher.runDelay(self._moveDown, self, self._moveConfig.downTime / 1000)
	end
end

function RoomCharacterSpineComp:_moveUp()
	if not self._moveConfig then
		return
	end

	self:_killMoveTween()

	self._spineMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(self._spineGOTrs, self._moveConfig.upDistance / 1000, self._moveConfig.upDuration / 1000)
	self._shadowMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(self._shadowGOTrs, self._moveConfig.upDistance / 1000, self._moveConfig.upDuration / 1000)
end

function RoomCharacterSpineComp:_moveDown()
	if not self._moveConfig then
		return
	end

	self:_killMoveTween()

	self._spineMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(self._spineGOTrs, DefaulCharacterHeight, self._moveConfig.downDuration / 1000)
	self._shadowMoveTweenId = ZProj.TweenHelper.DOLocalMoveY(self._shadowGOTrs, DefaulCharacterHeight, self._moveConfig.downDuration / 1000)
end

function RoomCharacterSpineComp:_killMoveTween()
	if self._spineMoveTweenId then
		ZProj.TweenHelper.KillById(self._spineMoveTweenId)
	end

	if self._shadowMoveTweenId then
		ZProj.TweenHelper.KillById(self._shadowMoveTweenId)
	end
end

function RoomCharacterSpineComp:_onAnimCallback(actionName, eventName, eventArgs)
	local scene = GameSceneMgr.instance:getCurScene()
	local mo = self.entity:getMO()

	self._isAnimalActionComplete = eventName == SpineAnimEvent.ActionComplete

	if self._isAnimal and actionName == RoomCharacterEnum.CharacterAnimalAnimStateName.Jump and eventName == SpineAnimEvent.ActionComplete then
		scene.character:setCharacterAnimal(self.entity.id, false)
	elseif not self._isAnimal and self._touchAction and eventName == SpineAnimEvent.ActionComplete then
		self._touchAction = false

		if actionName == RoomCharacterEnum.CharacterAnimStateName.SpecialIdle then
			self:_stopPlaySpecialIdle()
		end

		self:refreshAnimState()
		TaskDispatcher.cancelTask(self._touchAfter, self)
		TaskDispatcher.runDelay(self._touchAfter, self, RoomCharacterEnum.WaitingTimeAfterTouch)
	elseif not self._isAnimal and actionName == RoomCharacterEnum.CharacterAnimStateName.SpecialIdle and eventName == SpineAnimEvent.ActionComplete then
		self:_stopPlaySpecialIdle()

		local var_29_0 = RoomCharacterHelper.getAnimStateName(self._moveState, mo.heroId)

		self:play(animName, RoomCharacterEnum.CharacterLoopAnimState[self._moveState] or false, false)
	elseif not self._isAnimal and self._curAnimState == actionName and self._isLoop ~= true and eventName == SpineAnimEvent.ActionComplete then
		local nextAnim = RoomCharacterHelper.getNextAnimStateName(self._moveState, actionName)

		if nextAnim then
			self:play(nextAnim, nextAnim == actionName, false)
		else
			self:play(RoomCharacterHelper.getIdleAnimStateName(mo.heroId), true, false)
		end
	end
end

function RoomCharacterSpineComp:_stopPlaySpecialIdle()
	if self._specialIdleAnimator then
		self._specialIdleAnimator.enabled = false
	end

	if self._specialIdleGO then
		gohelper.setActive(self._specialIdleGO, false)
	end

	if self._spineGO then
		ZProj.CharacterSetVariantHelper.Disable(self._spineGO)
	end

	if self._meshRenderer and self._material then
		self._meshRenderer.material = self._material
	end
end

function RoomCharacterSpineComp:tryPlaySpecialIdle()
	if not self._spineGO then
		return
	end

	local mo = self.entity:getMO()

	if mo:isHasSpecialIdle() and self._curAnimState ~= RoomCharacterEnum.CharacterAnimStateName.SpecialIdle then
		self:play(RoomCharacterEnum.CharacterAnimStateName.SpecialIdle, false, false)

		if self._cameraAnimController then
			if not self._specialIdleAnimator then
				self._specialIdleAnimator = gohelper.onceAddComponent(self._spineGO, typeof(UnityEngine.Animator))
				self._specialIdleAnimator.runtimeAnimatorController = self._cameraAnimController
			else
				self._specialIdleAnimator.runtimeAnimatorController = nil
				self._specialIdleAnimator.enabled = false
				self._specialIdleAnimator.enabled = true
				self._specialIdleAnimator.runtimeAnimatorController = self._cameraAnimController
			end
		end

		if self._effectPrefab then
			if not self._specialIdleGO then
				local mountbottomGO = gohelper.findChild(self._spineGO, "mountroot/mountbottom")

				self._specialIdleGO = gohelper.clone(self._effectPrefab, mountbottomGO or self._spineGO, "special_idle_effect")
				self._specialIdleGOTrs = self._specialIdleGO.transform
			else
				gohelper.setActive(self._specialIdleGO, false)
				gohelper.setActive(self._specialIdleGO, true)
			end

			local leftGO = gohelper.findChild(self._specialIdleGO, self._effectPrefab.name .. "_r")
			local rightGO = gohelper.findChild(self._specialIdleGO, self._effectPrefab.name .. "_l")

			gohelper.setActive(leftGO, self._lookDir == SpineLookDir.Left)
			gohelper.setActive(rightGO, self._lookDir == SpineLookDir.Right)
		end
	end
end

function RoomCharacterSpineComp:_updateAnimShadow(animName)
	local isShow = self:_isShowAnimShadow(animName)

	if self._isLastAminShadow ~= isShow then
		self._isLastAminShadow = isShow
		self._meshRenderer.shadowCastingMode = isShow and UnityEngine.Rendering.ShadowCastingMode.On or UnityEngine.Rendering.ShadowCastingMode.Off
	end
end

function RoomCharacterSpineComp:_isShowAnimShadow(animName)
	local config = RoomConfig.instance:getCharacterShadowConfig(self._skinId, animName or self._curAnimState)

	if config and config.shadow == 1 then
		return false
	end

	return true
end

function RoomCharacterSpineComp:_touchAfter()
	TaskDispatcher.cancelTask(self._touchAfter, self)

	local scene = GameSceneMgr.instance:getCurScene()

	scene.character:setCharacterTouch(self.entity.id, false)
end

function RoomCharacterSpineComp:getCharacterGO()
	return self:getSpineGO()
end

function RoomCharacterSpineComp:getShadowGO()
	return self._shadowGO
end

function RoomCharacterSpineComp:getMountheadGO()
	return self._mountheadGO
end

function RoomCharacterSpineComp:getMountheadGOTrs()
	return self._mountheadGOTrs
end

function RoomCharacterSpineComp:_checkAnimator(animRes)
	local animController = self._scene.preloader:getResource(animRes)

	if animController then
		self._animator = gohelper.onceAddComponent(self.entity.containerGO, typeof(UnityEngine.Animator))
		self._animatorPlayer = gohelper.onceAddComponent(self.entity.containerGO, typeof(SLFramework.AnimatorPlayer))
		self._animator.runtimeAnimatorController = animController

		return true
	end

	return false
end

function RoomCharacterSpineComp:playAnim(animRes, animName, normalizedTime, callback, callbackObj)
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

function RoomCharacterSpineComp:clearAnim()
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

function RoomCharacterSpineComp:_animDone()
	if self._callback then
		self._callback(self._callbackObj)
	end
end

function RoomCharacterSpineComp:clearSpine()
	if self.entity and self.entity.characterspineeffect then
		self.entity.characterspineeffect:clearEffect()
	end

	self:_killMoveTween()
	self:clearAnim()
	TaskDispatcher.cancelTask(self._moveUp, self)
	TaskDispatcher.cancelTask(self._moveDown, self)
	TaskDispatcher.cancelTask(self._animDone, self)
	RoomCharacterSpineComp.super.clearSpine(self)

	if self._shadowGO then
		gohelper.destroy(self._shadowGO)

		self._shadowGO = nil
		self._shadowGOTrs = nil
	end

	self._cameraAnimController = nil
	self._specialIdleAnimator = nil
	self._specialIdleGO = nil
	self._specialIdleGOTrs = nil
	self._effectPrefab = nil
	self._isLoop = nil
	self._mountheadGO = nil
	self._mountheadGOTrs = nil
	self._shadowPointGOTrs = nil

	self:_touchAfter()
end

function RoomCharacterSpineComp:beforeDestroy()
	self:removeEventListeners()
	RoomCharacterSpineComp.super.beforeDestroy(self)
end

return RoomCharacterSpineComp
