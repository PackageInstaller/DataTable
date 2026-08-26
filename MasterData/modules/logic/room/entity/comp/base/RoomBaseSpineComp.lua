-- chunkname: @modules/logic/room/entity/comp/base/RoomBaseSpineComp.lua

module("modules.logic.room.entity.comp.base.RoomBaseSpineComp", package.seeall)

local RoomBaseSpineComp = class("RoomBaseSpineComp", LuaCompBase)
local ShaderColorName = "_MainColor"
local ShowFadeTime = 0.5
local HideFadeTime = 0.5

RoomBaseSpineComp.DefaulSpineHeight = 0.01

function RoomBaseSpineComp:ctor(entity)
	self.entity = entity
	self._spinePrefabRes = nil
	self._lookDir = SpineLookDir.Default
	self._moveState = RoomCharacterEnum.CharacterMoveState.Idle
end

function RoomBaseSpineComp:init(go)
	self.go = go
	self.goTrs = go.transform
	self._scene = GameSceneMgr.instance:getCurScene()
	self._materialRes = RoomCharacterEnum.MaterialPath
	self._loader = nil
	self._spineGO = nil
	self._material = nil
	self._meshRenderer = nil
	self._skeletonAnim = nil
	self._curAnimState = nil
	self._isLoop = nil
	self._alpha = 1

	self:onInit()
end

function RoomBaseSpineComp:onInit()
	return
end

function RoomBaseSpineComp:getLookDir()
	return self._lookDir
end

function RoomBaseSpineComp:setLookDir(lookDir)
	if self._lookDir == lookDir then
		return
	end

	self._lookDir = lookDir

	self:refreshFlip()
end

function RoomBaseSpineComp:refreshFlip()
	if self._skeletonAnim then
		if self._lookDir == SpineLookDir.Right then
			self._skeletonAnim:SetScaleX(SpineLookDir.Right)
		else
			self._skeletonAnim:SetScaleX(SpineLookDir.Left)
		end
	end
end

function RoomBaseSpineComp:refreshRotation()
	if not self._spineGO then
		return
	end

	local rotate = self._scene.camera:getCameraRotate()
	local quaternion = Quaternion.New()

	quaternion:SetEuler(0, Mathf.Rad2Deg * rotate, 0)

	self._spineGOTrs.rotation = quaternion
end

function RoomBaseSpineComp:showSpine()
	if self._spineGO then
		local alpha = self:getAlpha()

		self:tweenAlpha(alpha, 1, (1 - alpha) * ShowFadeTime)
	else
		if self._loader then
			self._loader:dispose()

			self._loader = nil
		end

		self._loader = SequenceAbLoader.New()

		self:addResToLoader(self._loader)
		self._loader:setConcurrentCount(10)
		self._loader:setLoadFailCallback(self._onLoadOneFail)
		self._loader:startLoad(self._onLoadFinish, self)
	end
end

function RoomBaseSpineComp:hideSpine()
	if self._spineGO then
		local alpha = self:getAlpha()

		self.tweenAlpha(self, alpha, 0, alpha * HideFadeTime, self._hideCallback, self)
	else
		self:clearSpine()
	end
end

function RoomBaseSpineComp:_hideCallback()
	self:clearSpine()
end

function RoomBaseSpineComp:isShowAnimShadow()
	return true
end

function RoomBaseSpineComp:addResToLoader(loader)
	loader:addPath(self._spinePrefabRes)
	loader:addPath(self._materialRes)
end

function RoomBaseSpineComp:_onLoadOneFail(loader, assetItem)
	logError(string.format("%s:_onLoadOneFail 加载失败, url:%s", self.__cname, assetItem.ResPath))
end

function RoomBaseSpineComp:_onLoadFinish(loader)
	local prefabAssetItem = loader:getAssetItem(self._spinePrefabRes)

	if not prefabAssetItem then
		logError("can not find :" .. self._spinePrefabRes)
	end

	local prefab = prefabAssetItem:GetResource(self._spinePrefabRes)
	local materialAssetItem = loader:getAssetItem(self._materialRes)
	local replaceMaterial = materialAssetItem:GetResource(self._materialRes)

	self._spineGO = gohelper.clone(prefab, self.entity.containerGO, "spine")
	self._spineGOTrs = self._spineGO.transform

	gohelper.setLayer(self._spineGO, LayerMask.NameToLayer("Scene"), true)

	self._meshRenderer = self._spineGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	self._skeletonAnim = self._spineGO:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
	self._skeletonAnim.PhysicsPositionInheritanceFactor = Vector2.New(0, 0)
	self._skeletonAnim.PhysicsRotationInheritanceFactor = 0

	gohelper.onceAddComponent(self._spineGO, UnitSpine.TypeSpineAnimationEvent)
	TaskDispatcher.cancelTask(self._onSpineAnimEvent, self)
	TaskDispatcher.runDelay(self._onSpineAnimEvent, self, 0.02)
	transformhelper.setLocalPos(self._spineGOTrs, 0, RoomBaseSpineComp.DefaulSpineHeight, 0)
	transformhelper.setLocalScale(self._spineGOTrs, 0.07, 0.07, 0.07)
	self:_replaceMaterial(replaceMaterial)
	self:refreshFlip()
	self:refreshRotation()
	self:tweenAlpha(0, 1, ShowFadeTime)
end

function RoomBaseSpineComp:_replaceMaterial(material)
	self._material = UnityEngine.GameObject.Instantiate(material)

	local sharedMaterial = self._meshRenderer.sharedMaterial

	self._material:SetTexture("_MainTex", sharedMaterial:GetTexture("_MainTex"))
	self._material:SetTexture("_BackLight", sharedMaterial:GetTexture("_NormalMap"))
	self._material:SetTexture("_DissolveTex", sharedMaterial:GetTexture("_DissolveTex"))

	local customMaterialOverride = self._skeletonAnim.CustomMaterialOverride

	if customMaterialOverride then
		customMaterialOverride:Clear()
		customMaterialOverride:Add(sharedMaterial, self._material)
	end

	self._meshRenderer.material = self._material
	self._meshRenderer.sortingLayerName = "Default"
end

function RoomBaseSpineComp:_onSpineAnimEvent()
	if not gohelper.isNil(self._spineGO) then
		self._csSpineEvt = gohelper.onceAddComponent(self._spineGO, UnitSpine.TypeSpineAnimationEvent)
	end

	if self._csSpineEvt then
		self._csSpineEvt:SetAnimEventCallback(self._onAnimCallback, self)
	end
end

function RoomBaseSpineComp:_onAnimCallback(actionName, eventName, eventArgs)
	return
end

function RoomBaseSpineComp:getAnimState()
	if self._skeletonAnim then
		return self._skeletonAnim.AnimationName
	end
end

function RoomBaseSpineComp:play(animState, isLoop, reStart)
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
	else
		local spineName = gohelper.isNil(self._spineGO) and "nil" or self._spineGO.name

		logError(string.format("animName:%s  goName:%s  Animation Name not exist ", animState, spineName))
	end
end

function RoomBaseSpineComp:tweenAlpha(fromAlpha, toAlpha, duration, callback, callbackObj)
	if self._alphaTweenId then
		self._scene.tween:killById(self._alphaTweenId)

		self._alphaTweenId = nil
	end

	if duration and duration > 0 then
		self:setAlpha(fromAlpha)

		self._alphaTweenId = self._scene.tween:tweenFloat(0, 1, duration, self._tweenAlphaFrameCallback, self._tweenAlphaFinishCallback, self, {
			fromAlpha = fromAlpha,
			toAlpha = toAlpha,
			callback = callback,
			callbackObj = callbackObj
		})
	else
		self:setAlpha(toAlpha)
	end
end

function RoomBaseSpineComp:_tweenAlphaFrameCallback(value, param)
	local fromAlpha = param.fromAlpha
	local toAlpha = param.toAlpha
	local alpha = fromAlpha * (1 - value) + toAlpha * value

	self:setAlpha(alpha)
end

function RoomBaseSpineComp:_tweenAlphaFinishCallback(param)
	local toAlpha = param.toAlpha
	local callback = param.callback
	local callbackObj = param.callbackObj

	self:setAlpha(toAlpha)

	if callback then
		param.callback(callbackObj)
	end
end

function RoomBaseSpineComp:setAlpha(alpha)
	self._alpha = alpha

	self:updateAlpha()
end

function RoomBaseSpineComp:getAlpha()
	return self._alpha
end

function RoomBaseSpineComp:updateAlpha()
	local isPressing = self.entity.isPressing
	local alpha = isPressing and 0 or self._alpha

	if self._material then
		local color = self._material:GetColor(ShaderColorName)

		color.a = alpha

		self._material:SetColor(ShaderColorName, color)
	end

	if self:isShowAnimShadow() and self._meshRenderer then
		self._meshRenderer.shadowCastingMode = alpha > 0.5 and UnityEngine.Rendering.ShadowCastingMode.On or UnityEngine.Rendering.ShadowCastingMode.Off
	end
end

function RoomBaseSpineComp:playVoice(audioId)
	if self._spineGO then
		local emitter = ZProj.AudioEmitter.Get(self._spineGO)

		emitter:Emitter(audioId)
	end
end

function RoomBaseSpineComp:playVoiceWithLang(audioId, lang)
	if self._spineGO then
		local emitter = ZProj.AudioEmitter.Get(self._spineGO)
		local audioCfg = AudioConfig.instance:getAudioCOById(audioId)
		local bnkName = audioCfg.bankName

		ZProj.AudioManager.Instance:LoadBank(bnkName, lang)
		emitter:Emitter(audioId, lang)
		ZProj.AudioManager.Instance:UnloadBank(bnkName)
	end
end

function RoomBaseSpineComp:getSpineGO()
	return self._spineGO
end

function RoomBaseSpineComp:clearSpine()
	TaskDispatcher.cancelTask(self._onSpineAnimEvent, self)

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._alphaTweenId then
		self._scene.tween:killById(self._alphaTweenId)

		self._alphaTweenId = nil
	end

	if self._csSpineEvt then
		self._csSpineEvt:RemoveAnimEventCallback()

		self._csSpineEvt = nil
	end

	if self._spineGO then
		gohelper.destroy(self._spineGO)

		self._spineGO = nil
		self._spineGOTrs = nil
	end

	if self._material then
		gohelper.destroy(self._material)

		self._material = nil
	end

	self._meshRenderer = nil
	self._skeletonAnim = nil
	self._curAnimState = nil
	self._isLoop = nil
end

function RoomBaseSpineComp:beforeDestroy()
	self:clearSpine()
end

return RoomBaseSpineComp
