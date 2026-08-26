-- chunkname: @modules/logic/main/view/skininteraction/BleSkinInteraction.lua

module("modules.logic.main.view.skininteraction.BleSkinInteraction", package.seeall)

local BleSkinInteraction = class("BleSkinInteraction", CommonSkinInteraction)
local moveMinValue = 0
local moveMaxValue = 200
local fadeMinValue = 0
local fadeMaxValue = 10
local cameraPosZIn = -15
local cameraPosZNormal = -17
local middleGoPath = "Drawables/bone6/effect-Bone"
local b_jiaohu_01 = "b_jiaohu_01"
local b_jiaohu_02 = "b_jiaohu_02"
local b_jiaohu_04 = "b_jiaohu_04"
local b_jiaohu_05 = "b_jiaohu_05"
local b_jiaohu_03_1 = "b_jiaohu_03_1"
local b_jiaohu_03_2 = "b_jiaohu_03_2"
local b_idle = "b_idle"
local UVChangeValue1 = 0.5
local UVChangeValue2 = 1.45

function BleSkinInteraction:_onInit()
	BleSkinInteraction.super._onInit(self)

	if not self._effectLoader then
		self._animationControllerName = "313402_ble"
		self._effectUrl = string.format("ui/animations/dynamic/%s.controller", self._animationControllerName)
		self._effectLoader = MultiAbLoader.New()

		self._effectLoader:addPath(self._effectUrl)
		self._effectLoader:startLoad(self._loadEffectFinished, self)
	end

	self._targetPos = Vector2(31.78, -78.47)
	self._lightSpine = self._view._lightSpine
	self._spineGo = self._lightSpine:getSpineGo()
	self._boneDragOffsetPos = {}
end

function BleSkinInteraction:_loadEffectFinished(effectLoader)
	return
end

function BleSkinInteraction:_playCameraAnim(animName)
	if not self._effectLoader then
		return
	end

	local path = self._effectUrl
	local animatorInst = self._effectLoader:getAssetItem(path):GetResource()
	local animator = CameraMgr.instance:getCameraRootAnimator()

	animator.runtimeAnimatorController = animatorInst
	animator.enabled = true

	animator:Play(animName, 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)

	local time = 2.1

	UIBlockHelper.instance:startBlock("BleSkinInteractionCameraAnim", time)
	TaskDispatcher.cancelTask(self._delayResetCamera, self)
	TaskDispatcher.runDelay(self._delayResetCamera, self, time)
end

function BleSkinInteraction:_delayResetCamera()
	UIBlockMgrExtend.setNeedCircleMv(true)
	self:_resetCameraPos()
end

function BleSkinInteraction:isCustomDrag()
	return true
end

function BleSkinInteraction:_onBodyChange(prevBodyName, curBodyName)
	if curBodyName == b_idle and (prevBodyName == b_jiaohu_01 or prevBodyName == b_jiaohu_02 or prevBodyName == b_jiaohu_03_1 or prevBodyName == b_jiaohu_03_2) then
		self:_setAllCrystalLightEffectVisible(false)

		self._isShowLight = false

		self:_disableLightKeyword()

		self._dragSuccessTime = Time.time + 0.5

		if self._changeUVTweenId then
			ZProj.TweenHelper.KillById(self._changeUVTweenId)

			self._changeUVTweenId = nil
		end

		TaskDispatcher.cancelTask(self._playBeginAudio, self)
		AudioMgr.instance:trigger(AudioEnum.UI.hero3134_interaction_end)
	end

	if curBodyName == b_jiaohu_01 then
		self:_initMats()
		TaskDispatcher.cancelTask(self._delayChangeUV, self)
		TaskDispatcher.runDelay(self._delayChangeUV, self, 2.48)
		TaskDispatcher.cancelTask(self._playBeginAudio, self)
		TaskDispatcher.runDelay(self._playBeginAudio, self, 5)

		return
	end

	if prevBodyName == b_jiaohu_01 then
		TaskDispatcher.cancelTask(self._delayChangeUV, self)

		return
	end

	if curBodyName == b_jiaohu_04 then
		self:_setAllCrystalLightOutEffectVisible(false)
		AudioMgr.instance:trigger(AudioEnum.UI.hero3134_interaction_end)
		self:_setAllCrystalLightEffectVisible(false)
		TaskDispatcher.cancelTask(self._delayExitChangeUV, self)
		TaskDispatcher.runDelay(self._delayExitChangeUV, self, 1.5)
		gohelper.setActive(self._lightEffectGo, false)

		return
	end

	if curBodyName == b_jiaohu_05 then
		AudioMgr.instance:trigger(AudioEnum.UI.hero3134_interaction_end)
		self:_setAllCrystalLightEffectVisible(false)
		TaskDispatcher.cancelTask(self._delayExitChangeUV, self)
		TaskDispatcher.runDelay(self._delayExitChangeUV, self, 1.5)
	end

	if prevBodyName == b_jiaohu_04 then
		self:_resetParams()
		gohelper.setActive(self._finshEffectGo, false)

		self._finshEffectGo = nil

		return
	end
end

local areaList = {
	{
		5,
		1,
		"Param_yidong1",
		"Param_jianbian1",
		8,
		{
			0.78,
			0.32
		},
		{
			-309.59,
			154.78
		}
	},
	{
		5,
		2,
		"Param_yidong2",
		"Param_jianbian2",
		9,
		{
			0.67,
			0.14
		},
		{
			-431.53,
			13.6
		}
	},
	{
		5,
		3,
		"Param_yidong3",
		"Param_jianbian3",
		10,
		[7] = {
			-354.63,
			-127
		}
	},
	{
		4,
		1,
		"Param_yidong4",
		"Param_jianbian4",
		12,
		{
			0.68,
			0.32
		}
	},
	{
		4,
		2,
		"Param_yidong5",
		"Param_jianbian5",
		11,
		{
			0.67,
			0.14
		}
	},
	{
		4,
		3,
		"Param_yidong6",
		"Param_jianbian6",
		13
	}
}
local dragFinishEffect = {
	"Drawables/bone6/effect-Bone/roleeffect_ble_jh04_6cai",
	"Drawables/bone6/effect-Bone/roleeffect_ble_jh04_6zi",
	"Drawables/bone6/effect-Bone/roleeffect_ble_jh04_6jin"
}

function BleSkinInteraction:_getBoneDragOffsetPos(spineGo, index, normalPos)
	local offset = self._boneDragOffsetPos[index]

	if offset then
		return offset
	end

	local bonePath = string.format("Drawables/bone%s/effect-Bone", index)
	local boneGo = gohelper.findChild(spineGo, bonePath)
	local posX, posY = self:_getBoneViewPos(boneGo)
	local offset = Vector2.New(normalPos[1] - posX, normalPos[2] - posY)

	self._boneDragOffsetPos[index] = offset

	return offset
end

function BleSkinInteraction:_getBoneViewPos(boneGo)
	local transform = boneGo.transform
	local camera = CameraMgr.instance:getUnitCamera()
	local worldPos = transform.position
	local posX, posY = recthelper.worldPosToScreenPoint(camera, worldPos.x, worldPos.y, worldPos.z)

	posX, posY = recthelper.screenPosToAnchorPos2(Vector2(posX, posY), self._mainHeroView._golightspinecontrol.transform)

	return posX, posY
end

function BleSkinInteraction:beforeBeginDrag(view, config, skinConfig)
	if self:_isDragSuccess() or self:inProtectionTime() then
		return false
	end

	self._mainHeroView = view
	self._dragSpecialRespond = config
	self._heroSkinConfig = skinConfig
	self._lightSpine = self._mainHeroView._lightSpine
	self._live2d = self._lightSpine:_getLive2d()

	local spineGo = self._lightSpine:getSpineGo()

	self._spineGo = spineGo

	local pos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self._mainHeroView._golightspinecontrol.transform)
	local posX = pos.x
	local posY = pos.y

	for i, v in ipairs(areaList) do
		local areaId = v[1]
		local areaIndex = v[2]
		local effectIndex = v[5]
		local normalPos = v[7]
		local offsetPos = normalPos and self:_getBoneDragOffsetPos(spineGo, effectIndex, normalPos)

		if offsetPos then
			pos.x = posX + offsetPos.x
			pos.y = posY + offsetPos.y
		else
			pos.x = posX
			pos.y = posY
		end

		if self._mainHeroView:checkSpecialTouchByKey(areaId, pos, areaIndex) then
			self._beingDragPos = pos
			self._targetDistance = Vector2.Distance(self._beingDragPos, self._targetPos)
			self._dragParamName = v[3]
			self._dragParamMinValue = moveMinValue
			self._dragParamMaxValue = moveMaxValue
			self._dragParamLength = self._dragParamMaxValue - self._dragParamMinValue
			self._dragParamIndex = self._lightSpine:addParameter(self._dragParamName, 0, self._dragParamMinValue)

			if self._dragParamIndex == -1 then
				logError("add parameter failed paramName:", self._dragParamName)
			end

			self._fadeParamMinValue = fadeMinValue
			self._fadeParamMaxValue = fadeMaxValue
			self._fadeParamName = v[4]
			self._fadeParamLength = self._fadeParamMaxValue - self._fadeParamMinValue
			self._fadeParamIndex = self._lightSpine:addParameter(self._fadeParamName, 0, self._fadeParamMinValue)

			if self._fadeParamIndex == -1 then
				logError("add parameter failed paramName:", self._fadeParamName)
			end

			local effectPath = string.format("Drawables/bone%s/effect-Bone/roleeffect_ble_jh02_%s", effectIndex, effectIndex)

			self._effectGo = gohelper.findChild(spineGo, effectPath)

			if not self._effectGo then
				logError(string.format("BleSkinInteraction no effect go:%s path %s ", spineGo, effectPath))
			else
				local middleGo = gohelper.findChild(spineGo, middleGoPath)
				local component = self._effectGo:GetComponentInChildren(typeof(ZProj.ParticleShapeToDirectMesh))

				if not component or not middleGo then
					logError(string.format("BleSkinInteraction no particle component or middle middleGo:%s component:%s ", middleGo, component))
				else
					component.target = middleGo.transform
				end
			end

			gohelper.setActive(self._effectGo, true)

			self._posList = v[6]

			local dragEffectPath = string.format("Drawables/bone%s/effect-Bone/roleeffect_ble_jh03_%s", effectIndex, effectIndex)

			self._dragEffectGo = gohelper.findChild(spineGo, dragEffectPath)

			if not self._dragEffectGo then
				logError(string.format("BleSkinInteraction no dragEffectPath go:%s path %s ", spineGo, dragEffectPath))
			else
				transformhelper.setLocalScale(self._dragEffectGo.transform, 1, 1, 1)
			end

			local lightEffectPath = string.format("Drawables/bone%s/effect-Bone/roleeffect_ble_jh04_%s", effectIndex, effectIndex)

			self._lightEffectGo = gohelper.findChild(spineGo, lightEffectPath)

			if not self._lightEffectGo then
				logError(string.format("BleSkinInteraction no lightEffectPath go:%s path %s ", spineGo, lightEffectPath))
			end

			local dragSuccessEffectPath = string.format("Drawables/bone%s/effect-Bone/roleeffect_ble_jh052_%s", effectIndex, effectIndex)

			self._dragSuccessEffectGo = gohelper.findChild(spineGo, dragSuccessEffectPath)

			if not self._dragSuccessEffectGo then
				logError(string.format("BleSkinInteraction no dragSuccessEffectPath go:%s path %s ", spineGo, dragSuccessEffectPath))
			end

			gohelper.setActive(self._dragSuccessEffectGo, false)
			self:_setAllCrystalLightEffectVisible(false)
			self:_setAllCrystalLightOutEffectVisible(i, true)
			gohelper.setActive(self._lightCrystalEffectGoList[i], true)
			self:_moveCamera(cameraPosZIn)
			self._live2d:setBodyAnimation(b_jiaohu_03_1, false, 0.5)
			TaskDispatcher.cancelTask(self._delayPlayAnim, self)
			TaskDispatcher.runDelay(self._delayPlayAnim, self, 4)
			AudioMgr.instance:trigger(AudioEnum.UI.hero3134_mainsfx_mic_drag)

			return true
		end
	end
end

function BleSkinInteraction:_initCrystalLightOutEffect()
	if not self._lightCrystalOutEffectGoList then
		self._lightCrystalOutEffectGoList = {}

		for i, v in ipairs(areaList) do
			local effectIndex = v[5]
			local lightCrystalOutEffectPath = string.format("Drawables/bone%s/effect-Bone/roleeffect_ble_jhout_%s", effectIndex, effectIndex)
			local go = gohelper.findChild(self._spineGo, lightCrystalOutEffectPath)

			self._lightCrystalOutEffectGoList[i] = go

			if not go then
				logError(string.format("BleSkinInteraction no lightCrystalOutEffectPath go:%s path %s ", self._spineGo, lightCrystalOutEffectPath))
			end
		end
	end
end

function BleSkinInteraction:_setAllCrystalLightOutEffectVisible(index, visible)
	self:_initCrystalLightOutEffect()

	for i, v in pairs(self._lightCrystalOutEffectGoList) do
		gohelper.setActive(v, visible and i ~= index)
	end
end

function BleSkinInteraction:_initCrystalLightEffect()
	if not self._lightCrystalEffectGoList then
		self._lightCrystalEffectGoList = {}

		for i, v in ipairs(areaList) do
			local effectIndex = v[5]
			local lightCrystalEffectPath = string.format("Drawables/bone%s/effect-Bone/roleeffect_ble_jh03_%s", effectIndex, effectIndex)
			local go = gohelper.findChild(self._spineGo, lightCrystalEffectPath)

			self._lightCrystalEffectGoList[i] = go

			if not go then
				logError(string.format("BleSkinInteraction no lightCrystalEffectPath go:%s path %s ", self._spineGo, lightCrystalEffectPath))
			end
		end
	end
end

function BleSkinInteraction:_setAllCrystalLightEffectVisible(isVisible)
	self:_initCrystalLightEffect()

	for _, v in pairs(self._lightCrystalEffectGoList) do
		gohelper.setActive(v, isVisible)
	end
end

function BleSkinInteraction:_initMats()
	if gohelper.isNil(self._mat) then
		local meshGo = gohelper.findChild(self._spineGo, "Drawables/ArtMesh10")
		local render = meshGo and meshGo:GetComponent(typeof(UnityEngine.Renderer))

		self._mat = render and render.sharedMaterial

		if not self._mat then
			logError(string.format("BleSkinInteraction no mesh render:%s meshGo:%s ", render, meshGo))
		end
	end

	if gohelper.isNil(self._mat2) then
		local meshGo = gohelper.findChild(self._spineGo, "Drawables/ArtMesh9")
		local render = meshGo and meshGo:GetComponent(typeof(UnityEngine.Renderer))

		self._mat2 = render and render.sharedMaterial

		if not self._mat2 then
			logError(string.format("BleSkinInteraction no mesh2 render:%s meshGo:%s ", render, meshGo))
		end
	end
end

function BleSkinInteraction:_delayPlayAnim()
	self._live2d:setBodyAnimation(b_jiaohu_03_2, true, 0.5)
end

function BleSkinInteraction:beforeEndDrag()
	if not self._beingDragPos then
		return
	end

	gohelper.setActive(self._effectGo, false)
	TaskDispatcher.cancelTask(self._delayPlayAnim, self)
	TaskDispatcher.cancelTask(self._playBeginAudio, self)

	if self:_isDragSuccess() then
		return
	else
		self:_setAllCrystalLightOutEffectVisible()

		if self._dragEffectGo then
			transformhelper.setLocalScale(self._dragEffectGo.transform, 1, 1, 1)
		end

		self:_setAllCrystalLightEffectVisible(true)
		self:_changeUV(self._dragUvValue or UVChangeValue2, UVChangeValue1, true, 0.5)
		self._live2d:setBodyAnimation(b_jiaohu_02, true, 0.5)
		self:_moveCamera(cameraPosZNormal)
	end

	self:_onEndDrag(true)
end

function BleSkinInteraction:_onEndDrag(resetParam)
	if resetParam then
		self:_resetParams()
	end

	self._beingDragPos = nil
end

function BleSkinInteraction:_resetParams()
	if self._dragParamName then
		self._lightSpine:removeParameter(self._dragParamName)

		self._dragParamName = nil
	end

	if self._fadeParamName then
		self._lightSpine:removeParameter(self._fadeParamName)

		self._fadeParamName = nil
	end
end

function BleSkinInteraction:beforeOnDrag(pos)
	tabletool.clear(self._boneDragOffsetPos)

	if not self._beingDragPos then
		return
	end

	if self:_isDragSuccess() then
		return
	end

	local distance = self:_getDistance(self._beingDragPos, self._targetPos, pos)
	local percent = 1 - distance / self._targetDistance

	percent = Mathf.Clamp(percent, 0, 1)

	local percentValue = self._dragParamMinValue + percent * self._dragParamLength

	self._lightSpine:updateParameter(self._dragParamIndex, percentValue)

	if self._posList then
		local paramPercent = self._posList[1]
		local paramValue = self._posList[2]
		local scalePercent = Mathf.Clamp(percent / paramPercent, 0, 1)
		local scale = 1 + paramValue * scalePercent

		if self._dragEffectGo then
			transformhelper.setLocalScale(self._dragEffectGo.transform, scale, scale, 1)
		end
	end

	self._dragUvValue = Mathf.Lerp(UVChangeValue1, UVChangeValue2, percent)

	self:_onChangeUVUpdate(self._dragUvValue)

	if distance <= 90 or percent >= 0.95 then
		self:_onDragSuccess()
	end
end

function BleSkinInteraction:_getDistance(a, b, c)
	local abX = b.x - a.x
	local abY = b.y - a.y
	local acX = c.x - a.x
	local acY = c.y - a.y
	local abLengthSquared = abX * abX + abY * abY

	if abLengthSquared == 0 then
		return 0
	end

	local dotProduct = acX * abX + acY * abY
	local t = dotProduct / abLengthSquared

	t = math.max(0, math.min(1, t))

	local projX = a.x + t * abX
	local projY = a.y + t * abY
	local dx = b.x - projX
	local dy = b.y - projY

	return (math.sqrt(dx * dx + dy * dy))
end

function BleSkinInteraction:_isDragSuccess()
	return self._dragSuccessTime and Time.time - self._dragSuccessTime <= 1.1
end

function BleSkinInteraction:_onDragSuccess()
	gohelper.setActive(self._dragSuccessEffectGo, true)
	gohelper.setActive(self._dragEffectGo, false)

	self._dragSuccessTime = Time.time

	TaskDispatcher.cancelTask(self._onFadeUpdate, self)
	TaskDispatcher.runRepeat(self._onFadeUpdate, self, 0)
end

function BleSkinInteraction:_onFadeUpdate()
	local deltaTime = Time.time - self._dragSuccessTime
	local value = Mathf.Clamp(deltaTime, 0, 1)
	local fadeValue = Mathf.Lerp(fadeMinValue, fadeMaxValue, value)

	self:_onFadeOutUpdate(fadeValue)

	if value >= 1 then
		TaskDispatcher.cancelTask(self._onFadeUpdate, self)
		self:_onFadeOutFinish()
	end
end

function BleSkinInteraction:_onFadeOutUpdate(value)
	self._lightSpine:updateParameter(self._fadeParamIndex, value * 10)
end

function BleSkinInteraction:_onFadeOutFinish()
	local specialRespond = self._dragSpecialRespond

	self._mainHeroView:_onDragEnd()
	self._mainHeroView:_doClickPlayVoice(specialRespond)
	self:_onEndDrag()
	self:_showFinishEffect()
end

function BleSkinInteraction:_showFinishEffect()
	self:_playCameraAnim("313402_ble_jh04")

	local finishEffectIndex = math.random(1, #dragFinishEffect)
	local finishEffect = dragFinishEffect[finishEffectIndex]
	local finishEffectGo = gohelper.findChild(self._spineGo, finishEffect)

	self._finshEffectGo = finishEffectGo

	if not finishEffectGo then
		logError(string.format("BleSkinInteraction no finish effect go:%s path %s ", self._spineGo, finishEffect))
	else
		gohelper.setActive(finishEffectGo, false)
		gohelper.setActive(finishEffectGo, true)
	end
end

function BleSkinInteraction:_playBeginAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.hero3134_interaction_begin)
end

function BleSkinInteraction:_delayChangeUV()
	self:_changeUV(0, UVChangeValue1, true, 1.1)
end

function BleSkinInteraction:_delayExitChangeUV()
	self:_changeUV(UVChangeValue1, 0, false, 1.3)
end

function BleSkinInteraction:_changeUV(from, to, isShowLight, time)
	self._isShowLight = isShowLight

	if isShowLight and not gohelper.isNil(self._mat) and not gohelper.isNil(self._mat2) then
		self._mat:EnableKeyword("_USELOCALMASK_GOUV_ON")
		self._mat2:EnableKeyword("_USELOCALMASK_GOUV_ON")
	end

	if self._changeUVTweenId then
		ZProj.TweenHelper.KillById(self._changeUVTweenId)

		self._changeUVTweenId = nil
	end

	self._matParam = self._matParam or Vector4(0, 0, 0, 0)
	self._changeUVTweenId = ZProj.TweenHelper.DOTweenFloat(from, to, time, self._onChangeUVUpdate, self._onChangeUVFinish, self, nil, EaseType.Linear)
end

function BleSkinInteraction:_onChangeUVUpdate(value)
	self._matParam.w = value

	if gohelper.isNil(self._mat) or gohelper.isNil(self._mat2) then
		return
	end

	self._mat:SetVector("_GoUVOffset", self._matParam)
	self._mat2:SetVector("_GoUVOffset", self._matParam)
end

function BleSkinInteraction:_onChangeUVFinish()
	if not self._isShowLight then
		self:_disableLightKeyword()
	end
end

function BleSkinInteraction:_disableLightKeyword()
	if gohelper.isNil(self._mat) or gohelper.isNil(self._mat2) then
		return
	end

	self._mat:DisableKeyword("_USELOCALMASK_GOUV_ON")
	self._mat2:DisableKeyword("_USELOCALMASK_GOUV_ON")
end

function BleSkinInteraction:_moveCamera(to)
	if self._cameraTweenId then
		ZProj.TweenHelper.KillById(self._cameraTweenId)

		self._cameraTweenId = nil
	end

	self._mainRootGo = CameraMgr.instance:getCameraTraceGO()

	local posX, posY, from = transformhelper.getLocalPos(self._mainRootGo.transform)

	self._cameraPosX, self._cameraPosY = posX, posY
	self._cameraTweenId = ZProj.TweenHelper.DOTweenFloat(from, to, 1, self._onMoveCameraUpdate, self._onMoveCameraFinish, self, nil, EaseType.Linear)
end

function BleSkinInteraction:_onMoveCameraUpdate(value)
	transformhelper.setLocalPos(self._mainRootGo.transform, self._cameraPosX, self._cameraPosY, value)
end

function BleSkinInteraction:_onMoveCameraFinish()
	return
end

function BleSkinInteraction:_resetCameraPos()
	if not self._mainRootGo then
		return
	end

	local animator = CameraMgr.instance:getCameraRootAnimator()
	local animatorInst = animator.runtimeAnimatorController

	if not animatorInst or animatorInst.name ~= self._animationControllerName then
		return
	end

	animator.runtimeAnimatorController = nil

	local cameraPosX, cameraPosY, cameraPosZ = transformhelper.getLocalPos(self._mainRootGo.transform)

	transformhelper.setLocalPos(self._mainRootGo.transform, cameraPosX, cameraPosY, cameraPosZNormal)
end

function BleSkinInteraction:_onDestroy()
	BleSkinInteraction.super._onDestroy(self)
	TaskDispatcher.cancelTask(self._delayPlayAnim, self)
	TaskDispatcher.cancelTask(self._delayResetCamera, self)
	TaskDispatcher.cancelTask(self._delayChangeUV, self)
	TaskDispatcher.cancelTask(self._delayExitChangeUV, self)
	TaskDispatcher.cancelTask(self._playBeginAudio, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	TaskDispatcher.cancelTask(self._onFadeUpdate, self)

	if self._cameraTweenId then
		ZProj.TweenHelper.KillById(self._cameraTweenId)

		self._cameraTweenId = nil
	end

	if self._changeUVTweenId then
		ZProj.TweenHelper.KillById(self._changeUVTweenId)

		self._changeUVTweenId = nil
	end

	if self._effectLoader then
		self._effectLoader:dispose()
	end

	self:_resetCameraPos()
end

return BleSkinInteraction
